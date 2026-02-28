--!strict
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

local Window = Fluent:CreateWindow({
	Title = "Grow a Garden ",
	SubTitle = "by EfHub",
	TabWidth = 100,
	Size = UDim2.fromOffset(1400, 900),
	Resize = true,
	MinSize = Vector2.new(580, 460),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local QuickSave, SyncBackgroundTasks
local FruitData = require(game:GetService("ReplicatedStorage").Data.SeedData) -- This is table data of seeds
local FruitTable = {}
for FruitName, FruitInfo in pairs(FruitData) do
	table.insert(FruitTable, FruitName)
end
table.sort(FruitTable)

local Tabs = {
	Auto = Window:AddTab({ Title = "Automatic", Icon = "robot" }),
}

local Options = Fluent.Options

Window:SelectTab(1)

--[[ Automatic Section In Automatic tab]]
local ShovelSection = Tabs.Auto:AddCollapsibleSection("Shovel", false)

ShovelSection:AddToggle("tgAutoPlantShovel", {
	Title = "Auto Plant Shovel",
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

local tempShovelDD = { "ALL" }
table.move(FruitTable, 1, #FruitTable, 2, tempShovelDD)

ShovelSection:AddDropdown("ddShovelPlant", {
	Title = "Select Plant(s) to Shovel",
	Values = tempShovelDD,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

ShovelSection:AddDivider()

ShovelSection:AddToggle("tgAutoCropShovel", {
	Title = "Auto Crop Shovel",
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

ShovelSection:AddDropdown("ddShovelCrop", {
	Title = "Select Crop(s) to Shovel",
	Values = tempShovelDD,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Add a lot of Fruit Shovel Conditions ]]
ShovelSection:AddDivider()

--[[ Shovel Cosmetic]]
ShovelSection:AddToggle("tgShovelCosmetic", {
	Title = "Shovel All Cosmetic",
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

local ReclaimSection = Tabs.Auto:AddCollapsibleSection("Reclaim", false)
ReclaimSection:AddToggle("tgReclaim", {
	Title = "Reclaim",
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

ReclaimSection:AddDropdown("ddReclaim", {
	Title = "Reclaim Type",
	Values = tempShovelDD,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Trowel Section ]]
local TrowelSection = Tabs.Auto:AddCollapsibleSection("Trowel", false)
TrowelSection:AddToggle("tgTrowel", {
	Title = "Trowel",
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

TrowelSection:AddDropdown("ddTrowel", {
	Title = "Trowel Type",
	Values = tempShovelDD,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
