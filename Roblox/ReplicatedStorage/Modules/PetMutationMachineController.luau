-- game:GetService("ReplicatedStorage").Modules.PetMutationMachineController

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 22:36:32
-- Luau version 6, Types version 3
-- Time taken: 0.026072 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local DataService_upvr = require(ReplicatedStorage_upvr.Modules.DataService)
local TimeHelper_upvr = require(ReplicatedStorage_upvr.Modules.TimeHelper)
local SoundData_upvr = require(ReplicatedStorage_upvr.Data.SoundData)
local SoundPlayer_upvr = require(ReplicatedStorage_upvr.Modules.SoundPlayer)
local PetList_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry).PetList
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local var9_upvw
local any_GetTagged_result1 = game:GetService("CollectionService"):GetTagged("PetMutationMachine")
if #any_GetTagged_result1 <= 0 then
	warn("Cannot find Pet Mutation machine")
	return {}
end
local _1_upvr = any_GetTagged_result1[1]
local TimerTextLabel_upvr = _1_upvr:FindFirstChild("TimerTextLabel", true)
local tbl_2_upvr = {}
local PetMutationMachineProximityPrompt_upvr = _1_upvr:FindFirstChild("PetMutationMachineProximityPrompt", true)
local function GetMachineData_upvr() -- Line 76, Named "GetMachineData"
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
	local PetMutationMachine = any_GetData_result1.PetMutationMachine
	if not PetMutationMachine then
		return warn(`No PetMuationMachine data for {LocalPlayer_upvr.Name}!`)
	end
	return PetMutationMachine
end
local SelectiveAssetReplication_upvr = require(ReplicatedStorage_upvr.Modules.SelectiveAssetReplication)
local PetModelLocation_upvr = _1_upvr:FindFirstChild("PetModelLocation", true)
local function UpdateModel_upvr() -- Line 89, Named "UpdateModel"
	--[[ Upvalues[5]:
		[1]: GetMachineData_upvr (readonly)
		[2]: var9_upvw (read and write)
		[3]: SelectiveAssetReplication_upvr (readonly)
		[4]: PetList_upvr (readonly)
		[5]: PetModelLocation_upvr (readonly)
	]]
	local GetMachineData_result1_4 = GetMachineData_upvr()
	if not GetMachineData_result1_4 then
	else
		if not GetMachineData_result1_4.SubmittedPet then
			if var9_upvw then
				var9_upvw:Destroy()
				var9_upvw = nil
			end
			return
		end
		local clone = SelectiveAssetReplication_upvr:GetAssetAsync("PetAssets", GetMachineData_result1_4.SubmittedPet.PetType):Clone()
		clone:SetPrimaryPartCFrame(CFrame.new(clone:GetPrimaryPartCFrame().Position) * PetList_upvr[GetMachineData_result1_4.SubmittedPet.PetType].WeldOffset)
		var9_upvw = clone
		if not var9_upvw then return end
		if not var9_upvw.PrimaryPart or not PetModelLocation_upvr.PrimaryPart then
			warn("Both models need a PrimaryPart set.")
			return
		end
		local any_GetExtentsSize_result1 = var9_upvw:GetExtentsSize()
		local any_GetExtentsSize_result1_2 = PetModelLocation_upvr:GetExtentsSize()
		for _, v in var9_upvw:GetDescendants() do
			if v:IsA("BasePart") then
				v.Anchored = true
			end
		end
		var9_upvw:ScaleTo(math.min(any_GetExtentsSize_result1_2.X / any_GetExtentsSize_result1.X, any_GetExtentsSize_result1_2.Y / any_GetExtentsSize_result1.Y, any_GetExtentsSize_result1_2.Z / any_GetExtentsSize_result1.Z))
		var9_upvw:PivotTo(CFrame.new(PetModelLocation_upvr:GetPivot().Position) * var9_upvw:GetPivot().Rotation)
		var9_upvw.Parent = PetModelLocation_upvr
	end
