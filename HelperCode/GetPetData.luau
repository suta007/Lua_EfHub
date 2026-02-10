--[[
PetData
 - HatchedFrom
 - IsFavorite
 - Boosts
 - Name
 - LevelProgress
 - BaseWeight
 - Level
 - Hunger
 - MutationType
UUID
PetType
]]

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
-- ใช้ game:GetService("ReplicatedStorage") แบบเต็มเพื่อความชัวร์ (ดีแล้วครับ)
local ActivePetsService = require(game:GetService("ReplicatedStorage").Modules.PetServices.ActivePetsService)

-- ประกาศตัวแปรล่วงหน้า (Forward Declaration) แก้ให้ครบทุกตัว
local GetRawPetData, GetPetLevel, GetPetMutationType, GetPetHunger, GetPetType

-- ==========================================
-- ฟังก์ชันกลางสำหรับดึงข้อมูล (Private helper)
-- ==========================================
GetRawPetData = function(uuid)
    local success, result = pcall(function()
        -- ถูกต้อง: ส่ง Name ตามที่เราแกะได้
        return ActivePetsService:GetPetData(LocalPlayer.Name, uuid)
    end)
    
    if success and result then
        return result -- คืนค่า Table ข้อมูลทั้งหมดกลับไป
    end
    return nil
end

-- ==========================================
-- 1. ฟังก์ชันหา Level
-- ==========================================
GetPetLevel = function(uuid)
    local data = GetRawPetData(uuid)
    -- เช็ค PetData ก่อน เพราะ Level อยู่ข้างในนั้น
    if data and data.PetData then
        return data.PetData.Level or 0
    end
    return 0
end

-- ==========================================
-- 2. ฟังก์ชันหา MutationType
-- ==========================================
GetPetMutationType = function(uuid)
    local data = GetRawPetData(uuid)
    if data and data.PetData then
        return data.PetData.MutationType -- คืนค่า nil ได้ถ้าไม่มี
    end
    return nil
end

-- ==========================================
-- 3. ฟังก์ชันหา Hunger
-- ==========================================
GetPetHunger = function(uuid)
    local data = GetRawPetData(uuid)
    if data and data.PetData then
        return data.PetData.Hunger or 0
    end
    return 0
end

-- ==========================================
-- 4. ฟังก์ชันหา PetType
-- ==========================================
GetPetType = function(uuid)
    local data = GetRawPetData(uuid)
    if data then
        -- ถูกต้อง: ตัวนี้อยู่นอก PetData (ตามโครงสร้างที่พี่เอฟเจอ)
        return data.PetType or "Unknown"
    end
    return "Unknown"
end


local uuid = "{cc034702-a88a-4348-9596-b687224f2521}"

print("Level:", GetPetLevel(uuid))
print("Type:", GetPetType(uuid))
print("Hunger:", GetPetHunger(uuid))
print("Mutation:", GetPetMutationType(uuid))

--[[
ลบ ฟังชั่น RawName, GetPetAge, CheckPetAge ออก

แล้วแก้ ฟังก์ชั่นที่ถูกเรียกใช้เป็น
RawName เป็น GetPetType
GetPetAge เป็น GetPetLevel
CheckPetAge เป็น GetPetLevel
]]