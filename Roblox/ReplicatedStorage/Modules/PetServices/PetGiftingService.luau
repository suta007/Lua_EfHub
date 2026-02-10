-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-09 18:50:44
-- Luau version 6, Types version 3
-- Time taken: 0.002033 seconds

local module = {}
local PetGiftingService_upvr = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetGiftingService")
function module.GivePet(arg1, arg2) -- Line 12
	--[[ Upvalues[1]:
		[1]: PetGiftingService_upvr (readonly)
	]]
	PetGiftingService_upvr:FireServer("GivePet", arg2)
end
local Gift_Notification_upvr = script.Gift_Notification
local Gift_Notification_upvr_2 = game.Players.LocalPlayer.PlayerGui:WaitForChild("Gift_Notification")
game.ReplicatedStorage.GameEvents.GiftPet.OnClientEvent:Connect(function(arg1, arg2, arg3) -- Line 16
	--[[ Upvalues[2]:
		[1]: Gift_Notification_upvr (readonly)
		[2]: Gift_Notification_upvr_2 (readonly)
	]]
	local clone_upvr = Gift_Notification_upvr:Clone()
	if game:GetService("UserInputService").PreferredInput == Enum.PreferredInput.Touch then
		local UIScale = Instance.new("UIScale")
		UIScale.Scale = 1.3
		UIScale.Parent = clone_upvr
	end
	clone_upvr.Parent = Gift_Notification_upvr_2.Frame
	clone_upvr.Holder.Notification_UI.TextLabel.Text = "Gift from @"..arg3
	clone_upvr.Holder.TextLabel.Text = arg2
	clone_upvr.Holder.Frame.Accept.MouseButton1Click:Connect(function() -- Line 30
		--[[ Upvalues[2]:
			[1]: clone_upvr (readonly)
			[2]: arg1 (readonly)
		]]
		clone_upvr:Destroy()
		game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(true, arg1)
	end)
	clone_upvr.Holder.Frame.Decline.MouseButton1Click:Connect(function() -- Line 35
		--[[ Upvalues[2]:
			[1]: clone_upvr (readonly)
			[2]: arg1 (readonly)
		]]
		clone_upvr:Destroy()
		game.ReplicatedStorage.GameEvents.AcceptPetGift:FireServer(false, arg1)
	end)
end)
return module
