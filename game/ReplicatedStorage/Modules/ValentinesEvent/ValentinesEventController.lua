-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-14 18:44:59
-- Luau version 6, Types version 3
-- Time taken: 0.009737 seconds

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GuiController_upvr = require(ReplicatedStorage.Modules.GuiController)
local DataService_upvr = require(ReplicatedStorage.Modules.DataService)
local Comma_Module_upvr = require(ReplicatedStorage.Comma_Module)
local ValentinesEvent_UI_upvr = game:GetService("Players").LocalPlayer.PlayerGui:WaitForChild("ValentinesEvent_UI")
local Main_upvr = ValentinesEvent_UI_upvr.Frame:WaitForChild("Main")
local Content_3 = Main_upvr:WaitForChild("Content")
local any_new_result1_upvr =
	require(ReplicatedStorage.Modules.EventService).new("ValentinesEventController", "Valentines Event 2025")
local RewardsData_upvr = require(ReplicatedStorage.Data.ValentinesEvent.RewardsData)
local SmallRewards_upvr = Content_3:WaitForChild("SmallRewards")
local ClaimValentineReward_upvr = ReplicatedStorage.GameEvents.ValentinesEvent.ClaimValentineReward
local function InitializeRewardsUI_upvr() -- Line 51, Named "InitializeRewardsUI"
	--[[ Upvalues[6]:
		[1]: DataService_upvr (readonly)
		[2]: RewardsData_upvr (readonly)
		[3]: SmallRewards_upvr (readonly)
		[4]: any_new_result1_upvr (readonly)
		[5]: ClaimValentineReward_upvr (readonly)
		[6]: Comma_Module_upvr (readonly)
	]]
	local any_GetData_result1_2_upvr = DataService_upvr:GetData()
	for i_upvr = 1, 5 do
		if RewardsData_upvr.Rewards[i_upvr] then
			local var25_upvr = RewardsData_upvr.Rewards[i_upvr]
			local SOME = SmallRewards_upvr:FindFirstChild(`Reward{i_upvr}`)
			if SOME then
				local Content = SOME:FindFirstChild("Content")
				local ClaimButton_upvr_2 = Content:FindFirstChild("ClaimButton")
				local ClaimedDisplay_upvr = Content:FindFirstChild("ClaimedDisplay")
				local Price_upvr_2 = Content:FindFirstChild("Price")
				local function Update() -- Line 79
					--[[ Upvalues[6]:
						[1]: any_GetData_result1_2_upvr (readonly)
						[2]: var25_upvr (readonly)
						[3]: i_upvr (readonly)
						[4]: ClaimButton_upvr_2 (readonly)
						[5]: Price_upvr_2 (readonly)
						[6]: ClaimedDisplay_upvr (readonly)
					]]
					if
						var25_upvr.Price <= any_GetData_result1_2_upvr.SpecialCurrency.HeartCoins
						and not any_GetData_result1_2_upvr.ValentinesEvent.Completed[i_upvr]
					then
						ClaimButton_upvr_2.Visible = true
						Price_upvr_2.Visible = false
						ClaimedDisplay_upvr.Visible = false
					else
						if any_GetData_result1_2_upvr.ValentinesEvent.Completed[i_upvr] then
							ClaimedDisplay_upvr.Visible = true
							Price_upvr_2.Visible = false
							ClaimButton_upvr_2.Visible = false
							return
						end
						Price_upvr_2.Visible = true
						ClaimedDisplay_upvr.Visible = false
						ClaimButton_upvr_2.Visible = false
					end
				end
				any_new_result1_upvr:Bind(DataService_upvr:GetPathSignal("SpecialCurrency/HeartCoins"):Connect(Update))
				any_new_result1_upvr:Bind(DataService_upvr:GetPathSignal("ValentinesEvent/Completed"):Connect(Update))
				if
					var25_upvr.Price <= any_GetData_result1_2_upvr.SpecialCurrency.HeartCoins
					and not any_GetData_result1_2_upvr.ValentinesEvent.Completed[i_upvr]
				then
					ClaimButton_upvr_2.Visible = true
					Price_upvr_2.Visible = false
					ClaimedDisplay_upvr.Visible = false
				elseif any_GetData_result1_2_upvr.ValentinesEvent.Completed[i_upvr] then
					ClaimedDisplay_upvr.Visible = true
					Price_upvr_2.Visible = false
					ClaimButton_upvr_2.Visible = false
				else
					Price_upvr_2.Visible = true
					ClaimedDisplay_upvr.Visible = false
					ClaimButton_upvr_2.Visible = false
				end
				any_new_result1_upvr:Bind(ClaimButton_upvr_2.Activated:Connect(function() -- Line 117
					--[[ Upvalues[2]:
						[1]: ClaimValentineReward_upvr (copied, readonly)
						[2]: i_upvr (readonly)
					]]
					ClaimValentineReward_upvr:FireServer(i_upvr)
				end))
				Content:FindFirstChild("ITEM_IMAGE").Image = var25_upvr.ImageId
				Content:FindFirstChild("RewardName").RewardName.Text = var25_upvr.ItemName
				Price_upvr_2.Counter.Text = `{Comma_Module_upvr.Comma(var25_upvr.Price)}`
				SOME.LayoutOrder = 0
			end
		end
	end
