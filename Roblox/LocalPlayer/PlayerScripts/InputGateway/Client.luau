--game:GetService("Players").LocalPlayer.PlayerScripts.InputGateway.Client

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:12:00
-- Luau version 6, Types version 3
-- Time taken: 0.001972 seconds

local UserInputService = game:GetService("UserInputService")
local Activation_upvr = script.Parent:WaitForChild("Activation")
local mouse_upvr = game:GetService("Players").LocalPlayer:GetMouse()
local var5_upvw = false
local function _(arg1, arg2) -- Line 16, Named "activate"
	--[[ Upvalues[2]:
		[1]: var5_upvw (read and write)
		[2]: Activation_upvr (readonly)
	]]
	var5_upvw = arg1
	Activation_upvr:FireServer(arg1, arg2)
end
UserInputService.InputBegan:Connect(function(arg1, arg2) -- Line 21, Named "onInputBegan"
	--[[ Upvalues[3]:
		[1]: mouse_upvr (readonly)
		[2]: var5_upvw (read and write)
		[3]: Activation_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [1] 2. Error Block 17 start (CF ANALYSIS FAILED)
	if arg1.UserInputType.Name == "MouseButton1" then
		-- KONSTANTWARNING: GOTO [33] #22
	end
	-- KONSTANTERROR: [1] 2. Error Block 17 end (CF ANALYSIS FAILED)
end)
UserInputService.InputEnded:Connect(function(arg1, arg2) -- Line 46, Named "onInputEnded"
	--[[ Upvalues[3]:
		[1]: var5_upvw (read and write)
		[2]: mouse_upvr (readonly)
		[3]: Activation_upvr (readonly)
	]]
	local function INLINED() -- Internal function, doesn't exist in bytecode
		local Name = arg1.UserInputType.Name
		return Name == "MouseButton1"
	end
	if not arg2 and var5_upvw and (INLINED() or Name == "Touch" or Name == "Gamepad1") then
		var5_upvw = false
		Activation_upvr:FireServer(false, mouse_upvr.Hit)
	end
end)
