-- Task Add getgenv().EfHub_ prefix to all functions ans Variables
local Fluent = loadstring(
	game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau")
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

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/GAG")

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")

local LocalPlayer = game:GetService("Players").LocalPlayer
local MyName = LocalPlayer.Name
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")
local VirtualUser = game:GetService("VirtualUser")
local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain
local CollectEvent = ReplicatedStorage.GameEvents.Crops.Collect
local InventoryService = require(ReplicatedStorage.Modules.InventoryService)

getgenv().EfHub_ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService)
getgenv().EfHub_PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry)
getgenv().EfHub_DataService = require(ReplicatedStorage.Modules.DataService)

-- alias getgenv services to locals for faster lookup / correct references
local DataService = getgenv().EfHub_DataService
local ActivePetsService = getgenv().EfHub_ActivePetsService
local PetMutationRegistry = getgenv().EfHub_PetMutationRegistry

--[[ Anti-AFK ]]

LocalPlayer.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

-- Variables USE Table
local IsLoading = true

getgenv().EfHub_DevMode = true
getgenv().EfHub_Main =
	{ SeedShop = {}, GearShop = {}, EggShop = {}, Pet = {}, Mutant = {}, FruitMutant = {}, Fruit = {} } -- MyFarm, FarmPoint
getgenv().EfHub_Pet = { Mutanting = false } -- Mutanting
getgenv().EfHub_Farm = {
	CollectFruitEnable = false,
	CollectDelay = 0.3,
	CheckFruitType = false,
	FruitType = {},
	ExcludeFruitType = false,
	CheckMutant = false,
	MutantType = {},
	ExceptMutant = false,
	CheckVariant = false,
	VariantType = "Normal",
	ExceptVariant = false,
	CheckWeight = false,
	WeightType = "Below",
	WeightValue = 100,
}

--function

local DevNoti
local QuickSave
local GetSelectedItems
local DevLog
local targetUUID
getgenv().EfHub_targetUUID = ""
getgenv().EfHub_MainFunc = {} -- GetMyFarm, ApplyAntiLag,BuildMutationCache
getgenv().EfHub_PetFunc = {} -- GetEquippedPetsUUID, GetRawPetData, GetPetLevel, GetPetMutation, GetPetHunger, GetPetType, GetPetFavorite, GetPetHungerPercent, GetPetUUID, EquipPet, UnequipPet, SwapPetLoadout, heldPet, IsActivePet, MakeMutant, Mutation, ClaimMutantPet, FeedPet
getgenv().EfHub_ItemFunc = {} --heldItemUUID, heldItemName
getgenv().EfHub_BuyFunc = {} -- ProcessBuy,
getgenv().EfHub_FarmFunc = {} -- FindFruitInv, CheckFruit, CollectFruit

-- getgenv().EfHub_Main
getgenv().EfHub_Main.SeedShop.Data = require(game:GetService("ReplicatedStorage").Data.SeedShopData) -- This is table data of seeds
getgenv().EfHub_Main.SeedShop.Table = {}
for seedName, seedInfo in pairs(getgenv().EfHub_Main.SeedShop.Data) do
	table.insert(getgenv().EfHub_Main.SeedShop.Table, seedName)
end

getgenv().EfHub_Main.GearShop.Data = require(game:GetService("ReplicatedStorage").Data.GearShopData)
getgenv().EfHub_Main.GearShop.Table = {}
for gearName, gearInfo in pairs(getgenv().EfHub_Main.GearShop.Data["Gear"]) do
	table.insert(getgenv().EfHub_Main.GearShop.Table, gearName)
end

getgenv().EfHub_Main.EggShop.Data = require(game:GetService("ReplicatedStorage").Data.PetEggData)
getgenv().EfHub_Main.EggShop.Table = {}
for eggName, eggInfo in pairs(getgenv().EfHub_Main.EggShop.Data) do
	table.insert(getgenv().EfHub_Main.EggShop.Table, eggName)
end

getgenv().EfHub_Main.Pet.Data = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetList)
local PetTable = {}
local HungerTable = {}
for petName, petInfo in pairs(getgenv().EfHub_Main.Pet.Data) do
	table.insert(PetTable, petName)
	HungerTable[petName] = petInfo["DefaultHunger"]
end
getgenv().EfHub_Main.Pet.Table = PetTable
getgenv().EfHub_Main.Pet.Hunger = HungerTable

getgenv().EfHub_Main.Mutant.Data = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry)
local MutantTable = {}
local EnumToNameCache = {}
for mutantName, mutantInfo in pairs(getgenv().EfHub_Main.Mutant.Data["PetMutationRegistry"]) do
	if type(mutantInfo) == "table" and mutantInfo.EnumId then
		table.insert(MutantTable, mutantName)
		EnumToNameCache[mutantInfo.EnumId] = mutantName
	end
end
getgenv().EfHub_Main.Mutant.Table = MutantTable
getgenv().EfHub_Main.Mutant.Enum = EnumToNameCache

getgenv().EfHub_Main.FruitMutant.Data = DataService:GetData().GardenGuide.MutationData
local FruitMutantTable = {}
for MutationName, MutationInfo in pairs(getgenv().EfHub_Main.FruitMutant.Data) do
	table.insert(FruitMutantTable, MutationName)
end
getgenv().EfHub_Main.FruitMutant.Table = FruitMutantTable

getgenv().EfHub_Main.Fruit.Data = require(game:GetService("ReplicatedStorage").Data.SeedData)

local FruitTable = {}
for FruitName, FruitInfo in pairs(getgenv().EfHub_Main.Fruit.Data) do
	table.insert(FruitTable, FruitName)
end
getgenv().EfHub_Main.Fruit.Table = FruitTable

