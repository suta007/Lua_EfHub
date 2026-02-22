local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local DataService = require(ReplicatedStorage.Modules.DataService)
local LocalPlayer = game:GetService("Players").LocalPlayer

local function QuickSave()
	print("QuickSave function called")
end
local function GetPetBaseWeight(uuid)
	print("..")
end

local PetTable = {}
local Tabs = nil
local Options = {}

-- =========================================================
-- [ สมมติฐานตัวแปรระบบ ] (ลบหรือปรับแก้ได้ถ้าพี่เอฟมีประกาศไว้แล้ว)
-- =========================================================

local currentMainPetUUID = nil

-- =========================================================
-- 1. ประกาศตัวแปรฟังก์ชันไว้ด้านบน (Forward Declarations)
-- =========================================================
local calculateCurrentWeight
local getInventoryList
local findMainPet
local findDupePet
local processAgeBreakMachine
local ToggleTask
local SyncBackgroundTasks

-- =========================================================
-- 2. ส่วนของการสร้าง UI (Fluent Renewed)
-- =========================================================
local AutoAgeBreakSection = Tabs.Pet:AddCollapsibleSection("Auto Age Break")

AutoAgeBreakSection:AddToggle("AAB_Enabled", {
	Title = "Enable Auto Age Break",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if SyncBackgroundTasks then
			SyncBackgroundTasks()
		end
	end,
})

