game:GetService("ReplicatedStorage").Modules.CraftingService.CraftingGlobalObjectService

CraftService = require(game:GetService("ReplicatedStorage").Modules.CraftingService.CraftingGlobalObjectService)


game:GetService("ReplicatedStorage").Data.CraftingData.CraftingRecipeRegistry

game:GetService("ReplicatedStorage").Data.CraftingData.CraftingObjectRegistry


local args = {
	"SetRecipe",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench",
	"Lightning Rod"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))

local args = {
	"SetRecipe",
	workspace:WaitForChild("CraftingTables"):WaitForChild("SeedEventCraftingWorkBench"),
	"SeedEventWorkbench",
	"Mandrake"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))


local args = {
	"InputItem",
	workspace:WaitForChild("CraftingTables"):WaitForChild("SeedEventCraftingWorkBench"),
	"SeedEventWorkbench",
	1,
	{
		ItemType = "Seed",
		ItemData = {
			UUID = "{bffce969-d1d2-4338-a155-8d784d349791}"
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))


local args = {
	"InputItem",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench",
	1,
	{
		ItemType = "Sprinkler",
		ItemData = {
			UUID = "{63421d03-9235-461c-81bc-a3cce5301188}"
		}
	}
}


game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))


local args = {
	"InputItem",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench",
	1,
	{
		ItemType = "Sprinkler",
		ItemData = {
			UUID = "{63421d03-9235-461c-81bc-a3cce5301188}"
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))


local args = {
	"Cancel",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))

+++++++++++++


local args = {
	"SetRecipe",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench",
	"Reclaimer"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))


local args = {
	"InputItem",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench",
	1,
	{
		ItemType = "PetEgg",
		ItemData = {
			UUID = "{bb0d84dd-8dbd-4904-af70-c873ca905c74}"
		}
	}
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))



local args = {
	"Craft",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"GearEventWorkbench"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))





local args = {
	"SetRecipe",
	workspace:WaitForChild("CraftingTables"):WaitForChild("EventCraftingWorkBench"),
	"SmithingEventPetWorkbench",
	"Gem Egg"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))




local args = {
	"SetRecipe",
	workspace:WaitForChild("CraftingTables"):WaitForChild("SeedEventCraftingWorkBench"),
	"SeedEventWorkbench",
	"Bee Balm"
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService"):FireServer(unpack(args))