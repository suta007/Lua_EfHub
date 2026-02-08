local function GetPetUUID(petName)
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" then
            local name = string.match(item.Name, "^(.-)%s*%[")
            if string.find(name, TargetPet) then
                if not string.find(name, TargetMutant) then
                    return item:GetAttribute("PET_UUID")
                end
            end
        end
    end
    return nil
end

local function heldPet()
    local uuid = GetPetUUID(TargetPet)
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            Humanoid:EquipTool(item)
            return true
        end
    end
    return false
end

heldPet()
