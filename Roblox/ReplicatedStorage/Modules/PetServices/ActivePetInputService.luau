-- game:GetService("ReplicatedStorage").Modules.PetServices.ActivePetInputService
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:42:10
-- Luau version 6, Types version 3
-- Time taken: 0.008183 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local TweenService_upvr = game:GetService("TweenService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local PetActionUserInterfaceService_upvr = require(ReplicatedStorage.Modules.PetServices.PetActionUserInterfaceService)
local CurrentCamera_upvw = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line 15
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvw (read and write)
	]]
	CurrentCamera_upvw = workspace.CurrentCamera
end)
local Highlight_upvr = Instance.new("Highlight")
Highlight_upvr.FillTransparency = 1
local var8_upvw
local function TargettingInputBegan_upvr() -- Line 28, Named "TargettingInputBegan"
	--[[ Upvalues[3]:
		[1]: var8_upvw (read and write)
		[2]: TweenService_upvr (readonly)
		[3]: Highlight_upvr (readonly)
	]]
	if not var8_upvw then
	else
		TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(0.2), {
			OutlineTransparency = 0.8;
		}):Play()
	end
end
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local function TargettingInputEnded_upvr() -- Line 36, Named "TargettingInputEnded"
	--[[ Upvalues[5]:
		[1]: var8_upvw (read and write)
		[2]: TweenService_upvr (readonly)
		[3]: Highlight_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
		[5]: PetActionUserInterfaceService_upvr (readonly)
	]]
	if not var8_upvw then
	else
		TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(0.2), {
			OutlineTransparency = 0;
		}):Play()
		if LocalPlayer_upvr:GetAttribute("DontOpenAction") then return end
		if PetActionUserInterfaceService_upvr.Target == var8_upvw then
			PetActionUserInterfaceService_upvr:Toggle(false)
			return
		end
		if PetActionUserInterfaceService_upvr.Target ~= nil then
			PetActionUserInterfaceService_upvr:Toggle(false)
		end
		task.delay(0.1, function() -- Line 53
			--[[ Upvalues[2]:
				[1]: PetActionUserInterfaceService_upvr (copied, readonly)
				[2]: var8_upvw (copied, read and write)
			]]
			PetActionUserInterfaceService_upvr:SetTarget(var8_upvw)
			PetActionUserInterfaceService_upvr:Toggle(true)
		end)
	end
end
local tbl_upvr = {
	[Enum.UserInputType.Touch] = {function(arg1) -- Line 61
		--[[ Upvalues[1]:
			[1]: TargettingInputBegan_upvr (readonly)
		]]
		TargettingInputBegan_upvr()
	end};
	[Enum.UserInputType.MouseButton1] = {function() -- Line 66
		--[[ Upvalues[1]:
			[1]: TargettingInputBegan_upvr (readonly)
		]]
		TargettingInputBegan_upvr()
	end};
	[Enum.KeyCode.ButtonR2] = {function() -- Line 71
		--[[ Upvalues[1]:
			[1]: TargettingInputBegan_upvr (readonly)
		]]
		TargettingInputBegan_upvr()
	end};
}
local tbl_upvr_2 = {
	[Enum.UserInputType.Touch] = {function(arg1) -- Line 79
		--[[ Upvalues[1]:
			[1]: TargettingInputEnded_upvr (readonly)
		]]
		TargettingInputEnded_upvr()
	end};
	[Enum.UserInputType.MouseButton1] = {function() -- Line 84
		--[[ Upvalues[1]:
			[1]: TargettingInputEnded_upvr (readonly)
		]]
		TargettingInputEnded_upvr()
	end};
	[Enum.KeyCode.ButtonR2] = {function() -- Line 89
		--[[ Upvalues[1]:
			[1]: TargettingInputEnded_upvr (readonly)
		]]
		TargettingInputEnded_upvr()
	end};
}
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 95
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	local var32 = tbl_upvr[arg1.KeyCode]
	if not var32 then
		var32 = tbl_upvr[arg1.UserInputType]
	end
	if not var32 then
	else
		for _, var31_upvr in var32 do
			task.spawn(function() -- Line 99
				--[[ Upvalues[2]:
					[1]: var31_upvr (readonly)
					[2]: arg1 (readonly)
				]]
				var31_upvr(arg1)
			end)
		end
	end
end)
UserInputService_upvr.InputEnded:Connect(function(arg1, arg2) -- Line 106
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	local var39 = tbl_upvr_2[arg1.KeyCode]
	if not var39 then
		var39 = tbl_upvr_2[arg1.UserInputType]
	end
	if not var39 then
	else
		for _, var38_upvr in var39 do
			task.spawn(function() -- Line 110
				--[[ Upvalues[2]:
					[1]: var38_upvr (readonly)
					[2]: arg1 (readonly)
				]]
				var38_upvr(arg1)
			end)
		end
	end
end)
UserInputService_upvr.TouchTap:Connect(function() -- Line 116
	--[[ Upvalues[1]:
		[1]: TargettingInputBegan_upvr (readonly)
	]]
	TargettingInputBegan_upvr()
end)
UserInputService_upvr.TouchEnded:Connect(function() -- Line 120
	--[[ Upvalues[1]:
		[1]: TargettingInputEnded_upvr (readonly)
	]]
	TargettingInputEnded_upvr()
end)
Highlight_upvr.Parent = script
local var44_upvw
local GetMouseToWorld_upvr = require(ReplicatedStorage.Modules.GetMouseToWorld)
local PetInformationUserInterfaceService_upvr = require(ReplicatedStorage.Modules.PetServices.PetInformationUserInterfaceService)
task.spawn(function() -- Line 127
	--[[ Upvalues[7]:
		[1]: UserInputService_upvr (readonly)
		[2]: var44_upvw (read and write)
		[3]: GetMouseToWorld_upvr (readonly)
		[4]: PetActionUserInterfaceService_upvr (readonly)
		[5]: PetInformationUserInterfaceService_upvr (readonly)
		[6]: var8_upvw (read and write)
		[7]: Highlight_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	while true do
		local var47
		var44_upvw = UserInputService_upvr:GetMouseLocation()
		local RaycastParams_new_result1 = RaycastParams.new()
		RaycastParams_new_result1.FilterDescendantsInstances = {}
		var47 = RaycastParams_new_result1
		local var45_result1 = GetMouseToWorld_upvr(var47, 1000)
		var47 = var45_result1
		if var47 then
			var47 = var45_result1.Instance
		end
		if var47 then
			local PetMover = var47:FindFirstAncestor("PetMover")
		end
		if not PetActionUserInterfaceService_upvr.Active then
			PetInformationUserInterfaceService_upvr:SetTarget(PetMover)
			if PetMover then
				PetInformationUserInterfaceService_upvr:Toggle(true)
			else
				PetInformationUserInterfaceService_upvr:Toggle(false)
			end
		elseif PetActionUserInterfaceService_upvr.Target == PetActionUserInterfaceService_upvr.Target then
			PetInformationUserInterfaceService_upvr:Toggle(false)
		end
		if PetMover and PetMover:FindFirstChildWhichIsA("Model", true) then
			var8_upvw = PetMover
			local var51 = PetMover
			if var51 then
				var51 = PetMover:FindFirstChildWhichIsA("Model", true)
			end
			Highlight_upvr.Adornee = var51
		else
			var8_upvw = nil
			Highlight_upvr.Adornee = nil
		end
		task.wait(0.2)
	end
end)
return {}
