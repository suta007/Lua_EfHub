local Fluent = loadstring(
	game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau")
)()

local Window = Fluent:CreateWindow({
	Title = "Console Log",
	SubTitle = "by EfHub",
	TabWidth = 0,
	Size = UDim2.fromOffset(1200, 768),
	Resize = true,
	-- MinSize = Vector2.new(470, 380),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
	Test = Window:AddTab({ Title = "Test", Icon = "setting" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local MaxFullHistory = 10000 -- จำนวนบรรทัดสูงสุดของประวัติทั้งหมด
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
			LogDisplay:SetValue("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph("LogDisplay", {
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
	if IsPaused then
		return
	end
	local entry = message
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
		local TempText = ""
		TempText = table.concat(DisplayTable, "\n")
		LogDisplay:SetValue(TempText)
	end
end
------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
local function InfoLog(message)
	AddLog("📋 " .. message)
end

local function WarnLog(message)
	AddLog("⚠️ " .. message)
end

local function ErrorLog(message)
	AddLog("❌ " .. message)
end

local function SuccessLog(message)
	AddLog("✅ " .. message)
end

local function TimeLog(message)
	local timestamp = os.date("%X")
	local entry = string.format("[%s] %s", timestamp, message)
	AddLog(entry)
end
------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local GetData_result = DataService:GetData()
--[[ local PetEggs = require(ReplicatedStorage.Data.PetRegistry.PetEggs)
for name, v in pairs(PetEggs) do
	print(tostring(name))
end ]]

local inventory = GetData_result and GetData_result.PetsData and GetData_result.PetsData.PetInventory
local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService)

local ngo = ActivePetsService:GetPetData("Patty_Nxch", "{a4cb6833-3c37-462e-b855-0f43288a8c22}")
local function ShowData(tbl, indent)
	local lclIndent = indent or 0
	local spacing = string.rep("  ", lclIndent)
	if type(tbl) == "table" then
		for k, v in pairs(tbl) do
			if type(v) == "table" then
				AddLog(spacing .. "[" .. tostring(k) .. "] : (Table)")
				ShowData(v, lclIndent + 1)
			else
				AddLog(spacing .. "[" .. tostring(k) .. "] : " .. tostring(v))
			end
			--return
		end
	else
		AddLog(spacing .. tostring(tbl))
	end
end

ShowData(ngo, 1)