local ShopKey = {
	Seed = "ROOT/SeedStocks/Shop/Stocks",
	Daily = "ROOT/SeedStocks/Daily Deals/Stocks",
	Gear = "ROOT/GearStock/Stocks",
	Egg = "ROOT/PetEggStock/Stocks",
	Santa = "ROOT/EventShopStock/Santa's Stash/Stocks",
	NewYear = "ROOT/EventShopStock/New Years Shop/Stocks",
	Traveling = "ROOT/TravelingMerchantShopStock/Stocks",
}

getgenv().EfHub_BuyList = {
	[ShopKey.Seed] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuySeedStock",
		ArgType = "SeedMode",
	},
	[ShopKey.Daily] = {
		Enabled = true,
		BuyAll = true,
		Items = {},
		RemoteName = "BuyDailySeedShopStock",
		ArgType = "NormalMode",
	},
	[ShopKey.Gear] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuyGearStock",
		ArgType = "NormalMode",
	},
	[ShopKey.Egg] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuyPetEgg",
		ArgType = "NormalMode",
	},
	[ShopKey.Traveling] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuyTravelingMerchantShopStock",
		ArgType = "NormalMode",
	},
	[ShopKey.Santa] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuyEventShopStock",
		ArgType = "EventMode",
		EventArg = "Santa's Stash",
	},
	[ShopKey.NewYear] = {
		Enabled = false,
		BuyAll = false,
		Items = {},
		RemoteName = "BuyEventShopStock",
		ArgType = "EventMode",
		EventArg = "New Years Shop",
	},
}

local function isTableEmpty(t)
	return type(t) ~= "table" or next(t) == nil
end

DevNoti = function(content)
	if getgenv().EfHub_DevMode then
		--[[         Fluent:Notify({
            Title = "EfHub - Dev Mode",
            Content = content,
            Duration = 5
        }) ]]
		if DevLog then
			DevLog(content)
		end
	end
end

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

QuickSave = function()
	if not IsLoading then
		SaveManager:Save("EfHub")
	end
end

local Window = Fluent:CreateWindow({
	Title = "Grow a Garden",
	SubTitle = "by EfHub",
	TabWidth = 100,
	Size = UDim2.fromOffset(1280, 800),
	Resize = true,
	MinSize = Vector2.new(1000, 720),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({
		Title = "Main",
		Icon = "home",
	}),
	Buy = Window:AddTab({
		Title = "Buy",
		Icon = "shopping-cart",
	}),
	Pet = Window:AddTab({
		Title = "Pet",
		Icon = "bone",
	}),
	Farm = Window:AddTab({
		Title = "Farm",
		Icon = "tree-pine",
	}),
	Log = Window:AddTab({
		Title = "Console",
		Icon = "terminal",
	}),
	Settings = Window:AddTab({
		Title = "Settings",
		Icon = "settings",
	}),
}

Window:SelectTab(1)

local Options = Fluent.Options

--GUI

------------------------------------------------------
-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือเปลี่ยนเป็น PlayerGui ถ้าไม่ติด
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(101, 1, 1)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "EfHub"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
	pcall(function()
		Window:Minimize()
	end)
end)

Tabs.Main:AddButton({
	Title = "Anti Lag",
	Callback = function()
		pcall(function()
			getgenv().EfHub_MainFunc.ApplyAntiLag()
		end)
	end,
})

local BuySeedSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Seeds", false)

BuySeedSection:AddToggle("buySeedEnable", {
	Title = "Buy Seeds",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Seed].Enabled = Value
		if Value then
			local SeedStocks = DataService:GetData().SeedStocks.Shop.Stocks
			if not isTableEmpty(SeedStocks) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Seed, SeedStocks)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
BuySeedSection:AddToggle("buySeedAll", {
	Title = "Buy All Seeds",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Seed].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

BuySeedSection:AddDropdown("SeedList", {
	Title = "Seeds",
	Description = "Select seeds to buy",
	Values = getgenv().EfHub_Main.SeedShop.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Seed].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Buy Daily Deal Section ]]
local BuyDailySection = Tabs.Buy:AddCollapsibleSection("Auto Buy Daily Seed", false)
BuyDailySection:AddToggle("buyDailyEnable", {
	Title = "Buy Daily Seed",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Daily].Enabled = Value
		if Value then
			local DailyStocks = DataService:GetData().SeedStocks["Daily Deals"].Stocks
			if not isTableEmpty(DailyStocks) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Daily, DailyStocks)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
BuyDailySection:AddToggle("buyDailyAll", {
	Title = "Buy All Daily Seed",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Daily].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[
 Buy Gear Section
]]
local buyGearSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Gear", false)
buyGearSection:AddToggle("buyGearEnable", {
	Title = "Buy Gear",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Gear].Enabled = Value
		if Value then
			local GearStock = DataService:GetData().GearStock.Stocks
			if not isTableEmpty(GearStock) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Gear, GearStock)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
