-- game:GetService("ReplicatedStorage").Modules.PetAgeBreakUIController

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 22:31:47
-- Luau version 6, Types version 3
-- Time taken: 0.029597 seconds

local LocalPlayer_upvr = game:GetService("Players").LocalPlayer
local ReplicatedStorage_upvr = game:GetService("ReplicatedStorage")
local PetUtilities_upvr = require(ReplicatedStorage_upvr.Modules.PetServices.PetUtilities)
local DataService_upvr = require(ReplicatedStorage_upvr.Modules.DataService)
local GuiController_upvr = require(ReplicatedStorage_upvr.Modules.GuiController)
local NumberUtil_upvr = require(ReplicatedStorage_upvr.Modules.NumberUtil)
local CountDictionary_upvr = require(ReplicatedStorage_upvr.Modules.CountDictionary)
local PetAgeBreakMachineData_upvr = require(ReplicatedStorage_upvr.Data.PetAgeBreakMachineData)
local PetsService_upvr = require(ReplicatedStorage_upvr.Modules.PetServices.PetsService)
local PetList_upvr = require(ReplicatedStorage_upvr.Data.PetRegistry).PetList
local GameEvents = ReplicatedStorage_upvr:WaitForChild("GameEvents")
local PetAgeBreak_UI_upvr = LocalPlayer_upvr:WaitForChild("PlayerGui"):WaitForChild("PetAgeBreak_UI")
local Main_upvr = PetAgeBreak_UI_upvr:WaitForChild("Main")
local Details_upvr = Main_upvr:WaitForChild("Details")
local module_upvr = {}
local tbl_upvw = {}
local tbl_upvw_2 = {}
local var18_upvw
local tbl_upvr = {}
local var20_upvw
local TweenService_upvr = game:GetService("TweenService")
local function TweenDetails_upvr(arg1) -- Line 50, Named "TweenDetails"
	--[[ Upvalues[2]:
		[1]: TweenService_upvr (readonly)
		[2]: Details_upvr (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local tbl = {}
	local var23
	local function INLINED() -- Internal function, doesn't exist in bytecode
		var23 = UDim2.new(0.8, 0, 0.5, 0)
		return var23
	end
	if not arg1 or not INLINED() then
		var23 = UDim2.new(0.6, 0, 0.5, 0)
	end
	tbl.Position = var23
	var23 = {}
	if arg1 then
	else
	end
	var23.Scale = 0.1
	local TweenInfo_new_result1 = TweenInfo.new(0.25, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)
	TweenService_upvr:Create(Details_upvr, TweenInfo_new_result1, tbl):Play()
	local class_UIScale = Details_upvr:FindFirstChildWhichIsA("UIScale")
	if class_UIScale then
		TweenService_upvr:Create(class_UIScale, TweenInfo_new_result1, var23):Play()
	end
end
local function RefreshToolCache_upvr() -- Line 60, Named "RefreshToolCache"
	--[[ Upvalues[2]:
		[1]: var18_upvw (read and write)
		[2]: LocalPlayer_upvr (readonly)
	]]
	var18_upvw = {}
	for _, v in LocalPlayer_upvr.Backpack:GetChildren() do
		local PET_UUID_2 = v:GetAttribute("PET_UUID")
		if PET_UUID_2 then
			var18_upvw[PET_UUID_2] = v
		end
	end
	for _, v_2 in LocalPlayer_upvr.Character:GetChildren() do
		local PET_UUID_3 = v_2:GetAttribute("PET_UUID")
		if PET_UUID_3 then
			var18_upvw[PET_UUID_3] = v_2
		end
	end
end
local function _(arg1) -- Line 72, Named "GetToolFromUUID"
	--[[ Upvalues[2]:
		[1]: var18_upvw (read and write)
		[2]: RefreshToolCache_upvr (readonly)
	]]
	if not var18_upvw then
		RefreshToolCache_upvr()
	end
	return var18_upvw[arg1]
end
local function UpdateDetails_upvr(arg1) -- Line 78, Named "UpdateDetails"
	--[[ Upvalues[3]:
		[1]: PetList_upvr (readonly)
		[2]: PetUtilities_upvr (readonly)
		[3]: Details_upvr (readonly)
	]]
	local var38 = PetList_upvr[arg1.PetType]
	local PetData = arg1.PetData
	local Level = PetData.Level
	Details_upvr.Holder.Header.PET_TEXT.Text = arg1.PetType or "Unknown"
	Details_upvr.Holder.Display.Display.PET_NAME_CONFIG.Text = PetData.Name or "Unnamed"
	Details_upvr.Holder.Display.Display.PET_IMAGE.Image = var38.Icon or ""
	Details_upvr.Holder.Description.Display.PET_DESCRIPTION.Text = var38.Description or "No description available."
	Details_upvr.Holder.Stats.Holder.Weight.PET_WEIGHT.Text = `Weight: {math.round(PetUtilities_upvr:CalculateWeight(PetData.BaseWeight, Level) * 100) / 100} KG`
	Details_upvr.Holder.Stats.Holder.Age.PET_AGE.Text = `Age: {Level}`
end
local function SetSelectedStyle_upvr(arg1, arg2) -- Line 92, Named "SetSelectedStyle"
	if not arg1:FindFirstChild("Display") then
	else
		if arg2 then
			arg1.Display.BackgroundColor3 = Color3.fromRGB(30, 100, 14)
			arg1.Display.UIStroke.Color = Color3.fromRGB(37, 238, 38)
			arg1.Display.SELECTED_VIGNETTE.Visible = true
			return
		end
		arg1.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18)
		arg1.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0)
		arg1.Display.SELECTED_VIGNETTE.Visible = false
	end
end
function module_upvr.UpdatePetCard(arg1, arg2, arg3) -- Line 109
	--[[ Upvalues[11]:
		[1]: Main_upvr (readonly)
		[2]: tbl_upvr (readonly)
		[3]: var20_upvw (read and write)
		[4]: SetSelectedStyle_upvr (readonly)
		[5]: var18_upvw (read and write)
		[6]: module_upvr (readonly)
		[7]: tbl_upvw_2 (read and write)
		[8]: tbl_upvw (read and write)
		[9]: TweenDetails_upvr (readonly)
		[10]: UpdateDetails_upvr (readonly)
		[11]: CountDictionary_upvr (readonly)
	]]
	local SellFrame = Main_upvr.Main.Holder.SellFrame
	if arg3.PetData.IsFavorite then
		SellFrame = true
	else
		SellFrame = false
	end
	arg2.Favorite.Visible = SellFrame
	if tbl_upvr[arg2.Name] ~= nil then
		tbl_upvr[arg2.Name]:Disconnect()
		tbl_upvr[arg2.Name] = nil
	end
	tbl_upvr[arg2.Name] = arg2.MouseButton1Click:Connect(function() -- Line 119
		--[[ Upvalues[12]:
			[1]: var20_upvw (copied, read and write)
			[2]: arg3 (readonly)
			[3]: SetSelectedStyle_upvr (copied, readonly)
			[4]: arg2 (readonly)
			[5]: var18_upvw (copied, read and write)
			[6]: module_upvr (copied, readonly)
			[7]: tbl_upvw_2 (copied, read and write)
			[8]: tbl_upvw (copied, read and write)
			[9]: TweenDetails_upvr (copied, readonly)
			[10]: UpdateDetails_upvr (copied, readonly)
			[11]: Main_upvr (copied, readonly)
			[12]: CountDictionary_upvr (copied, readonly)
		]]
		-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
		local var43
		if var20_upvw ~= arg3.UUID then
			var43 = false
		else
			var43 = true
		end
		if var43 then
		else
		end
		var20_upvw = arg3.UUID
		if not arg3.PetData.IsFavorite then
			SetSelectedStyle_upvr(arg2, not arg2.Display.SELECTED_VIGNETTE.Visible)
			local var44 = var18_upvw[arg3.UUID]
			if not var44 or not var44:IsDescendantOf(game) then
				warn("Tool not found or destroyed:", arg3.UUID)
				local var45 = arg2
				if not var45:FindFirstChild("Display") then
				else
					var45.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18)
					var45.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0)
					var45.Display.SELECTED_VIGNETTE.Visible = false
				end
			end
			module_upvr:ClearSelection()
			if not arg2.Display.SELECTED_VIGNETTE.Visible then
				tbl_upvw_2[var44] = nil
				tbl_upvw[arg3.UUID] = nil
				TweenDetails_upvr(false)
			else
				tbl_upvw_2[var44] = true
				tbl_upvw[arg3.UUID] = arg2
				UpdateDetails_upvr(arg3)
				TweenDetails_upvr(true)
			end
			Main_upvr.Main.SellCosts.Main.SelectedAmount.Text = CountDictionary_upvr(tbl_upvw_2).." Selected"
		end
	end)
