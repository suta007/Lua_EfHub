--!nocheck

local Fluent = loadstring(
	game:HttpGet(
		"https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/FluentData/Renewed/Fluent.luau",
		true
	)
)()
local SaveManager = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau")
)()
local InterfaceManager = loadstring(
	game:HttpGet(
		"https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"
	)
)()
local CollapsibleAddon = loadstring(
	game:HttpGet("https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua")
)()

CollapsibleAddon(Fluent)
local Options = Fluent.Options

local QuickSave
local GetSelectedItems

local testPlant

local ReplicatedStorage = game:GetService("ReplicatedStorage")

local PetData = require(ReplicatedStorage.Data.PetRegistry.PetList)
local PetTable = {}
for petName, petInfo in pairs(PetData) do
	table.insert(PetTable, petName)
end

local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs)
local EggTable = {}
for EggName, v in pairs(PetEggs) do
	table.insert(EggTable, EggName)
end

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
	ScrollBarImageColor = Color3.fromRGB(255, 255, 255),
	ScrollBarImageTransparency = 0.5,
	ScrollBarBackgroundTransparency = 1,
})

local VirtualInputManager = game:GetService("VirtualInputManager")
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือ PlayerGui ถ้าใช้บน Local
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(101, 1, 1)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "FF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

-- กำหนดปุ่มที่ใช้ย่อ/ขยาย UI ตามตั้งค่าของ Fluent Renewed
local toggleKey = Enum.KeyCode.LeftControl

ToggleButton.MouseButton1Click:Connect(function()
	pcall(function()
		-- ซ่อน/แสดง UI แบบตรงๆ ข้ามระบบ Minimize ของ Library ไปเลย
		-- เช็คดูว่า Fluent เก็บ ScreenGui หรือ Frame หลักไว้ที่ตัวแปรไหน
		if Window.GUI then
			Window.GUI.Enabled = not Window.GUI.Enabled
		elseif Window.Instance then
			Window.Instance.Enabled = not Window.Instance.Enabled
		elseif Window.Root then
			Window.Root.Visible = not Window.Root.Visible
		end
	end)
end)

GetSelectedItems = function(DropdownValue)
	local Items = {}
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then
				table.insert(Items, Value)
			end
		end
	end
	return Items
end

local SpecialHatchType = {}
local SellPetType = {}
local PlaceEggList = {}
local EggHatchList = {}

local Tabs = {
	Pet = Window:AddTab({ Title = "Pet", Icon = "bone" }),
	Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}
Window:SelectTab(1)

Tabs.Pet:AddButton({
	Title = "Test Plant",
	Callback = function()
		testPlant()
	end,
})

local HatchSection = Tabs.Pet:AddCollapsibleSection("Auto Hatch Eggs", false)

HatchSection:AddToggle("tgPlaceEggsEn", {
	Title = "Place Eggs",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddPlaceEgg", {
	Title = "Select Eggs",
	Values = EggTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if GetSelectedItems then
			PlaceEggList = GetSelectedItems(Value)
		end
	end,
})

