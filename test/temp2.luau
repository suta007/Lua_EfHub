local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local myShovel = LocalPlayer.Backpack["Shovel [Destroy Plants]"]
Humanoid:EquipTool(myShovel)

GetMyFarm = function()
	local farmFolder = workspace:FindFirstChild("Farm")
	if not farmFolder then
		return nil
	end
	for _, oFarm in pairs(farmFolder:GetChildren()) do
		local success, owner = pcall(function()
			return oFarm.Important.Data.Owner.Value
		end)

		if success and owner == LocalPlayer.Name then
			return oFarm
		end
	end
	return nil
end

local MyFarm = GetMyFarm()

ShovelPlant = function()
	local Farm_Important = MyFarm:FindFirstChild("Important")
	local Plants_Physical = Farm_Important and Farm_Important:FindFirstChild("Plants_Physical")

	local ShovelPlantList = { "Buttercup" } --GetSelectedItems(Options.ddShovelPlant.Value)
	local myShovel = LocalPlayer.Backpack:FindFirstChild("Shovel [Destroy Plants]")

	if Plants_Physical then
		for _, plant in pairs(Plants_Physical:GetChildren()) do
			if table.find(ShovelPlantList, plant.Name) then
				pcall(function()
					Humanoid:EquipTool(myShovel)
				end)
				game:GetService("ReplicatedStorage")
					:WaitForChild("GameEvents")
					:WaitForChild("Remove_Item")
					:FireServer(plant)
				task.wait(0.1)
			end
		end
	end
end

for i = 1, 3 do
	ShovelPlant()
end