end
function module_upvr.GetPetFrame(arg1, arg2) -- Line 151
	--[[ Upvalues[1]:
		[1]: Main_upvr (readonly)
	]]
	return Main_upvr.Main.Holder.SellFrame.BackgroundFrame.SellScrollingFrame:FindFirstChild(arg2)
end
function module_upvr.ClearSelection(arg1) -- Line 157
	--[[ Upvalues[4]:
		[1]: tbl_upvw (read and write)
		[2]: Main_upvr (readonly)
		[3]: tbl_upvw_2 (read and write)
		[4]: TweenDetails_upvr (readonly)
	]]
	if next(tbl_upvw) == nil then
	else
		for _, v_3 in pairs(tbl_upvw) do
			if not v_3:FindFirstChild("Display") then
			else
				v_3.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18)
				v_3.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0)
				v_3.Display.SELECTED_VIGNETTE.Visible = false
			end
		end
		Main_upvr.Main.SellCosts.Main.SelectedAmount.Text = 0.." Selected"
		tbl_upvw = {}
		tbl_upvw_2 = {}
		TweenDetails_upvr(false)
	end
end
local NoDupeText_upvr = Main_upvr:FindFirstChild("NoDupeText", true)
function module_upvr.RefreshUI(arg1) -- Line 168
	--[[ Upvalues[15]:
		[1]: var20_upvw (read and write)
		[2]: TweenDetails_upvr (readonly)
		[3]: RefreshToolCache_upvr (readonly)
		[4]: DataService_upvr (readonly)
		[5]: Main_upvr (readonly)
		[6]: PetUtilities_upvr (readonly)
		[7]: LocalPlayer_upvr (readonly)
		[8]: tbl_upvr (readonly)
		[9]: var18_upvw (read and write)
		[10]: PetList_upvr (readonly)
		[11]: module_upvr (readonly)
		[12]: NoDupeText_upvr (readonly)
		[13]: CountDictionary_upvr (readonly)
		[14]: PetAgeBreakMachineData_upvr (readonly)
		[15]: NumberUtil_upvr (readonly)
	]]
	var20_upvw = nil
	TweenDetails_upvr(false)
	RefreshToolCache_upvr()
	local PetAgeBreakMachine_3 = DataService_upvr:GetData().PetAgeBreakMachine
	local var90
	if not PetAgeBreakMachine_3.SubmittedPet then
	else
		var90 = Main_upvr.Main
		local SellScrollingFrame_2 = var90.Holder.SellFrame.BackgroundFrame.SellScrollingFrame
		local TEMPLATE = SellScrollingFrame_2:FindFirstChild("TEMPLATE")
		local children_3, NONE, NONE_3 = SellScrollingFrame_2:GetChildren()
		for _, v_4 in children_3, NONE, NONE_3 do
			if v_4:IsA("ImageButton") and v_4.Name ~= "TEMPLATE" then
				v_4:Destroy()
			end
		end
		TEMPLATE.Visible = false
		NONE_3 = LocalPlayer_upvr
		local any_GetPetsSortedByAge_result1_2 = PetUtilities_upvr:GetPetsSortedByAge(NONE_3, 0, true, false)
		if not any_GetPetsSortedByAge_result1_2 or #any_GetPetsSortedByAge_result1_2 == 0 then return end
		NONE_3 = nil
		for _, v_5 in tbl_upvr, NONE_3 do
			if v_5 then
				v_5:Disconnect()
			end
		end
		NONE_3 = tbl_upvr
		table.clear(NONE_3)
		NONE_3 = nil
		for _, v_6 in any_GetPetsSortedByAge_result1_2, NONE_3 do
			if v_6.PetData.Level >= 0 then
				local var97 = var18_upvw[v_6.UUID]
				if var97 and var97.Parent then
					local SubmittedPet = PetAgeBreakMachine_3.SubmittedPet
					if v_6.PetType == SubmittedPet.PetType then
						local clone = TEMPLATE:Clone()
						clone.Visible = true
						clone.Name = v_6.UUID
						if v_6.PetData.IsFavorite then
							SubmittedPet = true
						else
							SubmittedPet = false
						end
						clone.Favorite.Visible = SubmittedPet
						SubmittedPet = PetList_upvr
						SubmittedPet = clone.Display.PET_NAME
						SubmittedPet.Text = v_6.PetType
						SubmittedPet = clone.Display.PET_AGE
						SubmittedPet.Text = `Age: {v_6.PetData.Level} • {math.round(PetUtilities_upvr:CalculateWeight(v_6.PetData.BaseWeight, v_6.PetData.Level) * 100) / 100} KG`
						SubmittedPet = clone.Display.DetailHolder.PET_IMAGE
						SubmittedPet.Image = SubmittedPet[v_6.PetType].Icon
						SubmittedPet = clone:FindFirstChild("Display")
						if not SubmittedPet then
						else
							SubmittedPet = clone.Display
							SubmittedPet.BackgroundColor3 = Color3.fromRGB(94, 44, 18)
							SubmittedPet = clone.Display.UIStroke
							SubmittedPet.Color = Color3.fromRGB(103, 31, 0)
							SubmittedPet = clone.Display.SELECTED_VIGNETTE
							SubmittedPet.Visible = false
						end
						SubmittedPet = module_upvr:UpdatePetCard
						SubmittedPet(clone, v_6)
						clone.Parent = SellScrollingFrame_2
					end
				end
			end
		end
		if CountDictionary_upvr(tbl_upvr) > 0 then
			NONE_3 = false
		else
			NONE_3 = true
		end
		NoDupeText_upvr.Visible = NONE_3
		NONE_3 = PetAgeBreakMachine_3.SubmittedPet.PetData.Level + 1 - PetAgeBreakMachineData_upvr.REQUIRED_PET_LEVEL
		NONE_3 = Main_upvr.Main.SellCosts.Main.CostAmount
		NONE_3.Text = `{NumberUtil_upvr.FormatCompactPrice(NONE_3 * PetAgeBreakMachineData_upvr.AGEUP_PRICE)} \xA2`
	end
