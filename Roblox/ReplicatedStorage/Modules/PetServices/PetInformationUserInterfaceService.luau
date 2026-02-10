-- game:GetService("ReplicatedStorage").Modules.PetServices.PetInformationUserInterfaceService

-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:52:08
-- Luau version 6, Types version 3
-- Time taken: 0.008819 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService_upvr = game:GetService("TweenService")
local CurrentCamera_upvw = workspace.CurrentCamera
workspace:GetPropertyChangedSignal("CurrentCamera"):Connect(function() -- Line 12
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvw (read and write)
	]]
	CurrentCamera_upvw = workspace.CurrentCamera
end)
local ActivePetsService_upvr = require(ReplicatedStorage.Modules.PetServices.ActivePetsService)
local WaitForDescendant = require(ReplicatedStorage.Modules.WaitForDescendant)
local PetRegistry = require(ReplicatedStorage.Data.PetRegistry)
local PetInformationUI_upvr = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("PetUI"):WaitForChild("PetInformationUI")
local module_upvr = {
	Active = false;
	Target = nil;
}
local var6_result1_upvr_2 = WaitForDescendant(PetInformationUI_upvr, "PET_TEXT")
local var6_result1_upvr = WaitForDescendant(PetInformationUI_upvr, "LEVEL_TEXT")
function module_upvr.SetTarget(arg1, arg2) -- Line 50
	--[[ Upvalues[4]:
		[1]: module_upvr (readonly)
		[2]: ActivePetsService_upvr (readonly)
		[3]: var6_result1_upvr_2 (readonly)
		[4]: var6_result1_upvr (readonly)
	]]
	module_upvr.Target = arg2
	if not arg2 then
	else
		local any_GetPetDataFromPetObject_result1 = ActivePetsService_upvr:GetPetDataFromPetObject(arg2)
		if not any_GetPetDataFromPetObject_result1 then return end
		local PetData = any_GetPetDataFromPetObject_result1.PetData
		local Name = PetData.Name
		if Name == "" then
			Name = nil
		end
		var6_result1_upvr_2.Text = Name or any_GetPetDataFromPetObject_result1.PetType
		var6_result1_upvr.Text = `Age {PetData.Level}`
		module_upvr:Update(0)
	end