buyGearSection:AddToggle("buyGearAll", {
	Title = "Buy All Gear",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Gear].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

buyGearSection:AddDropdown("GearList", {
	Title = "Gear",
	Description = "Select gear to buy",
	Values = getgenv().EfHub_Main.GearShop.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Gear].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[
 Buy Pet Eggs Section
]]
local buyEggSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Pet Eggs", false)
buyEggSection:AddToggle("buyEggEnable", {
	Title = "Buy Pet Eggs",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Egg].Enabled = Value
		if Value then
			local EggStock = DataService:GetData().PetEggStock.Stocks
			if not isTableEmpty(EggStock) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Egg, EggStock)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
buyEggSection:AddToggle("buyEggAll", {
	Title = "Buy All Pet Eggs",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Egg].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

buyEggSection:AddDropdown("EggList", {
	Title = "Pet Eggs",
	Description = "Select pet eggs to buy",
	Values = getgenv().EfHub_Main.EggShop.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Egg].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[
 Buy Traveling Merchant Items Section
]]
local BuyTravelingSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Traveling Merchant Items", false)
BuyTravelingSection:AddToggle("buyTravelingEnable", {
	Title = "Buy Traveling Merchant Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Traveling].Enabled = Value
		if Value then
			local TravelingStock = DataService:GetData().TravelingMerchantShopStock.Stocks
			if not isTableEmpty(TravelingStock) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Traveling, TravelingStock)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
BuyTravelingSection:AddToggle("buyTravelingAll", {
	Title = "Buy All Traveling Merchant Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Traveling].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

local TravelingList = {}
local function TravelSelected(DropdownValue)
	if type(DropdownValue) == "table" then
		for Value, State in pairs(DropdownValue) do
			if State then
				table.insert(TravelingList, Value)
			end
		end
	end
	return TravelingList
end

local TravelingData = require(game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData)
local Traval = {}

local t = 1
for Name, data in pairs(TravelingData) do
	local TravalTable = {}
	if type(data.ShopData) == "table" then
		for itemName, itemInfo in pairs(data.ShopData) do
			table.insert(TravalTable, itemName)
		end
	end
	Traval[t] = BuyTravelingSection:AddDropdown("TravelingList" .. t, {
		Title = Name .. " Items",
		Description = "Select items to buy",
		Values = TravalTable,
		Multi = true,
		Default = {},
		Searchable = true,
		Callback = function(Value)
			getgenv().EfHub_BuyList[ShopKey.Traveling].Items = TravelSelected(Value)
			if QuickSave then
				QuickSave()
			end
		end,
	})
	t = t + 1
end

--[[
 Buy Event Shop Items Section
]]

--[[
 Buy Santa's Stash Section
]]
local BuySantaSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Santa's Stash Items", false)
BuySantaSection:AddToggle("buySantaEnable", {
	Title = "Buy Santa's Stash Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Santa].Enabled = Value
		if Value then
			local SantaStocks = DataService:GetData().EventShopStock["Santa's Stash"].Stocks
			if not isTableEmpty(SantaStocks) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.Santa, SantaStocks)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
BuySantaSection:AddToggle("buySantaAll", {
	Title = "Buy All Santa's Stash Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Santa].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

local EventData = require(game:GetService("ReplicatedStorage").Data.EventShopData)
local SantaTable = {}
for itemName, itemInfo in pairs(EventData["Santa's Stash"]) do
	table.insert(SantaTable, itemName)
end
--table.sort(SantaTable)
BuySantaSection:AddDropdown("SantaList", {
	Title = "Santa's Stash Items",
	Description = "Select items to buy",
	Values = SantaTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.Santa].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[
 Buy New Years Shop Items Section
]]
local BuyNewYearSection = Tabs.Buy:AddCollapsibleSection("Auto Buy New Years Shop Items", false)
BuyNewYearSection:AddToggle("buyNewYearEnable", {
	Title = "Buy New Years Shop Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.NewYear].Enabled = Value
		if Value then
			local NewYearStocks = DataService:GetData().EventShopStock["New Years Shop"].Stocks
			if not isTableEmpty(NewYearStocks) then
				getgenv().EfHub_BuyFunc.ProcessBuy(ShopKey.NewYear, NewYearStocks)
			end
		end
		if QuickSave then
			QuickSave()
		end
	end,
})
BuyNewYearSection:AddToggle("buyNewYearAll", {
	Title = "Buy All New Years Shop Items",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.NewYear].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
local NewYearTable = {}
for itemName, itemInfo in pairs(EventData["New Years Shop"]) do
	table.insert(NewYearTable, itemName)
end
--table.sort(NewYearTable)
BuyNewYearSection:AddDropdown("NewYearList", {
	Title = "New Years Shop Items",
	Description = "Select items to buy",
	Values = NewYearTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_BuyList[ShopKey.NewYear].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Auto Pet Tab]]
local PetWorkSection = Tabs.Pet:AddCollapsibleSection("Pet Farming", false)
PetWorkSection:AddDropdown("PetMode", {
	Title = "Pet Mode",
	Description = "Select Pet Mode",
	Values = { "Nightmare", "Elephant", "Mutant", "Level" },
	Multi = false,
	Default = "Nightmare",
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
PetWorkSection:AddToggle("PetModeEnable", {
	Title = "Enable Pet Farm",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
		if Value then
			task.wait(1)
			local mode = Options.PetMode.Value
			if mode == "Nightmare" then
				-- Mutation = "Nightmare"
			elseif mode == "Mutant" then
				if Mutation then
					getgenv().EfHub_PetFunc.Mutation()
				end
			else
				-- Mutation = "EfHub"
			end
		end
	end,
})

PetWorkSection:AddDropdown("TargetPetDropdown", {
	Title = "Target Pet",
	Description = "Select Target Pet for Farming",
	Values = getgenv().EfHub_Main.Pet.Table,
	Multi = false,
	Default = "",
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddDropdown("TargetMutantDropdown", {
	Title = "Target Mutant",
	Description = "Select Target Mutant for Farming",
	Values = getgenv().EfHub_Main.Mutant.Table,
	Multi = false,
	Default = "",
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

-- make input for age limit just integer only bestween 0 - 100
PetWorkSection:AddInput("AgeLimitInput", {
	Title = "Age Limit",
	Description = "Enter age limit (0-100)",
	Placeholder = "Enter age limit",
	Filter = "Number",
	Default = 50,
	Callback = function(Value)
		local numValue = tonumber(Value)
		if numValue < 0 or numValue > 100 then
			numValue = 50
			Options.AgeLimitInput:SetValue(numValue)
		end
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddInput("LoadOutDelay", {
	Title = "Loadout Switch Delay time",
	Description = "Enter delay time in seconds",
	Placeholder = "Enter delay time",
	Filter = "Number",
	Default = 10,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddDropdown("LevelSlots", {
	Title = "Select Loadout",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 1,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddDropdown("TimeSlots", {
	Title = "Select Time Slot",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 2,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddDropdown("MutantSlots", {
	Title = "Select Mutant Slot",
	Values = { 1, 2, 3, 4, 5, 6 },
	Default = 3,
	Multi = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

local PetFeedSection = Tabs.Pet:AddCollapsibleSection("Pet Feeding", false)

PetFeedSection:AddToggle("AutoFeedPet", {
	Title = "Auto Feed",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
-- Toggle Allow All Food
PetFeedSection:AddToggle("AllowAllFood", {
	Title = "Allow All Food",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PetFeedSection:AddDropdown("AllowFoodType", {
	Title = "Allow Food Type",
	Values = getgenv().EfHub_Main.Fruit.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
--Slide PetHungerPercent 0 - 100
PetFeedSection:AddSlider("PetHungerPercent", {
	Title = "Pet Hunger Percent",
	Min = 1,
	Max = 100,
	Default = 80,
	--Rounding = 1,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Farm Section]]

local CollectSection = Tabs.Farm:AddCollapsibleSection("Collect Fruit", false)
CollectSection:AddToggle("tgCollectFruitEnable", {
	Title = "Auto Collect All Fruit ",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.CollectFruitEnable = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
--local CollectDelay = 0.3
CollectSection:AddInput("inCollectDelay", {
	Title = "Collect Delay",
	Default = 0.3,
	Min = 0.1,
	Max = 3600,
	Callback = function(Value)
		getgenv().EfHub_Farm.CollectDelay = tonumber(Value) or getgenv().EfHub_Farm.CollectDelay
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDivider()
CollectSection:AddToggle("tgCheckFruitType", {
	Title = "Check Fruit Type",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.CheckFruitType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDropdown("ddFruitType", {
	Title = "Fruit Type",
	Values = getgenv().EfHub_Main.Fruit.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_Farm.FruitType = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddToggle("tgExcludeFruitType", {
	Title = "Exclude Fruit Type",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.ExcludeFruitType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDivider()
--CheckMutant
CollectSection:AddToggle("tgCheckMutant", {
	Title = "Check Mutant",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.CheckMutant = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
--MutantType

CollectSection:AddDropdown("ddMutantType", {
	Title = "Mutant Type",
	Values = getgenv().EfHub_Main.FruitMutant.Table,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		getgenv().EfHub_Farm.MutantType = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

-- ExceptMutant
CollectSection:AddToggle("tgExceptMutant", {
	Title = "Except Mutant",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.ExceptMutant = Value
		if QuickSave then
		end
	end,
})
CollectSection:AddDivider()

CollectSection:AddToggle("tgCheckVariant", {
	Title = "Check Variant",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.CheckVariant = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDropdown("ddVariantType", {
	Title = "Variant Type",
	Values = { "Normal", "Silver", "Gold", "Rainbow", "Diamond" },
	Multi = false,
	Default = "Normal",
	Callback = function(Value)
		getgenv().EfHub_Farm.VariantType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddToggle("tgExceptVariant", {
	Title = "Except Variant",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.ExceptVariant = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDivider()

CollectSection:AddToggle("tgCheckWeight", {
	Title = "Check Weight",
	Default = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.CheckWeight = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
CollectSection:AddDropdown("ddWeightType", {
	Title = "Weight Type",
	Values = { "Above", "Below" },
	Multi = false,
	Default = "Below",
	Callback = function(Value)
		getgenv().EfHub_Farm.WeightType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
CollectSection:AddInput("ipWeightValue", {
	Title = "Weight Value",
	Default = "100",
	Numeric = true,
	Finished = false,
	Callback = function(Value)
		getgenv().EfHub_Farm.WeightValue = tonumber(Value) or 100
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ Log Section ]]
--
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local IsUpdateScheduled = false -- ตัวแปรเช็คว่ามีการนัดการอัป
-- ปุ่ม Clear
Tabs.Log:AddButton({
	Title = "Clear Logs",
	Callback = function()
		DisplayTable = {}
		if LogDisplay then
			LogDisplay:SetValue("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

local LogDisplay = Tabs.Log:CreateParagraph("MyConsole", {
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------

local function FlushLogUpdates()
	if LogDisplay then
		pcall(function()
			-- รวบยอดเอาข้อมูลในตารางไปแสดงทีเดียว
			LogDisplay:SetValue(table.concat(DisplayTable, "\n"))
		end)
	end
	IsUpdateScheduled = false -- ทำงานเสร็จแล้ว ยกเลิก "นัด" (พร้อมรับนัดใหม่)
end

local function AddLog(message)
	local entry = string.format("[%s] %s", os.date("%X"), message)

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then
		table.remove(DisplayTable, 1)
	end

	if not IsUpdateScheduled then
		IsUpdateScheduled = true
		task.delay(0.3, FlushLogUpdates)
	end
end

------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
--[[ local function InfoLog(message)
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
end *]]

DevLog = function(message)
	AddLog("💻 " .. message)
end

getgenv().EfHub_RemoteCache = {}

getgenv().EfHub_BuyFunc.ProcessBuy = function(ShopKey, StockData)
	local Setting = getgenv().EfHub_BuyList[ShopKey]
	if not Setting or not Setting.Enabled then
		return
	end
	local Remote = getgenv().EfHub_RemoteCache[Setting.RemoteName]
	if not Remote then
		Remote = GameEvents:FindFirstChild(Setting.RemoteName)
		if Remote then
			getgenv().EfHub_RemoteCache[Setting.RemoteName] = Remote
		end
	end

	for itemId, itemInfo in pairs(StockData) do
		local ItemName = itemInfo.EggName or itemId
		local StockAmount = tonumber(itemInfo.Stock) or 0
		local BuyEnabled = false
		if Setting.BuyAll then
			BuyEnabled = true
		else
			for _, TargetName in ipairs(Setting.Items) do
				if TargetName == ItemName then
					BuyEnabled = true
					break
				end
			end
		end

		if BuyEnabled == true and StockAmount > 0 then
			for i = 1, StockAmount do
				local Args = {}
				if Setting.ArgType == "SeedMode" then
					Args = { "Shop", ItemName }
				elseif Setting.ArgType == "EventMode" then
					Args = { ItemName, Setting.EventArg }
				else
					Args = { ItemName }
				end
				Remote:FireServer(unpack(Args))
				task.wait(0.1)
			end
			BuyEnabled = false

			local LogMessage = string.format("Bought %s : %s", ItemName, StockAmount)
			DevNoti(LogMessage)
		end
	end
end

getgenv().EfHub_MainFunc.GetMyFarm = function()
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

getgenv().EfHub_Main.MyFarm = getgenv().EfHub_MainFunc.GetMyFarm()

--[[
 Auto Buy System
]]

if getgenv().EfHub_Main.MyFarm then
	if getgenv().EfHub_Main.MyFarm:FindFirstChild("Spawn_Point") then
		getgenv().EfHub_Main.FarmPoint = getgenv().EfHub_Main.MyFarm.Spawn_Point.CFrame
	end
end

getgenv().EfHub_MainFunc.BuildMutationCache = function()
	local mutations = PetMutationRegistry.PetMutationRegistry or PetMutationRegistry

	for name, info in pairs(mutations) do
		if type(info) == "table" and info.EnumId then
			getgenv().EfHub_Main.Mutant.Enum[info.EnumId] = name
		end
	end
end

getgenv().EfHub_PetFunc.GetEquippedPetsUUID = function()
	local EquippedPets = DataService:GetData().PetsData.EquippedPets or {}
	local UUIDtbl = {}
	for _, uuid in pairs(EquippedPets) do
		if uuid then
			table.insert(UUIDtbl, uuid)
		end
	end
	return UUIDtbl
end

getgenv().EfHub_PetFunc.GetRawPetData = function(uuid)
	local success, result = pcall(function()
		return ActivePetsService:GetPetData(LocalPlayer.Name, uuid)
	end)

	if success and result then
		return result
	end
	return nil
end

-- ==========================================
-- 1. ฟังก์ชันหา Level
-- ==========================================
getgenv().EfHub_PetFunc.GetPetLevel = function(uuid)
	local data = getgenv().EfHub_PetFunc.GetRawPetData(uuid)
	if data and data.PetData then
		return data.PetData.Level or 1
	end
	return 1
end

-- ==========================================
-- 2. ฟังก์ชันหา Mutation
-- ==========================================
getgenv().EfHub_PetFunc.GetPetMutation = function(uuid)
	local data = getgenv().EfHub_PetFunc.GetRawPetData(uuid)
	if data and data.PetData then
		local rawEnum = data.PetData.MutationType
		if rawEnum then
			return getgenv().EfHub_Main.Mutant.Enum[rawEnum] or rawEnum
		end
	end
	return nil
end

-- ==========================================
-- 3. ฟังก์ชันหา Hunger
-- ==========================================
getgenv().EfHub_PetFunc.GetPetHunger = function(uuid)
	local data = getgenv().EfHub_PetFunc.GetRawPetData(uuid)
	if data and data.PetData then
		return data.PetData.Hunger or 0
	end
	return 0
end

-- ==========================================
-- 4. ฟังก์ชันหา PetType
-- ==========================================
getgenv().EfHub_PetFunc.GetPetType = function(uuid)
	local data = getgenv().EfHub_PetFunc.GetRawPetData(uuid)
	if data then
		return data.PetType or "Unknown"
	end
	return "Unknown"
end

getgenv().EfHub_PetFunc.GetPetHungerPercent = function(uuid)
	return 100
		* (
			getgenv().EfHub_PetFunc.GetPetHunger(uuid)
			/ getgenv().EfHub_Main.Pet.Hunger[getgenv().EfHub_PetFunc.GetPetType(uuid)]
		)
end

-- RawName removed (unused)

getgenv().EfHub_PetFunc.GetPetFavorite = function(uuid)
	local data = getgenv().EfHub_PetFunc.GetRawPetData(uuid)
	if data and data.PetData then
		local Favorited = data.PetData.IsFavorite
		if Favorited then
			return Favorited
		end
	end
	return nil
end

getgenv().EfHub_PetFunc.GetPetUUID = function(petName)
	local TargetPet = petName
	local name
	local TargetMutant = "EfHub"

	if Options.PetMode.Value == "Nightmare" then
		TargetMutant = "Nightmare"
	elseif Options.PetMode.Value == "Mutant" then
		TargetMutant = Options.TargetMutantDropdown.Value
	end
	local timeout = 10
	local startTime = tick()
	repeat
		local UUIDs = getgenv().EfHub_PetFunc.GetEquippedPetsUUID()
		for _, uuid in pairs(UUIDs) do
			local PetType = getgenv().EfHub_PetFunc.GetPetType(uuid)
			if PetType and PetType == TargetPet then
				if
					getgenv().EfHub_PetFunc.GetPetMutation(uuid) ~= TargetMutant
					and not getgenv().EfHub_PetFunc.GetPetFavorite(uuid)
				then
					DevNoti("Found pet in ActivePetUI: " .. PetType .. " (UUID: " .. uuid .. ")")
					return uuid
				end
			end
		end
		local PetInventory = DataService:GetData().PetsData.PetInventory
		if PetInventory then
			for k, v in pairs(PetInventory) do
				if type(v) == "table" then
					for _, Data in pairs(v) do
						local PetType = Data.PetType
						local uuid = Data.UUID
						if PetType and PetType == TargetPet then
							if
								getgenv().EfHub_PetFunc.GetPetMutation(uuid) ~= TargetMutant
								and not getgenv().EfHub_PetFunc.GetPetFavorite(uuid)
							then
								DevNoti("Found pet in Backpack: " .. PetType .. " (UUID: " .. uuid .. ")")
								return uuid
							end
						end
					end
				end
			end
		end
		task.wait(0.5)
	until tick() - startTime > timeout
	return nil
end

getgenv().EfHub_PetFunc.EquipPet = function(uuid)
	local args = { "EquipPet", uuid }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

getgenv().EfHub_PetFunc.UnequipPet = function(uuid)
	local args = { "UnequipPet", uuid }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

getgenv().EfHub_PetFunc.SwapPetLoadout = function(Loadout) -- Loadout is int 1-6
	if Loadout == 2 then
		Loadout = 3
	elseif Loadout == 3 then
		Loadout = 2
	end
	local args = { "SwapPetLoadout", Loadout }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

getgenv().EfHub_PetFunc.heldPet = function(uuid)
	local timeout = 3 -- รอสูงสุด 3 วินาที
	local startTime = tick()
	repeat
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
				Humanoid:EquipTool(item)
				task.wait(0.3) -- รอให้ถือติด
				return true
			end
		end
		task.wait(0.2)
	until tick() - startTime > timeout
	DevNoti("Failed to hold pet: " .. tostring(uuid))
	return false
end

getgenv().EfHub_ItemFunc.heldItemUUID = function(uuid) -- find item in backpack and select it
	for _, item in ipairs(Backpack:GetChildren()) do
		if item:GetAttribute("c") == uuid then
			Humanoid:EquipTool(item)
			return true
		end
	end
	return false
end

getgenv().EfHub_ItemFunc.heldItemName = function(itemName) -- find item in backpack and select it
	for _, item in ipairs(Backpack:GetChildren()) do
		local name = string.match(item.Name, "^(.-)%s*%[") or string.match(item.Name, "^(.-)%s*[xX]%d+") or item.Name
		name = string.trim(name)
		if name == itemName then
			Humanoid:EquipTool(item)
			return true
		end
	end
	return false
end

getgenv().EfHub_PetFunc.IsActivePet = function(uuid)
	if table.find(getgenv().EfHub_PetFunc.GetEquippedPetsUUID(), uuid) then
		return true
	else
		return false
	end
end

getgenv().EfHub_PetFunc.MakeMutant = function(uuid)
	getgenv().EfHub_PetFunc.SwapPetLoadout(Options.TimeSlots.Value)
	task.wait(Options.LoadOutDelay.Value)
	Character:PivotTo(CFrame.new(-236.17, 4.50, 14.36))
	task.wait(0.2)
	if getgenv().EfHub_PetFunc.IsActivePet(uuid) then
		getgenv().EfHub_PetFunc.UnequipPet(uuid) -- Swaps to loadout 4 to check pet age
		task.wait(1)
	end
	if getgenv().EfHub_PetFunc.heldPet(uuid) then
		task.wait(0.5)
		local args = { "SubmitHeldPet" }
		GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer(unpack(args))
		task.wait(0.5)
		local args = { "PetAssets", Options.TargetPetDropdown.Value }
		GameEvents:WaitForChild("ReplicationChannel"):FireServer(unpack(args))
		task.wait(1)
		local args = { "StartMachine" }
		GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer(unpack(args))
		getgenv().EfHub_Pet.Mutanting = true
	end
end

getgenv().EfHub_PetFunc.ClaimMutantPet = function(uuid)
	getgenv().EfHub_PetFunc.SwapPetLoadout(Options.MutantSlots.Value)
	task.wait(Options.LoadOutDelay.Value)
	local args = { "ClaimMutatedPet" }
	GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer(unpack(args))
	task.wait(3)
	if Character and Humanoid then
		pcall(function()
			Humanoid:UnequipTools()
		end)
	end
	-- local mutantPetname = GetPetMutation(uuid)
	DevNoti(
		"Successfully claimed "
			.. getgenv().EfHub_PetFunc.GetPetType(uuid)
			.. " Mutant : "
			.. getgenv().EfHub_PetFunc.GetPetMutation(uuid)
	)
	getgenv().EfHub_Pet.Mutanting = false
	local cTargetMutant = Options.TargetMutantDropdown.Value
	task.wait(10)
	if cTargetMutant == getgenv().EfHub_PetFunc.GetPetMutation(uuid) then
		getgenv().EfHub_PetFunc.Mutation()
	else
		getgenv().EfHub_PetFunc.Mutation(uuid)
	end
end

getgenv().EfHub_PetFunc.Mutation = function(uuid)
	if Options.PetModeEnable.Value then
		local TargetPet = Options.TargetPetDropdown.Value
		targetUUID = uuid or getgenv().EfHub_PetFunc.GetPetUUID(TargetPet)
		if targetUUID then
			getgenv().EfHub_targetUUID = targetUUID
			local age = getgenv().EfHub_PetFunc.GetPetLevel(targetUUID)
			DevNoti(TargetPet .. " Age : " .. tostring(age))
			if age < 50 then
				local FarmPoint = getgenv().EfHub_Main.FarmPoint
				if not FarmPoint then
					DevNoti("ไม่พบ FarmPoint ของคุณ")
					return
				end
				Character:PivotTo(CFrame.new(FarmPoint.X, FarmPoint.Y, FarmPoint.Z))
				task.wait(0.3)
				DevNoti("Swapping to loadout " .. Options.LevelSlots.Value .. " to equip pet...")
				getgenv().EfHub_PetFunc.SwapPetLoadout(Options.LevelSlots.Value)
				task.wait(Options.LoadOutDelay.Value)
				DevNoti("Equipping pet...")
				pcall(function()
					getgenv().EfHub_PetFunc.EquipPet(targetUUID)
				end)
			else
				DevNoti("Send " .. TargetPet .. " to the Mutant Machine")
				getgenv().EfHub_PetFunc.MakeMutant(targetUUID)
			end
		else
			DevNoti("Target pet '" .. TargetPet .. "' not found in backpack.")
		end
	end
end

DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
	local TargetLevel = tonumber(Options.AgeLimitInput.Value) or 50
	local TargetPet = Options.TargetPetDropdown.Value or "None"

	if Type ~= "UpdateData" then
		return
	end
	if not string.find(Profile, LocalPlayer.Name) then
		return
	end
	if not Data or type(Data) ~= "table" then
		return
	end
	for _, Packet in ipairs(Data) do
		local Key = Packet[1]
		local Content = Packet[2]

		-- Process Buy Requests
		if getgenv().EfHub_BuyList[Key] then
			task.spawn(function()
				getgenv().EfHub_BuyFunc.ProcessBuy(Key, Content)
			end)
		end

		if Options.PetModeEnable.Value then
			-- Process Pet Mutation
			--local targetUUID = getgenv().EfHub_targetUUID
			task.spawn(function()
				if string.find(Key, "ROOT/GardenGuide/PetData") then
					local age = tonumber(Content) or (targetUUID and getgenv().EfHub_PetFunc.GetPetLevel(targetUUID))
					if not age then
						return
					end
					task.wait(0.3)
					DevNoti("Key 1 :  " .. TargetPet .. " Age : " .. tostring(age))
					if age >= TargetLevel then
						DevNoti(TargetPet .. " has reached level " .. TargetLevel)
						getgenv().EfHub_PetFunc.UnequipPet(targetUUID)
						task.wait(0.3)
						getgenv().EfHub_PetFunc.MakeMutant(targetUUID)
					end
				elseif Key == "ROOT/BadgeData/PetMaster" then
					local age = (targetUUID and getgenv().EfHub_PetFunc.GetPetLevel(targetUUID))
					if not age then
						return
					end
					task.wait(0.3)
					DevNoti("Key 2 :  " .. TargetPet .. " Age : " .. tostring(age))
					if age >= TargetLevel then
						DevNoti(TargetPet .. " has reached level " .. TargetLevel)
						getgenv().EfHub_PetFunc.UnequipPet(targetUUID)
						task.wait(0.3)
						getgenv().EfHub_PetFunc.MakeMutant(targetUUID)
					end
				elseif Key == "ROOT/PetMutationMachine/PetReady" then
					if getgenv().EfHub_Pet.Mutanting then
						getgenv().EfHub_PetFunc.ClaimMutantPet(targetUUID)
					end
					task.wait(0.3)
				end
			end)
		end
	end
end)

getgenv().EfHub_MainFunc.ApplyAntiLag = function()
	-- Lighting
	Lighting.GlobalShadows = false
	Lighting.FogEnd = 9e9
	Lighting.Brightness = 0
	Lighting.EnvironmentDiffuseScale = 0
	Lighting.EnvironmentSpecularScale = 0
	Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

	-- Terrain Water
	Terrain.WaterWaveSize = 0
	Terrain.WaterWaveSpeed = 0
	Terrain.WaterReflectance = 0
	Terrain.WaterTransparency = 1

	-- Workspace optimize
	for i, v in ipairs(workspace:GetDescendants()) do
		if i % 200 == 0 then
			task.wait()
		end

		if v:IsA("BasePart") then
			v.Material = Enum.Material.SmoothPlastic
			v.Reflectance = 0
		elseif v:IsA("ParticleEmitter") then
			v.Enabled = false
		elseif v:IsA("Decal") or v:IsA("Texture") then
			v.Transparency = 1
		end
	end

	-- Rendering quality (safe)
	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
end

getgenv().EfHub_FarmFunc.FindFruitInv = function()
	local InventoryData = DataService:GetData().InventoryData or {}
	local AllowList = GetSelectedItems(Options.AllowFoodType.Value)
	for uuid, Item in pairs(InventoryData) do
		if Item.ItemType and Item.ItemType == "Holdable" and Item.ItemData and not Item.ItemData.IsFavorite then
			local FruitInv = Item.ItemData.ItemName
			if Options.AllowAllFood.Value then
				return uuid
			else
				--AllowFoodType
				for _, Fruit in pairs(AllowList) do
					if FruitInv == Fruit then
						--AddLog("Found Fruit : "..FruitInv.." UUID: "..uuid)
						return uuid
					end
				end
			end
		end
	end
	return nil
end

getgenv().EfHub_PetFunc.FeedPet = function()
	local petUUID = getgenv().EfHub_PetFunc.GetEquippedPetsUUID()
	if #petUUID == 0 then
		return
	end
	for i, uuid in pairs(petUUID) do
		local hunger = getgenv().EfHub_PetFunc.GetPetHungerPercent(uuid)
		if hunger <= Options.PetHungerPercent.Value then
			local FruitInvUUID = getgenv().EfHub_FarmFunc.FindFruitInv()
			if FruitInvUUID then
				if getgenv().EfHub_ItemFunc.heldItemUUID(FruitInvUUID) then
					local args = { "Feed", uuid }
					GameEvents:WaitForChild("ActivePetService"):FireServer(unpack(args))
					task.wait(1)
				end
			else
				break
			end
		end
	end
end

getgenv().EfHub_FarmFunc.CheckFruit = function(model)
	-- 1. ตรวจสอบเบื้องต้นว่าเป็น Model หรือไม่
	if not model or not model:IsA("Model") then
		return false
	end
	-- 2. ตรวจสอบชนิดผลไม้ (Fruit Type)
	if getgenv().EfHub_Farm.CheckFruitType then
		local tFruitType = model.Name
		-- ตรวจสอบว่าชื่อผลไม้อยู่ในตารางที่กำหนดหรือไม่
		local isFound = table.find(getgenv().EfHub_Farm.FruitType, tFruitType) ~= nil

		-- ตรรกะ: (เจอในรายการยกเว้น) หรือ (ไม่เจอในรายการที่ต้องการ) -> ไม่ผ่าน
		if isFound == getgenv().EfHub_Farm.ExcludeFruitType then
			return false
		end
	end

	-- 3. ตรวจสอบการกลายพันธุ์ (Mutant)
	if getgenv().EfHub_Farm.CheckMutant then
		local hasMutant = false
		for _, v in pairs(getgenv().EfHub_Farm.MutantType) do
			if model:GetAttribute(v) == true then
				hasMutant = true
				break
			end
		end

		if hasMutant == getgenv().EfHub_Farm.ExceptMutant then
			return false
		end
	end

	-- 4. ตรวจสอบรูปแบบย่อย (Variant)
	if getgenv().EfHub_Farm.CheckVariant then
		local VariantObj = model:FindFirstChild("Variant")

		-- ถ้าต้องเช็ค Variant แต่ผลไม้ไม่มี Variant เลย -> ถือว่าไม่ผ่าน
		if not VariantObj then
			return false
		end

		local tVariant = VariantObj.Value
		local isVariantMatch = (tVariant == getgenv().EfHub_Farm.VariantType)

		if isVariantMatch == getgenv().EfHub_Farm.ExceptVariant then
			return false
		end
	end

	-- 5. ตรวจสอบน้ำหนัก (Weight)
	if getgenv().EfHub_Farm.CheckWeight then
		local weightObj = model:FindFirstChild("Weight")
		if not weightObj then
			return false
		end

		local tWeight = weightObj.Value

		-- ตรวจสอบค่าตัวเลข
		if getgenv().EfHub_Farm.WeightType == "Above" and not (tWeight >= getgenv().EfHub_Farm.WeightValue) then
			return false
		elseif getgenv().EfHub_Farm.WeightType == "Below" and not (tWeight < getgenv().EfHub_Farm.WeightValue) then
			return false
		end
	end

	-- หากผ่านการตรวจสอบทุกขั้นตอน ให้ถือว่าเป็นจริง
	return true
end

getgenv().EfHub_FarmFunc.CollectFruit = function()
	if InventoryService.IsMaxInventory() then --
		--DevNoti("กระเป๋าเต็มแล้วครับ! หยุดเก็บ")
		return
	end

	if getgenv().EfHub_Main.MyFarm then
		local Farm_Important = getgenv().EfHub_Main.MyFarm:FindFirstChild("Important")
		local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")
		if Plants_Physical then
			-- วนลูปต้นไม้ทุกต้น
			for _, plant in pairs(Plants_Physical:GetChildren()) do
				local Fruits = plant:FindFirstChild("Fruits")
				if Fruits then
					for _, fruit in pairs(Fruits:GetChildren()) do
						if not getgenv().EfHub_Farm.CollectFruitEnable then
							return
						end
						if fruit:IsA("Model") then
							-- หา Part ที่ชื่อ "2" (ตามโครงสร้างเกมที่คุณระบุ)
							local Prompt_Part = fruit:FindFirstChild("2")

							if Prompt_Part then
								local Prompt = Prompt_Part:FindFirstChild("ProximityPrompt")

								-- เช็คว่า Prompt มีจริง และ เปิดใช้งานอยู่ (ยังไม่ถูกเก็บ)
								if Prompt and Prompt.Enabled then
									-- 2. เรียกใช้ฟังก์ชัน CheckFruit (จากขั้นตอนที่แล้ว)
									if getgenv().EfHub_FarmFunc.CheckFruit(fruit) then
										-- ย้าย Log มาตรงนี้: จะโชว์เฉพาะตัวที่ "ผ่าน" เงื่อนไขและถูกเก็บจริง
										--AddLog("Auto Collect: " .. fruit.Name)

										-- ส่งข้อมูลไป Server
										CollectEvent:FireServer({ fruit })

										-- (ตัวเลือกเสริม) ใส่ wait นิดนึงถ้ากลัวเน็ตหลุดกรณีเก็บรัวๆ
										task.wait(getgenv().EfHub_Farm.CollectDelay)
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

--[[
 SaveManager and InterfaceManager Setup
]]

--SaveManager:SetIgnoreIndexes({})
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

task.spawn(function()
	while not SaveManager.Options.SaveManager_ConfigList do
		task.wait()
	end
	SaveManager.Options.SaveManager_ConfigList:SetValue("EfHub")
	SaveManager:Load("EfHub")
	IsLoading = false
	Fluent:Notify({
		Title = "EfHub",
		Content = "Settings loaded automatically",
		Duration = 3,
	})
end)
--IsLoading = false

task.spawn(function()
	while Options.AutoFeedPet.Value do -- ใช้ While Loop เพื่อให้ทำงานวนไปเรื่อยๆ
		pcall(function() -- ใส่ pcall กัน Error แล้วสคริปต์หลุด
			getgenv().EfHub_PetFunc.FeedPet()
		end)
		task.wait(10) -- เช็คความหิวทุกๆ 2 วินาที (ไม่ต้องถี่มาก)
	end
end)

task.spawn(function()
	while getgenv().EfHub_Farm.CollectFruitEnable do -- ใช้ While Loop เพื่อให้ทำงานวนไปเรื่อยๆ
		getgenv().EfHub_FarmFunc.CollectFruit()
		task.wait(getgenv().EfHub_Farm.CollectDelay)
	end
end)