end
local Progress_upvr = Content_3:WaitForChild("Progress")
local NumberUtil_upvr = require(ReplicatedStorage.Modules.NumberUtil)
function any_new_result1_upvr.OnStarted(arg1) -- Line 136
	--[[ Upvalues[7]:
		[1]: Main_upvr (readonly)
		[2]: any_new_result1_upvr (readonly)
		[3]: InitializeRewardsUI_upvr (readonly)
		[4]: DataService_upvr (readonly)
		[5]: Progress_upvr (readonly)
		[6]: Comma_Module_upvr (readonly)
		[7]: NumberUtil_upvr (readonly)
	]]
	arg1:Bind(Main_upvr.Header.CloseButton.Activated:Connect(function(arg1_2, arg2) -- Line 141
		--[[ Upvalues[1]:
			[1]: any_new_result1_upvr (copied, readonly)
		]]
		any_new_result1_upvr:Close()
	end))
	InitializeRewardsUI_upvr()
	local function UpdateProgress() -- Line 149
		--[[ Upvalues[3]:
			[1]: DataService_upvr (copied, readonly)
			[2]: Progress_upvr (copied, readonly)
			[3]: Comma_Module_upvr (copied, readonly)
		]]
		local any_GetData_result1 = DataService_upvr:GetData()
		Progress_upvr.ProgressBar.Bar_Actual:TweenSize(
			UDim2.fromScale(math.clamp(any_GetData_result1.SpecialCurrency.HeartCoins / 1000, 0, 1), 1),
			Enum.EasingDirection.Out,
			Enum.EasingStyle.Quad,
			0.3,
			true
		)
		Progress_upvr.ProgressBar.PROGRESS.Text = tostring(
			Comma_Module_upvr.Comma(any_GetData_result1.SpecialCurrency.HeartCoins)
		) .. '❤️<font transparency=".4">/2,000❤️</font>'
		Progress_upvr.ProgressBar.PROGRESS_SHADOW.Text = tostring(
			Comma_Module_upvr.Comma(any_GetData_result1.SpecialCurrency.HeartCoins)
		) .. '❤️<font transparency=".4">/2,000❤️</font>'
	end
	arg1:Bind(DataService_upvr:GetPathSignal("SpecialCurrency/HeartCoins"):Connect(UpdateProgress))
	UpdateProgress()
	task.spawn(function() -- Line 169
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
function any_new_result1_upvr.OnEnded(arg1) -- Line 178
end
function any_new_result1_upvr.Open(arg1) -- Line 182
	--[[ Upvalues[2]:
		[1]: GuiController_upvr (readonly)
		[2]: ValentinesEvent_UI_upvr (readonly)
	]]
	GuiController_upvr:Open(ValentinesEvent_UI_upvr)
end
function any_new_result1_upvr.Close(arg1) -- Line 186
	--[[ Upvalues[2]:
		[1]: GuiController_upvr (readonly)
		[2]: ValentinesEvent_UI_upvr (readonly)
	]]
	GuiController_upvr:Close(ValentinesEvent_UI_upvr)
end
GuiController_upvr:UsePopupAnims(ValentinesEvent_UI_upvr)
any_new_result1_upvr:Initialize()
return any_new_result1_upvr
