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
local upvals = debug.getupvalues(
	getconnections(game:GetService("ReplicatedStorage").GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function
)
--local fData = GetData_result.SaveSlots.AllSlots.DEFAULT.SavedObjects["{8035761e-dcc7-4173-976e-1c82b41d62a3}"]
local fData = GetData_result.SaveSlots.AllSlots.DEFAULT.SavedObjects

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

for x, y in pairs(upvals) do
	for a, b in pairs(y) do
		WarnLog(tostring(a))
		local pet = fData[tostring(a)]
		if type(pet) == "table" then
			InfoLog("ObjectType : " .. pet.ObjectType)
			InfoLog("Type : " .. pet.Data.Type)
			InfoLog("BaseWeight : " .. tostring(pet.Data.BaseWeight))
			InfoLog("CanHatch : " .. tostring(pet.Data.CanHatch))
		end
	end
end
--[[ task.spawn(function()
	while true do
		ShowData(fData, 1)
		task.wait(1)
	end
end) ]]

ShowData(upvals, 1)

local ObjectType = pet.ObjectType --PetEgg
local Type = pet.Data.Type -- ชนิดสัตว์
local BaseWeight = pet.Data.BaseWeight --น้ำหนัก
local CanHatch = pet.Data.CanHatch -- true

InfoLog("ObjectType : " .. ObjectType)
InfoLog("Type : " .. Type)
InfoLog("BaseWeight : " .. tostring(BaseWeight))
InfoLog("CanHatch : " .. tostring(CanHatch))

local ObjectType = fData.ObjectType --PetEgg
local Type = fData.Data.Type -- ชนิดสัตว์
local BaseWeight = fData.Data.BaseWeight --น้ำหนัก
local CanHatch = fData.Data.CanHatch -- true

InfoLog("ObjectType : " .. ObjectType)
InfoLog("Type : " .. Type)
InfoLog("BaseWeight : " .. tostring(BaseWeight))
InfoLog("CanHatch : " .. tostring(CanHatch))
