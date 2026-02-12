local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local GetData_result = DataService:GetData()
local InventoryData = GetData_result.InventoryData



local AllowList={"Elder Strawberry","Apple","Carrot"}

local function FindFruitInv()
	for uuid,Item in pairs(InventoryData) do
		if Item.ItemData and Item.ItemData.ItemName then
		local FruitInv = Item.ItemData.ItemName
		for _,Fruit in pairs(AllowList) do
			if FruitInv == Fruit then
				--AddLog("Found Fruit : "..FruitInv.." UUID: "..uuid)
				return uuid
			end
		end
	end
end
	return nil
end

local FruitInvUUID = FindFruitInv()
AddLog(" UUID: "..FruitInvUUID)