end
local function _() -- Line 147, Named "UpdateTimer"
	--[[ Upvalues[3]:
		[1]: GetMachineData_upvr (readonly)
		[2]: TimeHelper_upvr (readonly)
		[3]: TimerTextLabel_upvr (readonly)
	]]
	local GetMachineData_result1_5 = GetMachineData_upvr()
	if not GetMachineData_result1_5 then
	else
		if 0 < GetMachineData_result1_5.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_result1_5.TimeLeft)}`
			return
		end
		if GetMachineData_result1_5.PetReady then
			TimerTextLabel_upvr.Text = "READY"
			return
		end
		TimerTextLabel_upvr.Text = ""
	end
end
local var29_upvw = 0
local function _(arg1) -- Line 169, Named "AnimatePet"
	--[[ Upvalues[1]:
		[1]: var29_upvw (read and write)
	]]
	arg1:PivotTo((arg1:GetPivot() + Vector3.new(0, math.sin(var29_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
end
local var30_upvw
local NumberUtil_upvr = require(ReplicatedStorage_upvr.Modules.NumberUtil)
local PetMutationMachineData_upvr = require(ReplicatedStorage_upvr.Data.PetMutationMachineData)
local function UpdatePrompt_upvr() -- Line 183, Named "UpdatePrompt"
	--[[ Upvalues[7]:
		[1]: tbl_2_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: PetMutationMachineProximityPrompt_upvr (readonly)
		[4]: GetMachineData_upvr (readonly)
		[5]: var30_upvw (read and write)
		[6]: NumberUtil_upvr (readonly)
		[7]: PetMutationMachineData_upvr (readonly)
	]]
	if tbl_2_upvr[LocalPlayer_upvr] then
		PetMutationMachineProximityPrompt_upvr.Enabled = false
	else
		local GetMachineData_upvr_result1 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1 then return end
		PetMutationMachineProximityPrompt_upvr.Enabled = true
		if GetMachineData_upvr_result1.IsRunning or 0 < GetMachineData_upvr_result1.TimeLeft then
			if var30_upvw and var30_upvw.ArePaidRandomItemsRestricted then
				PetMutationMachineProximityPrompt_upvr.Enabled = false
			else
				PetMutationMachineProximityPrompt_upvr.ActionText = "Skip"
			end
		end
		if GetMachineData_upvr_result1.PetReady then
			PetMutationMachineProximityPrompt_upvr.ActionText = "Claim Pet"
			return
		end
		if GetMachineData_upvr_result1.SubmittedPet and not GetMachineData_upvr_result1.IsRunning then
			PetMutationMachineProximityPrompt_upvr.ActionText = `Start Mutation: {NumberUtil_upvr.FormatCompactPrice(PetMutationMachineData_upvr.MUTATE_PRICE)} \xA2`
			return
		end
		if not GetMachineData_upvr_result1.SubmittedPet then
			PetMutationMachineProximityPrompt_upvr.ActionText = "Submit Pet"
		end
	end
end
local PolicyService_upvr = require(ReplicatedStorage_upvr.Modules.PolicyService)
task.spawn(function() -- Line 216
	--[[ Upvalues[4]:
		[1]: var30_upvw (read and write)
		[2]: PolicyService_upvr (readonly)
		[3]: LocalPlayer_upvr (readonly)
		[4]: UpdatePrompt_upvr (readonly)
	]]
	var30_upvw = PolicyService_upvr:GetPolicyInfoForPlayerAsync(LocalPlayer_upvr)
	UpdatePrompt_upvr()
end)
local function _(arg1, arg2, arg3, arg4) -- Line 222, Named "quadraticBezier"
	return (1 - arg1) ^ 2 * arg2 + (1 - arg1) * 2 * arg1 * arg3 + arg1 ^ 2 * arg4
end
local TweenService_upvr = game:GetService("TweenService")
local var78_upvw = false
local PetMutationMachineService_RE_upvr = ReplicatedStorage_upvr:WaitForChild("GameEvents").PetMutationMachineService_RE
local InventoryServiceEnums_upvr = require(ReplicatedStorage_upvr.Data.EnumRegistry.InventoryServiceEnums)
local ItemTypeEnums_upvr = require(ReplicatedStorage_upvr.Data.EnumRegistry.ItemTypeEnums)
local PetsService_upvr = require(ReplicatedStorage_upvr.Modules.PetServices.PetsService)
local ConfirmationPromptController_upvr = require(ReplicatedStorage_upvr.Modules.ConfirmationPromptController)
PetMutationMachineProximityPrompt_upvr.Triggered:Connect(function() -- Line 380
	--[[ Upvalues[9]:
		[1]: var78_upvw (read and write)
		[2]: GetMachineData_upvr (readonly)
		[3]: PetMutationMachineService_RE_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
		[5]: InventoryServiceEnums_upvr (readonly)
		[6]: ItemTypeEnums_upvr (readonly)
		[7]: PetsService_upvr (readonly)
		[8]: ReplicatedStorage_upvr (readonly)
		[9]: ConfirmationPromptController_upvr (readonly)
	]]
	if var78_upvw then
	else
		var78_upvw = true
		task.delay(0.5, function() -- Line 386
			--[[ Upvalues[1]:
				[1]: var78_upvw (copied, read and write)
			]]
			var78_upvw = false
		end)
		local GetMachineData_upvr_result1_2 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1_2 then return end
		if GetMachineData_upvr_result1_2.IsRunning or 0 < GetMachineData_upvr_result1_2.TimeLeft then
			PetMutationMachineService_RE_upvr:FireServer("AuthoriseSkip")
		end
		if GetMachineData_upvr_result1_2.PetReady then
			PetMutationMachineService_RE_upvr:FireServer("ClaimMutatedPet")
			return
		end
		if GetMachineData_upvr_result1_2.SubmittedPet and not GetMachineData_upvr_result1_2.IsRunning then
			PetMutationMachineService_RE_upvr:FireServer("StartMachine")
			return
		end
		if not GetMachineData_upvr_result1_2.SubmittedPet then
			local Character = LocalPlayer_upvr.Character
			if not Character then return end
			local class_Tool = Character:FindFirstChildWhichIsA("Tool")
			if not class_Tool then return end
			if class_Tool:GetAttribute(InventoryServiceEnums_upvr.ITEM_TYPE) ~= ItemTypeEnums_upvr.Pet then return end
			local var88 = "Common"
			local var89 = require(ReplicatedStorage_upvr.Data.PetRegistry.PetList)[PetsService_upvr:GetPlayerPetData(class_Tool:GetAttribute("PET_UUID")).PetType]
			if var89 then
				var88 = var89.Rarity
			end
			local tbl = {
				Title = "Submit Pet To Mutation Machine";
				Header = "Are you sure you want to submit that pet?";
			}
			local attribute = class_Tool:GetAttribute(InventoryServiceEnums_upvr.ItemName)
			if not attribute then
				attribute = class_Tool.Name
			end
			tbl.Middle = `{tostring(attribute)}`
			tbl.Footer = "Your pet will reset back to age 1."
			local tbl_3 = {}
			local attribute_2 = class_Tool:GetAttribute(InventoryServiceEnums_upvr.ItemName)
			if not attribute_2 then
				attribute_2 = class_Tool.Name
			end
			tbl_3[`{tostring(attribute_2)}`] = var88
			tbl.AnimatedWords = tbl_3
			ConfirmationPromptController_upvr:Open(tbl, {
				ConfirmEvent = PetMutationMachineService_RE_upvr;
				ConfirmEventData = {"SubmitHeldPet"};
			})
		end
	end
end)
local var97_upvw
DataService_upvr:GetPathSignal("PetMutationMachine/IsRunning"):Connect(function() -- Line 439
	--[[ Upvalues[8]:
		[1]: GetMachineData_upvr (readonly)
		[2]: UpdatePrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: SoundPlayer_upvr (readonly)
		[6]: SoundData_upvr (readonly)
		[7]: _1_upvr (readonly)
		[8]: var97_upvw (read and write)
	]]
	local GetMachineData_result1 = GetMachineData_upvr()
	if not GetMachineData_result1 then
	else
		UpdatePrompt_upvr()
		local GetMachineData_result1_3 = GetMachineData_upvr()
		if not GetMachineData_result1_3 then
		elseif 0 < GetMachineData_result1_3.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_result1_3.TimeLeft)}`
		elseif GetMachineData_result1_3.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
		if GetMachineData_result1.IsRunning then
			SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Start, {}, nil, _1_upvr)
			if var97_upvw then
				var97_upvw:Play()
			else
				var97_upvw = SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Loop, {
					Looped = true;
				}, nil, _1_upvr)
			end
		end
		SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.LoopDone)
		var97_upvw:Stop()
		task.spawn(function() -- Line 455
			--[[ Upvalues[2]:
				[1]: SoundPlayer_upvr (copied, readonly)
				[2]: SoundData_upvr (copied, readonly)
			]]
			task.wait(1)
			SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Finished)
		end)
	end
