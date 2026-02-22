-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-22 01:31:59
-- Luau version 6, Types version 3
-- Time taken: 0.023317 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local module_upvr = {}
local PetRegistry_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry)
local PetEggService_upvr = ReplicatedStorage_upvr.GameEvents.PetEggService
local tbl_upvr = {}
local tbl_upvr_2 = {}
local tbl_upvr_3 = {}
for _, v in script.EggEffects:GetChildren() do
	tbl_upvr_2[v.Name] = require(v)
end
local LocalPlayer_upvr = game.Players.LocalPlayer
local function _(arg1, arg2, arg3) -- Line 42, Named "CreateProximityPromptAttachment"
	local Attachment_3 = Instance.new("Attachment")
	Attachment_3.Parent = arg1
	Attachment_3.Name = `{arg2.Name}Att`
	Attachment_3.CFrame = CFrame.new(arg3)
	arg2.Parent = Attachment_3
	return Attachment_3
end
local function _(arg1, arg2) -- Line 55, Named "UpdateAttachmentHeight"
	if not arg1 then
	else
		if not arg2 then
			return
		end
		arg2.CFrame = CFrame.new(0, arg1:GetExtentsSize().Y, 0)
	end
end
local function _(arg1) -- Line 63, Named "PlaySound"
	local clone_upvr = arg1:Clone()
	clone_upvr.Parent = workspace
	clone_upvr:Play()
	clone_upvr.Ended:Once(function() -- Line 68
		--[[ Upvalues[1]:
			[1]: clone_upvr (readonly)
		]]
		clone_upvr:Destroy()
	end)
end
local function TryDoHatchAnim_upvr(arg1, arg2) -- Line 74, Named "TryDoHatchAnim"
	--[[ Upvalues[3]:
		[1]: tbl_upvr (readonly)
		[2]: tbl_upvr_3 (readonly)
		[3]: tbl_upvr_2 (readonly)
	]]
	if not arg1 then
		warn("DoHatchAnim | No server egg!")
	else
		local var20 = tbl_upvr[arg1]
		if not var20 then
			warn("DoHatchAnim | No state data for server egg")
			return
		end
		local Asset = var20.Asset
		if not Asset then
			warn("DoHatchAnim | No asset!")
			return
		end
		local OBJECT_UUID = arg1:GetAttribute("OBJECT_UUID")
		if not OBJECT_UUID then
			return warn("DoHatchAnim | No egg uuid!")
		end
		if Asset:GetAttribute("DoingHatch") then
			return
		end
		Asset:SetAttribute("DoingHatch", true)
		Asset.Parent = workspace.Visuals
		local var23 = tbl_upvr_3[OBJECT_UUID]
		local EggName = arg1:GetAttribute("EggName")
		if tbl_upvr_2[EggName] then
			tbl_upvr_2[EggName](Asset, var23, arg2)
			return
		end
		if EggName == "Rare Egg" or EggName == "Legendary Egg" or EggName == "Mythical Egg" then
			tbl_upvr_2.Rare(Asset, var23, arg2)
			return
		end
		tbl_upvr_2.Normal(Asset, var23, arg2)
	end
end
local function ActivateEgg_upvr(arg1, arg2) -- Line 105, Named "ActivateEgg"
	--[[ Upvalues[2]:
		[1]: tbl_upvr (readonly)
		[2]: TryDoHatchAnim_upvr (readonly)
	]]
	if not arg1 then
		warn("ActivateEgg | No server egg!")
	else
		local var25 = tbl_upvr[arg1]
		if not var25 then
			warn("ActivateEgg | No state data for server egg")
			return
		end
		local Asset_2 = var25.Asset
		if not Asset_2 then
			warn("ActivateEgg | No asset!")
			return
		end
		local PetEgg = arg1:FindFirstChild("PetEgg")
		local var28
		if PetEgg then
			var28 = PetEgg:FindFirstChild("ProximityPromptAtt") or Asset_2:FindFirstChild("ProximityPrompt")
		end
		if var28 then
			var28:Destroy()
		end
		TryDoHatchAnim_upvr(arg1, arg2)
	end
