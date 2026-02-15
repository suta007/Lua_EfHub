local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local ValentinesRemote = GameEvents:WaitForChild("ValentinesEvent"):WaitForChild("ClaimValentineReward")

local DataService = require(ReplicatedStorage.Modules.DataService)
local REWARDS = { 30, 200, 700, 2000, 10000 }

local function ValentinesEvent()
	local data = DataService:GetData()
	if not data then
		return
	end

	local currentCoins = data.SpecialCurrency.HeartCoins
	local ValentinesCompleted = data.ValentinesEvent.Completed

	for i = 1, #REWARDS do
		if currentCoins >= REWARDS[i] and not ValentinesCompleted[i] then
			ValentinesRemote:FireServer(i)
		end
		task.wait(0.1)
	end
end

task.spawn(function()
	while true do
		pcall(function()
			ValentinesEvent()
		end)
		task.wait(60)
	end
end)
