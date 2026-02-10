-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:29:53
-- Luau version 6, Types version 3
-- Time taken: 0.006206 seconds

local DataStream_upvr = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("DataStream")
local module_upvr = {}
local tbl_2_upvr = {}
local module_upvr_2 = require(script:WaitForChild("TableListener"))
local module_upvr_4 = require(script:WaitForChild("DeepClone"))
DataStream_upvr.OnClientEvent:Connect(function(...) -- Line 17
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: module_upvr_2 (readonly)
		[3]: module_upvr_4 (readonly)
		[4]: tbl_2_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local args_list = {...}
	local _1 = args_list[1]
	if _1 == "InitData" then
		local _2 = args_list[2]
		local _3 = args_list[3]
		if not _2 or not _3 then
		else
			module_upvr[_2] = module_upvr_2.new(_3)
		end
	end
	if _1 == "UpdateData" then
		local _2_upvr = args_list[2]
		local var21_upvr = module_upvr[_2_upvr]
		if not var21_upvr then return end
		for _, v_upvr in args_list[3] do
			task.spawn(function() -- Line 40
				--[[ Upvalues[5]:
					[1]: var21_upvr (readonly)
					[2]: v_upvr (readonly)
					[3]: module_upvr_4 (copied, readonly)
					[4]: tbl_2_upvr (copied, readonly)
					[5]: _2_upvr (readonly)
				]]
				-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
				-- KONSTANTERROR: [0] 1. Error Block 46 start (CF ANALYSIS FAILED)
				local any_GetTable_result1 = var21_upvr:GetTable()
				local any_split_result1 = v_upvr[1]:split('/')
				local var25
				if #any_split_result1 < 1 then return end
				table.remove(any_split_result1, 1)
				if #any_split_result1 == 1 then
					var25 = 1
				else
					var25 = #any_split_result1 - 1
				end
				local var26
				var25 = nil
				-- KONSTANTERROR: [0] 1. Error Block 46 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [171] 144. Error Block 37 start (CF ANALYSIS FAILED)
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [171.12]
				local var27 = any_GetTable_result1[nil]
				if not var27 then
					var27 = {}
				end
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				any_GetTable_result1[nil] = var27
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				if nil == #any_split_result1 - 1 then
				end
				-- KONSTANTERROR: [171] 144. Error Block 37 end (CF ANALYSIS FAILED)
				-- KONSTANTERROR: [48] 42. Error Block 47 start (CF ANALYSIS FAILED)
				if not var26 then
				else
				end
				-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [182.14]
				-- KONSTANTERROR: [48] 42. Error Block 47 end (CF ANALYSIS FAILED)
			end)
			local _
		end
	end
end)
local tbl = {}
local module_upvr_3 = require(script:WaitForChild("Signal"))
function tbl.Constructor(arg1, arg2) -- Line 121
	--[[ Upvalues[3]:
		[1]: module_upvr_3 (readonly)
		[2]: DataStream_upvr (readonly)
		[3]: tbl_2_upvr (readonly)
	]]
	arg1.Name = arg2
	arg1.GlobalChanged = module_upvr_3.new()
	DataStream_upvr:FireServer("InitData")
	tbl_2_upvr[arg2] = arg1
end
tbl.Data = nil
local var31 = require(script:WaitForChild("class"))(tbl)
function var31.GetData(arg1) -- Line 132
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	return module_upvr[arg1.Name]
end
function var31.YieldUntilData(arg1, arg2) -- Line 137
	while true do
		local any_GetData_result1 = arg1:GetData()
		if any_GetData_result1 or (arg2 or math.huge) <= os.clock() - os.clock() then
			return any_GetData_result1
		end
		task.wait()
	end
end
function var31.GetPathSignal(arg1, arg2) -- Line 150
	local any_YieldUntilData_result1 = arg1:YieldUntilData()
	if not any_YieldUntilData_result1 then return end
	return any_YieldUntilData_result1:GetPathSignal(arg2)
end
return var31