end
local PetAgeLimitBreak_Cancel_upvr = GameEvents.PetAgeLimitBreak_Cancel
local Notification_upvr = require(ReplicatedStorage_upvr.Modules.Notification)
local ConfirmationPromptController_upvr = require(ReplicatedStorage_upvr.Modules.ConfirmationPromptController)
local PetAgeLimitBreak_Submit_upvr = GameEvents:WaitForChild("PetAgeLimitBreak_Submit")
function module_upvr.Start(arg1) -- Line 236
	--[[ Upvalues[17]:
		[1]: GuiController_upvr (readonly)
		[2]: PetAgeBreak_UI_upvr (readonly)
		[3]: var18_upvw (read and write)
		[4]: tbl_upvw_2 (read and write)
		[5]: module_upvr (readonly)
		[6]: Main_upvr (readonly)
		[7]: PetAgeLimitBreak_Cancel_upvr (readonly)
		[8]: Notification_upvr (readonly)
		[9]: DataService_upvr (readonly)
		[10]: PetsService_upvr (readonly)
		[11]: PetAgeBreakMachineData_upvr (readonly)
		[12]: NumberUtil_upvr (readonly)
		[13]: ReplicatedStorage_upvr (readonly)
		[14]: ConfirmationPromptController_upvr (readonly)
		[15]: PetAgeLimitBreak_Submit_upvr (readonly)
		[16]: tbl_upvw (read and write)
		[17]: var20_upvw (read and write)
	]]
	GuiController_upvr:UsePopupAnims(PetAgeBreak_UI_upvr)
	if var18_upvw ~= nil then
		table.clear(var18_upvw)
		var18_upvw = {}
	end
	if tbl_upvw_2 ~= nil then
		table.clear(tbl_upvw_2)
		tbl_upvw_2 = {}
	end
	local tbl_upvr_2 = {}
	local function _(arg1_2, arg2) -- Line 248, Named "IsDebounced"
		--[[ Upvalues[1]:
			[1]: tbl_upvr_2 (readonly)
		]]
		if tbl_upvr_2[arg1_2] and tick() - tbl_upvr_2[arg1_2] < (arg2 or 0.5) then
			return true
		end
		tbl_upvr_2[arg1_2] = tick()
		return false
	end
	module_upvr:ClearSelection()
	module_upvr:RefreshUI()
	Main_upvr.Main.Header.Exit.SENSOR.MouseButton1Click:Connect(function() -- Line 257
		--[[ Upvalues[4]:
			[1]: tbl_upvr_2 (readonly)
			[2]: module_upvr (copied, readonly)
			[3]: GuiController_upvr (copied, readonly)
			[4]: PetAgeBreak_UI_upvr (copied, readonly)
		]]
		local var106
		if tbl_upvr_2.ExitHeader and tick() - tbl_upvr_2.ExitHeader < (nil or 0.5) then
			var106 = true
		else
			tbl_upvr_2.ExitHeader = tick()
			var106 = false
		end
		if var106 then
		else
			var106 = module_upvr:ClearSelection
			var106()
			var106 = GuiController_upvr:Close
			var106(PetAgeBreak_UI_upvr)
		end
	end)
	Main_upvr.Main.Header.CancelAge.SENSOR.MouseButton1Click:Connect(function() -- Line 263
		--[[ Upvalues[4]:
			[1]: PetAgeLimitBreak_Cancel_upvr (copied, readonly)
			[2]: module_upvr (copied, readonly)
			[3]: GuiController_upvr (copied, readonly)
			[4]: PetAgeBreak_UI_upvr (copied, readonly)
		]]
		PetAgeLimitBreak_Cancel_upvr:FireServer()
		module_upvr:ClearSelection()
		GuiController_upvr:Close(PetAgeBreak_UI_upvr)
	end)
	Main_upvr.Main.SellCosts.Main.Clear.SENSOR.MouseButton1Click:Connect(function() -- Line 270
		--[[ Upvalues[2]:
			[1]: tbl_upvr_2 (readonly)
			[2]: module_upvr (copied, readonly)
		]]
		local var109
		if tbl_upvr_2.Clear and tick() - tbl_upvr_2.Clear < (nil or 0.5) then
			var109 = true
		else
			tbl_upvr_2.Clear = tick()
			var109 = false
		end
		if var109 then
		else
			var109 = module_upvr:ClearSelection
			var109()
		end
	end)
	Main_upvr.Main.SellCosts.Main.Sell.SENSOR.MouseButton1Click:Connect(function() -- Line 275
		--[[ Upvalues[16]:
			[1]: tbl_upvr_2 (readonly)
			[2]: tbl_upvw_2 (copied, read and write)
			[3]: Notification_upvr (copied, readonly)
			[4]: DataService_upvr (copied, readonly)
			[5]: PetsService_upvr (copied, readonly)
			[6]: PetAgeBreakMachineData_upvr (copied, readonly)
			[7]: NumberUtil_upvr (copied, readonly)
			[8]: ReplicatedStorage_upvr (copied, readonly)
			[9]: ConfirmationPromptController_upvr (copied, readonly)
			[10]: PetAgeLimitBreak_Submit_upvr (copied, readonly)
			[11]: var18_upvw (copied, read and write)
			[12]: tbl_upvw (copied, read and write)
			[13]: module_upvr (copied, readonly)
			[14]: var20_upvw (copied, read and write)
			[15]: GuiController_upvr (copied, readonly)
			[16]: PetAgeBreak_UI_upvr (copied, readonly)
		]]
		local var123
		if tbl_upvr_2.Sell and tick() - tbl_upvr_2.Sell < (nil or 0.5) then
			var123 = true
		else
			tbl_upvr_2.Sell = tick()
			var123 = false
		end
		if var123 then
		else
			var123 = {}
			for i_7, _ in tbl_upvw_2 do
				table.insert(var123, i_7:GetAttribute("PET_UUID"))
			end
			if #var123 ~= 1 then
				Notification_upvr:CreateNotification("Please submit one pet only!")
				return
			end
			local any_GetData_result1 = DataService_upvr:GetData()
			local PetAgeBreakMachine_2 = any_GetData_result1.PetAgeBreakMachine
			for _, v_8 in var123 do
				local any_GetPlayerPetData_result1 = PetsService_upvr:GetPlayerPetData(v_8)
				if not any_GetPlayerPetData_result1 then
					Notification_upvr:CreateNotification("Invalid Pet Submitted!")
					return
				end
				if any_GetPlayerPetData_result1.PetType ~= PetAgeBreakMachine_2.SubmittedPet.PetType then
					Notification_upvr:CreateNotification(`You can only submit {PetAgeBreakMachine_2.SubmittedPet.PetType}.`)
					return
				end
			end
			local var127 = (PetAgeBreakMachine_2.SubmittedPet.PetData.Level + 1 - PetAgeBreakMachineData_upvr.REQUIRED_PET_LEVEL) * PetAgeBreakMachineData_upvr.AGEUP_PRICE
			if any_GetData_result1.Sheckles < var127 then
				Notification_upvr:CreateNotification(`You need {NumberUtil_upvr.FormatCompactPrice(var127)} \xA2`)
				return
			end
			local any_GetPlayerPetData_result1_3 = PetsService_upvr:GetPlayerPetData(var123[1])
			print(any_GetPlayerPetData_result1_3)
			local var129 = "Common"
			local var130 = require(ReplicatedStorage_upvr.Data.PetRegistry.PetList)[any_GetPlayerPetData_result1_3.PetType]
			if var130 then
				var129 = var130.Rarity
			end
			ConfirmationPromptController_upvr:Open({
				Title = "Pet Fuse Confirmation";
				Header = "Are you sure you want to use this pet as the dupe?";
				Middle = `{any_GetPlayerPetData_result1_3.PetType} [Age {any_GetPlayerPetData_result1_3.PetData.Level}]`;
				Footer = "This will fuse this pet into the higher level pet!";
				AnimatedWords = {
					[`{any_GetPlayerPetData_result1_3.PetType}`] = var129;
				};
			}, {
				ConfirmEvent = PetAgeLimitBreak_Submit_upvr;
				ConfirmEventData = {var123};
			})
			for _, v_9 in var123 do
				var18_upvw[v_9] = nil
				if tbl_upvw[v_9] then
					tbl_upvw[v_9]:Destroy()
					tbl_upvw[v_9] = nil
				end
			end
			module_upvr:ClearSelection()
			table.clear(tbl_upvw_2)
			table.clear(tbl_upvw)
			var20_upvw = nil
			module_upvr:RefreshUI()
			GuiController_upvr:Close(PetAgeBreak_UI_upvr)
		end
	end)
	DataService_upvr:GetPathSignal("PetAgeBreakMachine/SubmittedPet"):Connect(function() -- Line 357
		--[[ Upvalues[4]:
			[1]: DataService_upvr (copied, readonly)
			[2]: module_upvr (copied, readonly)
			[3]: GuiController_upvr (copied, readonly)
			[4]: PetAgeBreak_UI_upvr (copied, readonly)
		]]
		task.wait(0.5)
		module_upvr:RefreshUI()
		if not DataService_upvr:GetData().PetAgeBreakMachine.SubmittedPet then
			GuiController_upvr:Close(PetAgeBreak_UI_upvr)
		end
	end)
