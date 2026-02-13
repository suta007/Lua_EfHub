-- game:GetService("ReplicatedStorage").Modules.CraftingService.CraftingGlobalObjectService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:34:39
-- Luau version 6, Types version 3
-- Time taken: 0.003698 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local CraftingGlobalObjectService_upvr = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("CraftingGlobalObjectService")
local module_upvr = {}
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
function module_upvr.GetCraftingObjectData(arg1, arg2) -- Line 20
	--[[ Upvalues[1]:
		[1]: DataService_upvr (readonly)
	]]
	local CraftingObjectId = arg2:GetAttribute("CraftingObjectId")
	if not CraftingObjectId then
		error(`CraftingService:GetCraftingDataForModel passed CraftingObject: {arg2:GetFullName()} does not have associated CraftingObjectId Attribute.`)
		return
	end
	if not arg2:GetAttribute("CraftingObjectType") then
		error(`CraftingService:GetCraftingDataForModel passed CraftingObject: {arg2:GetFullName()} does not have associated CraftingObjectType Attribute.`)
		return
	end
	return DataService_upvr:GetData().CraftingData.GlobalCraftingObjectData[CraftingObjectId]
end
local CraftingRecipeRegistry_upvr = require(ReplicatedStorage.Data.CraftingData.CraftingRecipeRegistry)
local CraftingObjectRegistry_upvr = require(ReplicatedStorage.Data.CraftingData.CraftingObjectRegistry)
local DumpTable_upvr = require(ReplicatedStorage.Modules.DumpTable)
function module_upvr.GetIndividualCraftingMachineData(arg1, arg2, arg3) -- Line 41
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: CraftingRecipeRegistry_upvr (readonly)
		[3]: CraftingObjectRegistry_upvr (readonly)
		[4]: DumpTable_upvr (readonly)
	]]
	local any_GetCraftingObjectData_result1 = module_upvr:GetCraftingObjectData(arg2)
	if not any_GetCraftingObjectData_result1 then return end
	if not CraftingRecipeRegistry_upvr then
		error(`CraftingService:GetIndividualCraftingMachineData passed RecipeId {arg3} does not have associated CraftingRecipeRegistryData.`)
		return
	end
	if not arg2:GetAttribute("CraftingObjectId") then
		error("CraftingService:GetIndividualCraftingMachineData passed CraftingObject: ", arg2, "does not have associated CraftingObjectId Attribute.")
		return
	end
	local CraftingObjectType = arg2:GetAttribute("CraftingObjectType")
	if not CraftingObjectType then
		error("CraftingService:GetIndividualCraftingMachineData passed CraftingObject: ", arg2, "does not have associated CraftingObjectType Attribute.")
		return
	end
	local var11 = CraftingObjectRegistry_upvr[CraftingObjectType]
	if not var11.Slots[arg3] then
		return warn("Could not get data cause foundslot does not exist for", arg3, CraftingObjectType, DumpTable_upvr(var11.Slots))
	end
	return any_GetCraftingObjectData_result1.MachineData[arg3]
end
function module_upvr.SetRecipe(arg1, arg2, arg3, arg4) -- Line 54
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("SetRecipe", arg2, arg3, arg4)
end
function module_upvr.InputItem(arg1, arg2, arg3, arg4, arg5) -- Line 58
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("InputItem", arg2, arg3, arg4, arg5)
end
function module_upvr.Craft(arg1, arg2, arg3) -- Line 62
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("Craft", arg2, arg3)
end
function module_upvr.Claim(arg1, arg2, arg3, arg4) -- Line 66
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("Claim", arg2, arg3, arg4)
end
function module_upvr.Skip(arg1, arg2, arg3, arg4) -- Line 70
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("AuthoriseSkip", arg2, arg3, arg4)
end
function module_upvr.Cancel(arg1, arg2, arg3) -- Line 74
	--[[ Upvalues[1]:
		[1]: CraftingGlobalObjectService_upvr (readonly)
	]]
	return CraftingGlobalObjectService_upvr:FireServer("Cancel", arg2, arg3)
end
return module_upvr