end
local PetList_upvr = PetRegistry.PetList
local var6_result1_upvr_3 = WaitForDescendant(PetInformationUI_upvr, "HUNGER_BAR")
local PetUtilities_upvr = require(ReplicatedStorage.Modules.PetServices.PetUtilities)
local MAX_LEVEL_upvr = PetRegistry.PetConfig.XP_CONFIG.MAX_LEVEL
local WaitForDescendant_result1_upvr = WaitForDescendant(PetInformationUI_upvr, "LEVEL_PROGRESS_BAR")
local WaitForDescendant_result1_upvr_3 = WaitForDescendant(PetInformationUI_upvr, "LEVEL_MAXED_TEXT")
local WaitForDescendant_result1_upvr_2 = WaitForDescendant(PetInformationUI_upvr, "LEVEL_ICON")
function module_upvr.Update(arg1, arg2) -- Line 69
	--[[ Upvalues[10]:
		[1]: module_upvr (readonly)
		[2]: ActivePetsService_upvr (readonly)
		[3]: PetList_upvr (readonly)
		[4]: TweenService_upvr (readonly)
		[5]: var6_result1_upvr_3 (readonly)
		[6]: PetUtilities_upvr (readonly)
		[7]: MAX_LEVEL_upvr (readonly)
		[8]: WaitForDescendant_result1_upvr (readonly)
		[9]: WaitForDescendant_result1_upvr_3 (readonly)
		[10]: WaitForDescendant_result1_upvr_2 (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local Target = module_upvr.Target
	local var23
	if not Target then
	else
		local any_GetPetDataFromPetObject_result1_2 = ActivePetsService_upvr:GetPetDataFromPetObject(Target)
		if not any_GetPetDataFromPetObject_result1_2 then return end
		local PetData_2 = any_GetPetDataFromPetObject_result1_2.PetData
		var23 = var6_result1_upvr_3
		local tbl = {
			Size = UDim2.fromScale(PetData_2.Hunger / PetList_upvr[any_GetPetDataFromPetObject_result1_2.PetType].DefaultHunger, 1);
		}
		TweenService_upvr:Create(var23, TweenInfo.new(arg2 or 0.2), tbl):Play()
		local Level = PetData_2.Level
		if MAX_LEVEL_upvr > Level then
			var23 = false
		else
			var23 = true
		end
		tbl = PetData_2.LevelProgress
		local var28 = tbl
		if var23 then
		else
		end
		TweenService_upvr:Create(WaitForDescendant_result1_upvr, TweenInfo.new(arg2 or 0.2), {
			Size = UDim2.fromScale((var28 or 0) / PetUtilities_upvr:GetCurrentLevelXPCost(Level), 1);
		}):Play()
		WaitForDescendant_result1_upvr_3.Visible = var23
		WaitForDescendant_result1_upvr_2.Visible = not var23
	end
end
local WaitForDescendant_result1_upvr_4 = WaitForDescendant(PetInformationUI_upvr, "CanvasGroup")
local WaitForDescendant_result1_upvr_5 = WaitForDescendant(PetInformationUI_upvr, "DROP_SHADOW")
local WaitForDescendant_result1_upvr_6 = WaitForDescendant(PetInformationUI_upvr, "CANVAS_STROKE")
function module_upvr.Toggle(arg1, arg2) -- Line 103
	--[[ Upvalues[5]:
		[1]: module_upvr (readonly)
		[2]: TweenService_upvr (readonly)
		[3]: WaitForDescendant_result1_upvr_4 (readonly)
		[4]: WaitForDescendant_result1_upvr_5 (readonly)
		[5]: WaitForDescendant_result1_upvr_6 (readonly)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	-- KONSTANTERROR: [0] 1. Error Block 27 start (CF ANALYSIS FAILED)
	local var33
	if module_upvr.Active == arg2 then
	else
		module_upvr.Active = arg2
		local tbl_3 = {}
		if arg2 then
			var33 = 0
		else
			var33 = 1
		end
		tbl_3.GroupTransparency = var33
		var33 = 0.15
		var33 = {}
		if arg2 then
			-- KONSTANTWARNING: GOTO [36] #30
		end
		-- KONSTANTERROR: [0] 1. Error Block 27 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [35] 29. Error Block 29 start (CF ANALYSIS FAILED)
		var33.ImageTransparency = 1
		TweenService_upvr:Create(WaitForDescendant_result1_upvr_4, TweenInfo.new(0.15), tbl_3):Play()
		var33 = TweenInfo.new(0.15)
		local tbl_2 = {}
		if arg2 then
		else
		end
		tbl_2.Transparency = 1
		TweenService_upvr:Create(WaitForDescendant_result1_upvr_6, var33, tbl_2):Play()
		if not arg2 then
			module_upvr.Target = nil
		end
		-- KONSTANTERROR: [35] 29. Error Block 29 end (CF ANALYSIS FAILED)
	end
end
local function _(arg1) -- Line 129, Named "GetWorldToPosition"
	--[[ Upvalues[1]:
		[1]: CurrentCamera_upvw (read and write)
	]]
	if not arg1 then return end
	local any_WorldToScreenPoint_result1 = CurrentCamera_upvw:WorldToScreenPoint(arg1)
	return UDim2.fromOffset(any_WorldToScreenPoint_result1.X, any_WorldToScreenPoint_result1.Y)
end
game:GetService("RunService").RenderStepped:Connect(function() -- Line 136
	--[[ Upvalues[3]:
		[1]: module_upvr (readonly)
		[2]: PetInformationUI_upvr (readonly)
		[3]: CurrentCamera_upvw (read and write)
	]]
	local var38
	if not module_upvr.Active then
	else
		var38 = module_upvr
		if not var38.Target then
			module_upvr:Toggle(false)
			return
		end
		local var39 = module_upvr.Target.Position + Vector3.new(0, 5, 0)
		if not var39 then
			var38 = nil
		else
			local any_WorldToScreenPoint_result1_2 = CurrentCamera_upvw:WorldToScreenPoint(var39)
			var38 = UDim2.fromOffset(any_WorldToScreenPoint_result1_2.X, any_WorldToScreenPoint_result1_2.Y)
		end
		PetInformationUI_upvr.Position = var38
	end
end)
task.spawn(function() -- Line 142
	--[[ Upvalues[1]:
		[1]: module_upvr (readonly)
	]]
	while true do
		task.wait(1)
		module_upvr:Update()
	end
end)
return module_upvr
