-- game:GetService("ReplicatedStorage").Modules.PetAgeBreakMachineController

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 22:30:00
-- Luau version 6, Types version 3
-- Time taken: 0.021603 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local DataService_upvr = require(ReplicatedStorage_upvr.Modules.DataService)
local TimeHelper_upvr = require(ReplicatedStorage_upvr.Modules.TimeHelper)
local SoundData_upvr = require(ReplicatedStorage_upvr.Data.SoundData)
local SoundPlayer_upvr = require(ReplicatedStorage_upvr.Modules.SoundPlayer)
local PetList_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry).PetList
local GameEvents = ReplicatedStorage_upvr:WaitForChild("GameEvents")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local var10_upvw
local _1_upvr = game:GetService("CollectionService"):GetTagged("PetAgeMachine")[1]
local TimerTextLabel_upvr = _1_upvr:FindFirstChild("TimerTextLabel", true)
local PetAgeMachineProximityPrompt_upvr = _1_upvr:FindFirstChild("PetAgeMachineProximityPrompt", true)
local function GetMachineData_upvr() -- Line 65, Named "GetMachineData"
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: DataService_upvr (readonly)
	]]
	if not LocalPlayer_upvr then
		return warn("No LocalPlayer!")
	end
	local any_GetData_result1 = DataService_upvr:GetData()
	if not any_GetData_result1 then
		return warn(`No PlayerData for {LocalPlayer_upvr}!`)
	end
	local PetAgeBreakMachine = any_GetData_result1.PetAgeBreakMachine
	if not PetAgeBreakMachine then
		return warn(`No PetAgeBreakMachine data for {LocalPlayer_upvr.Name}!`)
	end
	return PetAgeBreakMachine
end
local function _(arg1) -- Line 78, Named "ToggleMachineVisiblity"
	--[[ Upvalues[1]:
		[1]: _1_upvr (readonly)
	]]
	if arg1 then
		_1_upvr.Parent = workspace
	else
		_1_upvr.Parent = script
	end
end
local SelectiveAssetReplication_upvr = require(ReplicatedStorage_upvr.Modules.SelectiveAssetReplication)
local PetModelLocation_upvr = _1_upvr:FindFirstChild("PetModelLocation", true)
local function UpdateModel_upvr() -- Line 87, Named "UpdateModel"
	--[[ Upvalues[5]:
		[1]: GetMachineData_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: SelectiveAssetReplication_upvr (readonly)
		[4]: PetList_upvr (readonly)
		[5]: PetModelLocation_upvr (readonly)
	]]
	local GetMachineData_upvr_result1_10 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_10 then
	else
		if not GetMachineData_upvr_result1_10.SubmittedPet then
			if var10_upvw then
				var10_upvw:Destroy()
				var10_upvw = nil
			end
			return
		end
		local clone_2 = SelectiveAssetReplication_upvr:GetAssetAsync("PetAssets", GetMachineData_upvr_result1_10.SubmittedPet.PetType):Clone()
		clone_2:SetPrimaryPartCFrame(CFrame.new(clone_2:GetPrimaryPartCFrame().Position) * PetList_upvr[GetMachineData_upvr_result1_10.SubmittedPet.PetType].WeldOffset)
		var10_upvw = clone_2
		if not var10_upvw then return end
		if not var10_upvw.PrimaryPart or not PetModelLocation_upvr.PrimaryPart then
			warn("Both models need a PrimaryPart set.")
			return
		end
		local any_GetExtentsSize_result1 = var10_upvw:GetExtentsSize()
		local any_GetExtentsSize_result1_2 = PetModelLocation_upvr:GetExtentsSize()
		for _, v in var10_upvw:GetDescendants() do
			if v:IsA("BasePart") then
				v.Anchored = true
			end
		end
		var10_upvw:ScaleTo(math.min(any_GetExtentsSize_result1_2.X / any_GetExtentsSize_result1.X, any_GetExtentsSize_result1_2.Y / any_GetExtentsSize_result1.Y, any_GetExtentsSize_result1_2.Z / any_GetExtentsSize_result1.Z))
		var10_upvw:PivotTo(CFrame.new(PetModelLocation_upvr:GetPivot().Position) * var10_upvw:GetPivot().Rotation)
		var10_upvw.Parent = PetModelLocation_upvr
	end
