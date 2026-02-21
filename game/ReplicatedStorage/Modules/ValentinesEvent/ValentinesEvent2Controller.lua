-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-21 06:45:44
-- Luau version 6, Types version 3
-- Time taken: 0.007893 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiController_upvr = require(ReplicatedStorage.Modules.GuiController)
local NumberUtil_upvr = require(ReplicatedStorage.Modules.NumberUtil)
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
local RewardsData2_upvr = require(ReplicatedStorage.Data.ValentinesEvent.RewardsData2)
local ValentinesEvent2_UI_upvr = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ValentinesEvent2_UI")
local Main_upvr = ValentinesEvent2_UI_upvr.Frame:WaitForChild("Main")
local Content_2 = Main_upvr:WaitForChild("Content")
local any_new_result1_upvr =
	require(ReplicatedStorage.Modules.EventService).new("ValentinesEvent2Controller", "Valentines Event 2 2025")
local List_upvr = Content_2:WaitForChild("SmallRewards"):WaitForChild("List")
local function InitializeRewardsUI_upvr() -- Line 53, Named "InitializeRewardsUI"
	--[[ Upvalues[5]:
		[1]: DataService_upvr (readonly)
		[2]: RewardsData2_upvr (readonly)
		[3]: List_upvr (readonly)
		[4]: any_new_result1_upvr (readonly)
		[5]: NumberUtil_upvr (readonly)
	]]
	local any_GetData_result1_2_upvr = DataService_upvr:GetData()
	for i_upvr = 1, 10 do
		if RewardsData2_upvr.Rewards[i_upvr] then
			local var23 = RewardsData2_upvr.Rewards[i_upvr]
			local SOME_2 = List_upvr:FindFirstChild(`Reward{i_upvr}`)
			if SOME_2 then
				local Content_3 = SOME_2:FindFirstChild("Content")
				local ClaimButton_upvr = Content_3:FindFirstChild("ClaimButton")
				local ClaimedDisplay_upvr = Content_3:FindFirstChild("ClaimedDisplay")
				local Price_upvr_2 = Content_3:FindFirstChild("Price")
				local function Update() -- Line 81
					--[[ Upvalues[5]:
						[1]: any_GetData_result1_2_upvr (readonly)
						[2]: i_upvr (readonly)
						[3]: ClaimedDisplay_upvr (readonly)
						[4]: Price_upvr_2 (readonly)
						[5]: ClaimButton_upvr (readonly)
					]]
					if any_GetData_result1_2_upvr.ValentinesEvent.Completed2[i_upvr] then
						ClaimedDisplay_upvr.Visible = true
						Price_upvr_2.Visible = false
						ClaimButton_upvr.Visible = false
					else
						Price_upvr_2.Visible = true
						ClaimedDisplay_upvr.Visible = false
						ClaimButton_upvr.Visible = false
					end
				end
				any_new_result1_upvr:Bind(DataService_upvr:GetPathSignal("Sheckles"):Connect(Update))
				any_new_result1_upvr:Bind(DataService_upvr:GetPathSignal("ValentinesEvent/Completed2"):Connect(Update))
				if any_GetData_result1_2_upvr.ValentinesEvent.Completed2[i_upvr] then
					ClaimedDisplay_upvr.Visible = true
					Price_upvr_2.Visible = false
					ClaimButton_upvr.Visible = false
				else
					Price_upvr_2.Visible = true
					ClaimedDisplay_upvr.Visible = false
					ClaimButton_upvr.Visible = false
				end
				Content_3:FindFirstChild("ITEM_IMAGE").Image = var23.ImageId
				Content_3:FindFirstChild("RewardName").RewardName.Text = var23.ItemName
				Price_upvr_2.Counter.Text = `{NumberUtil_upvr.DisplaySheckles(var23.Price)}`
				SOME_2.LayoutOrder = 0
			end
		end
	end
