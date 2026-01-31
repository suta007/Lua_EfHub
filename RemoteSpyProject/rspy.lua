-- Remote Spy Project v0.1
-- Use Fluent UI Library form 'Core/Gui.lua'

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Remote Spy Project v0.1", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 0,
    Size = UDim2.fromOffset(580, 380),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    --MinSize = Vector2.new(470, 380),
    Acrylic = false, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
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
-- ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 40          -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {}      -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {}  -- ตารางเก็บประวัติทั้งหมด
local IsPaused = false

-- [สำคัญ] ประกาศตัวแปร LogDisplay ไว้ก่อน เพื่อให้ปุ่มรู้จักตัวแปรนี้
local LogDisplay = nil 

------------------------------------------------------
-- สร้างปุ่มควบคุม (อยู่ด้านบน)
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
-- สร้างหน้าจอแสดงผล
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
})

------------------------------------------------------
-- ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
    if IsPaused then return end

    local timestamp = os.date("%X")
    local entry = string.format("[%s] %s", timestamp, message)
    
    -- เก็บลงประวัติทั้งหมด
    table.insert(FullHistoryTable, entry)
    
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
-- ฟังก์ชันเสริม (Wrapper Functions)
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

InfoLog("Script initialized successfully.")
task.wait(0.5)


--[[ 
    ส่วนนี้คัดลอกไปวางต่อจากบรรทัดที่มี function AddLog(message) ... end 
    และต่อจาก GUI Code ของพี่เอฟ
]]

local mt = getrawmetatable(game)
local oldNamecall = mt.__namecall

-- ปลดล็อกให้แก้ไข metatable ได้
setreadonly(mt, false)

-- ฟังก์ชันช่วยแปลง Table เป็น String เพื่อให้อ่านง่ายขึ้น (กัน Error เวลาเจอข้อมูลแปลกๆ)
local function TableToString(tbl)
    local result = "{"
    for k, v in pairs(tbl) do
        if type(v) == "table" then
            result = result .. tostring(k) .. ": " .. "table, "
        else
            result = result .. tostring(k) .. ": " .. tostring(v) .. ", "
        end
    end
    return result .. "}"
end

-- ทำการ Hook __namecall เพื่อดักจับ Event
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod()
    local args = {...}

    -- ตรวจสอบว่าเป็น RemoteEvent (FireServer) หรือ RemoteFunction (InvokeServer) หรือไม่
    if method == "FireServer" or method == "InvokeServer" then
        
        -- สร้างข้อความที่จะโชว์ใน Log
        local remoteName = self.Name
        local argsString = ""

        -- วนลูปแกะข้อมูลใน Arguments ที่ส่งไป
        for i, v in ipairs(args) do
            if type(v) == "table" then
                argsString = argsString .. TableToString(v) .. ", "
            else
                argsString = argsString .. tostring(v) .. ", "
            end
        end

        -- ส่งข้อความเข้าสู่ระบบ Log ของพี่เอฟ
        local logMessage = "[Remote]: " .. remoteName .. " | [Args]: " .. argsString
        
        -- เรียกใช้ฟังก์ชัน AddLog ที่พี่เอฟมีอยู่แล้ว
        pcall(function()
            AddLog(logMessage) 
        end)
    end

    -- ปล่อยให้เกมทำงานต่อไปตามปกติ (ถ้าไม่ใส่บรรทัดนี้ เกมจะพังหรือคำสั่งไม่ทำงาน)
    return oldNamecall(self, ...)
end)

-- ล็อก metatable กลับคืน
setreadonly(mt, true)

-- แจ้งเตือนว่าเริ่มทำงานแล้ว
AddLog("Remote Spy Started! Waiting for signals...")