end
function module_upvr.Open(arg1) -- Line 372
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: GuiController_upvr (readonly)
		[3]: PetAgeBreak_UI_upvr (readonly)
	]]
	module_upvr:RefreshUI()
	GuiController_upvr:Open(PetAgeBreak_UI_upvr)
end
local CalculatePetValue_upvr = require(ReplicatedStorage_upvr.Modules.CalculatePetValue)
GameEvents:WaitForChild("Favorite_Item_BE").Event:Connect(function(arg1) -- Line 377
	--[[ Upvalues[7]:
		[1]: PetsService_upvr (readonly)
		[2]: module_upvr (readonly)
		[3]: CalculatePetValue_upvr (readonly)
		[4]: var18_upvw (read and write)
		[5]: RefreshToolCache_upvr (readonly)
		[6]: tbl_upvw_2 (read and write)
		[7]: tbl_upvw (read and write)
	]]
	if not arg1 then
		warn("PetAgeBreakUIController:Favorite_Item_BE | No pet tool!")
	else
		local PET_UUID = arg1:GetAttribute("PET_UUID")
		if not PET_UUID then return end
		task.wait(0.25)
		local any_GetPlayerPetData_result1_2 = PetsService_upvr:GetPlayerPetData(PET_UUID)
		if not any_GetPlayerPetData_result1_2 then
			return warn("PetAgeBreakUIController:Favorite_Item_BE | No pet data found!")
		end
		local any_GetPetFrame_result1 = module_upvr:GetPetFrame(PET_UUID)
		if not any_GetPetFrame_result1 then return end
		if any_GetPetFrame_result1 then
			module_upvr:UpdatePetCard(any_GetPetFrame_result1, any_GetPlayerPetData_result1_2)
			if not any_GetPetFrame_result1:FindFirstChild("Display") then
			else
				any_GetPetFrame_result1.Display.BackgroundColor3 = Color3.fromRGB(94, 44, 18)
				any_GetPetFrame_result1.Display.UIStroke.Color = Color3.fromRGB(103, 31, 0)
				any_GetPetFrame_result1.Display.SELECTED_VIGNETTE.Visible = false
			end
		else
			module_upvr:RefreshUI()
		end
		if not var18_upvw then
			RefreshToolCache_upvr()
		end
		if any_GetPlayerPetData_result1_2.PetData.IsFavorite and tbl_upvw_2[arg1] and tbl_upvw[any_GetPlayerPetData_result1_2.UUID] then
			tbl_upvw_2[arg1] = nil
			tbl_upvw[any_GetPlayerPetData_result1_2.UUID] = nil
		end
	end
end)
task.spawn(module_upvr.Start, module_upvr)
return module_upvr
