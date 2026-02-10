-- game:GetService("Players").LocalPlayer.PlayerScripts.Shovel_Client
-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:29:02
-- Luau version 6, Types version 3
-- Time taken: 0.018226 seconds

local UserInputService_upvr = game:GetService("UserInputService")
local CollectionService_upvr = game:GetService("CollectionService")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService_upvr = game:GetService("RunService")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local GetFarm_upvr = require(ReplicatedStorage.Modules.GetFarm)
local Item_Module_upvr = require(ReplicatedStorage.Item_Module)
local LocalPlayer_upvr = game.Players.LocalPlayer
local tbl_2_upvr = {
	Instance = nil;
	IsPlaceableObject = false;
}
local tbl_upvr = {"Carrot", "Strawberry", "Blueberry", "Orange Tulip", "Buttercup", "Tomato", "Corn", "Daffodil", "Apple", "Chocolate Carrot", "Red Lollipop", "Blue Lollipop", "Nightshade", "Glowshroom", "Mint", "Rose", "Foxglove", "Crocus", "Delphinium", "Manuka Flower", "Lavender", "Nectarshade", "Peace Lily", "Wild Carrot", "Pear", "Horsetail", "Monoblooma", "Dezen", "Artichoke", "Spring Onion", "Turnip", "Parsley", "Bloodred Mushroom", "Orange Delight", "Horned Redrose", "Peppermint Pop"}
local tbl_3_upvr = {"Carrot", "Christmas Tree"}
local function CheckIfValuable_upvr(arg1) -- Line 99, Named "CheckIfValuable"
	--[[ Upvalues[2]:
		[1]: Item_Module_upvr (readonly)
		[2]: tbl_upvr (readonly)
	]]
	local Name_2 = arg1.Name
	math.randomseed(arg1.Item_Seed.Value)
	math.random(700, 1400)
	if math.random(1, Item_Module_upvr.Return_Data(Name_2)[4]) == 1 then
		return true
	end
	if arg1.Variant.Value ~= "Normal" then
		return true
	end
	for _, v in tbl_upvr do
		if string.lower(Name_2) == string.lower(v) then
			return false
		end
	end
	return true
end
local function CheckIfCantShovel_upvr(arg1) -- Line 125, Named "CheckIfCantShovel"
	--[[ Upvalues[1]:
		[1]: tbl_3_upvr (readonly)
	]]
	for _, v_2 in tbl_3_upvr do
		if string.lower(arg1) == string.lower(v_2) then
			return true
		end
	end
	if string.find(string.lower(arg1), "sprinkler") then
		return true
	end
	return false
end
local var17_upvw
local function _(arg1) -- Line 143, Named "StartRainbowTween"
	--[[ Upvalues[2]:
		[1]: var17_upvw (read and write)
		[2]: RunService_upvr (readonly)
	]]
	if var17_upvw then
		var17_upvw:Disconnect()
	end
	local var19_upvw = 0
	local any_gsub_result1_upvr_2 = arg1.Text:gsub("<.->", "")
	var17_upvw = RunService_upvr.RenderStepped:Connect(function(arg1_2) -- Line 149
		--[[ Upvalues[3]:
			[1]: var19_upvw (read and write)
			[2]: arg1 (readonly)
			[3]: any_gsub_result1_upvr_2 (readonly)
		]]
		var19_upvw = (var19_upvw + arg1_2 * 0.2) % 1
		local Color3_fromHSV_result1 = Color3.fromHSV(var19_upvw, 1, 1)
		arg1.Text = string.format("<font color=\"#%s\">%s</font>", string.format("%02X%02X%02X", Color3_fromHSV_result1.R * 255, Color3_fromHSV_result1.G * 255, Color3_fromHSV_result1.B * 255), any_gsub_result1_upvr_2)
	end)
end
local function _() -- Line 157, Named "StopRainbowTween"
	--[[ Upvalues[1]:
		[1]: var17_upvw (read and write)
	]]
	if var17_upvw then
		var17_upvw:Disconnect()
		var17_upvw = nil
	end
end
local function _(arg1) -- Line 165, Named "StartTranscendentTween"
	--[[ Upvalues[2]:
		[1]: var17_upvw (read and write)
		[2]: RunService_upvr (readonly)
	]]
	if var17_upvw then
		var17_upvw:Disconnect()
	end
	local any_gsub_result1_upvr = arg1.Text:gsub("<.->", "")
	var17_upvw = RunService_upvr.RenderStepped:Connect(function() -- Line 170
		--[[ Upvalues[2]:
			[1]: arg1 (readonly)
			[2]: any_gsub_result1_upvr (readonly)
		]]
		local Color3_fromHSV_result1_2 = Color3.fromHSV(math.sin(tick() * 1.5) * 0.03 + 0.72, 1, 1)
		arg1.Text = string.format("<font color=\"#%s\">%s</font>", string.format("%02X%02X%02X", Color3_fromHSV_result1_2.R * 255, Color3_fromHSV_result1_2.G * 255, Color3_fromHSV_result1_2.B * 255), any_gsub_result1_upvr)
	end)