HatchSection:AddInput("ipMaxEggs", {
	Title = "Max Eggs",
	Default = 3,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddSpeedEggSlot", {
	Title = "Select Speed Loadout",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 1,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddInput("ipPlaceEggDelay", {
	Title = "Place Eggs Delay",
	Default = 0.2,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDivider()

HatchSection:AddToggle("tgAutoHatchEn", {
	Title = "Auto Hatch",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
local tempTable = { "ALL" }
table.move(EggTable, 1, #EggTable, 2, tempTable)
HatchSection:AddDropdown("ddEggHatch", {
	Title = "Select Egg to Hatch",
	Values = tempTable,
	Multi = true,
	Default = { "ALL" },
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if GetSelectedItems then
			EggHatchList = GetSelectedItems(Value)
		end
	end,
})

HatchSection:AddDropdown("ddHatchSlot", {
	Title = "Select Hatch Loadout",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 2,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddInput("ipHatchDelay", {
	Title = "Hatch Egg Delay",
	Default = 0.2,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddInput("ipSpecialHatchWeight", {
	Title = "Special Hatch Weight",
	Description = "Special Hatch if Weight above (0 = disable)",
	Default = 0,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddSpecialHatchType", {
	Title = "Special Hatch Pet",
	Values = PetTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if GetSelectedItems then
			SpecialHatchType = GetSelectedItems(Value)
		end
	end,
})

HatchSection:AddDivider()

HatchSection:AddToggle("tgSellPetEn", {
	Title = "Auto Sell Pet",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddSellPetSlot", {
	Title = "Select Sell Pet Loadout",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 3,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddSellPetType", {
	Title = "Sell Pet Type",
	Values = PetTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if GetSelectedItems then
			SellPetType = GetSelectedItems(Value)
		end
	end,
})

HatchSection:AddDropdown("ddSellMode", {
	Title = "Sell Pet Mode",
	Values = { "White list", "Black list" },
	Default = "White list",
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddInput("ipSellWeight", {
	Title = "Sell Pet Weight",
	Description = "(0 = disable)",
	Default = 0,
	Numeric = true,
	Finished = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddDropdown("ddSellWeightMode", {
	Title = "Sell Weight Mode",
	Values = { "Below", "Above" },
	Default = "Below",
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

HatchSection:AddToggle("tgSellMutantPet", {
	Title = "Sell Mutant Pet",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/test")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

SaveManager:Load("TestHatch")

QuickSave = function()
	SaveManager:Save("TestHatch")
end

Fluent:Notify({
	Title = "EfHub",
	Content = "Settings loaded automatically",
	Duration = 3,
})

---ของเก่า
local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local heldItemName

--ของใหม่
--Function
local PlaceEggs, HatchEgg, EggInFarm
local getBoundary, getPlate
--Variable
local isPlaceEgg = false
local isHatchEgg = false

GetMyFarm = function()
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

local MyFarm = GetMyFarm()

heldItemName = function(itemName) -- find item in backpack and select it
	for _, item in ipairs(Backpack:GetChildren()) do
		local name = string.match(item.Name, "^(.-)%s*%[") or string.match(item.Name, "^(.-)%s*[xX]%d+") or item.Name
		name = string.gsub(name, "^%s*(.-)%s*$", "%1")
		--name = string.trim(name)
		if name == itemName then
			pcall(function()
				Humanoid:EquipTool(item)
			end)
			return true
		end
	end
	return false
end

getBoundary = function(plate)
	if not plate then
		return nil
	end

	local bCf = plate.CFrame
	local size = plate.Size

	local bMinX, bMaxX = -size.X / 2 + 1, size.X / 2 - 1
	local bMinZ, bMaxZ = -size.Z / 2 + 1, size.Z / 2 - 1
	return {
		cf = bCf,
		minX = bMinX,
		maxX = bMaxX,
		minZ = bMinZ,
		maxZ = bMaxZ,
	}
end

getPlate = function()
	local myPlate = {}
	local plantLocations = MyFarm.Important.Plant_Locations:GetChildren()
	for _, plate in pairs(plantLocations) do
		if plate.Name == "Can_Plant" or plate:IsA("Part") then
			table.insert(myPlate, plate)
		end
	end
	return myPlate
end

testPlant = function()
	local Plate = getPlate()
	local Boundary = getBoundary(Plate[2])
	local x = Boundary.maxX
	local y = 0.1355266571044922
	local z = Boundary.minZ
	local cf = Boundary.cf
	local farmEgg = {}
	repeat
		if z > Boundary.maxZ then
			x = x - 4
			z = Boundary.minZ
		end
		if x < Boundary.minX then
			return
		end
		local NewPos = (cf * CFrame.new(x, 0, z)).Position
		local finalPos = Vector3.new(NewPos.X, y, NewPos.Z)
		heldItemName("Common Egg")
		GameEvents:WaitForChild("PetEggService"):FireServer("CreateEgg", finalPos)
		z = z + 4
		task.wait(1)
		farmEgg = EggInFarm() or {}
	until #farmEgg >= 4
end

EggInFarm = function()
	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Objects_Physical = Farm_Important and Farm_Important:FindFirstChild("Objects_Physical")
	local tempEggInFarm = {}
	if Objects_Physical then
		for _, oEgg in pairs(Objects_Physical:GetChildren()) do
			if oEgg and oEgg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
				table.insert(tempEggInFarm, oEgg)
			end
		end
	end
	return tempEggInFarm
end

HatchEgg = function()
	if Options.tgAutoHatchEn.Value then
		if isHatchEgg then
			return
		end
		if #EggHatchList == 0 then
			return
		end
		isHatchEgg = true
		local myEggs = EggInFarm()
		for _, nEggs in pairs(myEggs) do
			if nEggs:GetAttribute("READY") then
				if table.find(EggHatchList, "ALL") or table.find(EggHatchList, nEggs:GetAttribute("EggName")) then
					GameEvents.PetEggService:FireServer("HatchPet", nEggs)
				end
			end
			task.wait(tonumber(Options.ipHatchDelay.Value))
			Humanoid:UnequipTools()
		end
		isHatchEgg = false
	end
end

placeEggs = function()
	if Options.tgPlaceEggsEn.Value then
		if #PlaceEggList == 0 then
			return nil
		end
		local MaxEgg = tonumber(Options.ipMaxEggs.Value)
		for i = 1, MaxEgg do
			local myIndex = Random.new():NextInteger(1, #PlaceEggList)
			local Egg = PlaceEggList[myIndex]
			print(Egg)
			heldItemName(Egg)
			task.wait(1)
		end
		print("+++++++++++++++")
	end
end

task.spawn(function()
	while true do
		if Options.tgPlaceEggsEn.Value then
			placeEggs()
		end
		task.wait(5)
	end -- ปิด while
end)

task.spawn(function()
	while true do
		if Options.tgAutoHatchEn.Value then
			HatchEgg()
		end
		task.wait()
	end -- ปิด while
end)