end
local function _() -- Line 144, Named "UpdateTimer"
	--[[ Upvalues[3]:
		[1]: GetMachineData_upvr (readonly)
		[2]: TimeHelper_upvr (readonly)
		[3]: TimerTextLabel_upvr (readonly)
	]]
	local GetMachineData_upvr_result1_5 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_5 then
	else
		if 0 < GetMachineData_upvr_result1_5.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_upvr_result1_5.TimeLeft)}`
			return
		end
		if GetMachineData_upvr_result1_5.PetReady then
			TimerTextLabel_upvr.Text = "READY"
			return
		end
		TimerTextLabel_upvr.Text = ""
	end
end
local var28_upvw = 0
local function _(arg1) -- Line 166, Named "AnimatePet"
	--[[ Upvalues[1]:
		[1]: var28_upvw (read and write)
	]]
	arg1:PivotTo((arg1:GetPivot() + Vector3.new(0, math.sin(var28_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
end
local function _() -- Line 177, Named "UpdatePrompt"
	--[[ Upvalues[2]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
	]]
	local GetMachineData_upvr_result1_4 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_4 then
	else
		PetAgeMachineProximityPrompt_upvr.Enabled = true
		if GetMachineData_upvr_result1_4.IsRunning or 0 < GetMachineData_upvr_result1_4.TimeLeft then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
			return
		end
		if GetMachineData_upvr_result1_4.PetReady then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Claim Pet"
			return
		end
		if GetMachineData_upvr_result1_4.SubmittedPet and not GetMachineData_upvr_result1_4.IsRunning then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Select Dupes"
			return
		end
		if not GetMachineData_upvr_result1_4.SubmittedPet then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Submit Pet"
		end
	end
end
task.spawn(function() -- Line 200
	--[[ Upvalues[2]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
	]]
	local GetMachineData_upvr_result1_7 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_7 then
	else
		PetAgeMachineProximityPrompt_upvr.Enabled = true
		if GetMachineData_upvr_result1_7.IsRunning or 0 < GetMachineData_upvr_result1_7.TimeLeft then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
			return
		end
		if GetMachineData_upvr_result1_7.PetReady then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Claim Pet"
			return
		end
		if GetMachineData_upvr_result1_7.SubmittedPet and not GetMachineData_upvr_result1_7.IsRunning then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Select Dupes"
			return
		end
		if not GetMachineData_upvr_result1_7.SubmittedPet then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Submit Pet"
		end
	end
end)
local function _(arg1, arg2, arg3, arg4) -- Line 205, Named "quadraticBezier"
	return (1 - arg1) ^ 2 * arg2 + (1 - arg1) * 2 * arg1 * arg3 + arg1 ^ 2 * arg4
end
local TweenService_upvr = game:GetService("TweenService")
local var74_upvw = false
local PetAgeLimitBreak_Skip_upvr = GameEvents.PetAgeLimitBreak_Skip
local PetAgeLimitBreak_Claim_upvr = GameEvents.PetAgeLimitBreak_Claim
local PetAgeBreakUIController_upvr = require(ReplicatedStorage_upvr.Modules.PetAgeBreakUIController)
local InventoryServiceEnums_upvr = require(ReplicatedStorage_upvr.Data.EnumRegistry.InventoryServiceEnums)
local ItemTypeEnums_upvr = require(ReplicatedStorage_upvr.Data.EnumRegistry.ItemTypeEnums)
local PetAgeLimitBreak_SubmitHeld_upvr = GameEvents.PetAgeLimitBreak_SubmitHeld
PetAgeMachineProximityPrompt_upvr.Triggered:Connect(function() -- Line 361
	--[[ Upvalues[9]:
		[1]: var74_upvw (read and write)
		[2]: GetMachineData_upvr (readonly)
		[3]: PetAgeLimitBreak_Skip_upvr (readonly)
		[4]: PetAgeLimitBreak_Claim_upvr (readonly)
		[5]: PetAgeBreakUIController_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: InventoryServiceEnums_upvr (readonly)
		[8]: ItemTypeEnums_upvr (readonly)
		[9]: PetAgeLimitBreak_SubmitHeld_upvr (readonly)
	]]
	if var74_upvw then
	else
		var74_upvw = true
		task.delay(0.5, function() -- Line 367
			--[[ Upvalues[1]:
				[1]: var74_upvw (copied, read and write)
			]]
			var74_upvw = false
		end)
		local GetMachineData_upvr_result1_6 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1_6 then return end
		if GetMachineData_upvr_result1_6.IsRunning or 0 < GetMachineData_upvr_result1_6.TimeLeft then
			PetAgeLimitBreak_Skip_upvr:FireServer()
		end
		if GetMachineData_upvr_result1_6.PetReady then
			PetAgeLimitBreak_Claim_upvr:FireServer()
			return
		end
		if GetMachineData_upvr_result1_6.SubmittedPet and not GetMachineData_upvr_result1_6.IsRunning then
			PetAgeBreakUIController_upvr:Open()
			return
		end
		if not GetMachineData_upvr_result1_6.SubmittedPet then
			local Character_2 = LocalPlayer_upvr.Character
			if not Character_2 then return end
			local class_Tool = Character_2:FindFirstChildWhichIsA("Tool")
			if not class_Tool then return end
			if class_Tool:GetAttribute(InventoryServiceEnums_upvr.ITEM_TYPE) ~= ItemTypeEnums_upvr.Pet then return end
			PetAgeLimitBreak_SubmitHeld_upvr:FireServer()
		end
	end
end)
local function CheckMachineVisibility_upvr() -- Line 401, Named "CheckMachineVisibility"
	--[[ Upvalues[1]:
		[1]: DataService_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [28] 21. Error Block 6 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [28] 21. Error Block 6 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [15] 12. Error Block 2 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [28.7]
	-- KONSTANTERROR: [15] 12. Error Block 2 end (CF ANALYSIS FAILED)
end
local GuiController_upvr = require(ReplicatedStorage_upvr.Modules.GuiController)
local PetAgeBreak_UI_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("PetAgeBreak_UI")
PetAgeMachineProximityPrompt_upvr.PromptHidden:Connect(function() -- Line 428
	--[[ Upvalues[2]:
		[1]: GuiController_upvr (readonly)
		[2]: PetAgeBreak_UI_upvr (readonly)
	]]
	GuiController_upvr:Close(PetAgeBreak_UI_upvr)
end)
local var89_upvw
DataService_upvr:GetPathSignal("PetAgeBreakMachine/IsRunning"):Connect(function() -- Line 432
	--[[ Upvalues[8]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: SoundPlayer_upvr (readonly)
		[6]: SoundData_upvr (readonly)
		[7]: _1_upvr (readonly)
		[8]: var89_upvw (read and write)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 57 start (CF ANALYSIS FAILED)
	if not GetMachineData_upvr() then return end
	local GetMachineData_upvr_result1_3 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_3 then
		-- KONSTANTWARNING: GOTO [51] #40
	end
	-- KONSTANTERROR: [0] 1. Error Block 57 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [8] 9. Error Block 58 start (CF ANALYSIS FAILED)
	PetAgeMachineProximityPrompt_upvr.Enabled = true
	if GetMachineData_upvr_result1_3.IsRunning or 0 < GetMachineData_upvr_result1_3.TimeLeft then
		PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
	elseif GetMachineData_upvr_result1_3.PetReady then
		PetAgeMachineProximityPrompt_upvr.ActionText = "Claim Pet"
	elseif GetMachineData_upvr_result1_3.SubmittedPet and not GetMachineData_upvr_result1_3.IsRunning then
		PetAgeMachineProximityPrompt_upvr.ActionText = "Select Dupes"
	elseif not GetMachineData_upvr_result1_3.SubmittedPet then
		PetAgeMachineProximityPrompt_upvr.ActionText = "Submit Pet"
	end
	if not GetMachineData_upvr() then
		-- KONSTANTWARNING: GOTO [90] #70
	end
	-- KONSTANTERROR: [8] 9. Error Block 58 end (CF ANALYSIS FAILED)
end)
DataService_upvr:GetPathSignal("PetAgeBreakMachine/SubmittedPet"):Connect(function() -- Line 456
	--[[ Upvalues[7]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: UpdateModel_upvr (readonly)
		[6]: SoundPlayer_upvr (readonly)
		[7]: SoundData_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 53 start (CF ANALYSIS FAILED)
	if not GetMachineData_upvr() then return end
	local GetMachineData_upvr_result1_9 = GetMachineData_upvr()
	if not GetMachineData_upvr_result1_9 then
		-- KONSTANTWARNING: GOTO [51] #40
	end
	-- KONSTANTERROR: [0] 1. Error Block 53 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [8] 9. Error Block 50 start (CF ANALYSIS FAILED)
	PetAgeMachineProximityPrompt_upvr.Enabled = true
	if GetMachineData_upvr_result1_9.IsRunning or 0 < GetMachineData_upvr_result1_9.TimeLeft then
		PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
		-- KONSTANTWARNING: GOTO [51] #40
	end
	-- KONSTANTERROR: [8] 9. Error Block 50 end (CF ANALYSIS FAILED)
end)
RunService_upvr.RenderStepped:Connect(function(arg1) -- Line 469
	--[[ Upvalues[2]:
		[1]: var10_upvw (read and write)
		[2]: var28_upvw (read and write)
	]]
	if not var10_upvw then
	elseif var10_upvw.PrimaryPart then
		var28_upvw += arg1
		local var94 = var10_upvw
		var94:PivotTo((var94:GetPivot() + Vector3.new(0, math.sin(var28_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
	end
end)
task.spawn(function() -- Line 480
	--[[ Upvalues[4]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
	]]
	while true do
		task.wait(0.5)
		local GetMachineData_upvr_result1_8 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1_8 then
		else
			PetAgeMachineProximityPrompt_upvr.Enabled = true
			if GetMachineData_upvr_result1_8.IsRunning or 0 < GetMachineData_upvr_result1_8.TimeLeft then
				PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
			elseif GetMachineData_upvr_result1_8.PetReady then
				PetAgeMachineProximityPrompt_upvr.ActionText = "Claim Pet"
			elseif GetMachineData_upvr_result1_8.SubmittedPet and not GetMachineData_upvr_result1_8.IsRunning then
				PetAgeMachineProximityPrompt_upvr.ActionText = "Select Dupes"
			elseif not GetMachineData_upvr_result1_8.SubmittedPet then
				PetAgeMachineProximityPrompt_upvr.ActionText = "Submit Pet"
			end
		end
		local GetMachineData_upvr_result1_2 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1_2 then
		elseif 0 < GetMachineData_upvr_result1_2.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_upvr_result1_2.TimeLeft)}`
		elseif GetMachineData_upvr_result1_2.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
	end
