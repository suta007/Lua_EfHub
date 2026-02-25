local LocalPlayer = game:GetService("Players").LocalPlayer
local CoreGui = game:GetService("CoreGui")
local RunService = game:GetService("RunService")

-- สร้างโฟลเดอร์สำหรับเก็บ ESP (ถ้ารันซ้ำจะได้ลบของเก่าทิ้งได้)
local espFolderName = "EfHub_EggESP"
if CoreGui:FindFirstChild(espFolderName) then
	CoreGui[espFolderName]:Destroy()
end

local ESPFolder = Instance.new("Folder")
ESPFolder.Name = espFolderName
ESPFolder.Parent = gethui and gethui() or CoreGui -- รองรับ Delta Executor

local function createEggESP(oEgg, uuid, fData)
	local PetHatchData = fData[uuid]
	if not PetHatchData or not PetHatchData.Data then
		return
	end

	local petType = PetHatchData.Data.Type or "Unknown"

	-- 1. ดึงค่าดิบทศนิยมยาวๆ มาเลย (เช่น 1.3984183401395462)
	local rawBaseWeight = PetHatchData.Data.BaseWeight or 0

	-- 2. ดึงค่าโอกาสออก (จากข้อมูลที่พี่เอฟหามาได้)
	local normalizedOdd = 0
	if PetHatchData.Data.RandomPetData and PetHatchData.Data.RandomPetData.NormalizedOdd then
		normalizedOdd = PetHatchData.Data.RandomPetData.NormalizedOdd
	end

	-- 3. เอาค่าดิบมาคูณ 1.1 ให้เสร็จก่อน
	local estimatedWeight = rawBaseWeight * 1.1

	-- สร้าง BillboardGui (โค้ดส่วน UI เหมือนเดิม)
	local bgui = Instance.new("BillboardGui")
	bgui.Name = "ESP_" .. uuid
	bgui.Adornee = oEgg
	bgui.Size = UDim2.new(0, 150, 0, 60) -- เพิ่มความสูงนิดนึงให้พอดี 3 บรรทัด
	bgui.StudsOffset = Vector3.new(0, 3.5, 0)
	bgui.AlwaysOnTop = true
	bgui.Parent = ESPFolder

	local textLabel = Instance.new("TextLabel")
	textLabel.Parent = bgui
	textLabel.Size = UDim2.new(1, 0, 1, 0)
	textLabel.BackgroundTransparency = 1

	-- 4. แสดงผล: ใช้ string.format("%.2f") เพื่อปัดเศษแค่ตอนโชว์ให้ตาเห็น
	textLabel.Text = string.format("🐣 %s\n⚖️ %.2f kg", tostring(petType), tonumber(estimatedWeight))

	-- ไฮไลท์สีตามน้ำหนักคาดการณ์ (ถ้าฟักออกมาเกิน 2.0 ให้เป็นสีแรร์)
	if estimatedWeight >= 3.5 then
		textLabel.TextColor3 = Color3.fromRGB(255, 85, 85) -- สีชมพู
	else
		textLabel.TextColor3 = Color3.fromRGB(200, 200, 200) -- สีเขียว
	end

	textLabel.TextStrokeTransparency = 0
	textLabel.TextSize = 14
	textLabel.Font = Enum.Font.GothamBold
end

local function GetMyFarm()
	local farmFolder = workspace:FindFirstChild("Farm")
	if not farmFolder then
		return nil
	end
	for _, oFarm in pairs(farmFolder:GetChildren()) do
		local success, owner = pcall(function()
			return oFarm.Important.Data.Owner.Value
		end)

		if success and owner == LocalPlayer.Name then
			return oFarm
		end
	end
	return nil
end

-- ฟังก์ชันสแกนหาไข่ในฟาร์ม
local function scanAndCreateESP()
	local MyFarm = GetMyFarm() -- ใช้ฟังก์ชันเดิมของพี่เอฟ
	if not MyFarm then
		return
	end

	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Objects_Physical = Farm_Important and Farm_Important:FindFirstChild("Objects_Physical")

	if Objects_Physical then
		-- ลบป้ายเก่าทิ้งทั้งหมดก่อนสร้างใหม่ (ป้องกันป้ายค้างเวลาไข่ฟักไปแล้ว)
		ESPFolder:ClearAllChildren()

		-- ดึงข้อมูล DataService ล่าสุด
		local ReplicatedStorage = game:GetService("ReplicatedStorage")
		local DataService = require(ReplicatedStorage.Modules.DataService)
		local GetData_result = DataService:GetData()
		local fData = GetData_result.SaveSlots.AllSlots.DEFAULT.SavedObjects

		for _, oEgg in pairs(Objects_Physical:GetChildren()) do
			if oEgg and oEgg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
				local uuid = oEgg:GetAttribute("OBJECT_UUID")
				if uuid then
					createEggESP(oEgg, uuid, fData)
				end
			end
		end
	end
end

-- รันสแกน 1 ครั้งเพื่อแสดงผลทันที
scanAndCreateESP()

-- โบนัส: ตั้งลูปให้มันอัปเดตข้อมูลอัตโนมัติทุกๆ 5 วินาที
task.spawn(function()
	while task.wait(5) do
		-- ถ้าโฟลเดอร์ ESP ถูกปิดหรือลบทิ้ง ให้หยุดการทำงานของลูป
		if not CoreGui:FindFirstChild(espFolderName) then
			break
		end
		scanAndCreateESP()
	end
end)
