local LocalPlayer = game:GetService("Players").LocalPlayer
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local myShovel = LocalPlayer.Backpack["Shovel [Destroy Plants]"]
Humanoid:EquipTool(myShovel)


ShovelPlant = function()
	if not Options.tgAutoPlantShovel.Value then
		return
	end