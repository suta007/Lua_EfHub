local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local GetData_result = DataService:GetData()
local LocalPlayer = game:GetService("Players").LocalPlayer
local MyName = LocalPlayer.Name

local fData = GetData_result.SaveSlots.AllSlots.DEFAULT.SavedObjects
--local PetHatchData = fData[EggUUID] --เช่น fData["{8035761e-dcc7-4173-976e-1c82b41d62a3}"]
local GetMyFarm

--workspace.Farm.Farm.Important.Objects_Physical

GetMyFarm = function()
	local farmFolder = workspace:FindFirstChild("Farm")
	if not farmFolder then
		return nil
	end
	for _, oFarm in pairs(farmFolder:GetChildren()) do
		local success, owner = pcall(function()
			return oFarm.Important.Data.Owner.Value
		end)

		if success and owner == MyName then
			return oFarm
		end
	end
	return nil
end

local Egglist = {}
local MyFarm = GetMyFarm()

local Farm_Important = MyFarm:FindFirstChild("Important")
local Objects_Physical = Farm_Important and Farm_Important:FindFirstChild("Objects_Physical")
if Objects_Physical then
	for _, oEgg in pairs(Objects_Physical:GetChildren()) do
		if oEgg and oEgg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
			print(oEgg:GetAttribute("OBJECT_UUID"))
			table.insert(Egglist, oEgg:GetAttribute("OBJECT_UUID"))
		end
	end
end

for _, EggUUID in ipairs(Egglist) do
	local PetHatchData = fData[EggUUID]
	if PetHatchData.Data.CanHatch then
		print("ObjectType : " .. PetHatchData.ObjectType)
		print("Type : " .. tostring(PetHatchData.Data.Type))
		print("BaseWeight : " .. tostring(PetHatchData.Data.BaseWeight))
		print("CanHatch : " .. tostring(PetHatchData.Data.CanHatch))
		print("++++++++++++++++")
	end
end

--[[ 

--ฟักไข
local args = {
	"HatchPet",
	Instance.new("Model", nil)
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))

local args = {
	"HatchPet",
	Instance.new("Model", nil)
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))


วางไข่

local args = {
	"CreateEgg",
	vector.create(-3.8817138671875, 0.1355266571044922, -78.86181640625)
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))

local args = {
	"CreateEgg",
	vector.create(-0.965306282043457, 0.1355266571044922, -84.25543212890625)
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetEggService"):FireServer(unpack(args))

 ]]

--[[
 -- จากโค้ดของพี่เอฟ
 for _, oEgg in pairs(Objects_Physical:GetChildren()) do
     if oEgg and oEgg:GetAttribute("OBJECT_TYPE") == "PetEgg" then
         local uuid = oEgg:GetAttribute("OBJECT_UUID")
         local PetHatchData = fData[uuid]
         
         -- ถ้าพร้อมฟัก (CanHatch) และน้ำหนักได้ตามต้องการ
         if PetHatchData and PetHatchData.Data.CanHatch then
             print("กำลังส่งคำสั่งฟักไข่ UUID: " .. uuid)
             
             -- ส่งตัว 'oEgg' (ซึ่งก็คือ Instance ที่ Spy บอกว่าเป็น Model) ไปฟัก
             game:GetService("ReplicatedStorage").GameEvents.PetEggService:FireServer("HatchPet", oEgg)
         end
     end
 end
 ]]



workspace.Farm.Farm.Important.Plant_Locations:GetChildren()[2]
Atribute
 - Size : 37, 0.0010000000474974513, 82
 - CFrame : 8.99998474, 0.110527039, -116.502449, 1, 0, 0, 0, 1, 0, 0, 0, 1

workspace.Farm.Farm.Important.Plant_Locations.Can_Plant
Atribute
 -Size : 37, 0.0010000000474974513, 82
- CFrame : -41, 0.110527039, -116.502449, 1, 0, 0, 0, 1, 0, 0, 0, 1


--สวนอื่น
31, 0.0010000000474974513, 59
6.00002289, 0.110527039, 77.0665665, -1, 0, 0, 0, 1, 0, 0, 0, -1

31, 0.0010000000474974513, 59
-37.9999771, 0.110527039, 77.0665665, -1, 0, 0, 0, 1, 0, 0, 0, -1


local function GetExactFarmPos(platePart)
    if not platePart then return nil end
    
    local cf = platePart.CFrame
    local size = platePart.Size
    
    -- ล็อคค่าแกน Y ตามที่พี่เอฟดักจับมาได้
    local targetY = 0.1355266571044922
    
    -- คำนวณขอบเขตพื้นที่บนแผ่น (ลบออก 2 หน่วยเพื่อไม่ให้วางชิดขอบเกินไป)
    local minX, maxX = -size.X/2 + 2, size.X/2 - 2
    local minZ, maxZ = -size.Z/2 + 2, size.Z/2 - 2
    
    -- สุ่มตำแหน่ง X และ Z ภายในขอบเขตของแผ่นนั้นๆ
    local localX = math.random() * (maxX - minX) + minX
    local localZ = math.random() * (maxZ - minZ) + minZ
    
    -- แปลงจากพิกัด Local ของแผ่น ให้เป็นพิกัดโลก (World Position)
    -- โดยเราจะเอาแค่ค่า X และ Z จากการคำนวณ แล้วใช้ Y ที่พี่กำหนด
    local worldPos = (cf * CFrame.new(localX, 0, localZ)).Position
    
    return Vector3.new(worldPos.X, targetY, worldPos.Z)
end

-- วิธีการรันเพื่อวางไข่
local MyFarm = GetMyFarm() -- ใช้ฟังก์ชัน GetMyFarm เดิมที่พี่เขียนไว้
if MyFarm then
    local locations = MyFarm.Important.Plant_Locations:GetChildren()
    
    -- กรองเอาเฉพาะแผ่นที่ชื่อ Can_Plant
    local targetPlates = {}
    for _, p in pairs(locations) do
        if p.Name == "Can_Plant" then
            table.insert(targetPlates, p)
        end
    end

    if #targetPlates > 0 then
        -- สุ่มเลือก 1 แผ่น (ซ้ายหรือขวา) แล้วหาพิกัดวาง
        local selectedPlate = targetPlates[math.random(1, #targetPlates)]
        local finalPos = GetExactFarmPos(selectedPlate)
        
        if finalPos then
            print("🚀 กำลังวางไข่ที่พิกัด:", finalPos)
            game:GetService("ReplicatedStorage").GameEvents.PetEggService:FireServer("CreateEgg", finalPos)
        end
    end
end


็HitBox Size : 3.1245172023773193, 2.649517774581909, 2.6495068073272705