end
local CurrentCamera_upvr = workspace.CurrentCamera
local function RaycastToPosition_upvr(arg1) -- Line 209, Named "RaycastToPosition"
	--[[ Upvalues[2]:
		[1]: CurrentCamera_upvr (readonly)
		[2]: CollectionService_upvr (readonly)
	]]
	local any_ViewportPointToRay_result1 = CurrentCamera_upvr:ViewportPointToRay(arg1.X, arg1.Y)
	local RaycastParams_new_result1 = RaycastParams.new()
	RaycastParams_new_result1.FilterType = Enum.RaycastFilterType.Exclude
	RaycastParams_new_result1.FilterDescendantsInstances = {CollectionService_upvr:GetTagged("ShovelIgnore")}
	return workspace:Raycast(any_ViewportPointToRay_result1.Origin, any_ViewportPointToRay_result1.Direction * 500, RaycastParams_new_result1)
end
local Highlight_upvr = script.Highlight
local TweenService_upvr = game:GetService("TweenService")
RunService_upvr.RenderStepped:Connect(function() -- Line 218
	--[[ Upvalues[7]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: UserInputService_upvr (readonly)
		[3]: RaycastToPosition_upvr (readonly)
		[4]: Highlight_upvr (readonly)
		[5]: GetFarm_upvr (readonly)
		[6]: CollectionService_upvr (readonly)
		[7]: TweenService_upvr (readonly)
	]]
	if LocalPlayer_upvr and LocalPlayer_upvr.Character and LocalPlayer_upvr.Character:FindFirstChild("Shovel [Destroy Plants]") then
		local RaycastToPosition_upvr_result1_2 = RaycastToPosition_upvr(UserInputService_upvr:GetMouseLocation())
		if not RaycastToPosition_upvr_result1_2 then
			Highlight_upvr.Adornee = nil
		else
			local var6_result1 = GetFarm_upvr(LocalPlayer_upvr)
			if not var6_result1 or not RaycastToPosition_upvr_result1_2.Instance:IsDescendantOf(var6_result1) then return end
			local class_Model = RaycastToPosition_upvr_result1_2.Instance:FindFirstAncestorWhichIsA("Model")
			if class_Model and (CollectionService_upvr:HasTag(class_Model, "Growable") or CollectionService_upvr:HasTag(class_Model, "PlaceableObject")) then
				if Highlight_upvr.Adornee ~= class_Model then
					Highlight_upvr.FillTransparency = 1
					TweenService_upvr:Create(Highlight_upvr, TweenInfo.new(0.25), {
						FillTransparency = 0.65;
					}):Play()
				end
				Highlight_upvr.Adornee = class_Model
				return
			end
			Highlight_upvr.Adornee = nil
		end
	end
	Highlight_upvr.Adornee = nil
end)
local Notification_upvr = require(ReplicatedStorage.Modules.Notification)
local DeleteObject_upvr = GameEvents:WaitForChild("DeleteObject")
local ConfirmationPromptController_upvr = require(ReplicatedStorage.Modules.ConfirmationPromptController)
local SeedData_upvr = require(ReplicatedStorage.Data.SeedData)
local Remove_Item_upvr = GameEvents:WaitForChild("Remove_Item")
local function handleShovelInput_upvr(arg1, arg2) -- Line 246, Named "handleShovelInput"
	--[[ Upvalues[14]:
		[1]: LocalPlayer_upvr (readonly)
		[2]: RaycastToPosition_upvr (readonly)
		[3]: GetFarm_upvr (readonly)
		[4]: CollectionService_upvr (readonly)
		[5]: CheckIfCantShovel_upvr (readonly)
		[6]: Notification_upvr (readonly)
		[7]: var17_upvw (read and write)
		[8]: tbl_2_upvr (readonly)
		[9]: DeleteObject_upvr (readonly)
		[10]: ConfirmationPromptController_upvr (readonly)
		[11]: CheckIfValuable_upvr (readonly)
		[12]: SeedData_upvr (readonly)
		[13]: Item_Module_upvr (readonly)
		[14]: Remove_Item_upvr (readonly)
	]]
	if arg2 then
	else
		if not LocalPlayer_upvr.Character or not LocalPlayer_upvr.Character:FindFirstChild("Shovel [Destroy Plants]") then return end
		local RaycastToPosition_upvr_result1 = RaycastToPosition_upvr(arg1)
		if not RaycastToPosition_upvr_result1 then return end
		local class_Model_2 = RaycastToPosition_upvr_result1.Instance:FindFirstAncestorWhichIsA("Model")
		if not class_Model_2 then return end
		local GetFarm_upvr_result1 = GetFarm_upvr(LocalPlayer_upvr)
		if not GetFarm_upvr_result1 or not RaycastToPosition_upvr_result1.Instance:IsDescendantOf(GetFarm_upvr_result1) then return end
		if CollectionService_upvr:HasTag(class_Model_2, "PlaceableObject") then
			local Name = class_Model_2.Name
			print("TargetModel.Name:", Name)
			if CheckIfCantShovel_upvr(Name) then
				Notification_upvr:CreateNotification(`You cannot shovel {Name}!`)
			else
				if var17_upvw then
					var17_upvw:Disconnect()
					var17_upvw = nil
				end
				tbl_2_upvr.Instance = class_Model_2
				tbl_2_upvr.IsPlaceableObject = true
				local tbl = {
					ConfirmEvent = DeleteObject_upvr;
					ConfirmEventData = {tbl_2_upvr.Instance};
				}
				local function ConfirmCallback() -- Line 294
					--[[ Upvalues[2]:
						[1]: tbl_2_upvr (copied, readonly)
						[2]: var17_upvw (copied, read and write)
					]]
					tbl_2_upvr.Instance = nil
					tbl_2_upvr.IsPlaceableObject = false
					if var17_upvw then
						var17_upvw:Disconnect()
						var17_upvw = nil
					end
				end
				tbl.ConfirmCallback = ConfirmCallback
				ConfirmationPromptController_upvr:Open({
					Title = "Shovelling...";
					Header = "Are you sure you want to shovel that?";
					Middle = `{Name}`;
					Footer = "";
				}, tbl)
			end
		end
		if not class_Model_2:FindFirstChild("Grow") then return end
		if class_Model_2:GetAttribute("Favorited") then
			Notification_upvr:CreateNotification("This plant is favorited!")
			return
		end
		local Fruits = class_Model_2:FindFirstChild("Fruits")
		if Fruits then
			for _, v_3 in Fruits:GetChildren() do
				if v_3:GetAttribute("Favorited") then
					Notification_upvr:CreateNotification("This plant has favorited fruit!")
					return
				end
			end
		end
		local Name_3 = class_Model_2.Name
		if CheckIfCantShovel_upvr(Name_3) then
			Notification_upvr:CreateNotification(`You cannot shovel {Name_3}!`)
			return
		end
		local var57
		if CheckIfValuable_upvr(class_Model_2) then
			var57 = SeedData_upvr
			local var58 = var57[Name_3]
			local function INLINED() -- Internal function, doesn't exist in bytecode
				var57 = Item_Module_upvr.Return_Rarity_Data(var58.SeedRarity)
				return var57
			end
			if not var58 or not INLINED() then
				var57 = nil
			end
			if not var57 or not string.format("#%02X%02X%02X", var57[2].R * 255, var57[2].G * 255, var57[2].B * 255) then
			end
			tbl_2_upvr.Instance = RaycastToPosition_upvr_result1.Instance
			tbl_2_upvr.IsPlaceableObject = false
			warn(class_Model_2, class_Model_2:GetFullName(), tbl_2_upvr)
			ConfirmationPromptController_upvr:Open({
				Title = "Shovelling...";
				Header = "Are you sure you want to shovel that?";
				Middle = `{Name_3}`;
				Footer = "are considered valuable and removing this cannot be undone.";
			}, {
				ConfirmEvent = Remove_Item_upvr;
				ConfirmEventData = {class_Model_2};
				ConfirmCallback = function() -- Line 363, Named "ConfirmCallback"
					--[[ Upvalues[2]:
						[1]: tbl_2_upvr (copied, readonly)
						[2]: var17_upvw (copied, read and write)
					]]
					print("Call back")
					tbl_2_upvr.Instance = nil
					tbl_2_upvr.IsPlaceableObject = false
					if var17_upvw then
						var17_upvw:Disconnect()
						var17_upvw = nil
					end
				end;
			})
			return
		end
		Remove_Item_upvr:FireServer(RaycastToPosition_upvr_result1.Instance)
	end
end
local var62_upvw
local function updateInput() -- Line 379
	--[[ Upvalues[4]:
		[1]: var62_upvw (read and write)
		[2]: UserInputService_upvr (readonly)
		[3]: handleShovelInput_upvr (readonly)
		[4]: LocalPlayer_upvr (readonly)
	]]
	if var62_upvw then
		var62_upvw:Disconnect()
	end
	if UserInputService_upvr:GetLastInputType() == Enum.UserInputType.Touch then
		var62_upvw = UserInputService_upvr.TouchTapInWorld:Connect(handleShovelInput_upvr)
	else
		var62_upvw = LocalPlayer_upvr:GetMouse().Button1Down:Connect(function() -- Line 388
			--[[ Upvalues[2]:
				[1]: handleShovelInput_upvr (copied, readonly)
				[2]: UserInputService_upvr (copied, readonly)
			]]
			handleShovelInput_upvr(UserInputService_upvr:GetMouseLocation(), false)
		end)
	end
end
UserInputService_upvr.LastInputTypeChanged:Connect(updateInput)
task.spawn(updateInput)
