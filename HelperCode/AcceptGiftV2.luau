local Players = game:GetService("Players")
local VirtualInputManager = game:GetService("VirtualInputManager")
local GuiService = game:GetService("GuiService")
local LocalPlayer = Players.LocalPlayer

local giftGui = LocalPlayer:WaitForChild("PlayerGui"):WaitForChild("Gift_Notification")
local mainFrame = giftGui:WaitForChild("Frame")

-- ฟังก์ชัน: ซ่อน UI อื่น -> สั่งคลิกด้วย VIM -> คืนค่า UI
local function clearPathAndClick(button)
	local playerGui = LocalPlayer.PlayerGui
	local hiddenGuis = {}

	-- 1. ซ่อน UI อื่นๆ ทั้งหมดชั่วคราว (ป้องกันการคลิกติด UI ที่ทับอยู่)
	for _, gui in pairs(playerGui:GetChildren()) do
		if gui:IsA("ScreenGui") and gui.Name ~= "Gift_Notification" and gui.Enabled == true then
			gui.Enabled = false
			table.insert(hiddenGuis, gui)
		end
	end

	-- 2. คำนวณพิกัดปุ่ม (บวก GuiInset เพื่อความแม่นยำ 100%)
	local inset, _ = GuiService:GetGuiInset()
	local x = button.AbsolutePosition.X + (button.AbsoluteSize.X / 2)
	local y = button.AbsolutePosition.Y + (button.AbsoluteSize.Y / 2) + inset.Y

	print(
		"🖱️ [VIM] สั่งคลิก Accept แบบรวดเร็วที่พิกัด: X="
			.. math.floor(x)
			.. ", Y="
			.. math.floor(y)
	)

	-- 3. ยิงคำสั่งเมาส์จำลอง
	VirtualInputManager:SendMouseButtonEvent(x, y, 0, true, game, 1) -- เมาส์กดลง
	task.wait(0.05)
	VirtualInputManager:SendMouseButtonEvent(x, y, 0, false, game, 1) -- เมาส์ปล่อย

	-- 4. เปิด UI อื่นๆ กลับมาทันที (ไวมากจนตาแทบมองไม่ทัน)
	for _, gui in ipairs(hiddenGuis) do
		gui.Enabled = true
	end
end

-- ฟังก์ชัน: ตรวจจับและสั่งทำงาน
local function processGift(uiNode)
	task.spawn(function()
		local acceptBtn = nil
		local timeout = 0

		-- รอให้ปุ่ม Accept ปรากฏขึ้นมาในหน้าต่าง (รอนานสุด 3 วินาที)
		while timeout < 30 do
			acceptBtn = uiNode:FindFirstChild("Accept", true)
			if acceptBtn then
				break
			end

			task.wait(0.1)
			timeout = timeout + 1
		end

		if acceptBtn then
			-- หน่วงเวลาเล็กน้อยให้ UI ขยายตัวจนเสร็จแอนิเมชัน (ป้องกันคลิกพลาดพิกัด)
			task.wait(0.2)

			-- สั่งแหวกทางและคลิก
			clearPathAndClick(acceptBtn)
			print("✅ [Success] รับของขวัญเรียบร้อย!")
		else
			print("❌ [Error] ไม่พบปุ่ม Accept ในเวลาที่กำหนด")
		end
	end)
end

-- ดักจับเมื่อมีแจ้งเตือนใหม่
mainFrame.ChildAdded:Connect(function(child)
	processGift(child)
end)

-- เคลียร์แจ้งเตือนเก่าที่ค้างอยู่ตอนเพิ่งรันสคริปต์
for _, child in pairs(mainFrame:GetChildren()) do
	processGift(child)
end

print("🚀 ระบบ VIM Auto-Accept (Fast & Clean) รันสำเร็จค่ะพี่เอฟ!")
