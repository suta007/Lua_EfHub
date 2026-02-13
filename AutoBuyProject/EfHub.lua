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
local DevMode = true
local DevNoti
local IsLoading = true
local QuickSave
local GetSelectedItems

local targetUUID
local GetPetUUID
local GetPetName
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
local RawName
local DevLog
local ProcessBuy, ManualBuy, GetMyFarm, CollectFruit, CollectFruitAll
local AutoCollectFruitAll = false

local GetRawPetData, GetPetLevel, GetPetMutation, GetPetHunger, GetPetType, GetPetFavorite
local GetEquippedPetsUUID, FindFruitInv, FeedPet

local ShopKey = {
	Seed = "ROOT/SeedStocks/Shop/Stocks",
	Daily = "ROOT/SeedStocks/Daily/Stocks",
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

ProcessBuy = function(ShopKey, StockData)
	local Setting = BuyList[ShopKey]
	if not Setting or not Setting.Enabled then
		return
	end
	local Remote = GameEvents:FindFirstChild(Setting.RemoteName)
	if not Remote then
		return
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
	Size = UDim2.fromOffset(1200, 768),
	Resize = true,
	-- MinSize = Vector2.new(470, 380),
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

--[[
 local bntSave = Tabs.Settings:AddButton({
    Title = "Save Settings",
    Callback = function()
        SaveManager:Save("EfHub")
    end
})
local bntLoad = Tabs.Settings:AddButton({
    Title = "Load Settings",
    Callback = function()
        SaveManager:Load("EfHub")
    end
}) 
    ]]
--[[ 
Buy Seeds Section 
]]

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
			local mode = Options.PetMode.Value
			if mode == "Nightmare" then
				-- Mutation = "Nightmare"
			elseif mode == "Mutant" then
				if Mutation then
					Mutation()
				end
			else
				-- Mutation = "EfHub"
			end
		end
	end,
})
local PetData = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetList)
local PetTable = {}
for petName, petInfo in pairs(PetData) do
	table.insert(PetTable, petName)
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

--[[ Farm Section]]
local CollectSection = Tabs.Farm:AddCollapsibleSection("Collect Fruit", false)
CollectSection:AddToggle("tglCollectFruitAll", {
	Title = "Auto Collect All Fruit ",
	Default = false,
	Callback = function(Value)
		if CollectFruitAll then
			CollectFruitAll(Value)
		end
		if QuickSave then
			QuickSave()
		end
		AutoCollectFruitAll = Value
	end,
})

--[[ Log Section ]]
--
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {} -- ตารางเก็บข้อความโชว์

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

local function AddLog(message)
	local entry = string.format("[%s] %s", os.date("%X"), message)

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then
		table.remove(DisplayTable, 1)
	end
	if LogDisplay then
		-- LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
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
	-- เช็คโครงสร้างข้อมูลว่า List Mutation เก็บอยู่ที่ไหน
	-- (บางทีอาจซ้อนอยู่ใน .PetMutationRegistry หรืออยู่ที่ตัวแปรหลักเลย)
	local mutations = PetMutationRegistry.PetMutationRegistry or PetMutationRegistry

	for name, info in pairs(mutations) do
		-- ถ้าข้อมูลมี EnumId ให้เก็บลงตาราง Cache
		-- ตัวอย่าง: info.EnumId คือ 'a', name คือ "Shocked"
		-- ผลลัพธ์ใน Cache: EnumToNameCache['a'] = "Shocked"
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

