local ReplicatedStorage = game:GetService("ReplicatedStorage")
local InventoryService = require(ReplicatedStorage.Modules.InventoryService)

task.spawn(function()
	while true do
		if InventoryService.IsMaxInventory() then
			local result = game:GetService("ReplicatedStorage")
				:WaitForChild("GameEvents")
				:WaitForChild("ValentinesEvent")
				:WaitForChild("GiveHeartstruckFruits")
				:InvokeServer()
		end
		task.wait(60)
	end
end)
