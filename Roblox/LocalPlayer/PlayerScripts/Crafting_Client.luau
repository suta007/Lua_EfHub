-- game:GetService("Players").LocalPlayer.PlayerScripts.Crafting_Client
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:20:30
-- Luau version 6, Types version 3
-- Time taken: 0.007803 seconds

local Players = game:GetService("Players")
local UserInputService_upvr = game:GetService("UserInputService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local Character_upvw = LocalPlayer.Character
if not Character_upvw then
	Character_upvw = LocalPlayer.CharacterAdded:Wait()
end
LocalPlayer.CharacterAdded:Connect(function(arg1) -- Line 14
	--[[ Upvalues[1]:
		[1]: Character_upvw (read and write)
	]]
	Character_upvw = arg1
end)
local CraftingStationHandler_upvr = require(ReplicatedStorage.Modules.CraftingStationHandler)
local CraftingCancel_upvr = Players.LocalPlayer.PlayerGui:WaitForChild("CraftingCancel")
local Frame = CraftingCancel_upvr:WaitForChild("Frame")
local No = Frame:WaitForChild("No")
local Yes = Frame:WaitForChild("Yes")
local Interior = No:WaitForChild("Interior")
local Interior_2 = Yes:WaitForChild("Interior")
local var14_upvw
local Label_upvr_2 = Interior:WaitForChild("Label")
local Label_upvr = Interior_2:WaitForChild("Label")
local ImageLabel_upvr_2 = Interior:WaitForChild("ImageLabel")
local ImageLabel_upvr = Interior_2:WaitForChild("ImageLabel")
local function UpdateButtonLabels() -- Line 50
	--[[ Upvalues[5]:
		[1]: UserInputService_upvr (readonly)
		[2]: Label_upvr_2 (readonly)
		[3]: Label_upvr (readonly)
		[4]: ImageLabel_upvr_2 (readonly)
		[5]: ImageLabel_upvr (readonly)
	]]
	if UserInputService_upvr.TouchEnabled then
		Label_upvr_2.Text = "Cancel Recipe"
		Label_upvr.Text = "Submit All"
		ImageLabel_upvr_2.Visible = false
		ImageLabel_upvr.Visible = false
	else
		if UserInputService_upvr.GamepadEnabled then
			local any_GetImageForKeyCode_result1 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.ButtonB)
			local any_GetImageForKeyCode_result1_2 = UserInputService_upvr:GetImageForKeyCode(Enum.KeyCode.ButtonY)
			Label_upvr_2.Text = "Cancel Recipe"
			Label_upvr.Text = "Submit All"
			if any_GetImageForKeyCode_result1 then
				ImageLabel_upvr_2.Image = any_GetImageForKeyCode_result1
				ImageLabel_upvr_2.Visible = true
			else
				ImageLabel_upvr_2.Visible = false
			end
			if any_GetImageForKeyCode_result1_2 then
				ImageLabel_upvr.Image = any_GetImageForKeyCode_result1_2
				ImageLabel_upvr.Visible = true
			else
				ImageLabel_upvr.Visible = false
			end
		end
		Label_upvr_2.Text = "[C] Cancel Recipe"
		Label_upvr.Text = "[F] Submit All"
		ImageLabel_upvr_2.Visible = false
		ImageLabel_upvr.Visible = false
	end
end
UpdateButtonLabels()
local var21_upvw = false
No.Activated:Connect(function() -- Line 90, Named "CancelRecipe"
	--[[ Upvalues[2]:
		[1]: var14_upvw (read and write)
		[2]: CraftingStationHandler_upvr (readonly)
	]]
	if not var14_upvw then
	else
		CraftingStationHandler_upvr:CancelRecipe(var14_upvw)
	end
end)
Yes.Activated:Connect(function() -- Line 99, Named "SubmitAllItems"
	--[[ Upvalues[3]:
		[1]: var14_upvw (read and write)
		[2]: var21_upvw (read and write)
		[3]: CraftingStationHandler_upvr (readonly)
	]]
	if not var14_upvw then
	else
		if var21_upvw then return end
		var21_upvw = true
		task.delay(0.3, function() -- Line 110
			--[[ Upvalues[1]:
				[1]: var21_upvw (copied, read and write)
			]]
			var21_upvw = false
		end)
		CraftingStationHandler_upvr:SubmitAllRequiredItems(var14_upvw)
	end
end)
UserInputService_upvr.LastInputTypeChanged:Connect(UpdateButtonLabels)
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 121
	--[[ Upvalues[3]:
		[1]: var14_upvw (read and write)
		[2]: CraftingStationHandler_upvr (readonly)
		[3]: var21_upvw (read and write)
	]]
	if arg2 then
	else
		if arg1.KeyCode == Enum.KeyCode.C or arg1.KeyCode == Enum.KeyCode.ButtonB then
			if not var14_upvw then
			else
				CraftingStationHandler_upvr:CancelRecipe(var14_upvw)
			end
		end
		if arg1.KeyCode == Enum.KeyCode.F or arg1.KeyCode == Enum.KeyCode.ButtonY then
			if not var14_upvw then return end
			if var21_upvw then return end
			var21_upvw = true
			task.delay(0.3, function() -- Line 110
				--[[ Upvalues[1]:
					[1]: var21_upvw (copied, read and write)
				]]
				var21_upvw = false
			end)
			CraftingStationHandler_upvr:SubmitAllRequiredItems(var14_upvw)
		end
	end
end)
local function GetMachineId_upvr(arg1) -- Line 147, Named "GetMachineId"
	return arg1:GetAttribute("CraftingObjectType")
end
local CollectionService_upvr = game:GetService("CollectionService")
local CraftingGlobalObjectService_upvr = require(ReplicatedStorage.Modules.CraftingService.CraftingGlobalObjectService)
task.spawn(function() -- Line 151
	--[[ Upvalues[6]:
		[1]: CollectionService_upvr (readonly)
		[2]: Character_upvw (read and write)
		[3]: CraftingGlobalObjectService_upvr (readonly)
		[4]: GetMachineId_upvr (readonly)
		[5]: CraftingCancel_upvr (readonly)
		[6]: var14_upvw (read and write)
	]]
	while true do
		local var42
		var42(0.2)
		var42 = nil
		for _, v in CollectionService_upvr:GetTagged("CraftingObject") do
			if v:IsDescendantOf(workspace) then
				local var46 = v:GetPivot().Position - Character_upvw:GetPivot().Position
				if var46.Magnitude >= 8 then
					var46 = false
				else
					var46 = true
				end
				if var46 then
					local any_GetIndividualCraftingMachineData_result1 = CraftingGlobalObjectService_upvr:GetIndividualCraftingMachineData(v, GetMachineId_upvr(v))
					if any_GetIndividualCraftingMachineData_result1 and any_GetIndividualCraftingMachineData_result1.RecipeId ~= nil then
						var42 = v
					end
				end
			end
		end
		CraftingCancel_upvr.Enabled = var42
		var14_upvw = var42
	end
end)
