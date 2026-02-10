-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:33:35
-- Luau version 6, Types version 3
-- Time taken: 0.001948 seconds

local module_2_upvr = {}
module_2_upvr.__index = module_2_upvr
function module_2_upvr.new(arg1) -- Line 11
	--[[ Upvalues[1]:
		[1]: module_2_upvr (readonly)
	]]
	local module = {}
	module.Table = arg1
	module.PathRegistry = {}
	return setmetatable(module, module_2_upvr)
end
function module_2_upvr.Destroy(arg1) -- Line 20
	for _, v in arg1.PathRegistry do
		v:Destroy()
	end
end
function module_2_upvr.GetTable(arg1) -- Line 26
	return arg1.Table
end
function module_2_upvr.FindPathSignal(arg1, arg2) -- Line 30
	local PathRegistry = arg1.PathRegistry
	if not PathRegistry[arg2] then return end
	return PathRegistry[arg2]
end
function module_2_upvr.FreePathSignal(arg1, arg2) -- Line 36
	arg1.PathRegistry[arg2] = nil
end
local module_upvr = require(script:WaitForChild("Signal"))
function module_2_upvr.GetPathSignal(arg1, arg2) -- Line 41
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local any_FindPathSignal_result1 = arg1:FindPathSignal(arg2)
	if any_FindPathSignal_result1 then
		return any_FindPathSignal_result1
	end
	local any_new_result1 = module_upvr.new()
	arg1.PathRegistry[`{arg2}`] = any_new_result1
	return any_new_result1
end
return module_2_upvr