AutoAgeBreakSection:AddDropdown("AAB_PetType", {
	Title = "Select Pet Type",
	Values = PetTable,
	Default = "",
	Multi = false,
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

AutoAgeBreakSection:AddInput("AAB_TargetAge", {
	Title = "Target Break Age",
	Description = "Min: 101, Max: 125",
	Default = "125",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

-- เงื่อนไข Dupe: น้ำหนัก
AutoAgeBreakSection:AddToggle("AAB_CheckWeight", {
	Title = "Check Dupe Weight?",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
AutoAgeBreakSection:AddDropdown("AAB_WeightCond", {
	Title = "Weight Condition",
	Values = { "<=", ">=" },
	Default = "<=",
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
AutoAgeBreakSection:AddInput("AAB_WeightVal", {
	Title = "Dupe Weight Value",
	Default = "0",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

-- เงื่อนไข Dupe: อายุ (Level)
AutoAgeBreakSection:AddToggle("AAB_CheckAge", {
	Title = "Check Dupe Age?",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
AutoAgeBreakSection:AddDropdown("AAB_AgeCond", {
	Title = "Age Condition",
	Values = { "<=", ">=" },
	Default = "<=",
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
AutoAgeBreakSection:AddInput("AAB_AgeVal", {
	Title = "Dupe Age Value",
	Default = "0",
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

-- =========================================================
-- 3. เขียนฟังก์ชันแยกไว้ด้านล่าง (Function Implementations)
-- =========================================================

-- ฟังก์ชันคำนวณน้ำหนักปัจจุบัน
calculateCurrentWeight = function(uuid, petAge)
	local baseWeight = GetPetBaseWeight(uuid) or 0
	return baseWeight * (0.909 + (0.091 * petAge))
end

-- ฟังก์ชันดึงข้อมูลกระเป๋าสัตว์เลี้ยง
getInventoryList = function()
	local data = DataService:GetData()
	return data and data.PetsData and data.PetsData.PetInventory
end

-- ฟังก์ชันหาสัตว์เป้าหมาย (ตัวหลัก)
findMainPet = function()
	local targetType = Options.AAB_PetType.Value
	local targetAge = tonumber(Options.AAB_TargetAge.Value) or 125
	local inventory = getInventoryList()

	if inventory then
		for _, v in pairs(inventory) do
			if type(v) == "table" then
				for _, petData in pairs(v) do
					local uuid = petData.UUID
					local tPetType = petData.PetType

					if tPetType == targetType and not GetPetFavorite(uuid) then
						local petAge = GetPetLevel(uuid) or 0
						if petAge >= 100 and petAge < targetAge then
							return uuid
						end
					end
				end
			end
		end
	end
	return nil
end

-- ฟังก์ชันหาสัตว์ตัวซ้ำ (Dupe)
findDupePet = function(mainUUID, targetType)
	local checkWeight = Options.AAB_CheckWeight.Value
	local weightCond = Options.AAB_WeightCond.Value
	local weightVal = tonumber(Options.AAB_WeightVal.Value) or 0

	local checkAge = Options.AAB_CheckAge.Value
	local ageCond = Options.AAB_AgeCond.Value
	local ageVal = tonumber(Options.AAB_AgeVal.Value) or 0

	local inventory = getInventoryList()

	if inventory then
		for _, v in pairs(inventory) do
			if type(v) == "table" then
				for _, petData in pairs(v) do
					local uuid = petData.UUID
					local tPetType = petData.PetType

					if uuid ~= mainUUID and tPetType == targetType and not GetPetFavorite(uuid) then
						local petAge = GetPetLevel(uuid) or 0

						-- ป้องกันการดึงสัตว์ที่อายุ 100+ ไปเป็น Dupe เด็ดขาด
						if petAge >= 100 then
							continue
						end

						local isValid = true

						if checkAge then
							if ageCond == "<=" and petAge > ageVal then
								isValid = false
							end
							if ageCond == ">=" and petAge < ageVal then
								isValid = false
							end
						end

						if isValid and checkWeight then
							local currentWeight = calculateCurrentWeight(uuid, petAge)
							if weightCond == "<=" and currentWeight > weightVal then
								isValid = false
							end
							if weightCond == ">=" and currentWeight < weightVal then
								isValid = false
							end
						end

						if isValid then
							return uuid
						end
					end
				end
			end
		end
	end
	return nil
end

-- ลอจิกหลักของตู้ Age Break
processAgeBreakMachine = function()
	local playerData = DataService:GetData()
	if not playerData then
		return
	end

	local machineData = playerData.PetAgeBreakMachine
	if not machineData then
		return
	end

	local character = LocalPlayer.Character
	local humanoid = character and character:FindFirstChild("Humanoid")

	-- 1. ถ้าระบบพร้อม Claim
	if machineData.PetReady then
		GameEvents.PetAgeLimitBreak_Claim:FireServer()
		task.wait(1.5)
		return
	end

	-- 2. ถ้าตู้กำลังรันเวลาอยู่ให้รอ
	if machineData.IsRunning then
		return
	end

	-- 3. ถ้าตู้ว่าง
	if not machineData.SubmittedPet then
		local targetAge = tonumber(Options.AAB_TargetAge.Value) or 125

		if currentMainPetUUID then
			local petAge = GetPetLevel(currentMainPetUUID)
			if not petAge or petAge >= targetAge then
				currentMainPetUUID = nil
			end
		end

		if not currentMainPetUUID then
			currentMainPetUUID = findMainPet()
		end

		if currentMainPetUUID then
			if humanoid then
				humanoid:UnequipTools()
			end
			task.wait(0.3)

			heldPet(currentMainPetUUID)
			task.wait(0.5)

			GameEvents.PetAgeLimitBreak_SubmitHeld:FireServer()
			task.wait(1)
		end

	-- 4. ถ้าส่งตัวหลักไปแล้ว รอส่ง Dupe
	elseif machineData.SubmittedPet and not machineData.IsRunning then
		local targetType = machineData.SubmittedPet.PetType
		local inMachineUUID = machineData.SubmittedPet.PetUUID or currentMainPetUUID

		local dupeUUID = findDupePet(inMachineUUID, targetType)
		if dupeUUID then
			GameEvents.PetAgeLimitBreak_Submit:FireServer({ dupeUUID })
			task.wait(1.5)
		end
	end
end

-- =========================================================
-- 4. ระบบจัดการ Task ควบคุมการทำงานเบื้องหลัง
-- =========================================================

-- Background task controller (toggle-driven)
ToggleTask = function(taskName, enabled, funcBody)
	if enabled then
		if ActiveTasks[taskName] then
			return
		end
		ActiveTasks[taskName] = task.spawn(function()
			while true do
				local ok, err = pcall(funcBody)
				if not ok then
					WarnLog("Task '" .. taskName .. "' error: " .. tostring(err))
				end
				task.wait()
			end
		end)
	else
		if ActiveTasks[taskName] then
			task.cancel(ActiveTasks[taskName])
			ActiveTasks[taskName] = nil
		end
	end
end

SyncBackgroundTasks = function()
	ToggleTask("AutoFeedPet", Options.AutoFeedPet and Options.AutoFeedPet.Value, function()
		if Options.AutoFeedPet.Value then
			pcall(FeedPet)
			task.wait(10)
		end
	end)

	ToggleTask("AutoPlant", Options.tgPlantFruitEnable and Options.tgPlantFruitEnable.Value, function()
		pcall(AutoPlant)
		task.wait(tonumber(Options.inPlantDelay and Options.inPlantDelay.Value) or 0.3)
	end)

	ToggleTask(
		"CollectFruit1",
		Options.tgCollectFruitEnable and Options.tgCollectFruitEnable.Value,
		CollectFruitWorker1
	)

	-- นำ Auto Age Break มารวมใน Task System
	ToggleTask("AutoAgeBreak", Options.AAB_Enabled.Value, function()
		pcall(processAgeBreakMachine)
		task.wait(2) -- ดีเลย์ 2 วินาทีเพื่อไม่ให้รบกวนประสิทธิภาพเกมมากไป
	end)
end

-- =========================================================
-- 5. ส่วนของการรับ Event แจ้งเตือน (Event Listener)
-- =========================================================
DataService:GetPathSignal("PetAgeBreakMachine/PetReady"):Connect(function()
	if Options.AAB_Enabled and Options.AAB_Enabled.Value then
		local machineData = DataService:GetData() and DataService:GetData().PetAgeBreakMachine
		if machineData and machineData.PetReady then
			GameEvents.PetAgeLimitBreak_Claim:FireServer()
		end
	end
end)
