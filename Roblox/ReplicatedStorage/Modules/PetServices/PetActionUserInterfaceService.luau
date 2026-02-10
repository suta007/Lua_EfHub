-- game:GetService("ReplicatedStorage").Modules.PetServices.PetActionUserInterfaceService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:45:20
-- Luau version 6, Types version 3
-- Time taken: 0.017204 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local UserInputService_upvr = game:GetService("UserInputService")
local CurrentCamera_upvw = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line 12
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvw (read and write)
	]]
	CurrentCamera_upvw = workspace.CurrentCamera
end)
local Modules = ReplicatedStorage.Modules
local WaitForDescendant = require(Modules.WaitForDescendant)
local ActivePetsService_upvr = require(Modules:WaitForChild("PetServices").ActivePetsService)
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry)
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local PlayerGui_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui")
local PetActionUI_upvr = PlayerGui_upvr:WaitForChild("PetUI"):WaitForChild("PetActionUI")
local WaitForDescendant_result1_upvr = WaitForDescendant(PetActionUI_upvr, "CLOSE_BUTTON")
local var6_result1_upvr = WaitForDescendant(PetActionUI_upvr, "OPTION_HOLDER")
local module_upvr = {
	Active = false;
	Target = nil;
	LastStateBeforeInspection = nil;
}
local CollectionService_upvr = game:GetService("CollectionService")
local GuiService_upvr = game:GetService("GuiService")
local function CheckIfHoveringButton_upvr() -- Line 58, Named "CheckIfHoveringButton"
	--[[ Upvalues[4]:
		[1]: CollectionService_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
		[3]: GuiService_upvr (readonly)
		[4]: PlayerGui_upvr (readonly)
	]]
	local var19 = UserInputService_upvr:GetMouseLocation() - GuiService_upvr:GetGuiInset()
	for _, v in CollectionService_upvr:GetTagged("PetActionButton"), nil do
		if v:IsDescendantOf(PlayerGui_upvr) and table.find(PlayerGui_upvr:GetGuiObjectsAtPosition(var19.X, var19.Y), v) then
			return true
		end
	end
	return false
end
local PetActionTemplates_upvr = script:WaitForChild("PetActionTemplates")
local PetActionsHandlers_upvr = script:WaitForChild("PetActionsHandlers")
local SetupHoverAnimations_upvr = require(ReplicatedStorage.Modules.SetupHoverAnimations)
local SetupBrightnessAnimationImage_upvr = require(ReplicatedStorage.Modules.SetupBrightnessAnimationImage)
local Frame_Popup_Module_upvr = require(game.ReplicatedStorage.Frame_Popup_Module)
local ConfirmPetEggPurchase_upvr = PlayerGui_upvr:WaitForChild("ConfirmPetEggPurchase")
local PlayClickSound_upvr = require(ReplicatedStorage.Modules.PlayClickSound)
local PlayHoverSound_upvr = require(ReplicatedStorage.Modules.PlayHoverSound)
local function SetupAction_upvr(arg1) -- Line 81, Named "SetupAction"
	--[[ Upvalues[11]:
		[1]: PetActionTemplates_upvr (readonly)
		[2]: PetActionsHandlers_upvr (readonly)
		[3]: module_upvr (readonly)
		[4]: var6_result1_upvr (readonly)
		[5]: SetupHoverAnimations_upvr (readonly)
		[6]: SetupBrightnessAnimationImage_upvr (readonly)
		[7]: Frame_Popup_Module_upvr (readonly)
		[8]: ConfirmPetEggPurchase_upvr (readonly)
		[9]: LocalPlayer_upvr (readonly)
		[10]: PlayClickSound_upvr (readonly)
		[11]: PlayHoverSound_upvr (readonly)
	]]
	local SOME = PetActionsHandlers_upvr:FindFirstChild(arg1)
	if not SOME then
		return warn("No handler for", arg1)
	end
	local SOME_2_upvr = require(SOME)
	local Verifier = SOME_2_upvr.Verifier
	if Verifier and not Verifier(module_upvr.Target) then
	else
		local clone = PetActionTemplates_upvr:FindFirstChild(arg1):Clone()
		clone.Parent = var6_result1_upvr
		local Inner = clone:FindFirstChild("Inner")
		local SetupHoverAnimations_upvr_result1 = SetupHoverAnimations_upvr(Inner)
		SetupBrightnessAnimationImage_upvr(Inner)
		SetupHoverAnimations_upvr_result1.ZIndex = 1000
		local function ButtonPressed_upvr() -- Line 101, Named "ButtonPressed"
			--[[ Upvalues[6]:
				[1]: SOME_2_upvr (readonly)
				[2]: module_upvr (copied, readonly)
				[3]: Frame_Popup_Module_upvr (copied, readonly)
				[4]: ConfirmPetEggPurchase_upvr (copied, readonly)
				[5]: LocalPlayer_upvr (copied, readonly)
				[6]: PlayClickSound_upvr (copied, readonly)
			]]
			local Activate = SOME_2_upvr.Activate
			if Activate then
				Activate(module_upvr.Target)
			end
			Frame_Popup_Module_upvr.Hide(ConfirmPetEggPurchase_upvr)
			module_upvr:Toggle(false)
			LocalPlayer_upvr:SetAttribute("DontOpenAction", true)
			task.delay(0.3, function() -- Line 113
				--[[ Upvalues[1]:
					[1]: LocalPlayer_upvr (copied, readonly)
				]]
				LocalPlayer_upvr:SetAttribute("DontOpenAction", false)
			end)
			PlayClickSound_upvr()
		end
		SetupHoverAnimations_upvr_result1.MouseButton1Down:Connect(ButtonPressed_upvr)
		SetupHoverAnimations_upvr_result1.InputBegan:Connect(function(arg1_2) -- Line 121
			--[[ Upvalues[1]:
				[1]: ButtonPressed_upvr (readonly)
			]]
			if arg1_2.UserInputState == Enum.UserInputState.Begin and arg1_2.KeyCode == Enum.KeyCode.ButtonR2 then
				ButtonPressed_upvr()
			end
		end)
		SetupHoverAnimations_upvr_result1.MouseEnter:Connect(function() -- Line 126
			--[[ Upvalues[1]:
				[1]: PlayHoverSound_upvr (copied, readonly)
			]]
			PlayHoverSound_upvr()
		end)
	end
