-- Remote Spy Project v0.1
-- Use Fluent UI Library form 'Core/Gui.lua'

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Remote Spy Project v0.1.1", -- .. Fluent.Version,
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

--------------------------------------------------------------------------------
-- Remote Spy Logic (วางไว้ล่างสุดของ Script ต่อจาก AddLog)
--------------------------------------------------------------------------------

local LOG_REMOTE_EVENT = true    -- ต้องการดัก FireServer ไหม?
local LOG_REMOTE_FUNCTION = true -- ต้องการดัก InvokeServer ไหม?

-- ฟังก์ชันแปลง Table เป็นข้อความ (Serializer) เพื่อให้อ่านง่าย
local function FormatArgs(args)
    local output = {}
    for i, v in pairs(args) do
        local valueType = type(v)
        local valueStr = tostring(v)
        
        if valueType == "table" then
            valueStr = "Table" -- (ถ้าต้องการดูไส้ใน Table อาจต้องเขียนฟังก์ชัน Recursive เพิ่ม)
        elseif valueType == "string" then
            valueStr = '"' .. v .. '"'
        elseif valueType == "Instance" then
            valueStr = v.Name
        end
        table.insert(output, valueStr)
    end
    return table.concat(output, ", ")
end

-- ตรวจสอบว่า Executor รองรับ hookmetamethod หรือไม่
if not hookmetamethod then
    AddLog("Error: Your executor does not support hookmetamethod!")
    return
end

local OldNameCall = nil

-- เริ่มการ Hook
OldNameCall = hookmetamethod(game, "__namecall", newcclosure(function(self, ...)
    local Method = getnamecallmethod()
    local Args = {...}

    -- ตรวจสอบว่าเป็น RemoteEvent หรือ RemoteFunction
    if (self.ClassName == "RemoteEvent" and Method == "FireServer" and LOG_REMOTE_EVENT) or 
       (self.ClassName == "RemoteFunction" and Method == "InvokeServer" and LOG_REMOTE_FUNCTION) then

        -- ห่อหุ้มด้วย pcall เพื่อกัน Script พังถ้ามี Error ในการแปลงข้อความ
        pcall(function()
            local remoteName = self.Name
            local argsData = FormatArgs(Args)
            local logMsg = string.format("[Remote] %s | Args: %s", remoteName, argsData)
            
            -- ส่งเข้า GUI
            AddLog(logMsg)
            
            -- (Option) ปริ้นลง Console (F9) เผื่อ GUI ไม่ขึ้น
            print("Spy Caught: " .. logMsg)
        end)
    end

    return OldNameCall(self, ...)
end))

AddLog("Remote Spy Hooks Initialized Successfully.")