
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



-- Variables USE Table
getgenv().EfHub_IsLoading = true
getgenv().EfHub_Dev={
	Mode = true
}
getgenv().EfHub_Pet={
--[[
	local Mutanting = false
    local IsActivePet = false
]]
}

--function
getgenv().EfHub_DevNoti
getgenv().EfHub_QuickSave
getgenv().EfHub_GetSelectedItems

getgenv().EfHub_targetUUID
getgenv().EfHub_MainFunc={
	--[[
	local ApplyAntiLag
	local DevLog
	GetMyFarm,
	]]
}
getgenv().EfHub_PetFunc={
	--[[
	local GetPetUUID
	local EquipPet
	local UnequipPet
	local SwapPetLoadout
	local heldPet
	local MakeMutant
	local Mutation
	local ClaimMutantPet
	local GetRawPetData, GetPetLevel, GetPetMutation, GetPetHunger, GetPetType, GetPetFavorite, GetPetHungerPercent
	local GetEquippedPetsUUID,
	FeedPet
	]]
}
getgenv().EfHub_ItemFunc={
	--[[
	local heldItemName
	local heldItemUUID
	]]
}
getgenv().EfHub_BuyFunc={
	--[[
	local ProcessBuy,
	]]
}
getgenv().EfHub_FarmFunc={
	--[[
	CollectFruit, CheckFruit
	FindFruitInv, 
	]]
}

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