end
local var38_upvw
local PetList_upvr = PetRegistry.PetList
local DefaultPetActions_upvr = PetRegistry.DefaultPetActions
local module_upvr_2 = require(script:WaitForChild("ScriptModules"):WaitForChild("Radialize"))
function module_upvr.SetTarget(arg1, arg2) -- Line 131
	--[[ Upvalues[8]:
		[1]: var38_upvw (read and write)
		[2]: module_upvr (readonly)
		[3]: var6_result1_upvr (readonly)
		[4]: ActivePetsService_upvr (readonly)
		[5]: PetList_upvr (readonly)
		[6]: SetupAction_upvr (readonly)
		[7]: DefaultPetActions_upvr (readonly)
		[8]: module_upvr_2 (readonly)
	]]
	var38_upvw = nil
	if module_upvr.Target == arg2 then
	else
		module_upvr.Target = arg2
		if not arg2 then return end
		for _, v_2 in var6_result1_upvr:GetChildren() do
			if v_2:HasTag("PetActionButton") then
				v_2:Destroy()
			end
		end
		local any_GetPetDataFromPetObject_result1 = ActivePetsService_upvr:GetPetDataFromPetObject(arg2)
		if not any_GetPetDataFromPetObject_result1 then return end
		for _, v_3 in PetList_upvr[any_GetPetDataFromPetObject_result1.PetType].Actions do
			SetupAction_upvr(v_3)
		end
		for _, v_4 in DefaultPetActions_upvr do
			SetupAction_upvr(v_4)
		end
		module_upvr_2(var6_result1_upvr)
	end
end
local TweenService_upvr = game:GetService("TweenService")
local UIScale_upvr = PetActionUI_upvr:WaitForChild("UIScale")
local PetStatesRegistry_upvr = PetRegistry.PetStatesRegistry
local var55_upvw
function module_upvr.Toggle(arg1, arg2) -- Line 167
	--[[ Upvalues[8]:
		[1]: module_upvr (readonly)
		[2]: TweenService_upvr (readonly)
		[3]: UIScale_upvr (readonly)
		[4]: ActivePetsService_upvr (readonly)
		[5]: PetStatesRegistry_upvr (readonly)
		[6]: var55_upvw (read and write)
		[7]: WaitForDescendant_result1_upvr (readonly)
		[8]: UserInputService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 25 start (CF ANALYSIS FAILED)
	local var61
	if module_upvr.Active == arg2 then
	else
		module_upvr.Active = arg2
		local TweenInfo_new_result1 = TweenInfo.new(0.1)
		local tbl_2 = {}
		if arg2 then
			var61 = 1
		else
			var61 = 0
		end
		tbl_2.Scale = var61
		TweenService_upvr:Create(UIScale_upvr, TweenInfo_new_result1, tbl_2):Play()
		local var64 = module_upvr
		-- KONSTANTERROR: [0] 1. Error Block 25 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [41] 32. Error Block 9 start (CF ANALYSIS FAILED)
		var61 = PetStatesRegistry_upvr[ActivePetsService_upvr:GetServerState(TweenInfo_new_result1, var64).CurrentState]
		module_upvr.LastStateBeforeInspection = var61
		var55_upvw = tick()
		game.Workspace:SetAttribute("LastMenu", var55_upvw)
		game:GetService("GamepadService"):EnableGamepadCursor(WaitForDescendant_result1_upvr)
		-- KONSTANTERROR: [41] 32. Error Block 9 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [81] 61. Error Block 10 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [81] 61. Error Block 10 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [107] 79. Error Block 22 start (CF ANALYSIS FAILED)
		if not arg2 then
			var61 = nil
			module_upvr.Target = var61
			var61 = module_upvr
			if var61.LastStateBeforeInspection then
				var61 = game.Workspace:GetAttribute("LastMenu")
				if var61 == var55_upvw then
					var61 = game:GetService("GamepadService"):DisableGamepadCursor
					var61()
				end
				var61 = task.spawn
				var61(function() -- Line 214
					game:GetService("RunService"):UnbindFromRenderStep("LockOn")
				end)
			end
		end
		-- KONSTANTERROR: [107] 79. Error Block 22 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [140] 102. Error Block 17 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [140] 102. Error Block 17 end (CF ANALYSIS FAILED)
	end
end
local function _(arg1) -- Line 222, Named "GetWorldToPosition"
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvw (read and write)
	]]
	if not arg1 then return end
	local any_WorldToScreenPoint_result1, any_WorldToScreenPoint_result2 = CurrentCamera_upvw:WorldToScreenPoint(arg1)
	return UDim2.fromOffset(any_WorldToScreenPoint_result1.X, any_WorldToScreenPoint_result1.Y), any_WorldToScreenPoint_result2
