local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Log Console 0.1", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 80,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 20          -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {}      -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {}  -- ตารางเก็บประวัติทั้งหมด
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
    end
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
    Title = "Copy All Logs",
    --Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(table.concat(FullHistoryTable, "\n"))
            Fluent:Notify({Title="Success", Content="Copied all logs!", Duration=2})
        else
            Fluent:Notify({Title="Error", Content="Executor not supported", Duration=2})
        end
    end
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
    end
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
    if IsPaused then return end

    local timestamp = os.date("%X")
    local entry = string.format("[%s] %s", timestamp, message)
    
    -- เก็บลงประวัติทั้งหมด
    table.insert(FullHistoryTable, 1, entry)
    
    -- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
    table.insert(DisplayTable, 1, entry)
    if #DisplayTable > MaxLines then
        table.remove(DisplayTable, #DisplayTable)
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

------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)
SuccessLog("Connected to server.")

task.spawn(function()
    while true do
        task.wait(2)
        -- สุ่มเหตุการณ์เพื่อเทส
        local rand = math.random(1, 4)
        if rand == 1 then
            InfoLog("Searching for items...")
        elseif rand == 2 then
            WarnLog("HP is low (45%)")
        elseif rand == 3 then
            SuccessLog("Bought 100 Seeds")
        else
            ErrorLog("Failed to find path!")
        end
    end
end)