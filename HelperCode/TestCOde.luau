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

local PlantData = GetData_result.CropMastery.PlantData
local function ShowData(tbl, indent)
	local lclIndent = indent or 0
	local spacing = string.rep("  ", lclIndent)
	for k, v in pairs(tbl) do
		if type(v) == "table" then
			AddLog(spacing .. "[" .. tostring(k) .. "] : (Table)")
			ShowData(v, lclIndent + 1)
		else
			AddLog(spacing .. "[" .. tostring(k) .. "] : " .. tostring(v))
		end
		--return
	end
end
--ShowData(PlantData, 1)


local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")

local ActivePetsService = require(ReplicatedStorage.Modules.PetServices.ActivePetsService)

local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")

local GetRawPetData , GetPetFavorite, MakePetFavorite, MakePetUnfavorite


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

GetPetFavorite = function(uuid)
	local data = GetRawPetData(uuid)
	if data and data.PetData then
		local Favorited = data.PetData.IsFavorite
		if Favorited then
			return Favorited
		end
	end
	return nil
end

MakePetFavorite = function(uuid)
	local timeout = 3 -- รอสูงสุด 3 วินาที
	local startTime = tick()
	if not GetPetFavorite(uuid) then
		repeat
			for _, item in ipairs(Backpack:GetChildren()) do
				if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
					local args = {
						item
					}
					GameEvents:WaitForChild("Favorite_Item"):FireServer(unpack(args))

					task.wait(0.3) -- รอให้ถือติด
					return true
				end
			end
			task.wait(0.2)
		until tick() - startTime > timeout
	end
	return false
end

MakePetUnfavorite = function(uuid)
	local timeout = 3 -- รอสูงสุด 3 วินาที
	local startTime = tick()
	if GetPetFavorite(uuid) then
		repeat
			for _, item in ipairs(Backpack:GetChildren()) do
				if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
					local args = {
						item
					}
					GameEvents:WaitForChild("Favorite_Item"):FireServer(unpack(args))

					task.wait(0.3) -- รอให้ถือติด
					return true
				end
			end
			task.wait(0.2)
		until tick() - startTime > timeout
	end
	return false
end

local pUUID= "{1e61fc9a-d1f4-4513-bb6b-de543547c8e1}"

--MakePetFavorite(pUUID)
MakePetUnfavorite(pUUID)