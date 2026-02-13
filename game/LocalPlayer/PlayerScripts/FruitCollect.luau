-- game:GetService("Players").LocalPlayer.PlayerScripts.FruitCollect

local FruitCollectionController_upvr = require(game.ReplicatedStorage.Modules.FruitCollectionController)
game.Players.LocalPlayer.PlayerGui:WaitForChild("ReplicatedAssets").ChildAdded:Connect(function(arg1) -- Line 15
	--[[ Upvalues[1]:
		[1]: FruitCollectionController_upvr (readonly)
	]]
	if arg1:IsA("Model") and arg1:GetAttribute("FruitDebris") then
		FruitCollectionController_upvr:StartCollection(arg1)
	end
end)
