-- game:GetService("ReplicatedStorage").Modules.PetServices.ActivePetsService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:44:15
-- Luau version 6, Types version 3
-- Time taken: 0.113774 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local PetsPhysical_upvr = workspace:WaitForChild("PetsPhysical")
local TwoPointCast_upvr = require(ReplicatedStorage.Modules.TwoPointCast)
local PetUtilities_upvr = require(ReplicatedStorage.Modules.PetServices.PetUtilities)
local PetSoundHandler_upvr = require(ReplicatedStorage.Modules.PetServices.PetSoundHandler)
local PetMutationRegistry_upvr = require(ReplicatedStorage.Data.PetRegistry.PetMutationRegistry)
local var13_upvr = require(ReplicatedStorage.Modules.OptimisationControllers.IsBadDeviceHeuristic)()
local var14_upvw = LocalPlayer_upvr:GetAttribute("KeepPetOnGround") or false
local RaycastParams_new_result1_upvr_2 = RaycastParams.new()
RaycastParams_new_result1_upvr_2.FilterDescendantsInstances = {workspace.Farm}
RaycastParams_new_result1_upvr_2.FilterType = Enum.RaycastFilterType.Include
local RaycastParams_new_result1_upvr = RaycastParams.new()
RaycastParams_new_result1_upvr.FilterDescendantsInstances = {workspace.Interaction, workspace.BasePlate}
RaycastParams_new_result1_upvr.FilterType = Enum.RaycastFilterType.Include
local PetVFXHandler_upvr = require(ReplicatedStorage.Modules.PetServices.PetVFXHandler)
local SkinService_upvr = require(ReplicatedStorage.Modules.SkinService)
local PlatformService_upvr = ReplicatedStorage.Modules.PlatformService
if game:GetService("UserInputService").TouchEnabled then
	PlatformService_upvr = "Mobile"
else
	PlatformService_upvr = "PC"
end
local tbl_upvr_4 = {}
for _, v in ReplicatedStorage.Modules.PetServices.AnimationEvents:GetDescendants() do
	if v:IsA("ModuleScript") then
		tbl_upvr_4[v.Name] = require(v)
	end
end
local PetList_upvr = require(ReplicatedStorage.Data.PetRegistry).PetList
local ActivePetService_upvr = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("ActivePetService")
local any_new_result1_upvr = require(ReplicatedStorage.Modules.ReplicationClass).new("ActivePetsService_Replicator")
any_new_result1_upvr.DontStager = true
local function _() -- Line 99, Named "GetReplicatedData"
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	return any_new_result1_upvr:YieldUntilData().Table
end
local module_upvr = {}
local tbl_upvr_6 = {}
module_upvr.ClientPetState = tbl_upvr_6
local tbl_upvr_2 = {}
module_upvr.ClientServerPetState = tbl_upvr_2
local function _(arg1) -- Line 113, Named "GetClientServerPetState"
	--[[ Upvalues[1]:
		[1]: tbl_upvr_2 (readonly)
	]]
	return tbl_upvr_2[arg1]
end
local function _(arg1) -- Line 118, Named "GetServerPetFromReplicated"
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local ServerPetStates_2 = any_new_result1_upvr:YieldUntilData().Table.ServerPetStates
	if not ServerPetStates_2 then
		return nil
	end
	return ServerPetStates_2[arg1]
end
local function _(arg1) -- Line 126, Named "GetServerPetDataFromReplicated"
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local ServerPetData_2 = any_new_result1_upvr:YieldUntilData().Table.ServerPetData
	if not ServerPetData_2 then
		return nil
	end
	return ServerPetData_2[arg1]
end
local function _(arg1, arg2) -- Line 133, Named "WeldInPlace"
	if not arg1 or not arg2 then return end
	local Weld = Instance.new("Weld")
	Weld.Part0 = arg1
	Weld.Part1 = arg2
	Weld.Name = "Weld"
	Weld.Parent = arg2
	Weld.Name = `{arg1.Name}_{arg2.Name}_WELD`
	return Weld
end
local function GetClientPetState(arg1) -- Line 150
	--[[ Upvalues[1]:
		[1]: tbl_upvr_6 (readonly)
	]]
	local var35 = tbl_upvr_6[arg1]
	if not var35 then
		var35 = {}
		tbl_upvr_6[arg1] = var35
	end
	return var35
end
local function _(arg1) -- Line 161, Named "GetChubbyChipmunkScale"
	return (math.clamp(arg1, 1, 50) - 1) * 0.20408163265306123 + 1
end
local function _(arg1) -- Line 168, Named "GetClampedLevel"
	return math.min(arg1.Level or 1, 100)
end
local function RemoveServerPet_upvr(arg1) -- Line 173, Named "RemoveServerPet"
	--[[ Upvalues[2]:
		[1]: tbl_upvr_2 (readonly)
		[2]: tbl_upvr_4 (readonly)
	]]
	local var36 = tbl_upvr_2[arg1]
	if not var36 then
	else
		if var36.PetSoundHandler then
			var36.PetSoundHandler:destroy()
		end
		if var36.Asset then
			var36.Asset:Destroy()
		end
		if var36.Model then
			var36.Model:Destroy()
		end
		local CurrentAnimation_5 = var36.CurrentAnimation
		if CurrentAnimation_5 then
			local var38 = tbl_upvr_4[CurrentAnimation_5.Name]
			if var38 and var38.AnimationEnded then
				var38.AnimationEnded(arg1)
			end
			CurrentAnimation_5:Stop()
		end
		tbl_upvr_2[arg1] = nil
	end
