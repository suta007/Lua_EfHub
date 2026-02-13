-- game:GetService("Players").LocalPlayer.PlayerScripts.CancelPetAgeMachine
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:16:54
-- Luau version 6, Types version 3
-- Time taken: 0.009030 seconds

local Players = game:GetService("Players")
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character_upvw = LocalPlayer.Character
if not Character_upvw then
	Character_upvw = LocalPlayer.CharacterAdded:Wait()
end
LocalPlayer.CharacterAdded:Connect(function(arg1) -- Line 15
	--[[ Upvalues[1]:
		[1]: Character_upvw (read and write)
	]]
	Character_upvw = arg1
end)
local PetAgeLimitBreak_Cancel_upvr = ReplicatedStorage:WaitForChild("GameEvents").PetAgeLimitBreak_Cancel
local LocalPlayer_2 = Players.LocalPlayer
local PetAgeMachineCancel_upvr = LocalPlayer_2.PlayerGui:WaitForChild("PetAgeMachineCancel")
local Cancel = PetAgeMachineCancel_upvr.Frame.CancelFrame:WaitForChild("Cancel")
local TextLabel_upvr = Cancel:FindFirstChild("TextLabel")
local CancelBG_upvr = PetAgeMachineCancel_upvr.Frame.CancelFrame.CancelBG
local CancelIcon_upvr = CancelBG_upvr:FindFirstChild("CancelIcon")
if UserInputService_upvr.TouchEnabled then
	TextLabel_upvr.Text = "Cancel Machine"
	CancelIcon_upvr.Visible = false
elseif UserInputService_upvr.GamepadEnabled then
	local any_GetImageForKeyCode_result1_2 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.ButtonB)
	TextLabel_upvr.Text = "Cancel Machine"
	if any_GetImageForKeyCode_result1_2 then
		CancelIcon_upvr.Image = any_GetImageForKeyCode_result1_2
		CancelBG_upvr.Visible = true
	else
		CancelBG_upvr.Visible = false
	end
else
	TextLabel_upvr.Text = "[C] Cancel Machine"
	CancelBG_upvr.Visible = false
end
Cancel.Activated:Connect(function() -- Line 67, Named "CancelRecipe"
	--[[ Upvalues[1]:
		[1]: PetAgeLimitBreak_Cancel_upvr (readonly)
	]]
	PetAgeLimitBreak_Cancel_upvr:FireServer()
end)
UserInputService_upvr.LastInputTypeChanged:Connect(function() -- Line 40, Named "UpdateButtonLabels"
	--[[ Upvalues[4]:
		[1]: UserInputService_upvr (readonly)
		[2]: TextLabel_upvr (readonly)
		[3]: CancelIcon_upvr (readonly)
		[4]: CancelBG_upvr (readonly)
	]]
	if UserInputService_upvr.TouchEnabled then
		TextLabel_upvr.Text = "Cancel Machine"
		CancelIcon_upvr.Visible = false
	else
		if UserInputService_upvr.GamepadEnabled then
			local any_GetImageForKeyCode_result1 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.ButtonB)
			TextLabel_upvr.Text = "Cancel Machine"
			if any_GetImageForKeyCode_result1 then
				CancelIcon_upvr.Image = any_GetImageForKeyCode_result1
				CancelBG_upvr.Visible = true
			else
				CancelBG_upvr.Visible = false
			end
		end
		TextLabel_upvr.Text = "[C] Cancel Machine"
		CancelBG_upvr.Visible = false
	end
end)
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 74
	--[[ Upvalues[1]:
		[1]: PetAgeLimitBreak_Cancel_upvr (readonly)
	]]
	if arg2 then
	elseif arg1.KeyCode == Enum.KeyCode.C or arg1.KeyCode == Enum.KeyCode.ButtonB then
		PetAgeLimitBreak_Cancel_upvr:FireServer()
	end
end)
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
local CollectionService_upvr = game:GetService("CollectionService")
local PetAgeBreak_UI_upvr = LocalPlayer_2.PlayerGui:WaitForChild("PetAgeBreak_UI")
task.spawn(function() -- Line 82
	--[[ Upvalues[5]:
		[1]: DataService_upvr (readonly)
		[2]: CollectionService_upvr (readonly)
		[3]: Character_upvw (read and write)
		[4]: PetAgeMachineCancel_upvr (readonly)
		[5]: PetAgeBreak_UI_upvr (readonly)
	]]
	while true do
		task.wait(0.2)
		local any_GetData_result1 = DataService_upvr:GetData()
		if any_GetData_result1 then
			local PetAgeBreakMachine_2 = any_GetData_result1.PetAgeBreakMachine
			local var39
			if PetAgeBreakMachine_2 then
				var39 = false
				local any_GetTagged_result1, any_GetTagged_result2_2, any_GetTagged_result3 = CollectionService_upvr:GetTagged("PetAgeMachine")
				for i, v in any_GetTagged_result1, any_GetTagged_result2_2, any_GetTagged_result3 do
					local var43
					if v:IsDescendantOf(workspace) then
						var43 = v:GetPivot().Position - Character_upvw:GetPivot().Position
						if var43.Magnitude >= 12 then
							var43 = false
						else
							var43 = true
						end
						if var43 and PetAgeBreakMachine_2.SubmittedPet and not PetAgeBreakMachine_2.IsRunning and not PetAgeBreakMachine_2.PetReady then
							var39 = true
						end
					end
				end
				any_GetTagged_result2_2 = var39
				local var44 = any_GetTagged_result2_2
				if var44 then
					i = PetAgeBreak_UI_upvr
					var44 = not i.Enabled
				end
				PetAgeMachineCancel_upvr.Enabled = var44
			end
		end
	end
end)
