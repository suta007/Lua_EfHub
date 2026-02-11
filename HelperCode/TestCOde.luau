--[[
    AutoHarvest System - Standalone Version
    ระบบเก็บเกี่ยวพืชอัตโนมัติสำหรับ Grow a Garden
]]

--// Services
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

--// ตั้งค่าฟาร์มของคุณ
local function GetMyFarm()
    local Farms = workspace.Farm:GetChildren()
    for _, Farm in pairs(Farms) do
        local Owner = Farm.Important.Data.Owner.Value
        if Owner == LocalPlayer.Name then
            return Farm
        end
    end
end

local MyFarm = GetMyFarm()
local PlantsPhysical = MyFarm.Important.Plants_Physical

--// ตัวแปรควบคุม
local AutoHarvestEnabled = false
local HarvestIgnores = {
    Normal = false,  -- true = ไม่เก็บพืชธรรมดา
    Gold = false,    -- true = ไม่เก็บพืชทอง
    Rainbow = false  -- true = ไม่เก็บพืชรุ้ง
}

--// ฟังก์ชันตรวจสอบว่าพืชเก็บได้หรือไม่
local function CanHarvest(Plant)
    local Prompt = Plant:FindFirstChild("ProximityPrompt", true)
    if not Prompt then return false end
    if not Prompt.Enabled then return false end
    return true
end

--// ฟังก์ชันเก็บพืชที่เก็บเกี่ยวได้จาก Parent
local function CollectHarvestable(Parent, Plants, IgnoreDistance)
    local Character = LocalPlayer.Character
    if not Character then return Plants end
    
    local PlayerPosition = Character:GetPivot().Position

    for _, Plant in pairs(Parent:GetChildren()) do
        -- ตรวจสอบ Fruits (ผลไม้)
        local Fruits = Plant:FindFirstChild("Fruits")
        if Fruits then
            CollectHarvestable(Fruits, Plants, IgnoreDistance)
        end

        -- ตรวจสอบระยะห่าง
        local PlantPosition = Plant:GetPivot().Position
        local Distance = (PlayerPosition - PlantPosition).Magnitude
        if not IgnoreDistance and Distance > 15 then continue end

        -- ตรวจสอบ Variant ที่ต้อง ignore
        local Variant = Plant:FindFirstChild("Variant")
        if Variant and HarvestIgnores[Variant.Value] then continue end

        -- เพิ่มในรายการถ้าเก็บได้
        if CanHarvest(Plant) then
            table.insert(Plants, Plant)
        end
    end
    
    return Plants
end

--// ฟังก์ชันหาพืชทั้งหมดที่เก็บเกี่ยวได้
local function GetHarvestablePlants(IgnoreDistance)
    local Plants = {}
    CollectHarvestable(PlantsPhysical, Plants, IgnoreDistance)
    return Plants
end

--// ฟังก์ชันเก็บเกี่ยวพืช
local function HarvestPlant(Plant)
    local Prompt = Plant:FindFirstChild("ProximityPrompt", true)
    if not Prompt then return end
    
    fireproximityprompt(Prompt)
end

--// ฟังก์ชันเก็บเกี่ยวทั้งหมด
local function HarvestAllPlants()
    local Plants = GetHarvestablePlants()
    for _, Plant in pairs(Plants) do
        HarvestPlant(Plant)
    end
end

--// Loop หลักของ AutoHarvest
local function AutoHarvestLoop()
    while wait(0.01) do
        if not AutoHarvestEnabled then continue end
        HarvestAllPlants()
    end
end

--// เริ่มระบบ
coroutine.wrap(AutoHarvestLoop)()

--// ฟังก์ชันควบคุม (เรียกใช้จากภายนอก)
local AutoHarvest = {}

function AutoHarvest:Enable()
    AutoHarvestEnabled = true
    print("✅ AutoHarvest เปิดใช้งาน")
end

function AutoHarvest:Disable()
    AutoHarvestEnabled = false
    print("❌ AutoHarvest ปิดใช้งาน")
end

function AutoHarvest:Toggle()
    AutoHarvestEnabled = not AutoHarvestEnabled
    print(AutoHarvestEnabled and "✅ AutoHarvest เปิด" or "❌ AutoHarvest ปิด")
end

function AutoHarvest:SetIgnore(variant, value)
    if HarvestIgnores[variant] ~= nil then
        HarvestIgnores[variant] = value
        print(string.format("🔧 ตั้งค่า Ignore %s = %s", variant, tostring(value)))
    end
end

function AutoHarvest:HarvestOnce()
    HarvestAllPlants()
    print("🌾 เก็บเกี่ยวครั้งเดียว")
end

return AutoHarvest

AutoHarvestEnabled = true

--[[
    วิธีใช้งาน:
    
    AutoHarvest:Enable()              -- เปิดใช้งาน
    AutoHarvest:Disable()             -- ปิดใช้งาน
    AutoHarvest:Toggle()              -- สลับเปิด/ปิด
    AutoHarvest:HarvestOnce()         -- เก็บเกี่ยวครั้งเดียว
    AutoHarvest:SetIgnore("Gold", true)  -- ไม่เก็บพืชทอง
]]