end
local EggSkipProducts_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry.EggSkipProducts)
local UpdateService_upvr = require(ReplicatedStorage_upvr.Modules.UpdateService)
local function CheckEggTimer_upvr(arg1, arg2) -- Line 135, Named "CheckEggTimer"
	--[[ Upvalues[4]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: EggSkipProducts_upvr (readonly)
		[4]: UpdateService_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	if arg1:GetAttribute("OWNER") ~= LocalPlayer_upvr.Name then
	else
		local var39 = tbl_upvr[arg1]
		if not var39 then
			warn("CheckEggTimer | No state data for server egg")
			return
		end
		local Asset_4 = var39.Asset
		if not Asset_4 then
			warn("CheckEggTimer | No asset!")
			return
		end
		local var41
		if not var41 and arg2 then
			var41 = arg1:WaitForChild("PetEgg", 5)
		end
		if not var41 then
			var41 = arg1
		end
		local ProximityPromptAtt = var41:FindFirstChild("ProximityPromptAtt")
		if not ProximityPromptAtt then
			ProximityPromptAtt = arg1:FindFirstChild("ProximityPromptAtt")
		end
		local SkipAllPromptAtt = var41:FindFirstChild("SkipAllPromptAtt")
		if not SkipAllPromptAtt then
			SkipAllPromptAtt = arg1:FindFirstChild("SkipAllPromptAtt")
		end
		local SkipPromptAtt = var41:FindFirstChild("SkipPromptAtt")
		if not SkipPromptAtt then
			SkipPromptAtt = arg1:FindFirstChild("SkipPromptAtt")
		end
		local ProximityPrompt = ProximityPromptAtt or arg1:FindFirstChild("ProximityPrompt")
		local SkipAllPrompt = SkipAllPromptAtt or arg1:FindFirstChild("SkipAllPrompt")
		local SkipPrompt = SkipPromptAtt or arg1:FindFirstChild("SkipPrompt")
		if not ProximityPrompt then
			return warn(`CheckEggTimer | No Proximity Prompt found for {Asset_4}`)
		end
		if not SkipPrompt then
			return warn(`CheckEggTimer | No Skip Prompt found for {Asset_4}`)
		end
		local var48 = ProximityPromptAtt
		if not arg1 then
		elseif not var48 then
		else
			var48.CFrame = CFrame.new(0, arg1:GetExtentsSize().Y, 0)
		end
		local var49 = SkipPromptAtt
		if not arg1 then
			-- KONSTANTWARNING: GOTO [147] #118
		end
		if not var49 then
		else
			var49.CFrame = CFrame.new(0, arg1:GetExtentsSize().Y, 0)
		end
		local ShowTime = arg1:GetAttribute("ShowTime")
		if ShowTime then
			if ShowTime > workspace:GetServerTimeNow() then
			else
			end
		else
		end
		if not true then
			SkipAllPrompt.Enabled = false
			ProximityPrompt.Enabled = false
			SkipPrompt.Enabled = false
			return
		end
		if arg1:GetAttribute("TimeToHatch") <= 0 then
			ProximityPrompt.Enabled = true
			SkipAllPrompt.Enabled = false
			SkipPrompt.Enabled = false
			return
		end
		ProximityPrompt.Enabled = false
		for i_2, _ in tbl_upvr do
			if i_2:GetAttribute("OWNER") == LocalPlayer_upvr.Name and i_2:GetAttribute("TimeToHatch") > 0 then
				local var51 = 0 + 1
			end
		end
		SkipAllPrompt.ObjectText = `{math.min(var51, #EggSkipProducts_upvr)} Eggs`
		local var52 = false
		if 2 <= var51 then
			var52 = not UpdateService_upvr:IsHiddenFromUpdate("Multi Egg Skip")
		end
		SkipAllPrompt.Enabled = var52
		SkipPrompt.Enabled = true
	end
end
local EggModels_upvr = ReplicatedStorage_upvr:WaitForChild("Assets"):WaitForChild("Models"):WaitForChild("EggModels")
function module_upvr.RenderEgg(arg1, arg2) -- Line 231
	--[[ Upvalues[7]:
		[1]: EggModels_upvr (readonly)
		[2]: PetRegistry_upvr (readonly)
		[3]: CheckEggTimer_upvr (readonly)
		[4]: tbl_upvr (readonly)
		[5]: LocalPlayer_upvr (readonly)
		[6]: ReplicatedStorage_upvr (readonly)
		[7]: PetEggService_upvr (readonly)
	]]
	local var58
	if not arg2:GetAttribute("READY") then
		var58 = "READY"
		arg2:GetAttributeChangedSignal(var58):Wait()
	end
	var58 = "ShowTime"
	local attribute = arg2:GetAttribute(var58)
	if attribute then
		var58 = workspace:GetServerTimeNow()
		if attribute > var58 then
		else
		end
	else
	end
	var58 = arg2:GetAttribute("EggName")
	if not var58 then
		repeat
			task.wait(0.5)
			var58 = arg2:GetAttribute("EggName")
		until 5 <= 0 + 1 and var58
	end
	if not var58 then
	else
		local SOME = EggModels_upvr:FindFirstChild(var58)
		if not SOME then
			return warn(`Could not find egg model associated with {var58}`)
		end
		local clone_4_upvr = SOME:Clone()
		clone_4_upvr.PrimaryPart.Anchored = true
		local HatchTime_upvr = PetRegistry_upvr.PetEggs[var58].HatchTime
		clone_4_upvr:ScaleTo(math.clamp(1 - 0.5 * (arg2:GetAttribute("TimeToHatch") / HatchTime_upvr), 0.2, 1))
		workspace.Terrain.EggParticle.WorldCFrame = arg2:GetPivot()
		for _, v_3 in workspace.Terrain.EggParticle:GetDescendants() do
			v_3:Emit(v_3:GetAttribute("EmitCount"))
		end
		local var66_upvw = Vector3.new(0, 1.5, 0)
		local var68_upvw = 0
		task.spawn(function() -- Line 278
			--[[ Upvalues[4]:
				[1]: var68_upvw (read and write)
				[2]: var66_upvw (read and write)
				[3]: clone_4_upvr (readonly)
				[4]: arg2 (readonly)
			]]
			while var68_upvw < 0.25 do
				var68_upvw += game:GetService("RunService").Heartbeat:Wait()
				var66_upvw = Vector3.new(0, 3, 0):Lerp(
					Vector3.new(0, 0, 0),
					game.TweenService:GetValue(var68_upvw / 0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
				)
				clone_4_upvr:PivotTo(
					arg2:GetPivot() * CFrame.new(0, var66_upvw.Y + clone_4_upvr:GetExtentsSize().Y * 0.5, 0)
				)
			end
		end)
		arg2:GetAttributeChangedSignal("TimeToHatch"):Connect(function() -- Line 291
			--[[ Upvalues[5]:
				[1]: clone_4_upvr (readonly)
				[2]: arg2 (readonly)
				[3]: HatchTime_upvr (readonly)
				[4]: var66_upvw (read and write)
				[5]: CheckEggTimer_upvr (copied, readonly)
			]]
			clone_4_upvr:ScaleTo(math.clamp(1 - 0.5 * (arg2:GetAttribute("TimeToHatch") / HatchTime_upvr), 0.2, 1))
			clone_4_upvr:PivotTo(
				arg2:GetPivot() * CFrame.new(0, var66_upvw.Y + clone_4_upvr:GetExtentsSize().Y * 0.5, 0)
			)
			CheckEggTimer_upvr(arg2, false)
		end)
		tbl_upvr[arg2] = {
			Asset = clone_4_upvr,
		}
		clone_4_upvr:PivotTo(arg2:GetPivot() * CFrame.new(0, var66_upvw.Y + clone_4_upvr:GetExtentsSize().Y * 0.4, 0))
		clone_4_upvr.Parent = arg2
		if arg2:GetAttribute("OWNER") ~= LocalPlayer_upvr.Name then
			return
		end
		local PetEgg_2 = arg2:WaitForChild("PetEgg", 5)
		if not PetEgg_2 then
			PetEgg_2 = arg2
		end
		local clone_2 = ReplicatedStorage_upvr.ProximityPrompt:Clone()
		clone_2.ActionText = "Hatch!"
		clone_2.HoldDuration = 1
		clone_2.Enabled = false
		clone_2.Parent = PetEgg_2
		clone_2.Triggered:Connect(function() -- Line 331
			--[[ Upvalues[2]:
				[1]: PetEggService_upvr (copied, readonly)
				[2]: arg2 (readonly)
			]]
			PetEggService_upvr:FireServer("HatchPet", arg2)
		end)
		local clone_3 = ReplicatedStorage_upvr.ProximityPrompt:Clone()
		clone_3.Name = "SkipAllPrompt"
		clone_3.ActionText = "Skip All Growth"
		clone_3.HoldDuration = 1
		clone_3.KeyboardKeyCode = Enum.KeyCode.R
		clone_3.GamepadKeyCode = Enum.KeyCode.ButtonY
		clone_3.Enabled = false
		clone_3.Parent = PetEgg_2
		clone_3.Triggered:Connect(function() -- Line 344
			--[[ Upvalues[2]:
				[1]: PetEggService_upvr (copied, readonly)
				[2]: arg2 (readonly)
			]]
			PetEggService_upvr:FireServer("AuthoriseMultiPurchase", arg2)
		end)
		local clone = ReplicatedStorage_upvr.ProximityPrompt:Clone()
		clone.ActionText = "Skip Growth"
		clone.Name = "SkipPrompt"
		clone.HoldDuration = 1
		clone.Enabled = false
		clone.Parent = PetEgg_2
		clone.Triggered:Connect(function() -- Line 354
			--[[ Upvalues[2]:
				[1]: PetEggService_upvr (copied, readonly)
				[2]: arg2 (readonly)
			]]
			PetEggService_upvr:FireServer("AuthorisePurchase", arg2)
		end)
		local Attachment_4 = Instance.new("Attachment")
		Attachment_4.Parent = PetEgg_2
		Attachment_4.Name = `{clone_2.Name}Att`
		Attachment_4.CFrame = CFrame.new(Vector3.new(0, 0, 0))
		clone_2.Parent = Attachment_4
		local var79 = Attachment_4
		local Attachment_2 = Instance.new("Attachment")
		Attachment_2.Parent = PetEgg_2
		Attachment_2.Name = `{clone_3.Name}Att`
		Attachment_2.CFrame = CFrame.new(Vector3.new(0, -1, 0))
		clone_3.Parent = Attachment_2
		local Attachment = Instance.new("Attachment")
		Attachment.Parent = PetEgg_2
		Attachment.Name = `{clone.Name}Att`
		Attachment.CFrame = CFrame.new(Vector3.new(0, 0, 0))
		clone.Parent = Attachment
		local var82 = Attachment
		CheckEggTimer_upvr(arg2, true)
		if not arg2 then
		elseif not var79 then
		else
			var79.CFrame = CFrame.new(0, arg2:GetExtentsSize().Y, 0)
		end
		if not arg2 then
		elseif not var82 then
		else
			var82.CFrame = CFrame.new(0, arg2:GetExtentsSize().Y, 0)
		end
	end
end
function module_upvr.DerenderEgg(arg1, arg2) -- Line 370
	--[[ Upvalues[1]:
		[1]: tbl_upvr (readonly)
	]]
	if not arg2 then
		warn("PetEggRender:DerenderEgg | No server egg to derender")
	else
		local var83 = tbl_upvr[arg2]
		if not var83 then
			warn("PetEggRender:DerenderEgg | No state data for server egg")
			return
		end
		local Asset_3 = var83.Asset
		if not Asset_3 then
			warn("PetEggRender:DerenderEgg | No asset to derender")
			return
		end
		if not Asset_3:GetAttribute("DoingHatch") then
			Asset_3:Destroy()
		end
	end
end
require(ReplicatedStorage_upvr.Modules.CreateTagHandler)({
	Tag = "PetEggServer",
	OnInstanceAdded = function(arg1) -- Line 388, Named "OnInstanceAdded"
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		if not arg1:IsDescendantOf(workspace) then
		else
			module_upvr:RenderEgg(arg1)
		end
	end,
	OnInstanceRemoved = function(arg1) -- Line 392, Named "OnInstanceRemoved"
		--[[ Upvalues[1]:
			[1]: module_upvr (readonly)
		]]
		module_upvr:DerenderEgg(arg1)
	end,
})
ReplicatedStorage_upvr.GameEvents.EggReadyToHatch_RE.OnClientEvent:Connect(function(arg1, arg2) -- Line 397
	--[[ Upvalues[1]:
		[1]: tbl_upvr_3 (readonly)
	]]
	tbl_upvr_3[arg2] = arg1
end)
PetEggService_upvr.OnClientEvent:Connect(function(arg1, arg2) -- Line 401
	--[[ Upvalues[1]:
		[1]: ActivateEgg_upvr (readonly)
	]]
	ActivateEgg_upvr(arg1, arg2)
end)
local SkipEgg_upvr = require(script.SkipEgg)
ReplicatedStorage_upvr.GameEvents.PetSkipped.OnClientEvent:Connect(function(arg1) -- Line 406
	--[[ Upvalues[1]:
		[1]: SkipEgg_upvr (readonly)
	]]
	SkipEgg_upvr(arg1)
end)
return module_upvr
