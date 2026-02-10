-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:26:00
-- Luau version 6, Types version 3
-- Time taken: 0.006016 seconds

local ReplicatedFirst_upvr = game:GetService("ReplicatedFirst")
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local module_upvr = {}
if require(ReplicatedStorage_upvr.Modules.IsDev)() and RunService_upvr:IsServer() then
	if RunService_upvr:IsStudio() or game.PlaceId == 108890465381067 then
		ReplicatedFirst_upvr.GlobalUpdateTime.Value = workspace:GetServerTimeNow() + 5
	else
		ReplicatedFirst_upvr.GlobalUpdateTime.Value = workspace:GetServerTimeNow() + 120
	end
end
local any_new_result1_upvr = require(ReplicatedStorage_upvr.Modules.Signal).new()
module_upvr.OnUpdated = any_new_result1_upvr
local tbl_upvr = {"Event Shop Restock", "Shop UI Rework", "Shop Exotic Buttercup Chest", "Shop Premium Bird Egg"}
local tbl_upvr_3 = {"Event Shop Restock", "Shop UI Rework"}
local tbl_upvr_2 = {}
local var9_upvw = false
function module_upvr.IsActive(arg1, arg2) -- Line 103
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local var10 = not module_upvr:IsHiddenFromUpdate(arg2)
	if var10 then
		var10 = not module_upvr:IsHiddenAfterUpdate(arg2)
	end
	return var10
end
function module_upvr.IsHiddenAfterUpdate(arg1, arg2) -- Line 107
	--[[ Upvalues[2]:
		[1]: tbl_upvr_3 (readonly)
		[2]: ReplicatedFirst_upvr (readonly)
	]]
	for _, v in tbl_upvr_3 do
		if v == arg2 and ReplicatedFirst_upvr.GlobalUpdateTime.Value < workspace:GetServerTimeNow() then
			return true
		end
	end
	return false
end
function module_upvr.IsHiddenFromUpdate(arg1, arg2) -- Line 117
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: ReplicatedFirst_upvr (readonly)
	]]
	for _, v_2 in tbl_upvr do
		if v_2 == arg2 and workspace:GetServerTimeNow() <= ReplicatedFirst_upvr.GlobalUpdateTime.Value then
			return true
		end
	end
	return false
end
function module_upvr.GetUpdateTime(arg1) -- Line 127
	--[[ Upvalues[1]:
		[1]: ReplicatedFirst_upvr (readonly)
	]]
	return ReplicatedFirst_upvr.GlobalUpdateTime.Value
end
function module_upvr.GetRemainingTimeUntilUpdate(arg1) -- Line 131
	--[[ Upvalues[1]:
		[1]: ReplicatedFirst_upvr (readonly)
	]]
	return ReplicatedFirst_upvr.GlobalUpdateTime.Value - workspace:GetServerTimeNow()
end
function module_upvr.IsUpdateDone(arg1) -- Line 135
	--[[ Upvalues[1]:
		[1]: var9_upvw (read and write)
	]]
	return var9_upvw
end
local function _() -- Line 139, Named "CompleteUpdate"
	--[[ Upvalues[3]:
		[1]: tbl_upvr_2 (readonly)
		[2]: var9_upvw (read and write)
		[3]: any_new_result1_upvr (readonly)
	]]
	for _, v_3 in tbl_upvr_2 do
		v_3.Parent = script
	end
	var9_upvw = true
	any_new_result1_upvr:Fire()
end
local children_upvr = workspace.Interaction.UpdateItems:GetChildren()
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
task.spawn(function() -- Line 149
	--[[ Upvalues[6]:
		[1]: ReplicatedFirst_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
		[3]: var9_upvw (read and write)
		[4]: any_new_result1_upvr (readonly)
		[5]: children_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
	]]
	local var36
	if ReplicatedFirst_upvr.GlobalUpdateTime.Value <= var36 then
		var36 = tbl_upvr_2
		for _, v_4 in var36 do
			v_4.Parent = script
		end
		var36 = true
		var9_upvw = var36
		var36 = any_new_result1_upvr:Fire
		var36()
	else
		var36 = children_upvr
		for i_5, v_5 in var36 do
			v_5.Parent = script
		end
		repeat
			var36 = task.wait(1)
			if not var36 then break end
			var36 = workspace:GetServerTimeNow()
			i_5 = ReplicatedFirst_upvr
		until i_5.GlobalUpdateTime.Value <= var36
		var36 = nil
		if LocalPlayer_upvr then
			i_5 = "FirstTimePlayer"
			var36 = LocalPlayer_upvr:GetAttribute(i_5)
		end
		for _, v_6 in children_upvr do
			if not var36 then
				v_6.Parent = workspace.Interaction.UpdateItems
			end
		end
		for _, v_7 in tbl_upvr_2 do
			v_7.Parent = script
		end
		var9_upvw = true
		any_new_result1_upvr:Fire()
	end
end)
function module_upvr.ForceCompleteUpdate(arg1) -- Line 185
	--[[ Upvalues[3]:
		[1]: ReplicatedFirst_upvr (readonly)
		[2]: RunService_upvr (readonly)
		[3]: ReplicatedStorage_upvr (readonly)
	]]
	ReplicatedFirst_upvr.GlobalUpdateTime.Value = workspace:GetServerTimeNow()
	if RunService_upvr:IsServer() then
		ReplicatedStorage_upvr.GameEvents.UpdateServiceForceUpdated:FireAllClients()
	end
end
if RunService_upvr:IsClient() then
	ReplicatedStorage_upvr.GameEvents.UpdateServiceForceUpdated.OnClientEvent:Connect(module_upvr.ForceCompleteUpdate, module_upvr)
end
return module_upvr