end
local function CreateServerPet_upvr(arg1) -- Line 208, Named "CreateServerPet"
	--[[ Upvalues[10]:
		[1]: any_new_result1_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
		[3]: PetsPhysical_upvr (readonly)
		[4]: PetList_upvr (readonly)
		[5]: SkinService_upvr (readonly)
		[6]: LocalPlayer_upvr (readonly)
		[7]: PlatformService_upvr (readonly)
		[8]: PetSoundHandler_upvr (readonly)
		[9]: PetVFXHandler_upvr (readonly)
		[10]: RemoveServerPet_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 67 start (CF ANALYSIS FAILED)
	local ServerPetStates = any_new_result1_upvr:YieldUntilData().Table.ServerPetStates
	local var48
	if not ServerPetStates then
		var48 = nil
	else
		var48 = ServerPetStates[arg1]
	end
	local ServerPetData_3 = any_new_result1_upvr:YieldUntilData().Table.ServerPetData
	if not ServerPetData_3 then
		-- KONSTANTWARNING: GOTO [24] #19
	end
	-- KONSTANTERROR: [0] 1. Error Block 67 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [23] 18. Error Block 73 start (CF ANALYSIS FAILED)
	local var50 = ServerPetData_3[arg1]
	if not var48 or not var50 then
		return nil
	end
	if tbl_upvr_2[arg1] then
		return tbl_upvr_2[arg1]
	end
	local SOME = PetsPhysical_upvr:WaitForChild(arg1, 2)
	if not SOME then
		return nil
	end
	local PetType_2 = var50.PetType
	local var53 = PetList_upvr[PetType_2]
	if not var53 then
		warn("Server pet type not found:", PetType_2)
		return nil
	end
	local Part = Instance.new("Part")
	Part.Size = Vector3.new(2, 2, 2)
	Part.Transparency = 1
	Part.Material = Enum.Material.Neon
	Part.Color = Color3.fromRGB(255, 14, 243)
	Part.Anchored = true
	Part.CanQuery = false
	Part.CanTouch = false
	Part:AddTag("PetTargetable")
	Part:AddTag("ServerPet")
	Part:SetAttribute("UUID", arg1)
	Part:SetAttribute("IsServerOwned", true)
	Part.Name = "ServerPetMover"
	Part.CanCollide = false
	local PetData = var50.PetData
	local CurrentCFrame_4 = var48.CurrentCFrame
	if not CurrentCFrame_4 then
		CurrentCFrame_4 = CFrame.new(0, 5, 0)
	end
	Part:PivotTo(CurrentCFrame_4)
	local module = {
		Asset = Part;
		LoadedAnimations = {};
		IsServerOwned = true;
		PetType = PetType_2;
	}
	tbl_upvr_2[arg1] = module
	local Variant_2 = var53.Variant
	if Variant_2 then
		SkinService_upvr:SetSkin(SOME, Variant_2)
	end
	if LocalPlayer_upvr:GetAttribute("PetScaling") == false then
		SOME:ScaleTo(1)
	else
		SOME:ScaleTo(math.max(0.1, (PetData.BaseWeight or 1) + var53.ModelScalePerLevel * (PetData.Level or 1)))
	end
	SOME:AddTag("PetModel")
	SOME:AddTag("ServerPetModel")
	if not SOME.PrimaryPart then
		warn(SOME, "Server pet missing PrimaryPart")
		Part:Destroy()
		tbl_upvr_2[arg1] = nil
		return nil
	end
	local PrimaryPart = SOME.PrimaryPart
	if not PrimaryPart or not Part then
		local _
	else
		local Weld_3 = Instance.new("Weld")
		Weld_3.Part0 = PrimaryPart
		Weld_3.Part1 = Part
		Weld_3.Name = "Weld"
		Weld_3.Parent = Part
		Weld_3.Name = `{PrimaryPart.Name}_{Part.Name}_WELD`
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	Weld_3.C1 *= var53.WeldOffset
	module.Model = SOME
	local var63_upvr = SOME:FindFirstChild("AnimationController")
	if var63_upvr then
		var63_upvr = SOME:FindFirstChild("AnimationController"):FindFirstChild("Animator")
	end
	if var63_upvr then
		local tbl_upvr = {}
		module.LoadedAnimations = tbl_upvr
		for i_2_upvr, v_2_upvr in var53.Animations do
			task.spawn(function() -- Line 300
				--[[ Upvalues[4]:
					[1]: var63_upvr (readonly)
					[2]: v_2_upvr (readonly)
					[3]: tbl_upvr (readonly)
					[4]: i_2_upvr (readonly)
				]]
				local any_LoadAnimation_result1_2 = var63_upvr:LoadAnimation(v_2_upvr)
				any_LoadAnimation_result1_2.Looped = true
				tbl_upvr[i_2_upvr] = any_LoadAnimation_result1_2
				if i_2_upvr == "Idle" then
					any_LoadAnimation_result1_2:Play()
				end
			end)
			local _
		end
	end
	if PlatformService_upvr == "PC" then
		module.PetSoundHandler = PetSoundHandler_upvr.new(PetType_2, SOME, arg1)
	end
	module.PetVFXHandler = PetVFXHandler_upvr.new(PetType_2, SOME, arg1)
	SOME.PrimaryPart.Anchored = false
	SOME.Parent = Part
	Part.Parent = PetsPhysical_upvr
	SOME.Destroying:Once(function() -- Line 322
		--[[ Upvalues[2]:
			[1]: RemoveServerPet_upvr (copied, readonly)
			[2]: arg1 (readonly)
		]]
		RemoveServerPet_upvr(arg1)
	end)
	do
		return module
	end
	-- KONSTANTERROR: [23] 18. Error Block 73 end (CF ANALYSIS FAILED)
end
local function CreatePetWithScale_upvr(arg1, arg2, arg3) -- Line 329, Named "CreatePetWithScale"
	--[[ Upvalues[14]:
		[1]: tbl_upvr_6 (readonly)
		[2]: any_new_result1_upvr (readonly)
		[3]: PetList_upvr (readonly)
		[4]: PetsPhysical_upvr (readonly)
		[5]: SkinService_upvr (readonly)
		[6]: module_upvr (readonly)
		[7]: Players_upvr (readonly)
		[8]: PetUtilities_upvr (readonly)
		[9]: var14_upvw (read and write)
		[10]: TwoPointCast_upvr (readonly)
		[11]: RaycastParams_new_result1_upvr_2 (readonly)
		[12]: PlatformService_upvr (readonly)
		[13]: PetSoundHandler_upvr (readonly)
		[14]: PetVFXHandler_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var77 = tbl_upvr_6[arg1]
	if not var77 then
		var77 = {}
		tbl_upvr_6[arg1] = var77
	end
	local var78 = var77
	if not var78 then
		local tonumber_result1 = tonumber(arg1)
		local var80 = tbl_upvr_6[tonumber_result1]
		if not var80 then
			var80 = {}
			tbl_upvr_6[tonumber_result1] = var80
		end
		var78 = var80
	end
	local var81 = var78[arg2]
	local PlayerPetData = any_new_result1_upvr:YieldUntilData().Table.PlayerPetData
	local var83 = PlayerPetData[arg1]
	if not var83 then
		var83 = PlayerPetData[tonumber(arg1)]
	end
	local var84 = var83.PetInventory.Data[arg2]
	local var85 = PetList_upvr[var84.PetType]
	if var85 then
	end
	local Asset_2_upvr = var81.Asset
	if not Asset_2_upvr then return end
	local Model_3 = var81.Model
	if Model_3 then
		Model_3:Destroy()
	end
	local SOME_4 = PetsPhysical_upvr:WaitForChild(arg2)
	if not SOME_4 then return end
	local var89_upvw = SOME_4
	local Variant = var85.Variant
	if Variant then
		SkinService_upvr:SetSkin(var89_upvw, Variant)
	end
	local PetType_3 = var84.PetType
	if PetType_3 == "Chubby Chipmunk" then
	else
	end
	if Players_upvr.LocalPlayer:GetAttribute("PetScaling") == false then
		var89_upvw:ScaleTo(1)
	else
		var89_upvw:ScaleTo(math.max(0.1, arg3) * (module_upvr:CalculateBoost(Players_upvr:FindFirstChild(arg1), arg2, "SIZE_MODIFICATION") or 1))
	end
	if not var14_upvw then
		local TwoPointCast_upvr_result1_2 = TwoPointCast_upvr(Asset_2_upvr.Position + Vector3.new(0, 1, 0), Asset_2_upvr.Position - Vector3.new(0, 1, 0), RaycastParams_new_result1_upvr_2)
		if not TwoPointCast_upvr_result1_2 or not TwoPointCast_upvr_result1_2.Position.Y then
		end
	end
	local const_number_upvw = 0
	local function SetPivotToBoundsOffset_upvr() -- Line 398, Named "SetPivotToBoundsOffset"
		--[[ Upvalues[3]:
			[1]: var89_upvw (read and write)
			[2]: Asset_2_upvr (readonly)
			[3]: const_number_upvw (read and write)
		]]
		if not var89_upvw or not Asset_2_upvr then
		else
			local any_GetBoundingBox_result1, any_GetBoundingBox_result2 = var89_upvw:GetBoundingBox()
			var89_upvw:PivotTo(Asset_2_upvr.CFrame * CFrame.new(0, const_number_upvw + any_GetBoundingBox_result2.Y / 2 + (any_GetBoundingBox_result1.Position - var89_upvw:GetPivot().Position).Y, 0))
		end
	end
	SetPivotToBoundsOffset_upvr()
	var89_upvw:AddTag("PetModel")
	if PlatformService_upvr == "PC" then
	end
	var81.PetSoundHandler = PetSoundHandler_upvr.new(PetType_3, var89_upvw, arg2)
	var81.PetVFXHandler = PetVFXHandler_upvr.new(PetType_3, var89_upvw, arg2)
	if not var89_upvw.PrimaryPart then
		warn(var89_upvw, "DOES NOT HAVE A PRIMARY_PART??")
		return
	end
	local PrimaryPart_2 = var89_upvw.PrimaryPart
	if not PrimaryPart_2 or not Asset_2_upvr then
		local _
	else
		local Weld_2 = Instance.new("Weld")
		Weld_2.Part0 = PrimaryPart_2
		Weld_2.Part1 = Asset_2_upvr
		Weld_2.Name = "Weld"
		Weld_2.Parent = Asset_2_upvr
		Weld_2.Name = `{PrimaryPart_2.Name}_{Asset_2_upvr.Name}_WELD`
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	Weld_2.C1 *= var85.WeldOffset
	var81.Model = var89_upvw
	local var100_upvr = var89_upvw:FindFirstChild("AnimationController")
	if var100_upvr then
		var100_upvr = var89_upvw:FindFirstChild("AnimationController"):FindFirstChild("Animator")
	end
	if var100_upvr then
		local tbl_upvr_3 = {}
		var81.LoadedAnimations = tbl_upvr_3
		for i_3_upvr, v_3_upvr in var85.Animations do
			task.spawn(function() -- Line 436
				--[[ Upvalues[5]:
					[1]: var100_upvr (readonly)
					[2]: v_3_upvr (readonly)
					[3]: tbl_upvr_3 (readonly)
					[4]: i_3_upvr (readonly)
					[5]: SetPivotToBoundsOffset_upvr (readonly)
				]]
				local any_LoadAnimation_result1 = var100_upvr:LoadAnimation(v_3_upvr)
				any_LoadAnimation_result1.Looped = true
				tbl_upvr_3[i_3_upvr] = any_LoadAnimation_result1
				if i_3_upvr == "Idle" then
					any_LoadAnimation_result1:Play()
				end
				task.defer(SetPivotToBoundsOffset_upvr)
			end)
			local _
		end
	end
	return var89_upvw
end
local function RemovePet_upvr(arg1, arg2) -- Line 453, Named "RemovePet"
	--[[ Upvalues[2]:
		[1]: tbl_upvr_6 (readonly)
		[2]: tbl_upvr_4 (readonly)
	]]
	local var105 = tbl_upvr_6[arg1]
	if not var105 then
		var105 = {}
		tbl_upvr_6[arg1] = var105
	end
	local var106 = var105
	local var107 = var106[arg2]
	if var107 then
		if var107.PetSoundHandler then
			var107.PetSoundHandler:destroy()
		end
		var107.Asset:Destroy()
		local Model = var107.Model
		if Model then
			Model:Destroy()
		end
	end
	local CurrentAnimation_2 = var107.CurrentAnimation
	local var110
	if CurrentAnimation_2 then
		var110 = tbl_upvr_4
		local var111 = var110[CurrentAnimation_2.Name]
		var110 = var111
		if var110 then
			var110 = var111.AnimationEnded
		end
		if var110 then
			var110(arg2)
		end
		CurrentAnimation_2:Stop()
	end
	var106[arg2] = nil
end
local GetFarm_upvr = require(ReplicatedStorage.Modules.GetFarm)
local function GetPet_upvr(arg1, arg2) -- Line 487, Named "GetPet"
	--[[ Upvalues[13]:
		[1]: tbl_upvr_6 (readonly)
		[2]: Players_upvr (readonly)
		[3]: GetFarm_upvr (readonly)
		[4]: PetsPhysical_upvr (readonly)
		[5]: any_new_result1_upvr (readonly)
		[6]: PetList_upvr (readonly)
		[7]: PetUtilities_upvr (readonly)
		[8]: LocalPlayer_upvr (readonly)
		[9]: var14_upvw (read and write)
		[10]: TwoPointCast_upvr (readonly)
		[11]: RaycastParams_new_result1_upvr_2 (readonly)
		[12]: CreatePetWithScale_upvr (readonly)
		[13]: RemovePet_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local tostring_result1_upvw = tostring(arg1)
	local var114 = tostring_result1_upvw
	local var115 = tbl_upvr_6[var114]
	if not var115 then
		var115 = {}
		tbl_upvr_6[var114] = var115
	end
	local var116 = var115
	if not var116 then
		local tonumber_result1_2 = tonumber(tostring_result1_upvw)
		local var118 = tbl_upvr_6[tonumber_result1_2]
		if not var118 then
			var118 = {}
			tbl_upvr_6[tonumber_result1_2] = var118
		end
		var116 = var118
	end
	local var119 = var116[arg2]
	local SOME_3 = Players_upvr:FindFirstChild(tostring_result1_upvw)
	if not SOME_3 then return end
	local GetFarm_upvr_result1 = GetFarm_upvr(SOME_3)
	if not GetFarm_upvr_result1 then
		do
			return
		end
		local var122
	end
	if not var119 then
		local SOME_2 = PetsPhysical_upvr:WaitForChild(arg2, 2)
		if not SOME_2 then
			return nil
		end
		local Part_2 = Instance.new("Part")
		Part_2.Size = Vector3.new(2, 2, 2)
		Part_2.Transparency = 1
		Part_2.Material = Enum.Material.Neon
		Part_2.Color = Color3.fromRGB(15, 119, 255)
		Part_2.Anchored = true
		Part_2.CanQuery = false
		Part_2:AddTag("PetTargetable")
		Part_2:SetAttribute("UUID", arg2)
		Part_2:SetAttribute("OWNER", tostring(tostring_result1_upvw))
		Part_2.Name = "PetMover"
		Part_2.CanCollide = false
		local Table_3 = any_new_result1_upvr:YieldUntilData().Table
		local PlayerPetData_2 = Table_3.PlayerPetData
		local ActivePetStates_3 = Table_3.ActivePetStates
		local var128 = PlayerPetData_2[tostring_result1_upvw]
		if not var128 then
			var128 = PlayerPetData_2[tonumber(tostring_result1_upvw)]
		end
		if not var128 then return end
		local PetInventory = var128.PetInventory
		if not PetInventory then return end
		local var130 = PetInventory.Data[arg2]
		if not var130 then return end
		local PetType_5 = var130.PetType
		local var132 = PetList_upvr[PetType_5]
		if var132 then
		end
		if PlayerPetData_2.PetType == "Chubby Chipmunk" then
			local any_CalculateWeight_result1 = PetUtilities_upvr:CalculateWeight(PlayerPetData_2.PetData.BaseWeight, PlayerPetData_2.PetData.Level, PlayerPetData_2.PetType)
			if any_CalculateWeight_result1 < 2 then
			elseif any_CalculateWeight_result1 < 15 then
			elseif any_CalculateWeight_result1 < 30 then
			elseif any_CalculateWeight_result1 < 40 then
			else
			end
		end
		if not var132 then
			warn(PetType_5, "does not have foundpettypedata")
			return
		end
		local var134 = var130.PetData.BaseWeight + var132.ModelScalePerLevel * var130.PetData.Level
		local var135 = ActivePetStates_3[tostring_result1_upvw]
		if not var135 then
			var135 = ActivePetStates_3[tonumber(tostring_result1_upvw)]
		end
		local var136 = var135[arg2]
		if not var136 then return end
		if LocalPlayer_upvr:GetAttribute("PetScaling") == false then
			var122 = 1
		else
			var122 = var134
		end
		local var137 = 0
		if not var14_upvw then
			local var9_result1 = TwoPointCast_upvr(Part_2.Position + Vector3.new(0, 2, 0), Part_2.Position - Vector3.new(0, 2, 0), RaycastParams_new_result1_upvr_2)
			local var139 = var9_result1
			if var139 then
				var139 = var9_result1.Position.Y
			end
			var137 = var139
		end
		local var140 = (var137 or 0) + (var132.YHeightScaler or 0) * var122
		if var132.MovementType ~= "Grounded" or not CFrame.new(var136.CurrentCFrame.X, var140, var136.CurrentCFrame.Z) then
			if not var136.CurrentCFrame then
			end
		end
		Part_2:PivotTo(GetFarm_upvr_result1:FindFirstChild("PetArea").CFrame)
		var116[arg2] = {
			Asset = Part_2;
			LoadedAnimations = {};
		}
		local CreatePetWithScale_upvr_result1 = CreatePetWithScale_upvr(tostring_result1_upvw, arg2, var134)
		if not CreatePetWithScale_upvr_result1 then
			Part_2:Destroy()
			var116[arg2] = nil
			return nil
		end
		SOME_2:PivotTo(CreatePetWithScale_upvr_result1:GetPivot() * CFrame.new(0, var140 + CreatePetWithScale_upvr_result1:GetExtentsSize().Y, 0))
		SOME_2.PrimaryPart.Anchored = false
		SOME_2.Parent = Part_2
		Part_2.Parent = PetsPhysical_upvr
		SOME_2.Destroying:Once(function() -- Line 628
			--[[ Upvalues[3]:
				[1]: RemovePet_upvr (copied, readonly)
				[2]: tostring_result1_upvw (read and write)
				[3]: arg2 (readonly)
			]]
			RemovePet_upvr(tostring_result1_upvw, arg2)
		end)
	end
	return var119
end
local function _(arg1) -- Line 636, Named "RemoveClientPetState"
	--[[ Upvalues[2]:
		[1]: tbl_upvr_6 (readonly)
		[2]: RemovePet_upvr (readonly)
	]]
	local var146 = tbl_upvr_6[arg1]
	if not var146 then
		var146 = {}
		tbl_upvr_6[arg1] = var146
	end
	local var147 = var146
	if var147 then
		for i_4 in var147 do
			RemovePet_upvr(arg1, i_4)
		end
	end
	tbl_upvr_6[arg1] = nil
end
local function UpdateServerPetsRegistry_upvr() -- Line 648, Named "UpdateServerPetsRegistry"
	--[[ Upvalues[4]:
		[1]: any_new_result1_upvr (readonly)
		[2]: tbl_upvr_2 (readonly)
		[3]: RemoveServerPet_upvr (readonly)
		[4]: CreateServerPet_upvr (readonly)
	]]
	local var152
	if not var152 then
		var152 = {}
	end
	for i_5 in tbl_upvr_2 do
		if not var152[i_5] then
			RemoveServerPet_upvr(i_5)
		end
	end
	for i_6 in var152 do
		if not tbl_upvr_2[i_6] then
			CreateServerPet_upvr(i_6)
		end
	end
end
local function UpdateRegistry_upvr() -- Line 667, Named "UpdateRegistry"
	--[[ Upvalues[8]:
		[1]: any_new_result1_upvr (readonly)
		[2]: tbl_upvr_6 (readonly)
		[3]: RemovePet_upvr (readonly)
		[4]: var13_upvr (readonly)
		[5]: LocalPlayer_upvr (readonly)
		[6]: PetsPhysical_upvr (readonly)
		[7]: GetPet_upvr (readonly)
		[8]: UpdateServerPetsRegistry_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local ActivePetStates = any_new_result1_upvr:YieldUntilData().Table.ActivePetStates
	local var162
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [13.5]
	var162 = tostring(nil)
	local var163 = var162
	var162 = ActivePetStates[var163]
	if not var162 then
		var162 = ActivePetStates[tonumber(var163)]
	end
	if not var162 then
		local var164 = var163
		local var165 = tbl_upvr_6[var164]
		if not var165 then
			var165 = {}
			tbl_upvr_6[var164] = var165
		end
		local var166 = var165
		if var166 then
			for i_7 in var166 do
				RemovePet_upvr(var164, i_7)
				local var167
			end
		end
		tbl_upvr_6[var167] = nil
		-- KONSTANTWARNING: GOTO [12] #10
	end
	for _ in var167, var166, tbl_upvr_6 do
		if not i_7 then
		end
		-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect (x3)
end
local function _(arg1, arg2, arg3, arg4) -- Line 715, Named "GetPredictedPosition"
	local var168 = (arg2 - arg1).Magnitude / arg4
	local var169 = os.clock() - arg3
	if var168 <= var169 then
		return arg2
	end
	return arg1:Lerp(arg2, var169 / var168)
end
local var170_upvw = 0
local tbl_upvr_5 = {}
local tbl_upvr_7 = {}
local function UpdatePositioning_upvr(arg1) -- Line 730, Named "UpdatePositioning"
	--[[ Upvalues[18]:
		[1]: var170_upvw (read and write)
		[2]: tbl_upvr_5 (readonly)
		[3]: tbl_upvr_7 (readonly)
		[4]: any_new_result1_upvr (readonly)
		[5]: tbl_upvr_6 (readonly)
		[6]: var13_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
		[8]: PetList_upvr (readonly)
		[9]: PetUtilities_upvr (readonly)
		[10]: module_upvr (readonly)
		[11]: Players_upvr (readonly)
		[12]: var14_upvw (read and write)
		[13]: TwoPointCast_upvr (readonly)
		[14]: RaycastParams_new_result1_upvr_2 (readonly)
		[15]: PlatformService_upvr (readonly)
		[16]: tbl_upvr_4 (readonly)
		[17]: tbl_upvr_2 (readonly)
		[18]: RaycastParams_new_result1_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	var170_upvw = 0
	table.clear(tbl_upvr_5)
	table.clear(tbl_upvr_7)
	local Table_2 = any_new_result1_upvr:YieldUntilData().Table
	local ActivePetStates_4 = Table_2.ActivePetStates
	local PlayerPetData_5 = Table_2.PlayerPetData
	local var304
	if not var304 then
		var304 = {}
	end
	if not Table_2.ServerPetData then
	end
	for i_9, v_4 in tbl_upvr_6 do
		local var305
		local function INLINED_4() -- Internal function, doesn't exist in bytecode
			var305 = LocalPlayer_upvr.Name
			return i_9 == var305
		end
		if not var305 or INLINED_4() then
			var305 = tostring(i_9)
			i_9 = var305
			var305 = ActivePetStates_4[i_9]
			if not var305 then
				var305 = ActivePetStates_4[tonumber(i_9)]
				local var306 = var305
			end
			if var306 then
				for i_10, v_5 in v_4 do
					local var307 = var306[i_10]
					if var307 then
						local Asset_5 = v_5.Asset
						local CurrentCFrame_2 = var307.CurrentCFrame
						if CurrentCFrame_2 then
							local LastUpdatedPosition_2 = tbl_upvr_6.LastUpdatedPosition
							if not LastUpdatedPosition_2 then
								LastUpdatedPosition_2 = CurrentCFrame_2.Position
							end
							local var311
							if (LastUpdatedPosition_2 - Asset_5.Position).Magnitude > 2 or v_5.IsNotFirstTime then
								v_5.LastUpdatedPosition = Asset_5.Position
								v_5.IsNotFirstTime = true
								local class_Model = Asset_5:FindFirstChildWhichIsA("Model", true)
								var311 = PlayerPetData_5[i_9]
								if not var311 then
									var311 = PlayerPetData_5[tonumber(i_9)]
									local var313
								end
								if var311 then
									local var314 = var311.PetInventory.Data[i_10]
									var313 = class_Model
									if var313 then
										var313 = class_Model.PrimaryPart
									end
									if var313 then
									end
									if not var313 then return end
									if not var314 then return end
									local PetType = var314.PetType
									local var316 = PetList_upvr[PetType]
									local MovementType_3 = var316.MovementType
									local any_Lerp_result1_6 = Asset_5.Position:Lerp(CurrentCFrame_2.Position, math.clamp(var307.MovementSpeed * arg1 / (CurrentCFrame_2.Position - Asset_5.Position).Magnitude, 0, 1))
									local var319
									if PetType == "Chubby Chipmunk" then
										var319 = (math.clamp(PetUtilities_upvr:CalculateWeight(var314.PetData.BaseWeight or 1, math.min(var314.PetData.Level or 1, 100)), 1, 50) - 1) * 0.20408163265306123 + 1
									else
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										var319 = var314.PetData.BaseWeight + var316.ModelScalePerLevel * PetUtilities_upvr:CalculateWeight(var314.PetData.BaseWeight or 1, math.min(var314.PetData.Level or 1, 100))
									end
									local var320 = var319 * (module_upvr:CalculateBoost(Players_upvr:FindFirstChild(i_9), i_10, "SIZE_MODIFICATION") or 1)
									local PetScaling_2 = LocalPlayer_upvr:GetAttribute("PetScaling")
									if PetScaling_2 == false then
									else
									end
									if PetScaling_2 == false then
										if v_5.LastScale ~= 1 then
											class_Model:ScaleTo(1)
											v_5.LastScale = 1
											-- KONSTANTWARNING: GOTO [251] #184
										end
									else
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										if v_5.LastScale ~= var320 then
											class_Model:ScaleTo(math.max(0.01, var320))
											v_5.LastScale = var320
										end
									end
									local var322 = 0
									if not var14_upvw then
										local TwoPointCast_upvr_result1 = TwoPointCast_upvr(Asset_5.Position + Vector3.new(0, 2, 0), Asset_5.Position - Vector3.new(0, 2, 0), RaycastParams_new_result1_upvr_2)
										local var324 = TwoPointCast_upvr_result1
										if var324 then
											var324 = TwoPointCast_upvr_result1.Position.Y
										end
										var322 = var324
									end
									local var325 = var322 or 0
									v_5.LastYHeight = math.lerp(v_5.LastYHeight or var325, var325, 5 * arg1)
									if MovementType_3 == "Grounded" then
									else
									end
									local Position_4 = var313.Position
									local Position = CurrentCFrame_2.Position
									if MovementType_3 == "Grounded" then
										if (Vector2.new(Position_4.X, Position_4.Z) - Vector2.new(Position.X, Position.Z)).Magnitude > 2.5 then
										else
										end
									end
									local var329 = false
									if MovementType_3 == "Flight" then
										if (Position_4 - Position).Magnitude > 1 then
											var329 = false
										else
											var329 = true
										end
									end
									if not var307.CustomAnimationState then
										if var329 or true then
											local _ = "Idle"
										else
										end
									end
									if not v_5.LastAnimationState or v_5.LastAnimationState ~= "Walk" then
										if PlatformService_upvr == "PC" and v_5.PetSoundHandler then
											-- KONSTANTERROR: Expression was reused, decompilation is incorrect
											v_5.PetSoundHandler:playSound("Walk")
										end
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										v_5.PetVFXHandler:playVFX("Walk")
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										v_5.LastAnimationState = "Walk"
									end
									local LoadedAnimations_2 = v_5.LoadedAnimations
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									local Walk_4 = LoadedAnimations_2.Walk
									local CurrentAnimation_3 = v_5.CurrentAnimation
									if CurrentAnimation_3 ~= Walk_4 and Walk_4 then
										local var334
										for i_11, v_6 in LoadedAnimations_2, var334 do
											v_6:Stop()
										end
										if CurrentAnimation_3 then
											var334 = tbl_upvr_4
											local var335 = var334[CurrentAnimation_3.Name]
											var334 = var335
											local var336 = var334
											if var336 then
												var336 = var335.AnimationEnded
											end
											if var336 then
												i_11 = i_10
												var336(i_11)
											end
											CurrentAnimation_3:Stop()
										end
										v_5.CurrentAnimation = Walk_4
										local var337
										if Walk_4 then
											var337 = tbl_upvr_4
											local var338 = var337[Walk_4.Name]
											var337 = var338
											if var337 then
												var337 = var338.AnimationStarted
											end
											if var337 then
												i_11 = i_10
												var337(i_11)
											end
											Walk_4:Play()
										end
									end
									local var339
									if v_5.LastTargetCFrame ~= CurrentCFrame_2 or not v_5.LastAngles then
										local function INLINED_5() -- Internal function, doesn't exist in bytecode
											i_11 = CurrentCFrame_2.Position
											return PetUtilities_upvr:GetLookAt(Asset_5.Position, i_11)
										end
										if MovementType_3 ~= "Grounded" or not INLINED_5() then
										end
										local any_ToEulerAnglesXYZ_result1, any_ToEulerAnglesXYZ_result2_3, any_ToEulerAnglesXYZ_result3 = CFrame.new(Asset_5.Position, CurrentCFrame_2.Position):ToEulerAnglesXYZ()
										if any_ToEulerAnglesXYZ_result1 ~= any_ToEulerAnglesXYZ_result1 or any_ToEulerAnglesXYZ_result2_3 ~= any_ToEulerAnglesXYZ_result2_3 or any_ToEulerAnglesXYZ_result3 ~= any_ToEulerAnglesXYZ_result3 then
											any_ToEulerAnglesXYZ_result1 = 0
											any_ToEulerAnglesXYZ_result3 = 0
										end
										local cframe_3 = CFrame.Angles(any_ToEulerAnglesXYZ_result1, 0, 0)
										local any_Lerp_result1_4 = v_5.LastAngles or cframe_3:Lerp(cframe_3, 6 * arg1)
										var170_upvw += 1
										tbl_upvr_7[var170_upvw] = Asset_5
										tbl_upvr_5[var170_upvw] = CFrame.new(any_Lerp_result1_6) * any_Lerp_result1_4
										v_5.LastAngles = any_Lerp_result1_4
									else
										var170_upvw += 1
										tbl_upvr_7[var170_upvw] = Asset_5
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										tbl_upvr_5[var170_upvw] = CFrame.new(any_Lerp_result1_6) * v_5.LastAngles
									end
								end
							end
						end
					end
				end
			end
		end
	end
	for i_12, v_7 in tbl_upvr_2 do
		var306 = var304[i_12]
		local var345 = var306
		if var345 then
			local var346 = ({})[i_12]
			if var346 then
				local Asset = v_7.Asset
				if Asset then
					local CurrentCFrame_3 = var345.CurrentCFrame
					if CurrentCFrame_3 then
						i_10 = var346.PetType
						v_5 = PetList_upvr[i_10]
						local var349
						if v_5 then
							local Model_2 = v_7.Model
							var349 = Model_2
							if var349 then
								var349 = Model_2.PrimaryPart
							end
							if var349 then
								local MovementType_2 = v_5.MovementType
								local Magnitude_2 = (CurrentCFrame_3.Position - Asset.Position).Magnitude
								local var353
								if Magnitude_2 < 0.1 then
									var170_upvw += 1
									tbl_upvr_7[var170_upvw] = Asset
									tbl_upvr_5[var170_upvw] = Asset.CFrame
								else
									var311 = 1
									var311 = CurrentCFrame_3.Position
									var353 = math.clamp((var345.MovementSpeed or 10) * arg1 / Magnitude_2, 0, var311)
									local any_Lerp_result1_3 = Asset.Position:Lerp(var311, var353)
									var311 = any_Lerp_result1_3.X
									var353 = 500
									var311 = workspace:Raycast(Vector3.new(var311, var353, any_Lerp_result1_3.Z), Vector3.new(0, -1000, 0), RaycastParams_new_result1_upvr)
									var353 = v_7.LastYHeight
									if not var353 then
										var353 = Asset.Position.Y
									end
									if var311 then
										var353 = var311.Position.Y
									end
									v_7.LastYHeight = math.lerp(v_7.LastYHeight or var353, var353, 5 * arg1)
									if MovementType_2 == "Grounded" then
									else
									end
									if Magnitude_2 > 2.5 then
									else
									end
									if true then
										local _ = "Idle"
									else
									end
									if v_7.LastAnimationState ~= "Walk" then
										if PlatformService_upvr == "PC" and v_7.PetSoundHandler then
											-- KONSTANTERROR: Expression was reused, decompilation is incorrect
											v_7.PetSoundHandler:playSound("Walk")
										end
										if v_7.PetVFXHandler then
											-- KONSTANTERROR: Expression was reused, decompilation is incorrect
											v_7.PetVFXHandler:playVFX("Walk")
										end
										-- KONSTANTERROR: Expression was reused, decompilation is incorrect
										v_7.LastAnimationState = "Walk"
									end
									-- KONSTANTERROR: Expression was reused, decompilation is incorrect
									local Walk_2 = v_7.LoadedAnimations.Walk
									local CurrentAnimation_4 = v_7.CurrentAnimation
									local var359
									if CurrentAnimation_4 ~= Walk_2 and Walk_2 then
										if CurrentAnimation_4 then
											var359 = CurrentAnimation_4:Stop
											var359()
										end
										v_7.CurrentAnimation = Walk_2
										var359 = Walk_2:Play
										var359()
									end
									local function INLINED_6() -- Internal function, doesn't exist in bytecode
										var359 = PetUtilities_upvr:GetLookAt(Asset.Position, CurrentCFrame_3.Position)
										return var359
									end
									if MovementType_2 ~= "Grounded" or not INLINED_6() then
										var359 = CFrame.new(Asset.Position, CurrentCFrame_3.Position)
									end
									local any_ToEulerAnglesXYZ_result1_3, any_ToEulerAnglesXYZ_result2_4, any_ToEulerAnglesXYZ_result3_2 = var359:ToEulerAnglesXYZ()
									if any_ToEulerAnglesXYZ_result1_3 ~= any_ToEulerAnglesXYZ_result1_3 then
										any_ToEulerAnglesXYZ_result1_3 = 0
									end
									if any_ToEulerAnglesXYZ_result2_4 ~= any_ToEulerAnglesXYZ_result2_4 then
									end
									if any_ToEulerAnglesXYZ_result3_2 ~= any_ToEulerAnglesXYZ_result3_2 then
									end
									local cframe = CFrame.Angles(any_ToEulerAnglesXYZ_result1_3, 0, 0)
									local any_Lerp_result1_2 = v_7.LastAngles or cframe:Lerp(cframe, 6 * arg1)
									v_7.LastAngles = any_Lerp_result1_2
									var170_upvw += 1
									tbl_upvr_7[var170_upvw] = Asset
									tbl_upvr_5[var170_upvw] = CFrame.new(any_Lerp_result1_3) * any_Lerp_result1_2
								end
							end
						end
					end
				end
			end
		end
	end
	workspace:BulkMoveTo(tbl_upvr_7, tbl_upvr_5, Enum.BulkMoveMode.FireCFrameChanged)
end
task.spawn(function() -- Line 1082
	--[[ Upvalues[2]:
		[1]: PlatformService_upvr (readonly)
		[2]: UpdatePositioning_upvr (readonly)
	]]
	while true do
		local var366
		if PlatformService_upvr == "Mobile" then
			var366 = 0.025
		else
			var366 = 0.015
		end
		var366 = task.spawn
		local task_wait_result1_upvr = task.wait(var366)
		var366(function() -- Line 1087
			--[[ Upvalues[2]:
				[1]: UpdatePositioning_upvr (copied, readonly)
				[2]: task_wait_result1_upvr (readonly)
			]]
			UpdatePositioning_upvr(task_wait_result1_upvr)
		end)
	end
end)
function module_upvr.GetServerState(arg1, arg2, arg3) -- Line 1093
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local ActivePetStates_2 = any_new_result1_upvr:YieldUntilData().Table.ActivePetStates
	local var370 = ActivePetStates_2[arg2]
	if not var370 then
		var370 = ActivePetStates_2[tonumber(arg2)]
	end
	if not var370 then return end
	return var370[arg3]
end
function module_upvr.GetPlayerDatastorePetData(arg1, arg2) -- Line 1106
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local PlayerPetData_6 = any_new_result1_upvr:YieldUntilData().Table.PlayerPetData
	local var372 = PlayerPetData_6[arg2]
	if not var372 then
		var372 = PlayerPetData_6[tonumber(arg2)]
	end
	if not var372 then return end
	return var372
end
function module_upvr.GetPetData(arg1, arg2, arg3) -- Line 1117
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local PlayerPetData_3 = any_new_result1_upvr:YieldUntilData().Table.PlayerPetData
	local var374 = PlayerPetData_3[arg2]
	if not var374 then
		var374 = PlayerPetData_3[tonumber(arg2)]
	end
	if not var374 then return end
	return var374.PetInventory.Data[arg3]
end
function module_upvr.GetPetDataFromPetObject(arg1, arg2) -- Line 1132
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	if not arg2 then return end
	return module_upvr:GetPetData(arg2:GetAttribute("OWNER"), arg2:GetAttribute("UUID"))
end
function module_upvr.SetPetState(arg1, arg2, arg3, arg4) -- Line 1141
	--[[ Upvalues[1]:
		[1]: ActivePetService_upvr (readonly)
	]]
	ActivePetService_upvr:FireServer("SetPetState", arg2, arg3, arg4)
end
function module_upvr.GetClientPetState(arg1, arg2) -- Line 1145
	--[[ Upvalues[1]:
		[1]: tbl_upvr_6 (readonly)
	]]
	local var375 = tbl_upvr_6[arg2]
	if not var375 then
		var375 = {}
		tbl_upvr_6[arg2] = var375
	end
	return var375
end
function module_upvr.CalculateBoost(arg1, arg2, arg3, arg4) -- Line 1149
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: PetMutationRegistry_upvr (readonly)
	]]
	if not arg2 then
		return 1
	end
	local any_GetPetData_result1 = module_upvr:GetPetData(arg2.Name, arg3)
	if not any_GetPetData_result1 then
		return 1
	end
	local MutationType = any_GetPetData_result1.PetData.MutationType
	local var386 = 1
	if MutationType then
		for _, v_8 in PetMutationRegistry_upvr.PetMutationRegistry[PetMutationRegistry_upvr.EnumToPetMutation[MutationType]].Boosts do
			if v_8.BoostType == arg4 then
				var386 += v_8.BoostAmount
			end
		end
	end
	local Boosts_2 = any_GetPetData_result1.PetData.Boosts
	if not Boosts_2 then
		return var386
	end
	for _, v_9 in Boosts_2 do
		if v_9.BoostType == arg4 then
			-- KONSTANTERROR: Expression was reused, decompilation is incorrect
			var386 += v_9.BoostAmount
		end
	end
	return var386
end
function module_upvr.GetBoostsOfType(arg1, arg2, arg3, arg4) -- Line 1190
	--[[ Upvalues[2]:
		[1]: module_upvr (readonly)
		[2]: PetMutationRegistry_upvr (readonly)
	]]
	local any_GetPetData_result1_2 = module_upvr:GetPetData(arg2.Name, arg3)
	if not any_GetPetData_result1_2 then return end
	local Boosts = any_GetPetData_result1_2.PetData.Boosts
	if not Boosts then return end
	for i_15, v_10 in Boosts do
		if v_10.BoostType == arg4 then
			table.insert({}, v_10)
		end
	end
	local MutationType_2 = any_GetPetData_result1_2.PetData.MutationType
	if MutationType_2 then
		i_15 = PetMutationRegistry_upvr
		v_10 = PetMutationRegistry_upvr
		i_15 = v_10.PetMutationRegistry
		i_15 = i_15[i_15.EnumToPetMutation[MutationType_2]].Boosts
		v_10 = nil
		for _, v_11 in i_15, v_10 do
			if v_11.BoostType == arg4 then
				-- KONSTANTERROR: Expression was reused, decompilation is incorrect
				table.insert({}, v_11)
			end
		end
	end
	-- KONSTANTERROR: Expression was reused, decompilation is incorrect
	return {}
end
function module_upvr.GetClientPetStateUUID(arg1, arg2, arg3) -- Line 1232
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	local any_GetClientPetState_result1 = module_upvr:GetClientPetState(arg2)
	if not any_GetClientPetState_result1 then
		any_GetClientPetState_result1 = module_upvr:GetClientPetState(tonumber(arg2))
	end
	if not any_GetClientPetState_result1 then return end
	return any_GetClientPetState_result1[arg3]
end
Players_upvr.PlayerRemoving:Connect(function(arg1) -- Line 1241
	--[[ Upvalues[2]:
		[1]: tbl_upvr_6 (readonly)
		[2]: RemovePet_upvr (readonly)
	]]
	local var399 = tbl_upvr_6[arg1]
	if not var399 then
		var399 = {}
		tbl_upvr_6[arg1] = var399
	end
	local var400 = var399
	if var400 then
		for i_17 in var400 do
			RemovePet_upvr(arg1, i_17)
		end
	end
	tbl_upvr_6[arg1] = nil
end)
function module_upvr.Feed(arg1, arg2) -- Line 1245
	--[[ Upvalues[2]:
		[1]: tbl_upvr_2 (readonly)
		[2]: ActivePetService_upvr (readonly)
	]]
	local var401 = tbl_upvr_2[arg2]
	if var401 and var401.IsServerOwned then
		ActivePetService_upvr:FireServer("FeedServerPet", arg2)
	else
		ActivePetService_upvr:FireServer("Feed", arg2)
	end
end
function module_upvr.GetServerPetData(arg1, arg2) -- Line 1259
	--[[ Upvalues[1]:
		[1]: any_new_result1_upvr (readonly)
	]]
	local ServerPetData = any_new_result1_upvr:YieldUntilData().Table.ServerPetData
	if not ServerPetData then
		return nil
	end
	return ServerPetData[arg2]
end
task.delay(2, function() -- Line 1271
	--[[ Upvalues[2]:
		[1]: UpdateRegistry_upvr (readonly)
		[2]: any_new_result1_upvr (readonly)
	]]
	UpdateRegistry_upvr()
	any_new_result1_upvr:GetPathSignal("ActivePetStates/@"):Connect(function(...) -- Line 1273
		--[[ Upvalues[1]:
			[1]: UpdateRegistry_upvr (copied, readonly)
		]]
		UpdateRegistry_upvr()
	end)
end)
UpdateRegistry_upvr()
task.spawn(function() -- Line 1282
	--[[ Upvalues[1]:
		[1]: UpdateRegistry_upvr (readonly)
	]]
	while true do
		task.wait(2)
		UpdateRegistry_upvr()
	end
end)
LocalPlayer_upvr:GetAttributeChangedSignal("KeepPetOnGround"):Connect(function() -- Line 1297
	--[[ Upvalues[2]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: var14_upvw (read and write)
	]]
	var14_upvw = LocalPlayer_upvr:GetAttribute("KeepPetOnGround")
end)
return module_upvr
