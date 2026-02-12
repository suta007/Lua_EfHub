local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local GetData_result = DataService:GetData()
local EquippedPets = GetData_result.PetsData.EquippedPets

local function GetEquippedPetsUUID()
	local UUIDtbl={}
	for _, uuid in pairs(EquippedPets) do
		if uuid then
			table.insert(UUIDtbl,uuid)
		end
	end
	return UUIDtbl
end

local AllUUID = GetEquippedPetsUUID()