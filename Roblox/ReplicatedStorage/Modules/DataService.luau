-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-10 07:28:35
-- Luau version 6, Types version 3
-- Time taken: 0.001461 seconds

local module = {
	Receiver = require(game:GetService("ReplicatedStorage").Modules.ReplicationClass).new(`{game:GetService("Players").LocalPlayer.Name}_DataServiceProfile`);
}
module.Receiver:YieldUntilData()
function module.GetPathSignal(arg1, arg2) -- Line 33
	local Receiver_2 = arg1.Receiver
	if not Receiver_2 then return end
	return Receiver_2:GetPathSignal(arg2)
end
function module.GetData(arg1) -- Line 39
	local Receiver = arg1.Receiver
	if not Receiver then
		return {}
	end
	Receiver:YieldUntilData()
	local any_YieldUntilData_result1 = Receiver:YieldUntilData(10)
	if not any_YieldUntilData_result1 then
		return {}
	end
	return any_YieldUntilData_result1.Table
end
return module
