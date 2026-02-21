local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")

-- อ้างอิงไปยัง Event และโฟลเดอร์ UI ที่เกมจะสร้างหน้าต่างแจ้งเตือน
local giftEvent = ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("GiftPet")
local giftNotificationFrame =
	LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gift_Notification"):WaitForChild("Frame")

task.wait(0.3)

giftEvent.OnClientEvent:Connect(function(arg1, arg2, arg3)
	-- 1. หน่วงเวลาเล็กน้อย (0.5 วินาที) ให้เกมสร้าง UI บนหน้าจอให้เสร็จก่อน
	task.wait(0.5)

	-- 2. วนลูปเช็ค UI ทั้งหมดที่อยู่ใน Frame (เผื่อมีคนส่งมาพร้อมกันหลายคน)
	for _, uiElement in pairs(giftNotificationFrame:GetChildren()) do
		-- 3. ตรวจสอบโครงสร้างว่าเป็น UI แจ้งเตือนของขวัญจริงๆ (ต้องมี Holder > Frame > Accept)
		if uiElement:FindFirstChild("Holder") and uiElement.Holder:FindFirstChild("Frame") then
			local acceptButton = uiElement.Holder.Frame:FindFirstChild("Accept")

			-- 4. ถ้าเจอปุ่ม Accept ให้ใช้คำสั่งของ Delta Executor เพื่อจำลองการคลิก
			if acceptButton then
				for _, connection in pairs(getconnections(acceptButton.MouseButton1Click)) do
					connection:Fire() -- สั่งทำงานเหมือนมีคนเอานิ้วไปกดปุ่มจริงๆ
				end

				print(
					"🖱️ ระบบ Auto-Accept แบบเนียนๆ รับของขวัญจาก @"
						.. tostring(arg3)
						.. " สำเร็จ!"
				)

				-- หน่วงเวลาสั้นๆ ก่อนกดอันถัดไป (ถ้ามี) ป้องกันเกมรวน
				task.wait(0.2)
			end
		end
	end
end)

print(
	"✅ สคริปต์รอรับสัตว์เลี้ยงแบบจำลองกดปุ่ม เริ่มทำงานแล้ว!"
)

--[[

local args = {
	"GivePet",
	game:GetService("Players"):WaitForChild("Pn_Pat09"),
}
game:GetService("ReplicatedStorage")
	:WaitForChild("GameEvents")
	:WaitForChild("PetGiftingService")
	:FireServer(unpack(args))

local args = {
	false,
	"7e8b23b9-2c90-4c66-ab32-83f03a147509",
}
game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("AcceptPetGift"):FireServer(unpack(args))

]]
