local Fluent = loadstring(
	game:HttpGet(
		"https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau",
		true
	)
)()
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Lighting = game:GetService("Lighting")

local Window = Fluent:CreateWindow({
	Title = "EfHub",
	SubTitle = "by suta007",
	TabWidth = 120,
	Size = UDim2.fromOffset(960, 720),
	Resize = true,
	Acrylic = true,
	Theme = "Darker",
	TopBarOverflow = 0,
	MinimizeKey = Enum.KeyCode.LeftControl,
	ScrollBarThickness = 3,
	ScrollBarImageColor = Color3.fromRGB(100, 33, 33),
	ScrollBarImageTransparency = 0.5,
	ScrollBarBackgroundTransparency = 1,
})

local Tabs = { Main = Window:AddTab({ Title = "main", Icon = "house" }) }
Window:SelectTab(1)
-- ตัวแปรเก็บสถานะของ Toggle เพื่อให้ Event ดักจับทำงานได้ถูกต้อง
local hideTrees = false
local hideFruits = false

-- 1. ฟังก์ชันหา Path หลัก (ป้องกัน Error)
local function GetPlantsFolder()
	local farm1 = workspace:FindFirstChild("Farm")
	if not farm1 then
		return nil
	end
	local farm2 = farm1:FindFirstChild("Farm")
	if not farm2 then
		return nil
	end
	local important = farm2:FindFirstChild("Important")
	if not important then
		return nil
	end
	return important:FindFirstChild("Plants_Physical")
end

-- 2. ฟังก์ชันตรวจสอบว่าเป็น "ผลไม้" หรือไม่ (เช็คจากโฟลเดอร์แม่)
local function IsFruit(object)
	local current = object
	-- วนลูปถอยกลับไปดูโฟลเดอร์แม่เรื่อยๆ จนกว่าจะเจอ Workspace
	while current and current ~= workspace do
		if current.Name == "Fruits" then
			return true
		end
		current = current.Parent
	end
	return false
end

-- 3. ฟังก์ชันจัดการความโปร่งใสและ Effect (ใช้ตัวเดิมที่เสถียรแล้ว)
local function SetVisibility(object, isHidden)
	if object:IsA("BasePart") or object:IsA("MeshPart") or object:IsA("Decal") or object:IsA("Texture") then
		if isHidden then
			if not object:GetAttribute("OriginalTrans") then
				object:SetAttribute("OriginalTrans", object.Transparency)
			end
			object.Transparency = 1
		else
			local originalTrans = object:GetAttribute("OriginalTrans")
			if originalTrans then
				object.Transparency = originalTrans
			end
		end
	elseif object:IsA("ParticleEmitter") or object:IsA("Sparkles") or object:IsA("Fire") or object:IsA("Trail") then
		if isHidden then
			if object:GetAttribute("OriginalEnabled") == nil then
				object:SetAttribute("OriginalEnabled", object.Enabled)
			end
			object.Enabled = false
		else
			local originalEnabled = object:GetAttribute("OriginalEnabled")
			if originalEnabled ~= nil then
				object.Enabled = originalEnabled
			end
		end
	end
end

-- ==========================================
-- สร้าง UI Toggle ใน Fluent Renewed
-- ==========================================

-- Toggle 1: ซ่อนต้นไม้ (ไม่รวมผล)
local TreeToggle = Tabs.Main:AddToggle("TreeToggle", {
	Title = "ซ่อนต้นไม้ (เหลือไว้แต่ผลไม้)",
	Default = false,
	Callback = function(state)
		hideTrees = state
		local plantsFolder = GetPlantsFolder()
		if plantsFolder then
			-- วนลูปหาทุกชิ้นส่วนใน Plants_Physical
			for _, obj in ipairs(plantsFolder:GetDescendants()) do
				-- ถ้า "ไม่ใช่" ผลไม้ ให้ปรับความโปร่งใสตามสถานะ Toggle ต้นไม้
				if not IsFruit(obj) then
					SetVisibility(obj, state)
				end
			end
		end
	end,
})

