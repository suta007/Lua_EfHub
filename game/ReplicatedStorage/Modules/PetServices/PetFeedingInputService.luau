-- game:GetService("ReplicatedStorage").Modules.PetServices.PetFeedingInputService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:47:56
-- Luau version 6, Types version 3
-- Time taken: 0.014415 seconds

local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local Character_upvr = LocalPlayer_upvr.Character
if not Character_upvr then
	Character_upvr = LocalPlayer_upvr.CharacterAdded:Wait()
end
local ActivePetsService_upvr = require(ReplicatedStorage_upvr.Modules.PetServices.ActivePetsService)
local InventoryServiceEnums_upvr = require(ReplicatedStorage_upvr.Data.EnumRegistry.InventoryServiceEnums)
local var6_upvw
local var7_upvw
local var8_upvw
local var9_upvw
local function SetUpProxPrompt_upvr() -- Line 32, Named "SetUpProxPrompt"
	--[[ Upvalues[4]:
		[1]: var8_upvw (read and write)
		[2]: var9_upvw (read and write)
		[3]: var6_upvw (read and write)
		[4]: ActivePetsService_upvr (readonly)
	]]
	var8_upvw = Instance.new("Part")
	var8_upvw.Name = "FeedPetProxPart"
	var8_upvw.CanCollide = false
	var8_upvw.CanQuery = false
	var8_upvw.Anchored = true
	var8_upvw.Transparency = 1
	var8_upvw.Parent = workspace
	var9_upvw = Instance.new("ProximityPrompt")
	var9_upvw.Name = "FEED_PET_PROX"
	var9_upvw.Exclusivity = Enum.ProximityPromptExclusivity.AlwaysShow
	var9_upvw.KeyboardKeyCode = Enum.KeyCode.F
	var9_upvw.RequiresLineOfSight = false
	var9_upvw.HoldDuration = 0.5
	var9_upvw.MaxActivationDistance = math.huge
	var9_upvw.Parent = var8_upvw
	var9_upvw.Style = Enum.ProximityPromptStyle.Custom
	var9_upvw:SetAttribute("Theme", "ShadowedPrompt")
	var9_upvw.Triggered:Connect(function() -- Line 52
		--[[ Upvalues[2]:
			[1]: var6_upvw (copied, read and write)
			[2]: ActivePetsService_upvr (copied, readonly)
		]]
		if not var6_upvw then
		else
			ActivePetsService_upvr:Feed(var6_upvw)
		end
	end)
end
local function _() -- Line 61, Named "ResetProximityPrompt"
	--[[ Upvalues[3]:
		[1]: var9_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var8_upvw (read and write)
	]]
	var9_upvw.Enabled = false
	if var7_upvw and var7_upvw.PlaybackState == Enum.PlaybackState.Playing then
		var7_upvw.Completed:Wait()
	end
	var8_upvw.CFrame = CFrame.new(100, 5000, 100)
