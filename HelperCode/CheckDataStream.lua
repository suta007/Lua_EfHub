local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
	Title = "Log Console 0.1", -- .. Fluent.Version,
	SubTitle = "by EfHub",
	TabWidth = 0,
	Size = UDim2.fromOffset(830, 525),
	Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
	MinSize = Vector2.new(470, 380),
	Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
	Theme = "Dark",
	MinimizeKey = Enum.KeyCode.RightControl, -- Used when theres no MinimizeKeybind
})

local Tabs = {
	Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือเปลี่ยนเป็น PlayerGui ถ้าไม่ติด
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(71, 1, 1)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "EF"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
	Window:Minimize() -- กดเพื่อ ย่อ/ขยาย หน้าจอ Fluent
end)
------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 50 -- จำนวนบรรทัดที่จะโชว์
local MaxFullHistory = 1000 -- จำนวนบรรทัดสูงสุดของประวัติทั้งหมด
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {} -- ตารางเก็บประวัติทั้งหมด
local IsPaused = false

-- [สำคัญ] ประกาศตัวแปร LogDisplay ไว้ก่อน เพื่อให้ปุ่มรู้จักตัวแปรนี้
local LogDisplay = nil

------------------------------------------------------
-- 2. สร้างปุ่มควบคุม (อยู่ด้านบน)
------------------------------------------------------

-- ปุ่มหยุด (Pause)
Tabs.Main:AddToggle("PauseSwitch", {
	Title = "Pause Logging",
	Default = false,
	Callback = function(Value)
		IsPaused = Value
	end,
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
	Title = "Copy All Logs",
	--Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(table.concat(FullHistoryTable, "\n"))
			Fluent:Notify({ Title = "Success", Content = "Copied all logs!", Duration = 2 })
		else
			Fluent:Notify({ Title = "Error", Content = "Executor not supported", Duration = 2 })
		end
	end,
})

-- ปุ่ม Clear
Tabs.Main:AddButton({
	Title = "Clear Logs",
	Callback = function()
		DisplayTable = {}
		FullHistoryTable = {}
		if LogDisplay then
			LogDisplay:SetDesc("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph({
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------

local function AddLog(ts, message)
	if IsPaused then
		return
	end
	local entry
	local Addtime = ts or false
	if Addtime then
		local timestamp = os.date("%X")
		entry = string.format("[%s] %s", timestamp, message)
	else
		entry = message
	end

	-- เก็บลงประวัติทั้งหมด
	table.insert(FullHistoryTable, entry)
	if #FullHistoryTable > MaxFullHistory then
		table.remove(FullHistoryTable, 1)
	end

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then
		table.remove(DisplayTable, 1)
	end

	-- อัปเดตหน้าจอ
	if LogDisplay then
		LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
	end
end

------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
local function InfoLog(message)
	AddLog(true, "📋 " .. message)
end

local function WarnLog(message)
	AddLog(true, "⚠️ " .. message)
end

local function ErrorLog(message)
	AddLog(true, "❌ " .. message)
end

local function SuccessLog(message)
	AddLog(true, "✅ " .. message)
end

------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)
SuccessLog("Connected to server.")

LocalPlayer = game:GetService("Players").LocalPlayer
DataStream = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("DataStream")
WarnLog("Listening to DataStream events...")
task.wait(0.5)

local BacklistPackets = {
	"ROOT/SaveSlots/AllSlots/DEFAULT/LastPetEggsIncubationTime",
	"ROOT/LastSaveTime",
	"ROOT/LastPetsIncubationTime",
	"ROOT/LastPetsSaveTime",
	"ROOT/TravelingMerchantShopStock/Stocks",
}

DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
	-- InfoLog("Received DataStream event: " .. Type)
	-- InfoLog("Profile: " .. Profile)

	-- เช็คว่าข้อมูลที่ส่งมาเป็นประเภท "UpdateData" หรือไม่
	-- if Type ~= "UpdateData" then return end

	-- เช็คว่าเป็นข้อมูลของตัวเราเองหรือไม่
	if not Profile:find(LocalPlayer.Name) then
		return
	end

	-- ต้องการดูว่าใน data มีอะไรบ้าง
	for index, packet in pairs(Data) do
		if not table.find(BacklistPackets, packet[1]) then
			AddLog(false, string.format("Packet %d: Key=%s", index, packet[1]))
			--InfoLog(string.format("Content: %s", tostring(packet[2])))
			if type(packet[2]) == "table" then
				for index2, content in pairs(packet[2]) do
					InfoLog(string.format("  Content %d: ID=%s", index2))
					if type(content) == "table" then
						for key, value in pairs(content) do
							InfoLog(string.format("    %s = %s", key, tostring(value)))
						end
                    else
                        InfoLog(string.format("    Value: %s", tostring(content)))
					end
				end
			else
				InfoLog(string.format("Content: %s", tostring(packet[2])))
			end
		end
	end
end)