-- Toggle 2: ซ่อนผลไม้ทั้งหมด
local FruitToggle = Tabs.Main:AddToggle("FruitToggle", {
	Title = "ซ่อนผลไม้",
	Default = false,
	Callback = function(state)
		hideFruits = state
		local plantsFolder = GetPlantsFolder()
		if plantsFolder then
			for _, obj in ipairs(plantsFolder:GetDescendants()) do
				-- ถ้า "เป็น" ผลไม้ ให้ปรับความโปร่งใสตามสถานะ Toggle ผลไม้
				if IsFruit(obj) then
					SetVisibility(obj, state)
				end
			end
		end
	end,
})

-- ==========================================
-- ระบบดักจับแบบ Real-time (ทำงานตลอดเวลาเมื่อมีของเกิดใหม่)
-- ==========================================
local plantsFolder = GetPlantsFolder()
if plantsFolder then
	plantsFolder.DescendantAdded:Connect(function(newObj)
		task.wait() -- รอชิ้นส่วนโหลด properties ให้ครบ

		if IsFruit(newObj) then
			-- ถ้าสิ่งที่งอกมาใหม่คือผลไม้ เช็คว่า Toggle ผลไม้เปิดอยู่ไหม
			if hideFruits then
				SetVisibility(newObj, true)
			end
		else
			-- ถ้าสิ่งที่งอกมาใหม่คือต้น/ใบ เช็คว่า Toggle ต้นไม้เปิดอยู่ไหม
			if hideTrees then
				SetVisibility(newObj, true)
			end
		end
	end)
end

-- ซ่อนสวน

-- 1. เตรียม Folder ชั่วคราวสำหรับเก็บสวนคนอื่น (เอาไว้บนสุดของสคริปต์)
local CacheFolder = Lighting:FindFirstChild("EfHub_FarmCache")
if not CacheFolder then
	CacheFolder = Instance.new("Folder")
	CacheFolder.Name = "EfHub_FarmCache"
	CacheFolder.Parent = Lighting
end

-- 2. ฟังก์ชันแยกสำหรับจัดการซ่อน/แสดงสวนคนอื่น
local function ToggleOtherFarms(state)
	local mainFarmFolder = workspace:FindFirstChild("Farm")
	-- ถ้าหาโฟลเดอร์หลักไม่เจอ ให้หยุดการทำงานทันทีเพื่อป้องกัน Error
	if not mainFarmFolder then
		return
	end

	if state then
		-- เปิดโหมดซ่อน: ค้นหาและย้ายสวนคนอื่นไปไว้ใน Cache
		for _, farmObj in ipairs(mainFarmFolder:GetChildren()) do
			if farmObj.Name == "Farm" then
				local important = farmObj:FindFirstChild("Important")
				if important then
					local data = important:FindFirstChild("Data")
					if data then
						local ownerVal = data:FindFirstChild("Owner")
						if ownerVal then
							local ownerName = tostring(ownerVal.Value)

							-- เช็คว่าไม่ใช่สวนของเรา และไม่ใช่ค่าว่าง
							if ownerName ~= LocalPlayer.Name then
								farmObj.Parent = CacheFolder
							end
						end
					end
				end
			end
		end
	else
		-- ปิดโหมดซ่อน: นำสวนทั้งหมดใน Cache กลับมาไว้ที่ Workspace เหมือนเดิม
		for _, cachedFarm in ipairs(CacheFolder:GetChildren()) do
			cachedFarm.Parent = mainFarmFolder
		end
	end
end

-- 3. ส่วนของการสร้าง UI ใน Fluent Renewed
-- โค้ดตรงนี้จะสั้นและคลีนมาก เพราะเราดึงฟังก์ชันมาเรียกใช้แค่นั้นค่ะ
local HideOthersToggle = Tabs.Main:AddToggle("HideOthersToggle", {
	Title = "ซ่อนสวนคนอื่น (ลดแลค)",
	Default = false,
	Callback = function(state)
		-- เรียกใช้งานฟังก์ชันที่เราแยกไว้
		ToggleOtherFarms(state)
	end,
})
