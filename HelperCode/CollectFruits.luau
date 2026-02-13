--workspace.Farm.Farm.Important.Plants_Physical["Elder Strawberry"].Fruits:GetChildren()[2]["2"].ProximityPrompt
local Fluent = loadstring(
	game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau")
)()

local Window = Fluent:CreateWindow({
	Title = "Console Log",
	SubTitle = "by EfHub",
	TabWidth = 0,
	Size = UDim2.fromOffset(1200, 768),
	Resize = true,
	-- MinSize = Vector2.new(470, 380),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local MaxFullHistory = 1000 -- จำนวนบรรทัดสูงสุดของประวัติทั้งหมด
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {} -- ตารางเก็บประวัติทั้งหมด
local IsPaused = false

-- [สำคัญ] ประกาศตัวแปร LogDisplay ไว้ก่อน เพื่อให้ปุ่มรู้จักตัวแปรนี้
local LogDisplay = nil

------------------------------------------------------
-- 2. สร้างปุ่มควบคุม (อยู่ด้านบน)
------------------------------------------------------

-- ปุ่มหยุด (Pause)
Tabs.Main:AddToggle("PauseSwitch", {
	Title = "Pause Logging",
	Default = false,
	Callback = function(Value)
		IsPaused = Value
	end,
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
	Title = "Copy All Logs",
	--Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(table.concat(FullHistoryTable, "\n"))
			Fluent:Notify({ Title = "Success", Content = "Copied all logs!", Duration = 2 })
		else
			Fluent:Notify({ Title = "Error", Content = "Executor not supported", Duration = 2 })
		end
	end,
})

-- ปุ่ม Clear
Tabs.Main:AddButton({
	Title = "Clear Logs",
	Callback = function()
		DisplayTable = {}
		FullHistoryTable = {}
		if LogDisplay then
			LogDisplay:SetValue("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph("LogDisplay", {
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
	if IsPaused then
		return
	end
	local entry = message
	-- เก็บลงประวัติทั้งหมด
	table.insert(FullHistoryTable, entry)
	if #FullHistoryTable > MaxFullHistory then
		table.remove(FullHistoryTable, 1)
	end

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then
		table.remove(DisplayTable, 1)
	end

	-- อัปเดตหน้าจอ
	if LogDisplay then
		local TempText = ""
		TempText = table.concat(DisplayTable, "\n")
		LogDisplay:SetValue(TempText)
	end
end
------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
local function InfoLog(message)
	AddLog("📋 " .. message)
end

local function WarnLog(message)
	AddLog("⚠️ " .. message)
end

local function ErrorLog(message)
	AddLog("❌ " .. message)
end

local function SuccessLog(message)
	AddLog("✅ " .. message)
end

local function TimeLog(message)
	local timestamp = os.date("%X")
	local entry = string.format("[%s] %s", timestamp, message)
	AddLog(entry)
end
------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local MyName = LocalPlayer.Name
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CollectEvent = ReplicatedStorage.GameEvents.Crops.Collect --  อ้างอิงจากบรรทัด 87
local GetMyFarm
local CollectFruit
local CheckFruit

local CollectFruitEnable = true

local CheckFruitType = true
local FruitType = { "Apple", "Elder Strawberry" }
local ExceptFruitType = false

local CheckMutant = true
local MutantType = { "Firework", "Wet" }
local ExceptMutant = false

local CheckVariant = true
local VariantType = "Normal" -- ใส่ชื่อ Variant ที่
local ExceptVariant = false

local CheckWeight = true
local WeightType = "more" -- "more" or "less"
local WeightValue = 100

GetMyFarm = function()
	local farmFolder = workspace:FindFirstChild("Farm")
	if not farmFolder then
		return nil
	end
	for _, oFarm in pairs(farmFolder:GetChildren()) do
		local success, owner = pcall(function()
			return oFarm.Important.Data.Owner.Value
		end)

		if success and owner == MyName then
			return oFarm
		end
	end
	return nil
end
--Collect Fruits

CheckFruit = function(model)
	local cType = false
	local cMutant = false
	local cVariant = false
	local cWeight = false

	if model:IsA("Model") then
		if CheckFruitType then
			local tFruitType = model.Name
			if table.find(FruitType, tFruitType) then
				if ExceptFruitType then
					cType = false
				else
					cType = true
				end
			else
				if ExceptFruitType then
					cType = true
				else
					cType = false
				end
			end
		else
			cType = true
		end

		if CheckMutant then
			local mHas = false
			for _, v in pairs(MutantType) do
				if model:GetAttribute(v) == true then
					mHas = true
					break
				end
			end
			if mHas then
				if ExceptMutant then
					cMutant = false
				else
					cMutant = true
				end
			else
				if ExceptMutant then
					cMutant = true
				else
					cMutant = false
				end
			end
		else
			cMutant = true
		end

		if CheckVariant then
			local tVariant = model:FindFirstChild("Weight").Variant
			if tVariant == VariantType then
				if ExceptVariant then
					cVariant = false
				else
					cVariant = true
				end
			else
				if ExceptVariant then
					cVariant = true
				else
					cVariant = false
				end
			end
		else
			cVariant=true
		end

		if CheckWeight then
			local tWeight = model:FindFirstChild("Weight").Value
			if WeightType == "more" then
				if tWeight >= WeightValue then
					cWeight = true
				end
			elseif WeightType == "less" then
				if tWeight < WeightValue then
					cWeight = true
				end
			end
		else
			cWeight=true
		end
	end
	return cType and cMutant and cVariant and cWeight
end




CheckFruit = function(model)
    -- 1. ตรวจสอบเบื้องต้นว่าเป็น Model หรือไม่
    if not model:IsA("Model") then return false end

    -- 2. ส่วนการตรวจสอบชนิดผลไม้ (Fruit Type)
    if CheckFruitType then
        local tFruitType = model.Name
        local isFound = table.find(FruitType, tFruitType) ~= nil
        
        -- ตรรกะ: หาก "เจอ" และ "ยกเว้น" มีค่าความจริงเหมือนกัน (เช่น เจอและสั่งยกเว้น) ถือว่าไม่ผ่าน
        if isFound == ExceptFruitType then 
            return false 
        end
    end

    -- 3. ส่วนการตรวจสอบการกลายพันธุ์ (Mutant)
    if CheckMutant then
        local hasMutant = false
        -- วนลูปตรวจสอบ Attribute ที่กำหนด
        for _, v in pairs(MutantType) do
            if model:GetAttribute(v) == true then
                hasMutant = true
                break
            end
        end
        
        if hasMutant == ExceptMutant then 
            return false 
        end
    end

    -- 4. ส่วนการตรวจสอบรูปแบบย่อย (Variant)
    if CheckVariant then
        local weightObj = model:FindFirstChild("Weight")
        -- เพิ่มความปลอดภัย: หากไม่พบ Object Weight ให้คืนค่า false (หรือปรับตามความเหมาะสม)
        if not weightObj then return false end

        local tVariant = weightObj.Variant
        local isVariantMatch = (tVariant == VariantType)

        if isVariantMatch == ExceptVariant then 
            return false 
        end
    end

    -- 5. ส่วนการตรวจสอบน้ำหนัก (Weight)
    if CheckWeight then
        local weightObj = model:FindFirstChild("Weight")
        if not weightObj then return false end
        
        local tWeight = weightObj.Value
        
        if WeightType == "more" then
            if not (tWeight >= WeightValue) then return false end
        elseif WeightType == "less" then
            if not (tWeight < WeightValue) then return false end
        end
    end

    -- หากผ่านการตรวจสอบทุกขั้นตอน ให้ถือว่าเป็นจริง
    return true
end

CollectFruit = function()
	local MyFarm = GetMyFarm()

	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")

	if Plants_Physical then
		for _, plant in pairs(Plants_Physical:GetChildren()) do
			local Fruits = plant:FindFirstChild("Fruits")
			if Fruits then
				for _, fruit in pairs(Fruits:GetChildren()) do
					if fruit:IsA("Model") then
						local Prompt_Part = fruit:FindFirstChild("2")

						if Prompt_Part then
							local Prompt = Prompt_Part:FindFirstChild("ProximityPrompt")
							if Prompt and Prompt.Enabled then
								-- AddLog("Auto Collect: " .. fruit.Name)

								CheckFruit(fruit)
								--if CheckFruit(fruit) then
								--CollectEvent:FireServer({ fruit })
								--end
							end
						end
					end
				end
			end
		end
	end
end

CollectFruit()