end
local MINIMUM_DISTANCE_FOR_FEEDING_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry).PetConfig.PET_FEEDING_CONFIG.MINIMUM_DISTANCE_FOR_FEEDING
local function GetClosestPetModel_upvr() -- Line 70, Named "GetClosestPetModel"
	--[[ Upvalues[4]:
		[1]: ActivePetsService_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: Character_upvr (readonly)
		[4]: MINIMUM_DISTANCE_FOR_FEEDING_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var51
	for _, v in ActivePetsService_upvr:GetClientPetState(LocalPlayer_upvr.Name), nil do
		local Asset_4 = v.Asset
		if Asset_4 then
			local class_Model = Asset_4:FindFirstChildWhichIsA("Model", true)
			if class_Model then
				local Magnitude_4 = (class_Model:GetPivot().Position - Character_upvr:GetPivot().Position).Magnitude
				if var51 > Magnitude_4 and MINIMUM_DISTANCE_FOR_FEEDING_upvr > Magnitude_4 then
					var51 = Magnitude_4
				end
			end
		end
	end
	for i_2, v_2 in ActivePetsService_upvr.ClientServerPetState do
		local Asset_3 = v_2.Asset
		if Asset_3 then
			local class_Model_3 = Asset_3:FindFirstChildWhichIsA("Model", true)
			if class_Model_3 then
				local Magnitude_3 = (class_Model_3:GetPivot().Position - Character_upvr:GetPivot().Position).Magnitude
				if var51 > Magnitude_3 and MINIMUM_DISTANCE_FOR_FEEDING_upvr > Magnitude_3 then
					var51 = Magnitude_3
				end
			end
		end
	end
	return i_2, class_Model_3
end
local function _(arg1) -- Line 111, Named "CurrentToolMatchID"
	--[[ Upvalues[2]:
		[1]: Character_upvr (readonly)
		[2]: InventoryServiceEnums_upvr (readonly)
	]]
	local class_Tool = Character_upvr:FindFirstChildWhichIsA("Tool")
	if not class_Tool then
		return false
	end
	if class_Tool:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID) ~= arg1 then
		return false
	end
	return true
end
local PetUtilities_upvr = require(ReplicatedStorage_upvr.Modules.PetServices.PetUtilities)
local FoodService_upvr = require(ReplicatedStorage_upvr.Modules.FoodService)
local TweenService_upvr = game:GetService("TweenService")
local TweenInfo_new_result1_upvr = TweenInfo.new(0.1, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, 0)
local DecimalNumberFormat_upvr = require(ReplicatedStorage_upvr.Data.DecimalNumberFormat)
local function OnToolEquip_upvr(arg1, arg2) -- Line 126, Named "OnToolEquip"
	--[[ Upvalues[15]:
		[1]: Character_upvr (readonly)
		[2]: InventoryServiceEnums_upvr (readonly)
		[3]: GetClosestPetModel_upvr (readonly)
		[4]: var9_upvw (read and write)
		[5]: var7_upvw (read and write)
		[6]: var8_upvw (read and write)
		[7]: ActivePetsService_upvr (readonly)
		[8]: LocalPlayer_upvr (readonly)
		[9]: var6_upvw (read and write)
		[10]: PetUtilities_upvr (readonly)
		[11]: ReplicatedStorage_upvr (readonly)
		[12]: FoodService_upvr (readonly)
		[13]: TweenService_upvr (readonly)
		[14]: TweenInfo_new_result1_upvr (readonly)
		[15]: DecimalNumberFormat_upvr (readonly)
	]]
	-- KONSTANTERROR: [241] 183. Error Block 45 start (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [241] 183. Error Block 45 end (CF ANALYSIS FAILED)
	-- KONSTANTERROR: [0] 1. Error Block 80 start (CF ANALYSIS FAILED)
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [241.3]
	if not nil then
	else
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [241.4]
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [241.197371]
		if nil ~= arg2 then
		else
		end
	end
	-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [241.2]
	-- KONSTANTERROR: [0] 1. Error Block 80 end (CF ANALYSIS FAILED)
end
local tbl_upvr = {}
local function WatchForToolEquip_upvr(arg1) -- Line 204, Named "WatchForToolEquip"
	--[[ Upvalues[6]:
		[1]: var9_upvw (read and write)
		[2]: var7_upvw (read and write)
		[3]: var8_upvw (read and write)
		[4]: InventoryServiceEnums_upvr (readonly)
		[5]: tbl_upvr (readonly)
		[6]: OnToolEquip_upvr (readonly)
	]]
	local function preConnections_upvr(arg1_2) -- Line 205, Named "preConnections"
		--[[ Upvalues[6]:
			[1]: var9_upvw (copied, read and write)
			[2]: var7_upvw (copied, read and write)
			[3]: var8_upvw (copied, read and write)
			[4]: InventoryServiceEnums_upvr (copied, readonly)
			[5]: tbl_upvr (copied, readonly)
			[6]: OnToolEquip_upvr (copied, readonly)
		]]
		if not arg1_2:HasTag("FruitTool") and not arg1_2:HasTag("FoodTool") then
			var9_upvw.Enabled = false
			if var7_upvw and var7_upvw.PlaybackState == Enum.PlaybackState.Playing then
				var7_upvw.Completed:Wait()
			end
			var8_upvw.CFrame = CFrame.new(100, 5000, 100)
		else
			local attribute_upvr = arg1_2:GetAttribute(InventoryServiceEnums_upvr.ITEM_UUID)
			if tbl_upvr[attribute_upvr] then return end
			local any_Connect_result1_upvw_2 = arg1_2.Equipped:Connect(function() -- Line 218
				--[[ Upvalues[3]:
					[1]: OnToolEquip_upvr (copied, readonly)
					[2]: arg1_2 (readonly)
					[3]: attribute_upvr (readonly)
				]]
				task.spawn(OnToolEquip_upvr, arg1_2, attribute_upvr)
			end)
			local any_Connect_result1_upvw = arg1_2.Unequipped:Connect(function() -- Line 223
				--[[ Upvalues[3]:
					[1]: var9_upvw (copied, read and write)
					[2]: var7_upvw (copied, read and write)
					[3]: var8_upvw (copied, read and write)
				]]
				var9_upvw.Enabled = false
				if var7_upvw and var7_upvw.PlaybackState == Enum.PlaybackState.Playing then
					var7_upvw.Completed:Wait()
				end
				var8_upvw.CFrame = CFrame.new(100, 5000, 100)
			end)
			tbl_upvr[attribute_upvr] = {any_Connect_result1_upvw_2, any_Connect_result1_upvw}
			arg1_2.Destroying:Once(function() -- Line 232
				--[[ Upvalues[7]:
					[1]: tbl_upvr (copied, readonly)
					[2]: attribute_upvr (readonly)
					[3]: any_Connect_result1_upvw_2 (read and write)
					[4]: any_Connect_result1_upvw (read and write)
					[5]: var9_upvw (copied, read and write)
					[6]: var7_upvw (copied, read and write)
					[7]: var8_upvw (copied, read and write)
				]]
				tbl_upvr[attribute_upvr] = nil
				any_Connect_result1_upvw_2:Disconnect()
				any_Connect_result1_upvw:Disconnect()
				var9_upvw.Enabled = false
				if var7_upvw and var7_upvw.PlaybackState == Enum.PlaybackState.Playing then
					var7_upvw.Completed:Wait()
				end
				var8_upvw.CFrame = CFrame.new(100, 5000, 100)
			end)
		end
	end
	for _, v_3 in arg1:GetChildren() do
		if v_3:IsA("Tool") then
			preConnections_upvr(v_3)
		end
	end
	arg1.ChildAdded:Connect(function(arg1_3) -- Line 248
		--[[ Upvalues[1]:
			[1]: preConnections_upvr (readonly)
		]]
		if arg1_3:IsA("Tool") then
			preConnections_upvr(arg1_3)
		end
	end)
end
task.spawn(function() -- Line 255
	--[[ Upvalues[6]:
		[1]: SetUpProxPrompt_upvr (readonly)
		[2]: var9_upvw (read and write)
		[3]: var7_upvw (read and write)
		[4]: var8_upvw (read and write)
		[5]: WatchForToolEquip_upvr (readonly)
		[6]: Character_upvr (readonly)
	]]
	SetUpProxPrompt_upvr()
	var9_upvw.Enabled = false
	if var7_upvw and var7_upvw.PlaybackState == Enum.PlaybackState.Playing then
		var7_upvw.Completed:Wait()
	end
	var8_upvw.CFrame = CFrame.new(100, 5000, 100)
	WatchForToolEquip_upvr(Character_upvr)
end)
return {}