RawName = function(Name)
	-- MutantTable
	for _, prefix in ipairs(MutantTable) do
		if string.sub(Name, 1, #prefix) == prefix then
			Name = string.sub(Name, #prefix + 1)
			break
		end
	end
	-- 2. ลบทุกวงเล็บทิ้ง
	Name = string.gsub(Name, "%b[]", "")
	-- 3. ตัดช่องว่างหัวท้าย
	Name = string.match(Name, "^%s*(.-)%s*$")
	return Name
end

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

GetPetUUID = function(petName)
	local TargetPet = petName -- PetSetting["PetMode"].TargetPet
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
		local UUIDs = GetEquippedPetsUUID()
		for _, uuid in pairs(UUIDs) do
			local PetType = GetPetType(uuid)
			if PetType and PetType == TargetPet then
				if GetPetMutation(uuid) ~= TargetMutant then
					InfoLog("Found pet in ActivePetUI: " .. PetType .. " (UUID: " .. uuid .. ")")
					return uuid
				end
			end
		end
		local GetData_result = DataService:GetData()
		local PetInventory = GetData_result.PetsData.PetInventory
		if PetInventory then
			for k, v in pairs(PetInventory) do
				if type(v) == "table" then
					for _, Data in pairs(v) do
						local PetType = Data.PetType
						local uuid = Data.UUID
						if PetType and PetType == TargetPet then
							if GetPetMutation(uuid) ~= TargetMutant then
								InfoLog("Found pet in Backpack: " .. PetType .. " (UUID: " .. uuid .. ")")
								return uuid
							end
						end
					end
				end
			end
		end

		--[[ 		for _, item in ipairs(Backpack:GetChildren()) do
			if item:GetAttribute("ItemType") == "Pet" then
				name = RawName(item.Name)
				-- if string.find(name, TargetPet) then
				if name == TargetPet then
					if not string.find(name, TargetMutant) then
						InfoLog("Found pet in backpack: " .. name .. " (UUID: " .. item:GetAttribute("PET_UUID") .. ")")
						return item:GetAttribute("PET_UUID")
					end
				end
			end
		end ]]

		task.wait(0.5)
	until tick() - startTime > timeout
	return nil
end

GetPetName = function(uuid)
	local timeout = 3 -- รอสูงสุด 3 วินาที
	local startTime = tick()
	repeat
		for _, item in ipairs(Backpack:GetChildren()) do
			if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
				return GetPetType(item.Name)
			end
		end
		local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
		local targetPet = scrollFramePath:FindFirstChild(uuid)
		if targetPet then
			return GetPetType(targetPet.Main.PET_TYPE.Text)
		end
	until tick() - startTime > timeout
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
		name = string.trim(name)
		if name == itemName then
			Humanoid:EquipTool(item)
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
		Mutation()
	else
		Mutation(uuid)
	end
end

Mutation = function(uuid)
	-- if PetSetting["PetMode"].Enabled then
	if Options.PetModeEnable.Value then
		local TargetPet = Options.TargetPetDropdown.Value
		targetUUID = uuid or GetPetUUID(TargetPet)
		if targetUUID then
			-- InfoLog("Found target pet: " .. TargetPet .. " (UUID: " .. targetUUID .. ")")
			local age = GetPetLevel(targetUUID)
			InfoLog("Current age of " .. TargetPet .. ": " .. tostring(age))
			if age < 50 then
				Character:PivotTo(CFrame.new(FarmPoint.X, FarmPoint.Y, FarmPoint.Z))
				task.wait(0.3)
				InfoLog("Swapping to loadout " .. Options.LevelSlots.Value .. " to equip pet...")
				SwapPetLoadout(Options.LevelSlots.Value)
				task.wait(Options.LoadOutDelay.Value)
				InfoLog("Equipping pet...")
				pcall(function()
					EquipPet(targetUUID)
				end)
			else
				InfoLog("Send " .. TargetPet .. " to the Mutant Machine")
				MakeMutant(targetUUID)
			end
		else
			ErrorLog("Target pet '" .. TargetPet .. "' not found in backpack.")
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
		if BuyList[Key] then
			task.spawn(function()
				ProcessBuy(Key, Content)
			end)
		end

		if Options.PetModeEnable.Value then
			-- Process Pet Mutation
			task.spawn(function()
				if string.find(Key, "ROOT/GardenGuide/PetData") then
					local age = tonumber(Content) or (targetUUID and GetPetLevel(targetUUID))
					if not age then
						return
					end
					task.wait(0.3)
					DevNoti("Key 1 :  " .. TargetPet .. " Age : " .. tostring(age))
					if age >= TargetLevel then
						DevInfoLogNoti(TargetPet .. " has reached level " .. TargetLevel)
						UnequipPet(targetUUID)
						task.wait(0.3)
						MakeMutant(targetUUID)
					end
				elseif Key == "ROOT/BadgeData/PetMaster" then
					local age = (targetUUID and GetPetLevel(targetUUID))
					if not age then
						return
					end
					task.wait(0.3)
					DevNoti("Key 2 :  " .. TargetPet .. " Age : " .. tostring(age))
					if age >= TargetLevel then
						InfoLog(TargetPet .. " has reached level " .. TargetLevel)
						UnequipPet(targetUUID)
						task.wait(0.3)
						MakeMutant(targetUUID)
					end
				elseif Key == "ROOT/PetMutationMachine/PetReady" then
					if Mutanting then
						ClaimMutantPet(targetUUID)
					end
					task.wait(0.3)
				end
			end)
		end
	end
end)

CollectFruit = function()
	MyFarm = GetMyFarm()

	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")
	if InventoryService.IsMaxInventory() then --
		--DevNoti("กระเป๋าเต็มแล้วครับ! หยุดเก็บ")
		return -- สั่งจบฟังก์ชันตรงนี้เลย
	end

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
								CollectEvent:FireServer({ fruit })
							end
						end
					end
				end
			end
		end
	end
end

CollectFruitAll = function(value)
	DevNoti("Call Function Callect fruit all")
	if AutoCollectFruitAll == value then
		DevNoti("AutoCollectFruitAll Same Value " .. tostring(value))
		return
	end
	AutoCollectFruitAll = value or false -- รับค่า true/false มาจากปุ่ม
	DevNoti("AutoCollectFruitAll is " .. tostring(AutoCollectFruitAll))
	if AutoCollectFruitAll then
		DevNoti("Start All Collect")
		task.spawn(function()
			while AutoCollectFruitAll do -- เช็คตลอดว่ายังเปิดอยู่ไหม
				CollectFruit()
				task.wait(0.5)
			end
		end)
	end
end

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

--task.wait(5)
--CollectFruitAll(Options.tglCollectFruitAll.Value)

local AllowList = { "Elder Strawberry", "Apple", "Carrot" }

FindFruitInv = function()
	local GetData_result = DataService:GetData()
	local InventoryData = GetData_result.InventoryData or {}
	for uuid, Item in pairs(InventoryData) do
		if Item.ItemData and Item.ItemData.ItemName then
			local FruitInv = Item.ItemData.ItemName
			for _, Fruit in pairs(AllowList) do
				if FruitInv == Fruit then
					--AddLog("Found Fruit : "..FruitInv.." UUID: "..uuid)
					return uuid
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
		local hunger = tonumber(GetPetHunger(uuid))
		--AddLog("Hunger:" .. tostring(hunger))
		if hunger <= 1000 then
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
					AddLog("Feed : " .. uuid)
					task.wait(1)
				end
			else
				break
			end
		end
	end
	--GetPetHunger
end

-- [[ ส่วน Loop การทำงาน ]] --
local isAutoFeeding = true -- ตัวแปรคุมเปิด/ปิด

task.spawn(function()
	while isAutoFeeding do -- ใช้ While Loop เพื่อให้ทำงานวนไปเรื่อยๆ
		--pcall(function() -- ใส่ pcall กัน Error แล้วสคริปต์หลุด
		FeedPet()
		--end)
		task.wait(10) -- เช็คความหิวทุกๆ 2 วินาที (ไม่ต้องถี่มาก)
	end
end)
