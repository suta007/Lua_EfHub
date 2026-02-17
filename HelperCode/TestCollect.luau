-- ==================================================================
-- ส่วนประกาศตัวแปรและ Service
-- ==================================================================
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local Players = game.Players
local LocalPlayer = Players.LocalPlayer
local MyName = LocalPlayer.Name
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
-- Module ของเกม
local InventoryService = require(ReplicatedStorage.Modules.InventoryService)
local CollectEvent = ReplicatedStorage.GameEvents.Crops.Collect

-- ตัวแปรระบบคิว (Queue System)
local FruitQueue = {} -- ตระกร้าพักผลไม้ที่รอเก็บ
local IsScanning = false -- สถานะว่ากำลังสแกนหาอยู่หรือไม่
--local tgCollectFruitEnable = true
-- ==================================================================
-- 1. ฟังก์ชันพื้นฐาน (Original Helpers)
-- ==================================================================

-- ฟังก์ชันหา Farm ของเรา
local function GetMyFarm()
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
local CheckFruitType = true
local FruitType = { "Tomato" }
-- ฟังก์ชันตรวจสอบเงื่อนไขผลไม้ (คงเดิมตามที่พี่เอฟเขียนไว้)
local function CheckFruit(model)
	if not model or not model:IsA("Model") then
		return false
	end

	-- 1. เช็คชื่อผลไม้ (Type)
	if CheckFruitType then
		local tFruitType = model.Name
		local isFound = table.find(FruitType, tFruitType) ~= nil
		if isFound == ExcludeFruitType then
			return false
		end
	end

	-- 2. เช็ค Mutant
	if CheckMutant then
		local hasMutant = false
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

	-- 3. เช็ค Variant
	if CheckVariant then
		local VariantObj = model:FindFirstChild("Variant")
		if not VariantObj then
			return false
		end
		local tVariant = VariantObj.Value
		local isVariantMatch = (tVariant == VariantType)
		if isVariantMatch == ExceptVariant then
			return false
		end
	end

	-- 4. เช็คน้ำหนัก (Weight)
	if CheckWeight then
		local weightObj = model:FindFirstChild("Weight")
		if not weightObj then
			return false
		end
		local tWeight = weightObj.Value
		if WeightType == "Above" and not (tWeight >= WeightValue) then
			return false
		elseif WeightType == "Below" and not (tWeight < WeightValue) then
			return false
		end
	end

	return true
end

-- ==================================================================
-- 2. ส่วนสแกนหาผลไม้ (Producer)
-- หน้าที่: วนลูปหาผลไม้แล้วยัดใส่ตระกร้า (FruitQueue)
-- ==================================================================
local function ScanFarmTask()
	if IsScanning then
		print("Wait")
		return
	end
	IsScanning = true

	task.spawn(function()
		-- เคลียร์คิวเก่าทิ้งก่อนเริ่มรอบใหม่ เพื่อความสดใหม่ของข้อมูล
		table.clear(FruitQueue)

		local MyFarm = GetMyFarm()
		if not MyFarm then
			IsScanning = false
			return
		end
		print("Start Scan")
		local Farm_Important = MyFarm:FindFirstChild("Important")
		local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")

		if Plants_Physical then
			local count = 0

			-- ใช้ ipairs เพื่อความเร็วในการวนลูป Array
			for _, plant in ipairs(Plants_Physical:GetChildren()) do
				-- หยุดสแกนทันทีถ้าผู้ใช้ปิด Function
				if not Options.tgCollectFruitEnable.Value then
					break
				end

				-- ตรวจสอบว่าในต้นไม้นั้นมี Folder Fruits หรือไม่ (บางทีผลไม้อยู่ใน plant เลย)
				local FruitsContainer = plant:FindFirstChild("Fruits")
				local itemsToCheck = FruitsContainer and FruitsContainer:GetChildren() or { plant }

				for _, item in ipairs(itemsToCheck) do
					if item:IsA("Model") then
						-- Optimization: เช็ค ProximityPrompt ก่อนเรียก CheckFruit
						-- (เพราะ CheckFruit กินทรัพยากรเยอะกว่า)
						local Prompt = item:FindFirstChild("ProximityPrompt", true)

						if Prompt and Prompt.Enabled then
							if CheckFruit(item) then
								table.insert(FruitQueue, item)
							end
						end
					end
				end

				-- Optimization: พักหายใจทุกๆ 50 ต้นไม้ ป้องกันเกมค้าง (Lag)
				count = count + 1
				if count % 50 == 0 then
					task.wait()
				end
			end
		end
		IsScanning = false
	end)
end

-- ==================================================================
-- 3. ส่วนไล่เก็บผลไม้ (Consumer Loop)
-- หน้าที่: เฝ้าตระกร้า ถ้ามีของก็หยิบไปเก็บ และเช็คกระเป๋าทุกครั้ง
-- ==================================================================

-- เริ่มการทำงานทันที (แยก Thread ออกมา)
task.spawn(function()
	while true do
		-- 1. เช็คว่าเปิดใช้งานบอทหรือไม่
		if not Options.tgCollectFruitEnable.Value then
			table.clear(FruitQueue) -- ล้างคิวทิ้งถ้าปิดบอท
			task.wait(1)
			continue
		end

		-- 2. เช็คกระเป๋าเต็ม (สำคัญที่สุด!)
		-- เช็คก่อนที่จะเริ่มหยิบของออกจากคิว
		local success, isFull = pcall(function()
			return InventoryService.IsMaxInventory(LocalPlayer)
		end)

		if success and isFull then
			-- ถ้ากระเป๋าเต็ม: ล้างคิวทิ้ง เพื่อไม่ให้เก็บต่อ และรอ 1 วินาที
			table.clear(FruitQueue)
			-- print("Inventory Full - Paused")
			task.wait(1)
			continue
		end

		-- 3. การทำงานเมื่อมีของในคิว (Queue Processing)
		if #FruitQueue > 0 then
			print("More")
			-- ดึงผลไม้ชิ้นแรกออกจากคิว (FIFO)
			local itemToCollect = table.remove(FruitQueue, 1)

			-- เช็คซ้ำอีกครั้งว่าของยังอยู่จริงไหม (เผื่อโดนเก็บไปแล้ว หรือหลุดโหลด)
			if itemToCollect and itemToCollect.Parent and itemToCollect:FindFirstChild("ProximityPrompt", true) then
				-- ส่งคำสั่งเก็บ
				CollectEvent:FireServer({ itemToCollect })

				-- รอตาม Delay ที่ตั้งไว้
				task.wait(CollectDelay)
			end
		else
			print("less")
			-- 4. ถ้าคิวว่าง (ไม่มีของให้เก็บ)
			-- สั่งให้ Producer เริ่มสแกนหารอบใหม่
			if not IsScanning then
				print("Scan")
				ScanFarmTask()
			end
			-- รอสักพักก่อนวนลูปเช็คใหม่ เพื่อลดการกิน CPU ตอนว่างงาน
			task.wait(0.5)
		end

		-- Safety Yield (ป้องกัน Script Crash)
		task.wait()
	end
end)

---local AutoSellALL = true

task.spawn(function()
	pcall(function()
		while Options.AutoSellALL.Value do
			local success, isFull = pcall(function()
				return InventoryService.IsMaxInventory(LocalPlayer)
			end)

			if success and isFull then
				local Previous = Character:GetPivot()
				Character:PivotTo(CFrame.new(62, 4, -26))
				task.wait(0.3)
				GameEvents.Sell_Inventory:FireServer()
				task.wait(0.5)
				Character:PivotTo(Previous)
			end
			task.wait(0.5)
		end
	end)
end)
