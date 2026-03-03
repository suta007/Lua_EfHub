--!nocheck
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local giftEvent = GameEvents:WaitForChild("GiftPet")
local giftNotificationFrame = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gift_Notification"):WaitForChild("Frame")

local DataService = require(ReplicatedStorage.Modules.DataService)

task.wait(0.3)

giftEvent.OnClientEvent:Connect(function(arg1, arg2, arg3)
	task.wait(0.5)
	for _, uiElement in pairs(giftNotificationFrame:GetChildren()) do
		if uiElement:FindFirstChild("Holder") and uiElement.Holder:FindFirstChild("Frame") then
			local acceptButton = uiElement.Holder.Frame:FindFirstChild("Accept")
			if acceptButton then
				for _, connection in pairs(getconnections(acceptButton.MouseButton1Click)) do
					connection:Fire()
				end
				task.wait(0.2)
			end
		end
	end
end)

local function AutoAlienClaim()
	local data = DataService:GetData()
	local inventory = data and data.PetsData and data.PetsData.PetInventory
	local AlienedPet = 0
	if inventory then
		for _, v in pairs(inventory) do
			if type(v) == "table" then
				for kUUID, petData in pairs(v) do
					--local tuuid = petData.UUID or kUUID
					if type(petData) == "table" then
						local MutationType = petData.PetData.MutationType
						if MutationType and MutationType == "Z" then AlienedPet = AlienedPet + 1 end
					end
				end
			end
		end
	end

	task.wait(0.1)
	if AlienedPet >= 10 then
		GameEvents:WaitForChild("GetPetMutationNames"):InvokeServer()
		task.wait(0.2)
		GameEvents:WaitForChild("AlienEvent"):WaitForChild("GiveAlienatedPets"):InvokeServer()
		task.wait(10)
	end
end

task.spawn(function()
	while true do
		pcall(AutoAlienClaim)
		task.wait(10)
	end
end)
