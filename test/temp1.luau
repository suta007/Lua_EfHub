local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- 1. สร้าง GUI หลัก
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "DraggableToggleUI"
ScreenGui.Parent = CoreGui

-- 2. สร้างปุ่มสำหรับ Toggle
local ToggleButton = Instance.new("TextButton")
ToggleButton.Parent = ScreenGui
ToggleButton.Size = UDim2.new(0, 40, 0, 40)
ToggleButton.Position = UDim2.new(0.5, 0, 0.1, 0)
ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0) -- เริ่มต้นสีแดง
ToggleButton.Text = ""

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 8)
UICorner.Parent = ToggleButton

-- 3. ระบบลาก (Drag System)
local dragging = false
local dragInput, dragStart, startPos

local function update(input)
	local delta = input.Position - dragStart
	-- คำนวณตำแหน่งใหม่และอัปเดตให้ปุ่มขยับตามเมาส์
	ToggleButton.Position =
		UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

-- เมื่อเริ่มคลิกที่ปุ่ม
ToggleButton.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 or input.UserInputType == Enum.UserInputType.Touch then
		dragging = true
		dragStart = input.Position
		startPos = ToggleButton.Position

		-- ตรวจสอบการปล่อยเมาส์
		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
	end
end)

-- ตรวจจับการขยับเมาส์ขณะที่อยู่บนปุ่ม
ToggleButton.InputChanged:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
		dragInput = input
	end
end)

-- อัปเดตตำแหน่งปุ่มตามการขยับเมาส์
UserInputService.InputChanged:Connect(function(input)
	if input == dragInput and dragging then
		update(input)
	end
end)

-- 4. ระบบ Toggle เปิด/ปิด (ทำงานเหมือนเดิม)
local isToggled = false

ToggleButton.MouseButton1Click:Connect(function()
	isToggled = not isToggled -- สลับสถานะ

	if isToggled then
		ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 255, 0)
		print("🟢 เริ่มการทำงานอัตโนมัติ")
		task.spawn(function()
			while isToggled do
				game:GetService("ReplicatedStorage")
					:WaitForChild("GameEvents")
					:WaitForChild("ValentinesEvent")
					:WaitForChild("ClaimValentineReward2")
					:FireServer()
				task.wait(5)
			end
		end)
	else
		ToggleButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
		print("🔴 หยุดการทำงาน")
	end
end)