end)
DataService_upvr:GetPathSignal("PetMutationMachine/SubmittedPet"):Connect(function() -- Line 463
	--[[ Upvalues[7]:
		[1]: GetMachineData_upvr (readonly)
		[2]: UpdatePrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: UpdateModel_upvr (readonly)
		[6]: SoundPlayer_upvr (readonly)
		[7]: SoundData_upvr (readonly)
	]]
	local GetMachineData_result1_7 = GetMachineData_upvr()
	if not GetMachineData_result1_7 then
	else
		UpdatePrompt_upvr()
		local GetMachineData_result1_6 = GetMachineData_upvr()
		if not GetMachineData_result1_6 then
		elseif 0 < GetMachineData_result1_6.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_result1_6.TimeLeft)}`
		elseif GetMachineData_result1_6.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
		UpdateModel_upvr()
		if GetMachineData_result1_7.SubmittedPet then
			SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Insert)
		end
	end
end)
RunService_upvr.RenderStepped:Connect(function(arg1) -- Line 476
	--[[ Upvalues[2]:
		[1]: var9_upvw (read and write)
		[2]: var29_upvw (read and write)
	]]
	if not var9_upvw then
	elseif var9_upvw.PrimaryPart then
		var29_upvw += arg1
		local var106 = var9_upvw
		var106:PivotTo((var106:GetPivot() + Vector3.new(0, math.sin(var29_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
	end
end)
task.spawn(function() -- Line 487
	--[[ Upvalues[4]:
		[1]: UpdatePrompt_upvr (readonly)
		[2]: GetMachineData_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
	]]
	while true do
		task.wait(0.5)
		UpdatePrompt_upvr()
		local GetMachineData_result1_2 = GetMachineData_upvr()
		if not GetMachineData_result1_2 then
		elseif 0 < GetMachineData_result1_2.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_result1_2.TimeLeft)}`
		elseif GetMachineData_result1_2.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
	end
