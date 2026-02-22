local Path = game:GetService("ReplicatedStorage").Modules.PetServices.PetsService
local PetsService = require(Path)

print("--- [ การตรวจสอบ PetsService ] ---")

-- 1. ตรวจสอบฟังก์ชันใน Table หลัก
for i, v in pairs(PetsService) do
	if type(v) == "function" then
		print("Found Function: " .. tostring(i))
	elseif type(v) == "table" then
		print("Found Table: " .. tostring(i))
		-- บางครั้งฟังก์ชันสำหรับ Client จะซ่อนอยู่ใน table ย่อย เช่น .Client
		if i == "Client" then
			for k, val in pairs(v) do
				if type(val) == "function" then
					print("   -> Client Function: " .. tostring(k))
				end
			end
		end
	end
end

-- 2. ตรวจสอบ Metatable (ในกรณีที่ใช้ OOP หรือระบบ Service)
local mt = getrawmetatable(PetsService)
if mt and mt.__index and type(mt.__index) == "table" then
	print("--- [ ฟังก์ชันใน Metatable ] ---")
	for i, v in pairs(mt.__index) do
		if type(v) == "function" then
			print("Found MT Function: " .. tostring(i))
		end
	end
end

print("--- [ จบการตรวจสอบ ] ---")
