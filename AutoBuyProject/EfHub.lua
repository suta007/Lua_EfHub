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
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService)
local PetMutationRegistry = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry)

local DataService = require(ReplicatedStorage.Modules.DataService)

local CollectEvent = ReplicatedStorage.GameEvents.Crops.Collect
local InventoryService = require(ReplicatedStorage.Modules.InventoryService)

CollapsibleAddon(Fluent)
local DevMode = false
local DevNoti
local IsLoading = true
local QuickSave
local GetSelectedItems

local targetUUID
local GetPetUUID
local EquipPet
local UnequipPet
local SwapPetLoadout
local heldPet
local heldItemName
local heldItemUUID
local MakeMutant
local Mutation
local ClaimMutantPet
local Mutanting = false
local IsActivePet = false
local ApplyAntiLag
local DevLog
local ProcessBuy, GetMyFarm, CheckFruit, AutoPlant, GetPosition, ScanFarmTask
local GetRawPetData, GetPetLevel, GetPetMutation, GetPetHunger, GetPetType, GetPetFavorite
local GetPetHungerPercent, CheckMakeMutant, PetNightmare, GetPetBaseWeight
local GetEquippedPetsUUID, FindFruitInv, FeedPet

local ViewportSize = workspace.CurrentCamera.ViewportSize
local targetWidth = math.min(ViewportSize.X - 50, 550) 
local targetHeight = math.min(ViewportSize.Y - 50, 350)

local IsScanning = false
local FruitQueue = {}
local ShopKey = {
	Seed = "ROOT/SeedStocks/Shop/Stocks",
	Daily = "ROOT/SeedStocks/Daily Deals/Stocks",
	Gear = "ROOT/GearStock/Stocks",
	Egg = "ROOT/PetEggStock/Stocks",
	Santa = "ROOT/EventShopStock/Santa's Stash/Stocks",
	NewYear = "ROOT/EventShopStock/New Years Shop/Stocks",
	Traveling = "ROOT/TravelingMerchantShopStock/Stocks",
}

local BuyList = {
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

local RemoteCache = {}

ProcessBuy = function(ShopKey, StockData)
	local Setting = BuyList[ShopKey]
	if not Setting or not Setting.Enabled then
		return
	end
	local Remote = RemoteCache[Setting.RemoteName]
	if not Remote then
		Remote = GameEvents:FindFirstChild(Setting.RemoteName)
		if Remote then
			RemoteCache[Setting.RemoteName] = Remote
		end
	end

	for itemId, itemInfo in pairs(StockData) do
		local ItemName = itemInfo.EggName or itemId
		local StockAmount = tonumber(itemInfo.Stock) or 0
		local BuyEnabled = false
		local StockInfo = string.format("Found %s : %s", ItemName, StockAmount)
		DevNoti(StockInfo)
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

local Window = Fluent:CreateWindow({
	Title = "Grow a Garden",
	SubTitle = "by EfHub",
	TabWidth = 100,
	Size = UDim2.fromOffset(580, 460),
	Resize = true,
	MinSize = Vector2.new(580, 460),
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
local Options = Fluent.Options

DevNoti = function(content)
	if DevMode then
		--[[         Fluent:Notify({
            Title = "EfHub - Dev Mode",
            Content = content,
            Duration = 5
        }) ]]
		DevLog(content)
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

Window:SelectTab(1)
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
			ApplyAntiLag()
		end)
	end,
})

local BuySeedSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Seeds", false)