end)
task.spawn(function() -- Line 489
	--[[ Upvalues[5]:
		[1]: GetMachineData_upvr (readonly)
		[2]: PetAgeMachineProximityPrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: UpdateModel_upvr (readonly)
	]]
	-- KONSTANTERROR: [0] 1. Error Block 49 start (CF ANALYSIS FAILED)
	if not GetMachineData_upvr() then
	else
		local GetMachineData_upvr_result1 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1 then
			-- KONSTANTWARNING: GOTO [51] #40
		end
		-- KONSTANTERROR: [0] 1. Error Block 49 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [8] 9. Error Block 50 start (CF ANALYSIS FAILED)
		PetAgeMachineProximityPrompt_upvr.Enabled = true
		if GetMachineData_upvr_result1.IsRunning or 0 < GetMachineData_upvr_result1.TimeLeft then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Skip"
		elseif GetMachineData_upvr_result1.PetReady then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Claim Pet"
		elseif GetMachineData_upvr_result1.SubmittedPet and not GetMachineData_upvr_result1.IsRunning then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Select Dupes"
		elseif not GetMachineData_upvr_result1.SubmittedPet then
			PetAgeMachineProximityPrompt_upvr.ActionText = "Submit Pet"
		end
		local GetMachineData_result1 = GetMachineData_upvr()
		if not GetMachineData_result1 then
		elseif 0 < GetMachineData_result1.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_result1.TimeLeft)}`
		elseif GetMachineData_result1.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
		UpdateModel_upvr()
		-- KONSTANTERROR: [8] 9. Error Block 50 end (CF ANALYSIS FAILED)
	end
end)
task.spawn(function() -- Line 499
	--[[ Upvalues[2]:
		[1]: _1_upvr (readonly)
		[2]: CheckMachineVisibility_upvr (readonly)
	]]
	_1_upvr.Parent = script
	while not CheckMachineVisibility_upvr() do
		_1_upvr.Parent = script
		task.wait(5)
	end
	_1_upvr.Parent = workspace
end)
GameEvents.PetAgeLimitBreak_PlayEffects.OnClientEvent:Connect(function(arg1) -- Line 209, Named "ClaimAnimation"
	--[[ Upvalues[10]:
		[1]: _1_upvr (readonly)
		[2]: var10_upvw (read and write)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: RunService_upvr (readonly)
		[5]: var28_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: SoundPlayer_upvr (readonly)
		[8]: SoundData_upvr (readonly)
		[9]: TweenService_upvr (readonly)
		[10]: PetList_upvr (readonly)
	]]
	local PetAgeMachinePoof = _1_upvr:FindFirstChild("PetAgeMachinePoof")
	if not var10_upvw then
	else
		local clone_4_upvr = var10_upvw:Clone()
		clone_4_upvr.Parent = var10_upvw.Parent
		var10_upvw.Parent = ReplicatedStorage_upvr
		local Character = LocalPlayer_upvr.Character
		if not Character then return end
		SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.SFX, {}, nil, PetAgeMachinePoof)
		local const_number_2 = 0
		while const_number_2 < 1.5 do
			local math_lerp_result1 = math.lerp(0.01, 0.1, TweenService_upvr:GetValue((const_number_2 + RunService_upvr.Heartbeat:Wait()) / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			_1_upvr:PivotTo(_1_upvr:GetPivot() + Vector3.new(math.random(-100, 100) / 100 * math_lerp_result1, math.random(-100, 100) / 100 * math_lerp_result1, math.random(-100, 100) / 100 * math_lerp_result1))
		end
		PetAgeMachinePoof.PixelSmoke:Emit(26)
		clone_4_upvr:Destroy()
		RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 221
			--[[ Upvalues[2]:
				[1]: clone_4_upvr (readonly)
				[2]: var28_upvw (copied, read and write)
			]]
			local var44 = clone_4_upvr
			var44:PivotTo((var44:GetPivot() + Vector3.new(0, math.sin(var28_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
		end):Disconnect()
		local var48 = PetList_upvr[arg1.Name]
		local var49
		if var48 and var48.WeldOffset then
			var49 = var48.WeldOffset
		end
		local var50 = CFrame.lookAt(clone_4_upvr:GetPivot().Position, Character:GetPivot().Position) * var49
		local clone = arg1:Clone()
		clone:ScaleTo(clone_4_upvr:GetScale())
		clone:PivotTo(var50)
		for _, v_2 in clone:GetDescendants() do
			if v_2:IsA("BasePart") then
				v_2.Anchored = true
			end
		end
		local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = clone:GetBoundingBox()
		local Part = Instance.new("Part")
		Part.CFrame = any_GetBoundingBox_result1
		Part.Name = "TrailPart"
		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Size = any_GetBoundingBox_result2
		Part.Transparency = 1
		local Attachment = Instance.new("Attachment")
		Attachment.Name = "Attachment"
		Attachment.CFrame = CFrame.new(0, any_GetBoundingBox_result2.Y * 0.5, 0)
		Attachment.Parent = Part
		local Attachment_2 = Instance.new("Attachment")
		Attachment_2.Name = "Attachment"
		Attachment_2.CFrame = CFrame.new(0, -any_GetBoundingBox_result2.Y * 0.5, 0)
		Attachment_2.Parent = Part
		local Trail = Instance.new("Trail")
		Trail.Name = "Trail"
		Trail.FaceCamera = true
		Trail.Lifetime = 0.5
		Trail.Attachment0 = Attachment
		Trail.Attachment0 = Attachment_2
		Trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.05, 1), NumberSequenceKeypoint.new(0.055, 0.4875), NumberSequenceKeypoint.new(1, 1)})
		Trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
		Trail.Parent = Part
		Part.Parent = clone
		clone.Parent = workspace.CurrentCamera
		task.wait(0.8)
		local const_number = 0
		while const_number < 0.8 do
			local var64 = const_number + RunService_upvr.Heartbeat:Wait()
			local Position = var50.Position
			local Position_2 = Character:GetPivot().Position
			local any_GetValue_result1 = TweenService_upvr:GetValue(var64 / 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			clone:ScaleTo(math.lerp(clone:GetScale(), 0.05, math.clamp((var64 - 0.4) / 0.4, 0, 1)))
			clone:PivotTo(CFrame.new((1 - any_GetValue_result1) ^ 2 * Position + (1 - any_GetValue_result1) * 2 * any_GetValue_result1 * (Position + (Position_2 - Position) * 0.5 + Vector3.new(0, 14, 0)) + any_GetValue_result1 ^ 2 * Position_2) * var50.Rotation)
		end
		clone:Destroy()
		local clone_3_upvr = workspace.Terrain.PopEffect:Clone()
		clone_3_upvr.CFrame = Character:GetPivot()
		SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Retrieve, {}, nil, clone_3_upvr)
		clone_3_upvr.Parent = workspace.Terrain
		for _, v_3 in clone_3_upvr:GetChildren() do
			if v_3:IsA("ParticleEmitter") then
				v_3:Emit(1)
			end
		end
		task.delay(1.5, function() -- Line 356
			--[[ Upvalues[1]:
				[1]: clone_3_upvr (readonly)
			]]
			clone_3_upvr:Destroy()
		end)
	end
end)
return {}