end)
local RebirthUnlocksSharedService_upvr = require(ReplicatedStorage_upvr.Modules.RebirthUnlocksSharedService)
task.spawn(function() -- Line 510
	--[[ Upvalues[8]:
		[1]: GetMachineData_upvr (readonly)
		[2]: UpdatePrompt_upvr (readonly)
		[3]: TimeHelper_upvr (readonly)
		[4]: TimerTextLabel_upvr (readonly)
		[5]: UpdateModel_upvr (readonly)
		[6]: RebirthUnlocksSharedService_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
		[8]: tbl_2_upvr (readonly)
	]]
	if not GetMachineData_upvr() then
	else
		UpdatePrompt_upvr()
		local GetMachineData_upvr_result1_3 = GetMachineData_upvr()
		if not GetMachineData_upvr_result1_3 then
		elseif 0 < GetMachineData_upvr_result1_3.TimeLeft then
			TimerTextLabel_upvr.Text = `{TimeHelper_upvr:GenerateColonFormatFromTime(GetMachineData_upvr_result1_3.TimeLeft)}`
		elseif GetMachineData_upvr_result1_3.PetReady then
			TimerTextLabel_upvr.Text = "READY"
		else
			TimerTextLabel_upvr.Text = ""
		end
		UpdateModel_upvr()
		if RebirthUnlocksSharedService_upvr:HasUnlockedFeature(LocalPlayer_upvr, "PET_MUTATION_MACHINE") then return end
		tbl_2_upvr[LocalPlayer_upvr] = true
		UpdatePrompt_upvr()
		local var113_upvw
		var113_upvw = RebirthUnlocksSharedService_upvr.OnRebirthUnlock:Connect(function(arg1, arg2) -- Line 523
			--[[ Upvalues[3]:
				[1]: LocalPlayer_upvr (copied, readonly)
				[2]: var113_upvw (read and write)
				[3]: tbl_2_upvr (copied, readonly)
			]]
			if arg1 ~= LocalPlayer_upvr then
			else
				if arg2 ~= "PET_MUTATION_MACHINE" then return end
				if var113_upvw then
					var113_upvw:Disconnect()
					var113_upvw = nil
				end
				tbl_2_upvr[arg1] = nil
			end
		end)
	end
end)
ReplicatedStorage_upvr.GameEvents.PetMutationClaimAnimation.OnClientEvent:Connect(function(arg1, arg2) -- Line 226, Named "ClaimAnimation"
	--[[ Upvalues[10]:
		[1]: _1_upvr (readonly)
		[2]: var9_upvw (read and write)
		[3]: ReplicatedStorage_upvr (readonly)
		[4]: RunService_upvr (readonly)
		[5]: var29_upvw (read and write)
		[6]: LocalPlayer_upvr (readonly)
		[7]: SoundPlayer_upvr (readonly)
		[8]: SoundData_upvr (readonly)
		[9]: TweenService_upvr (readonly)
		[10]: PetList_upvr (readonly)
	]]
	local PetMutationMachinePoof = _1_upvr:FindFirstChild("PetMutationMachinePoof")
	if not var9_upvw then
	else
		local clone_2_upvr = var9_upvw:Clone()
		clone_2_upvr.Parent = var9_upvw.Parent
		var9_upvw.Parent = ReplicatedStorage_upvr
		local Character_2 = LocalPlayer_upvr.Character
		if not Character_2 then return end
		SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.SFX, {}, nil, PetMutationMachinePoof)
		local const_number_2 = 0
		while const_number_2 < 1.5 do
			local math_lerp_result1 = math.lerp(0.01, 0.1, TweenService_upvr:GetValue((const_number_2 + RunService_upvr.Heartbeat:Wait()) / 1.5, Enum.EasingStyle.Quad, Enum.EasingDirection.Out))
			_1_upvr:PivotTo(_1_upvr:GetPivot() + Vector3.new(math.random(-100, 100) / 100 * math_lerp_result1, math.random(-100, 100) / 100 * math_lerp_result1, math.random(-100, 100) / 100 * math_lerp_result1))
		end
		PetMutationMachinePoof.PixelSmoke:Emit(26)
		clone_2_upvr:Destroy()
		RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 238
			--[[ Upvalues[2]:
				[1]: clone_2_upvr (readonly)
				[2]: var29_upvw (copied, read and write)
			]]
			local var48 = clone_2_upvr
			var48:PivotTo((var48:GetPivot() + Vector3.new(0, math.sin(var29_upvw) * 0.01, 0)) * CFrame.Angles(0, 0.008726646259971648, 0))
		end):Disconnect()
		local var52 = PetList_upvr[arg1.Name]
		local var53
		if var52 and var52.WeldOffset then
			var53 = var52.WeldOffset
		end
		local var54 = CFrame.lookAt(clone_2_upvr:GetPivot().Position, Character_2:GetPivot().Position) * var53
		local clone_4 = arg1:Clone()
		clone_4:ScaleTo(clone_2_upvr:GetScale() * arg2)
		clone_4:PivotTo(var54)
		for _, v_2 in clone_4:GetDescendants() do
			if v_2:IsA("BasePart") then
				v_2.Anchored = true
			end
		end
		local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = clone_4:GetBoundingBox()
		local Part = Instance.new("Part")
		Part.CFrame = any_GetBoundingBox_result1
		Part.Name = "TrailPart"
		Part.Anchored = true
		Part.CanCollide = false
		Part.CanQuery = false
		Part.CanTouch = false
		Part.Size = any_GetBoundingBox_result2
		Part.Transparency = 1
		local Attachment_2 = Instance.new("Attachment")
		Attachment_2.Name = "Attachment"
		Attachment_2.CFrame = CFrame.new(0, any_GetBoundingBox_result2.Y * 0.5, 0)
		Attachment_2.Parent = Part
		local Attachment = Instance.new("Attachment")
		Attachment.Name = "Attachment"
		Attachment.CFrame = CFrame.new(0, -any_GetBoundingBox_result2.Y * 0.5, 0)
		Attachment.Parent = Part
		local Trail = Instance.new("Trail")
		Trail.Name = "Trail"
		Trail.FaceCamera = true
		Trail.Lifetime = 0.5
		Trail.Attachment0 = Attachment_2
		Trail.Attachment0 = Attachment
		Trail.Transparency = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(0.05, 1), NumberSequenceKeypoint.new(0.055, 0.4875), NumberSequenceKeypoint.new(1, 1)})
		Trail.WidthScale = NumberSequence.new({NumberSequenceKeypoint.new(0, 1), NumberSequenceKeypoint.new(1, 0)})
		Trail.Parent = Part
		Part.Parent = clone_4
		clone_4.Parent = workspace.CurrentCamera
		task.wait(0.8)
		local const_number = 0
		while const_number < 0.8 do
			local var68 = const_number + RunService_upvr.Heartbeat:Wait()
			local Position_2 = var54.Position
			local Position = Character_2:GetPivot().Position
			local any_GetValue_result1 = TweenService_upvr:GetValue(var68 / 0.8, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
			clone_4:ScaleTo(math.lerp(clone_4:GetScale(), 0.05, math.clamp((var68 - 0.4) / 0.4, 0, 1)))
			clone_4:PivotTo(CFrame.new((1 - any_GetValue_result1) ^ 2 * Position_2 + (1 - any_GetValue_result1) * 2 * any_GetValue_result1 * (Position_2 + (Position - Position_2) * 0.5 + Vector3.new(0, 14, 0)) + any_GetValue_result1 ^ 2 * Position) * var54.Rotation)
		end
		clone_4:Destroy()
		local clone_3_upvr = workspace.Terrain.PopEffect:Clone()
		clone_3_upvr.CFrame = Character_2:GetPivot()
		SoundPlayer_upvr:PlaySound(SoundData_upvr.MachineSounds.Retrieve, {}, nil, clone_3_upvr)
		clone_3_upvr.Parent = workspace.Terrain
		for _, v_3 in clone_3_upvr:GetChildren() do
			if v_3:IsA("ParticleEmitter") then
				v_3:Emit(1)
			end
		end
		task.delay(1.5, function() -- Line 373
			--[[ Upvalues[1]:
				[1]: clone_3_upvr (readonly)
			]]
			clone_3_upvr:Destroy()
		end)
	end
end)
return {}