BuySeedSection:AddToggle("buySeedEnable", {
	Title = "Buy Seeds",
	Default = false,
	Callback = function(Value)
		BuyList[ShopKey.Seed].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local SeedStocks = GetData_result.SeedStocks.Shop.Stocks
			if not isTableEmpty(SeedStocks) then
				ProcessBuy(ShopKey.Seed, SeedStocks)
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
		BuyList[ShopKey.Seed].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

local SeedData = require(game:GetService("ReplicatedStorage").Data.SeedShopData) -- This is table data of seeds
local SeedTable = {}
for seedName, seedInfo in pairs(SeedData) do
	table.insert(SeedTable, seedName)
end
table.sort(SeedTable)
BuySeedSection:AddDropdown("SeedList", {
	Title = "Seeds",
	Description = "Select seeds to buy",
	Values = SeedTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		BuyList[ShopKey.Seed].Items = GetSelectedItems(Value)
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
		BuyList[ShopKey.Daily].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local DailyStocks = GetData_result.SeedStocks["Daily Deals"].Stocks
			if not isTableEmpty(DailyStocks) then
				ProcessBuy(ShopKey.Daily, DailyStocks)
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
		BuyList[ShopKey.Daily].BuyAll = Value
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
		BuyList[ShopKey.Gear].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local GearStock = GetData_result.GearStock.Stocks
			if not isTableEmpty(GearStock) then
				ProcessBuy(ShopKey.Gear, GearStock)
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
		BuyList[ShopKey.Gear].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
local GearData = require(game:GetService("ReplicatedStorage").Data.GearShopData)
local GearTable = {}
for gearName, gearInfo in pairs(GearData["Gear"]) do
	table.insert(GearTable, gearName)
end
table.sort(GearTable)
buyGearSection:AddDropdown("GearList", {
	Title = "Gear",
	Description = "Select gear to buy",
	Values = GearTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		BuyList[ShopKey.Gear].Items = GetSelectedItems(Value)
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
		BuyList[ShopKey.Egg].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local EggStock = GetData_result.PetEggStock.Stocks
			if not isTableEmpty(EggStock) then
				ProcessBuy(ShopKey.Egg, EggStock)
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
		BuyList[ShopKey.Egg].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
local EggData = require(game:GetService("ReplicatedStorage").Data.PetEggData)
local EggTable = {}
for eggName, eggInfo in pairs(EggData) do
	table.insert(EggTable, eggName)
end
table.sort(EggTable)
buyEggSection:AddDropdown("EggList", {
	Title = "Pet Eggs",
	Description = "Select pet eggs to buy",
	Values = EggTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		BuyList[ShopKey.Egg].Items = GetSelectedItems(Value)
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
		BuyList[ShopKey.Traveling].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local TravelingStock = GetData_result.TravelingMerchantShopStock.Stocks
			if not isTableEmpty(TravelingStock) then
				ProcessBuy(ShopKey.Traveling, TravelingStock)
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
		BuyList[ShopKey.Traveling].BuyAll = Value
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
			BuyList[ShopKey.Traveling].Items = TravelSelected(Value)
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
		BuyList[ShopKey.Santa].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local SantaStocks = GetData_result.EventShopStock["Santa's Stash"].Stocks
			if not isTableEmpty(SantaStocks) then
				ProcessBuy(ShopKey.Santa, SantaStocks)
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
		BuyList[ShopKey.Santa].BuyAll = Value
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
table.sort(SantaTable)
BuySantaSection:AddDropdown("SantaList", {
	Title = "Santa's Stash Items",
	Description = "Select items to buy",
	Values = SantaTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		BuyList[ShopKey.Santa].Items = GetSelectedItems(Value)
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
		BuyList[ShopKey.NewYear].Enabled = Value
		if Value then
			local GetData_result = DataService:GetData()
			local NewYearStocks = GetData_result.EventShopStock["New Years Shop"].Stocks
			if not isTableEmpty(NewYearStocks) then
				ProcessBuy(ShopKey.NewYear, NewYearStocks)
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
		BuyList[ShopKey.NewYear].BuyAll = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
local NewYearTable = {}
for itemName, itemInfo in pairs(EventData["New Years Shop"]) do
	table.insert(NewYearTable, itemName)
end
table.sort(NewYearTable)
BuyNewYearSection:AddDropdown("NewYearList", {
	Title = "New Years Shop Items",
	Description = "Select items to buy",
	Values = NewYearTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		BuyList[ShopKey.NewYear].Items = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

local PetSetting = {
	["PetMode"] = {
		Enabled = false,
		Mode = "Nightmare",
		TargetMutant = "GiantGolem",
		TargetPet = "Tiger",
		LevelSlots = 1,
		TimeSlot = 2,
		MutantSlot = 3,
		AgeLimit = 50,
	},
}

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
		---PetSetting["PetMode"].Mode = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
PetWorkSection:AddToggle("PetModeEnable", {
	Title = "Enable Pet Farm",
	Default = false,
	Callback = function(Value)
		-- PetSetting["PetMode"].Enabled = Value
		if QuickSave then
			QuickSave()
		end
		if Value then
			task.wait(1)
			--local mode = Options.PetMode.Value
			--if mode == "Nightmare" then
			-- Mutation = "Nightmare"
			--elseif mode == "Mutant" then
			--	if Mutation then
			Mutation()
			--	end
			--else
			-- Mutation = "EfHub"
			--end
		end
	end,
})
local PetData = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetList)
local PetTable = {}
local HungerTable = {}
for petName, petInfo in pairs(PetData) do
	table.insert(PetTable, petName)
	HungerTable[petName] = petInfo["DefaultHunger"]
end
table.sort(PetTable)
PetWorkSection:AddDropdown("TargetPetDropdown", {
	Title = "Target Pet",
	Description = "Select Target Pet for Farming",
	Values = PetTable,
	Multi = false,
	Default = PetSetting["PetMode"].TargetPet,
	Searchable = true,
	Callback = function(Value)
		PetSetting["PetMode"].TargetPet = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

PetWorkSection:AddToggle("UseFavoriteOnly", {
	Title = "Use Favorite Pet Only",
	Description = "Use Favorite Pet Only",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

local MutantData = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry)
local MutantTable = {}
local EnumToNameCache = {}
for mutantName, mutantInfo in pairs(MutantData["PetMutationRegistry"]) do
	if type(mutantInfo) == "table" and mutantInfo.EnumId then
		table.insert(MutantTable, mutantName)
		EnumToNameCache[mutantInfo.EnumId] = mutantName
	end
end

table.sort(MutantTable)
PetWorkSection:AddDropdown("TargetMutantDropdown", {
	Title = "Target Mutant",
	Description = "Select Target Mutant for Farming",
	Values = MutantTable,
	Multi = false,
	Default = PetSetting["PetMode"].TargetMutant,
	Searchable = true,
	Callback = function(Value)
		PetSetting["PetMode"].TargetMutant = Value
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
		-- PetSetting["PetMode"].AgeLimit = numValue
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
local FruitData = require(game:GetService("ReplicatedStorage").Data.SeedData) -- This is table data of seeds
local FruitTable = {}
for FruitName, FruitInfo in pairs(FruitData) do
	table.insert(FruitTable, FruitName)
end
table.sort(FruitTable)

PetFeedSection:AddDropdown("AllowFoodType", {
	Title = "Allow Food Type",
	Values = FruitTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
PetFeedSection:AddSlider("PetHungerPercent", {
	Title = "Pet Hunger Percent",
	Min = 1,
	Max = 100,
	Default = 80,
	Rounding = 1,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
--[[ Farm Section]]

local SellFruitSection = Tabs.Farm:AddCollapsibleSection("Sell Fruit", false)
SellFruitSection:AddToggle("AutoSellALL", {
	Title = "Auto Sell ALL",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})
SellFruitSection:AddToggle("AutoSellFruit", {
	Title = "Auto Sell Fruit",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--[[ สร้าง gui สำหรับตั้งค่าพวกนี้ ]]

local CollectDelay = 0.3

local CheckFruitType = false --toggle
local FruitType = {} -- dropdown multi
local ExcludeFruitType = false --toggle

local CheckMutant = false --toggle
local MutantType = {} --dropdown multi
local ExceptMutant = false --toggle

local CheckVariant = false --toggle
local VariantType = "Normal" -- dropdown gingle
local ExceptVariant = false -- toggle

local CheckWeight = false --toggle
local WeightType = "Below" -- "Above" or "Below" --dropdown single
local WeightValue = 100 --input
--[[
ใน CollectSection

ข้อมูลสร้าง gui อยู่ใน FluentData/renewed/Example.luau
]]

local CollectSection = Tabs.Farm:AddCollapsibleSection("Collect Fruit", false)
CollectSection:AddToggle("tgCollectFruitEnable", {
	Title = "Enable Auto Collect Fruit ",
	Default = false,
	Callback = function(Value)
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
		CollectDelay = tonumber(Value)
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
		CheckFruitType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDropdown("ddFruitType", {
	Title = "Fruit Type",
	Values = FruitTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		FruitType = GetSelectedItems(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddToggle("tgExcludeFruitType", {
	Title = "Exclude Fruit Type",
	Default = false,
	Callback = function(Value)
		ExcludeFruitType = Value
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
		CheckMutant = Value
		if QuickSave then
			QuickSave()
		end
	end,
})
--MutantType
local MutationData = DataService:GetData().GardenGuide.MutationData
local MutationTable = {}
for MutationName, MutationInfo in pairs(MutationData) do
	table.insert(MutationTable, MutationName)
end

CollectSection:AddDropdown("ddMutantType", {
	Title = "Mutant Type",
	Values = MutationTable,
	Multi = true,
	Default = {},
	Searchable = true,
	Callback = function(Value)
		MutantType = GetSelectedItems(Value)
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
		ExceptMutant = Value
		if QuickSave then
		end
	end,
})
CollectSection:AddDivider()

CollectSection:AddToggle("tgCheckVariant", {
	Title = "Check Variant",
	Default = false,
	Callback = function(Value)
		CheckVariant = Value
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
		VariantType = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddToggle("tgExceptVariant", {
	Title = "Except Variant",
	Default = false,
	Callback = function(Value)
		ExceptVariant = Value
		if QuickSave then
			QuickSave()
		end
	end,
})

CollectSection:AddDivider()

-- local CheckWeight = false --toggle
-- local WeightType = "Below" -- "Above", "Below"--dropdown single
-- local WeightValue = 100 --input

CollectSection:AddToggle("tgCheckWeight", {
	Title = "Check Weight",
	Default = false,
	Callback = function(Value)
		CheckWeight = Value
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
		WeightType = Value
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
		WeightValue = tonumber(Value) or 100
		if QuickSave then
			QuickSave()
		end
	end,
})

local PlantSection = Tabs.Farm:AddCollapsibleSection("Plant Fruit", false)
PlantSection:AddToggle("tgPlantFruitEnable", {
	Title = "Plant Fruit",
	Default = false,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PlantSection:AddDropdown("ddPlantFruitType", {
	Title = "Seed to Plant",
	Values = FruitTable,
	Multi = false,
	Default = "",
	Searchable = true,
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

PlantSection:AddDropdown("ddPlantPosition", {
	Title = "Plant Position",
	Values = { "User Position" },
	Multi = false,
	Default = "",
	Callback = function(Value)
		if QuickSave then
			QuickSave()
		end
	end,
})

--delay
PlantSection:AddInput("inPlantDelay", {
	Title = "Plant Delay (ms)",
	Default = "0.3",
	Numeric = true,
	Callback = function(Value)
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

DevLog = function(message)
	AddLog("💻 " .. message)
end

--[[
 SaveManager and InterfaceManager Setup
]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:SetIgnoreIndexes({})
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/GAG")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

--[[
 Quick Save Function
]]
QuickSave = function()
	if not IsLoading then
		SaveManager:Save("EfHub")
	end
end

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
IsLoading = false

--[[
 Auto Buy System
]]

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

local MyFarm = GetMyFarm()
local FarmPoint
if MyFarm then
	if MyFarm:FindFirstChild("Spawn_Point") then
		FarmPoint = MyFarm.Spawn_Point.CFrame
	end
end

local function BuildMutationCache()
	local mutations = PetMutationRegistry.PetMutationRegistry or PetMutationRegistry

	for name, info in pairs(mutations) do
		if type(info) == "table" and info.EnumId then
			EnumToNameCache[info.EnumId] = name
		end
	end
end

GetEquippedPetsUUID = function()
	local GetData_result = DataService:GetData()
	local EquippedPets = GetData_result.PetsData.EquippedPets or {}
	local UUIDtbl = {}
	for _, uuid in pairs(EquippedPets) do
		if uuid then
			table.insert(UUIDtbl, uuid)
		end
	end
	return UUIDtbl
end

GetRawPetData = function(uuid)
	local success, result = pcall(function()
		-- ถูกต้อง: ส่ง Name ตามที่เราแกะได้
		return ActivePetsService:GetPetData(LocalPlayer.Name, uuid)
	end)

	if success and result then
		return result -- คืนค่า Table ข้อมูลทั้งหมดกลับไป
	end
	return nil
end

-- ==========================================
-- 1. ฟังก์ชันหา Level
-- ==========================================
GetPetLevel = function(uuid)
	local data = GetRawPetData(uuid)
	-- เช็ค PetData ก่อน เพราะ Level อยู่ข้างในนั้น
	if data and data.PetData then
		return data.PetData.Level or 1
	end
	return 1
end

-- ==========================================
-- 2. ฟังก์ชันหา Mutation
-- ==========================================
GetPetMutation = function(uuid)
	local data = GetRawPetData(uuid)
	if data and data.PetData then
		local rawEnum = data.PetData.MutationType
		if rawEnum then
			return EnumToNameCache[rawEnum] or rawEnum
		end
	end
	return nil
end

-- ==========================================
-- 3. ฟังก์ชันหา Hunger
-- ==========================================
GetPetHunger = function(uuid)
	local data = GetRawPetData(uuid)
	if data and data.PetData then
		return data.PetData.Hunger or 0
	end
	return 0
end

-- ==========================================
-- 4. ฟังก์ชันหา PetType
-- ==========================================
GetPetType = function(uuid)
	local data = GetRawPetData(uuid)
	if data then
		-- ถูกต้อง: ตัวนี้อยู่นอก PetData (ตามโครงสร้างที่พี่เอฟเจอ)
		return data.PetType or "Unknown"
	end
	return "Unknown"
end

GetPetHungerPercent = function(uuid)
	return 100 * (GetPetHunger(uuid) / HungerTable[GetPetType(uuid)])
end

-- RawName removed (unused)

GetPetFavorite = function(uuid)
	local data = GetRawPetData(uuid)
	if data and data.PetData then
		local Favorited = data.PetData.IsFavorite
		if Favorited then
			return Favorited
		end
	end
	return nil
end

GetPetBaseWeight = function(uuid)
	local data = GetRawPetData(uuid)
	if data and data.PetData then
		local BaseWeight = tonumber(data.PetData.BaseWeight)
		if BaseWeight then
			return BaseWeight
		end
	end
	return nil
end

GetPetUUID = function(petName)
	local petMode = Options.PetMode.Value
	local useFavOnly = Options.UseFavoriteOnly.Value
	local targetMutant = "EfHub"

	if petMode == "Nightmare" then
		targetMutant = "Nightmare"
	elseif petMode == "Mutant" then
		targetMutant = Options.TargetMutantDropdown.Value
	end

	-- ฟังก์ชันเช็คเงื่อนไข (เพื่อลดความซ้ำซ้อนและเพิ่มความเร็ว)
	local function IsValidPet(uuid, pType)
		if pType ~= petName then
			return false
		end
		if (petMode == "Mutant" or petMode == "Nightmare") and GetPetMutation(uuid) == targetMutant then
			return false
		end
		if (GetPetFavorite(uuid) or false) ~= useFavOnly then
			return false
		end
		-- เงื่อนไขเพิ่มเติมที่พี่เอฟต้องการ
		--InfoLog("Weight : ".. tostring(GetPetBaseWeight(uuid)))
		if petMode == "Elephant" and GetPetBaseWeight(uuid) > 3.5 then
			return false
		end
		if petMode == "Level" and GetPetLevel(uuid) >= 100 then
			return false
		end

		return true
	end

	local startTime = tick()
	repeat
		-- 1. เช็คจากสัตว์เลี้ยงที่สวมใส่อยู่ (เร็วกว่า)
		for _, uuid in pairs(GetEquippedPetsUUID()) do
			local pType = GetPetType(uuid)
			if IsValidPet(uuid, pType) then
				InfoLog("Found pet (Equipped): " .. pType .. " [" .. uuid .. "]")
				return uuid
			end
		end

		-- 2. เช็คจาก Inventory
		local data = DataService:GetData()
		local inventory = data and data.PetsData and data.PetsData.PetInventory
		if inventory then
			for _, v in pairs(inventory) do
				if type(v) == "table" then
					for _, petData in pairs(v) do
						if IsValidPet(petData.UUID, petData.PetType) then
							InfoLog("Found pet (Backpack): " .. petData.PetType .. " [" .. petData.UUID .. "]")
							return petData.UUID
						end
					end
				end
			end
		end

		task.wait(0.5)
	until tick() - startTime > 10
	return nil
end

EquipPet = function(uuid)
	local args = { "EquipPet", uuid }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

UnequipPet = function(uuid)
	local args = { "UnequipPet", uuid }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

SwapPetLoadout = function(Loadout) -- Loadout is int 1-6
	if Loadout == 2 then
		Loadout = 3
	elseif Loadout == 3 then
		Loadout = 2
	end
	local args = { "SwapPetLoadout", Loadout }
	GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

heldPet = function(uuid)
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

	WarnLog("Failed to hold pet: " .. tostring(uuid))
	return false
end

heldItemUUID = function(uuid) -- find item in backpack and select it
	for _, item in ipairs(Backpack:GetChildren()) do
		if item:GetAttribute("c") == uuid then
			Humanoid:EquipTool(item)
			return true
		end
	end
	return false
end

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

IsActivePet = function(uuid)
	local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
	local targetPet = scrollFramePath:FindFirstChild(uuid)
	if targetPet then
		return true
	else
		return false
	end
end

MakeMutant = function(uuid)
	if Options.PetMode.Value ~= "Mutant" then
		return
	end
	SwapPetLoadout(Options.TimeSlots.Value)
	task.wait(Options.LoadOutDelay.Value)
	Character:PivotTo(CFrame.new(-236.17, 4.50, 14.36))
	task.wait(0.2)
	if IsActivePet(uuid) then
		UnequipPet(uuid) -- Swaps to loadout 4 to check pet age
		task.wait(1)
	end
	if heldPet(uuid) then
		task.wait(0.5)
		-- local args = {"MakeMutant", uuid}
		-- GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
		local args = { "SubmitHeldPet" }
		game:GetService("ReplicatedStorage")
			:WaitForChild("GameEvents")
			:WaitForChild("PetMutationMachineService_RE")
			:FireServer(unpack(args))
		task.wait(0.5)
		local args = { "PetAssets", Options.TargetPetDropdown.Value }
		game:GetService("ReplicatedStorage")
			:WaitForChild("GameEvents")
			:WaitForChild("ReplicationChannel")
			:FireServer(unpack(args))
		task.wait(1)
		local args = { "StartMachine" }
		game:GetService("ReplicatedStorage")
			:WaitForChild("GameEvents")
			:WaitForChild("PetMutationMachineService_RE")
			:FireServer(unpack(args))
		Mutanting = true
	end
end

ClaimMutantPet = function(uuid)
	-- print("Swapping to claim loadout " .. ClaimLoadout .. " to claim mutant pet...")
	SwapPetLoadout(Options.MutantSlots.Value)
	task.wait(Options.LoadOutDelay.Value)
	task.wait(Options.LoadOutDelay.Value)
	local args = { "ClaimMutatedPet" }
	game:GetService("ReplicatedStorage")
		:WaitForChild("GameEvents")
		:WaitForChild("PetMutationMachineService_RE")
		:FireServer(unpack(args))
	-- print("Mutant pet claimed successfully!")
	task.wait(3)
	if Character and Humanoid then
		pcall(function()
			Humanoid:UnequipTools()
		end)
	end
	-- local mutantPetname = GetPetMutation(uuid)
	SuccessLog("Successfully claimed " .. GetPetType(uuid) .. " Mutant : " .. GetPetMutation(uuid))
	Mutanting = false
	TargetMutant = Options.TargetMutantDropdown.Value
	task.wait(10)
	if TargetMutant == GetPetMutation(uuid) then
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:GetAttribute("PET_UUID") == uuid then
				item:SetAttribute("d", true)
			end
		end
		Mutation()
	else
		Mutation(uuid)
	end
end

Mutation = function(uuid)
	if Options.PetModeEnable.Value then
		local petMode = Options.PetMode.Value
		local TargetLimit = tonumber(Options.AgeLimitInput.Value) or 50
		local TargetPet = Options.TargetPetDropdown.Value

		-- ใช้ตัวแปร Global ตามที่พี่เอฟต้องการ
		targetUUID = uuid or GetPetUUID(TargetPet)

		if targetUUID then
			local age = GetPetLevel(targetUUID)
			-- InfoLog("Current level of " .. TargetPet .. ": " .. tostring(age))

			local function IsEquipPet()
				-- [แก้] ใช้ >= เพื่อให้หยุดเมื่อ "ถึง" เลเวลเป้าหมายพอดี (ไม่ต้องรอให้เกิน)
				if petMode == "Mutant" and age >= TargetLimit then
					return false
				end

				-- เงื่อนไขหยุดของ Level และ Elephant (หยุดเมื่อถึงเป้า)
				if petMode == "Level" and age >= TargetLimit then
					return false
				end

				if petMode == "Elephant" and age >= TargetLimit and GetPetBaseWeight(targetUUID) > 3.5 then
					return false
				end
				-- เงื่อนไขหยุดของ Nightmare
				if petMode == "Nightmare" and GetPetMutation(targetUUID) == "Nightmare" then
					return false
				end

				return true
			end

			if IsEquipPet() then
				-- สั่งวาร์ปทันที (ไม่ต้องเช็ค Character เพราะพี่เอฟยืนยันว่าไม่มีตาย)
				Character:PivotTo(CFrame.new(FarmPoint.X, FarmPoint.Y, FarmPoint.Z))
				task.wait(0.3)

				InfoLog("Swapping to loadout " .. Options.LevelSlots.Value .. " to equip pet...")
				SwapPetLoadout(Options.LevelSlots.Value)
				task.wait(Options.LoadOutDelay.Value)

				InfoLog("Equipping pet...")
				pcall(function()
					EquipPet(targetUUID)
				end)
			elseif petMode == "Mutant" then
				-- ถ้าหลุดจาก IsEquipPet และเป็นโหมด Mutant แสดงว่าเลเวลถึงเป้าแล้ว -> ส่งไปต้ม
				InfoLog("Send " .. TargetPet .. " to the Mutant Machine")
				MakeMutant(targetUUID)
			else
				-- ถ้าเป็นโหมดอื่นที่ถึงเป้าแล้ว ก็จบการทำงาน (Return)
				return
			end
		else
			ErrorLog("Target pet '" .. TargetPet .. "' not found in backpack.")
		end
	end
end

DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
	local TargetLevel = tonumber(Options.AgeLimitInput.Value) or 50
	--local TargetPet = Options.TargetPetDropdown.Value or "None"

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
		if BuyList[Key] then
			task.spawn(function()
				ProcessBuy(Key, Content)
			end)
		end

		if Options.PetModeEnable.Value then
			-- Process Pet Mutation
			task.spawn(function()
				if string.find(Key, "ROOT/GardenGuide/PetData") or Key == "ROOT/BadgeData/PetMaster" then
					if Options.PetMode.Value == "Nightmare" then
						PetNightmare(targetUUID)
					elseif Options.PetMode.Value == "Mutant" then
						CheckMakeMutant(targetUUID)
					else
						if GetPetLevel(targetUUID) >= TargetLevel then
							pcall(function()
								UnequipPet(targetUUID)
							end)
							task.wait(1)
							Mutation()
						end
					end --Elephant
				elseif Key == "ROOT/PetMutationMachine/PetReady" then
					if Mutanting and Options.PetMode.Value == "Mutant" then
						ClaimMutantPet(targetUUID)
					end
					task.wait(0.3)
				end
			end)
		end
	end
end)

ApplyAntiLag = function()
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

--[[ Anti-AFK ]]

LocalPlayer.Idled:Connect(function()
	VirtualUser:CaptureController()
	VirtualUser:ClickButton2(Vector2.new())
end)

FindFruitInv = function()
	local GetData_result = DataService:GetData()
	local InventoryData = GetData_result.InventoryData or {}
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

FeedPet = function()
	local petUUID = GetEquippedPetsUUID()
	if #petUUID == 0 then
		return
	end
	for i, uuid in pairs(petUUID) do
		local hunger = tonumber(GetPetHungerPercent(uuid))
		--AddLog("Hunger:" .. tostring(hunger))
		if hunger <= Options.PetHungerPercent.Value then
			local FruitInvUUID = FindFruitInv()
			if FruitInvUUID then
				if heldItemUUID(FruitInvUUID) then
					local args = {
						"Feed",
						uuid,
					}
					game:GetService("ReplicatedStorage")
						:WaitForChild("GameEvents")
						:WaitForChild("ActivePetService")
						:FireServer(unpack(args))
					--AddLog("Feed : " .. uuid)
					task.wait(1)
				end
			else
				break
			end
		end
	end
	--GetPetHunger
end

CheckFruit = function(model)
	-- 1. ตรวจสอบเบื้องต้นว่าเป็น Model หรือไม่
	if not model or not model:IsA("Model") then
		return false
	end
	-- 2. ตรวจสอบชนิดผลไม้ (Fruit Type)
	if CheckFruitType then
		local tFruitType = model.Name
		-- ตรวจสอบว่าชื่อผลไม้อยู่ในตารางที่กำหนดหรือไม่
		local isFound = table.find(FruitType, tFruitType) ~= nil

		-- ตรรกะ: (เจอในรายการยกเว้น) หรือ (ไม่เจอในรายการที่ต้องการ) -> ไม่ผ่าน
		if isFound == ExcludeFruitType then
			return false
		end
	end

	-- 3. ตรวจสอบการกลายพันธุ์ (Mutant)
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

	-- 4. ตรวจสอบรูปแบบย่อย (Variant)
	if CheckVariant then
		local VariantObj = model:FindFirstChild("Variant")

		-- ถ้าต้องเช็ค Variant แต่ผลไม้ไม่มี Variant เลย -> ถือว่าไม่ผ่าน
		if not VariantObj then
			return false
		end

		local tVariant = VariantObj.Value
		local isVariantMatch = (tVariant == VariantType)

		if isVariantMatch == ExceptVariant then
			return false
		end
	end

	-- 5. ตรวจสอบน้ำหนัก (Weight)
	if CheckWeight then
		local weightObj = model:FindFirstChild("Weight")
		if not weightObj then
			return false
		end

		local tWeight = weightObj.Value

		-- ตรวจสอบค่าตัวเลข
		if WeightType == "Above" and not (tWeight >= WeightValue) then
			return false
		elseif WeightType == "Below" and not (tWeight < WeightValue) then
			return false
		end
	end

	-- หากผ่านการตรวจสอบทุกขั้นตอน ให้ถือว่าเป็นจริง
	return true
end

ScanFarmTask = function()
	if IsScanning then
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

GetPosition = function()
	local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart")
	if HumanoidRootPart then
		local pivot = Character:GetPivot()
		return pivot.Position
	end
	return nil
end

AutoPlant = function()
	local pos = nil
	if Options.ddPlantPosition.Value == "User Position" then
		pos = GetPosition()
	end
	local tPlant = Options.ddPlantFruitType.Value
	local tSeed = tPlant .. " Seed"
	heldItemName(tSeed)
	if pos then
		local args = {
			vector.create(pos.X, pos.Y, pos.Z),
			tPlant,
		}
		game:GetService("ReplicatedStorage")
			:WaitForChild("GameEvents")
			:WaitForChild("Plant_RE")
			:FireServer(unpack(args))
	end
end

CheckMakeMutant = function(uuid)
	if Options.PetMode.Value ~= "Mutant" then
		return false
	end
	local TargetLevel = tonumber(Options.AgeLimitInput.Value) or 50
	local age = GetPetLevel(uuid)
	if not age then
		return
	end
	task.wait(0.3)
	--DevNoti("Key 1 :  " .. TargetPet .. " Age : " .. tostring(age))
	if age >= TargetLevel then
		--DevNoti(TargetPet .. " has reached level " .. TargetLevel)
		UnequipPet(uuid)
		task.wait(0.3)
		MakeMutant(uuid)
	end
end

PetNightmare = function(uuid)
	local mutant = GetPetMutation(uuid)
	if mutant and GetPetMutation(uuid) ~= "Nightmare" then
		local petsPhysical = game.Workspace:WaitForChild("PetsPhysical")
		for _, container in ipairs(petsPhysical:GetChildren()) do
			local PetModel = container:FindFirstChild(uuid)
			if PetModel then
				heldItemName("Cleansing Pet Shard")
				local args = {
					"ApplyShard",
					PetModel,
				}
				game:GetService("ReplicatedStorage")
					:WaitForChild("GameEvents")
					:WaitForChild("PetShardService_RE")
					:FireServer(unpack(args))
			end
		end
	elseif mutant and GetPetMutation(uuid) == "Nightmare" then
		UnequipPet(uuid)
		task.wait(1)
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:GetAttribute("PET_UUID") == uuid then
				item:SetAttribute("d", true)
			end
		end
		Mutation()
	end
end

task.spawn(function()
	while true do -- ใช้ While Loop เพื่อให้ทำงานวนไปเรื่อยๆ
		if Options.AutoFeedPet.Value then
			pcall(function() -- ใส่ pcall กัน Error แล้วสคริปต์หลุด
				FeedPet()
			end)
		end
		task.wait(10)
	end
end)

task.spawn(function()
	while true do -- ใช้ While Loop เพื่อให้ทำงานวนไปเรื่อยๆ
		if Options.tgPlantFruitEnable.Value then
			--pcall(function() -- ใส่ pcall กัน Error แล้วสคริปต์หลุด
			AutoPlant()
			--end)
		end
		task.wait(tonumber(Options.inPlantDelay.Value))
	end
end)

local function CollectValentines()
	local flag = false
	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")

	if Plants_Physical then
		for _, plant in pairs(Plants_Physical:GetChildren()) do
			local FruitsContainer = plant:FindFirstChild("Fruits")
			local Fruits = FruitsContainer and FruitsContainer:GetChildren() or { plant }
			for _, fruit in pairs(Fruits:GetChildren()) do
				if fruit:IsA("Model") then
					local Prompt = fruit:FindFirstChild("ProximityPrompt", true)
					if Prompt and Prompt.Enabled then
						if
							(fruit:GetAttribute("Heartstruck") or fruit:GetAttribute("Cute"))
							and not InventoryService.IsMaxInventory()
						then
							CollectEvent:FireServer({ fruit })
							flag = true
							task.wait()
						end
					end
				end
			end
			task.wait()
		end
		return flag
	end
	return nil
end

local function HasHeartstruck()
	for _, v in ipairs(game.Players.LocalPlayer.Backpack:GetChildren()) do
		if v:GetAttribute("Heartstruck") or v:GetAttribute("Cute") then
			return true
		end
	end
	return false
end

local function ValentinesEvent()
	local currentCoins = DataService:GetData().SpecialCurrency.HeartCoins
	local ValentinesCompleted = DataService:GetData().ValentinesEvent.Completed
	Rewards = { 30, 200, 700, 2000, 10000 }
	for i = 1, 5 do
		if currentCoins >= Rewards[i] and not ValentinesCompleted[i] then
			game:GetService("ReplicatedStorage")
				:WaitForChild("GameEvents")
				:WaitForChild("ValentinesEvent")
				:WaitForChild("ClaimValentineReward")
				:FireServer(i)
		end
		task.wait(0.3)
	end
end

local ValentinesEnable = true
task.spawn(function()
	while true do
		if ValentinesEnable then
			pcall(function()
				ValentinesEvent()
			end)
		end
		task.wait(60)
	end
end)
task.spawn(function()
	while true do
		if ValentinesEnable then
			pcall(function()
				CollectValentines()
				if HasHeartstruck() then
					local result = game:GetService("ReplicatedStorage")
						:WaitForChild("GameEvents")
						:WaitForChild("ValentinesEvent")
						:WaitForChild("GiveHeartstruckFruits")
						:InvokeServer()
					task.wait(0.3)
				end
			end)
		end
		task.wait(0.1)
	end
end)

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
			-- 4. ถ้าคิวว่าง (ไม่มีของให้เก็บ)
			-- สั่งให้ Producer เริ่มสแกนหารอบใหม่
			if not IsScanning then
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
		while true do
			if Options.AutoSellALL.Value then
				local success, isFull = pcall(function()
					return InventoryService.IsMaxInventory(LocalPlayer)
				end)

				if success and isFull then
					local Previous = Character:GetPivot()
					Character:PivotTo(CFrame.new(36.58, 4.50, 0.43))
					task.wait(0.3)
					GameEvents.Sell_Inventory:FireServer()
					task.wait(0.5)
					Character:PivotTo(Previous)
				end
			end
			task.wait()
		end
	end)
end)


task.spawn(function()
	pcall(function()
		while true do
			local petMode = Options.PetMode.Value
			if Options.PetModeEnable.Value and (petMode == "Elephant" or petMode == "Level")  then
				if GetPetLevel(targetUUID) >= Options.AgeLimitInput.Value then
							pcall(function()
								UnequipPet(targetUUID)
							end)
							task.wait(1)
							Mutation()
						end
			end
			task.wait(10)
		end
	end)
end)