end
game:GetService("RunService").RenderStepped:Connect(function() -- Line 229
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: CurrentCamera_upvw (read and write)
		[3]: PetActionUI_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var69
	if not module_upvr.Active then
	else
		var69 = module_upvr
		if not var69.Target then
			module_upvr:Toggle(false)
			return
		end
		local var70 = module_upvr.Target.Position + Vector3.new(0, 2.5 + module_upvr.Target.Size.Y / 2, 0)
		if not var70 then
			var69 = nil
		else
			local any_WorldToScreenPoint_result1_2, any_WorldToScreenPoint_result2_2 = CurrentCamera_upvw:WorldToScreenPoint(var70)
			var69 = any_WorldToScreenPoint_result2_2
		end
		if not var69 or not UDim2.fromOffset(any_WorldToScreenPoint_result1_2.X, any_WorldToScreenPoint_result1_2.Y) then
		end
		PetActionUI_upvr.Position = UDim2.fromScale(2, 2)
	end
end)
WaitForDescendant_result1_upvr.SENSOR.MouseButton1Down:Connect(function() -- Line 239
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	module_upvr:Toggle(false)
	LocalPlayer_upvr:SetAttribute("DontOpenAction", true)
	task.delay(0.3, function() -- Line 245
		--[[ Upvalues[1]:
			[1]: LocalPlayer_upvr (copied, readonly)
		]]
		LocalPlayer_upvr:SetAttribute("DontOpenAction", false)
	end)
end)
function module_upvr.Close() -- Line 250
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
	]]
	module_upvr:Toggle(false)
	LocalPlayer_upvr:SetAttribute("DontOpenAction", true)
	task.delay(0.3, function() -- Line 254
		--[[ Upvalues[1]:
			[1]: LocalPlayer_upvr (copied, readonly)
		]]
		LocalPlayer_upvr:SetAttribute("DontOpenAction", false)
	end)
end
local function DisableIfNoHover_upvr() -- Line 259, Named "DisableIfNoHover"
	--[[ Upvalues[3]:
		[1]: CheckIfHoveringButton_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
	]]
	if CheckIfHoveringButton_upvr() then
	else
		module_upvr:Toggle(false)
		LocalPlayer_upvr:SetAttribute("DontOpenAction", true)
		task.delay(0.3, function() -- Line 265
			--[[ Upvalues[1]:
				[1]: LocalPlayer_upvr (copied, readonly)
			]]
			LocalPlayer_upvr:SetAttribute("DontOpenAction", false)
		end)
	end
end
local tbl_3_upvr = {
	[Enum.UserInputType.MouseButton1] = {
		Activate = function() -- Line 272
		end;
	};
}
local tbl_4_upvr = {
	[Enum.UserInputType.MouseButton1] = {
		Deactivate = function() -- Line 280
			--[[ Upvalues[1]:
				[1]: DisableIfNoHover_upvr (readonly)
			]]
			DisableIfNoHover_upvr()
		end;
	};
}
UserInputService_upvr.InputBegan:Connect(function(arg1, arg2) -- Line 286
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	if arg2 then
	else
		local var88 = tbl_3_upvr[arg1.KeyCode]
		if not var88 then
			var88 = tbl_3_upvr[arg1.UserInputType]
		end
		if not var88 then return end
		for _, v_5 in var88 do
			task.spawn(v_5)
		end
	end
end)
UserInputService_upvr.InputEnded:Connect(function(arg1, arg2) -- Line 297
	--[[ Upvalues[1]:
		[1]: tbl_4_upvr (readonly)
	]]
	if arg2 then
	else
		local var94 = tbl_4_upvr[arg1.KeyCode]
		if not var94 then
			var94 = tbl_4_upvr[arg1.UserInputType]
		end
		if not var94 then return end
		for _, v_6 in var94 do
			task.spawn(v_6)
		end
	end
end)
UserInputService_upvr.TouchTap:Connect(function() -- Line 307
	--[[ Upvalues[1]:
		[1]: DisableIfNoHover_upvr (readonly)
	]]
	DisableIfNoHover_upvr()
end)
return module_upvr
