-- game:GetService("ReplicatedStorage").Modules.InventoryService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-12 02:27:06
-- Luau version 6, Types version 3
-- Time taken: 0.002803 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
local module_2_upvr = {}
local InventoryServiceEnums_upvr = require(ReplicatedStorage.Data.EnumRegistry.InventoryServiceEnums)
function module_2_upvr.GetToolData(arg1, arg2) -- Line 21
	--[[ Upvalues[2]:
		[1]: InventoryServiceEnums_upvr (readonly)
		[2]: DataService_upvr (readonly)
	]]
	if not arg2 then
		return warn("InventoryService:GetToolData | Player is Nil!", debug.traceback())
	end
	if not arg2:IsA("Tool") then
		return warn(`InventoryService:GetToolData | {arg2} is not of 'Tool' type!`, debug.traceback())
	end
	local attribute = arg2:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID)
	if not attribute then
		return warn(arg2, "has no attached ITEM_UUID attribute")
	end
	local var6 = DataService_upvr:GetData().InventoryData[attribute]
	if not var6 then return end
	return var6
end
function module_2_upvr.Find(arg1, arg2, arg3) -- Line 36
	--[[ Upvalues[1]:
		[1]: DataService_upvr (readonly)
	]]
	local var12
	if not var12 then
		function var12() -- Line 37
			return true
		end
	end
	local module = {}
	local any_GetData_result1 = DataService_upvr:GetData()
	if not any_GetData_result1 then
		return module
	end
	for i, v in any_GetData_result1.InventoryData do
		if v.ItemType == arg2 and var12(v.ItemData) then
			module[i] = v
		end
	end
	return module
end
local CountDictionary_upvr = require(ReplicatedStorage.Modules.CountDictionary)
local LocalPlayer_upvr = game.Players.LocalPlayer
function module_2_upvr.IsMaxInventory(arg1) -- Line 55
	--[[ Upvalues[3]:
		[1]: module_2_upvr (readonly)
		[2]: CountDictionary_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	local BonusBackpackSize = LocalPlayer_upvr:GetAttribute("BonusBackpackSize")
	if 200 + (BonusBackpackSize or 0) > CountDictionary_upvr(module_2_upvr:Find("Holdable")) then
		BonusBackpackSize = false
	else
		BonusBackpackSize = true
	end
	return BonusBackpackSize
end
return module_2_upvr