end
local Progress_upvr = Content_2:WaitForChild("Progress")
local ClaimButton_upvr_3 = Content_2:WaitForChild("ClaimButton")
local ClaimValentineReward2_upvr = ReplicatedStorage.GameEvents.ValentinesEvent.ClaimValentineReward2
function any_new_result1_upvr.OnStarted(arg1) -- Line 155
	--[[ Upvalues[9]:
		[1]: Main_upvr (readonly)
		[2]: any_new_result1_upvr (readonly)
		[3]: InitializeRewardsUI_upvr (readonly)
		[4]: DataService_upvr (readonly)
		[5]: RewardsData2_upvr (readonly)
		[6]: Progress_upvr (readonly)
		[7]: NumberUtil_upvr (readonly)
		[8]: ClaimButton_upvr_3 (readonly)
		[9]: ClaimValentineReward2_upvr (readonly)
	]]
	arg1:Bind(Main_upvr.Header.CloseButton.Activated:Connect(function(arg1_2, arg2) -- Line 160
		--[[ Upvalues[1]:
			[1]: any_new_result1_upvr (copied, readonly)
		]]
		any_new_result1_upvr:Close()
	end))
	InitializeRewardsUI_upvr()
	local function UpdateProgress() -- Line 168
		--[[ Upvalues[5]:
			[1]: DataService_upvr (copied, readonly)
			[2]: RewardsData2_upvr (copied, readonly)
			[3]: Progress_upvr (copied, readonly)
			[4]: NumberUtil_upvr (copied, readonly)
			[5]: ClaimButton_upvr_3 (copied, readonly)
		]]
		-- KONSTANTERROR: [0] 1. Error Block 1 start (CF ANALYSIS FAILED)
		local any_GetData_result1 = DataService_upvr:GetData()
		local const_number = 1
		-- KONSTANTERROR: [0] 1. Error Block 1 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [17] 15. Error Block 4 start (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [17] 15. Error Block 4 end (CF ANALYSIS FAILED)
		-- KONSTANTERROR: [9] 9. Error Block 15 start (CF ANALYSIS FAILED)
		-- KONSTANTWARNING: Failed to evaluate expression, replaced with nil [17.5]
		if not nil then
			local _1 = RewardsData2_upvr.Rewards[1]
			Progress_upvr.ProgressBar.Bar_Actual:TweenSize(
				UDim2.fromScale(math.clamp(any_GetData_result1.Sheckles / _1.Price, 0, 1), 1),
				Enum.EasingDirection.Out,
				Enum.EasingStyle.Quad,
				0.3,
				true
			)
			Progress_upvr.ProgressBar.PROGRESS.Text = tostring(
				NumberUtil_upvr.DisplaySheckles(any_GetData_result1.Sheckles)
			) .. '<font transparency=".4">/' .. tostring(NumberUtil_upvr.DisplaySheckles(_1.Price)) .. "</font>"
			Progress_upvr.ProgressBar.PROGRESS_SHADOW.Text = tostring(
				NumberUtil_upvr.DisplaySheckles(any_GetData_result1.Sheckles)
			) .. '<font transparency=".4">/' .. tostring(NumberUtil_upvr.DisplaySheckles(_1.Price)) .. "</font>"
			if _1.Price > any_GetData_result1.Sheckles then
				-- KONSTANTWARNING: GOTO [125] #92
			end
			-- KONSTANTWARNING: GOTO [124] #91
		end
		-- KONSTANTERROR: [9] 9. Error Block 15 end (CF ANALYSIS FAILED)
	end
	arg1:Bind(DataService_upvr:GetPathSignal("Sheckles"):Connect(UpdateProgress))
	arg1:Bind(ClaimButton_upvr_3.Activated:Connect(function() -- Line 204
		--[[ Upvalues[1]:
			[1]: ClaimValentineReward2_upvr (copied, readonly)
		]]
		ClaimValentineReward2_upvr:FireServer()
	end))
	UpdateProgress()
	task.spawn(function() -- Line 213
		--[[ Upvalues[2]:
			[1]: Main_upvr (copied, readonly)
			[2]: NumberUtil_upvr (copied, readonly)
		]]
		while task.wait(1) do
			Main_upvr.Header.RefreshIn.Timer.Text = `Ends in {NumberUtil_upvr.toDHMS(
				game.ReplicatedFirst.GlobalUpdateTime.Value + 604800 - game.Workspace:GetServerTimeNow() or 0
			)}`
		end
	end)
end
function any_new_result1_upvr.OnEnded(arg1) -- Line 222
end
function any_new_result1_upvr.Open(arg1) -- Line 226
	--[[ Upvalues[2]:
		[1]: GuiController_upvr (readonly)
		[2]: ValentinesEvent2_UI_upvr (readonly)
	]]
	GuiController_upvr:Open(ValentinesEvent2_UI_upvr)
end
function any_new_result1_upvr.Close(arg1) -- Line 230
	--[[ Upvalues[2]:
		[1]: GuiController_upvr (readonly)
		[2]: ValentinesEvent2_UI_upvr (readonly)
	]]
	GuiController_upvr:Close(ValentinesEvent2_UI_upvr)
end
GuiController_upvr:UsePopupAnims(ValentinesEvent2_UI_upvr)
any_new_result1_upvr:Initialize()
return any_new_result1_upvr
