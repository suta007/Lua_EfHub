-- Remote Spy Project v0.1
-- Use Fluent UI Library form 'Core/Gui.lua'

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Remote Spy Project v0.1.3", -- .. Fluent.Version,
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
ToggleButton.Text = "rSpy"
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
-- Remote Spy (Version: Mobile Optimized)
-- สคริปต์สำหรับดักจับข้อมูลที่เกมส่งไป Server (เหมาะสำหรับมือถือ)
--------------------------------------------------------------------------------

-- 1. แจ้งเตือนว่าเริ่มทำงานแล้ว
AddLog("Initializing Mobile Spy...") 

-- 2. ตรวจสอบความพร้อมของ Executor (ตัวรันโปรแกรม)
-- คำสั่ง getrawmetatable เป็นคำสั่งระดับสูง ถ้าไม่มี แสดงว่า Executor รุ่นนี้ไม่รองรับ
if not getrawmetatable then
    AddLog("Error: getrawmetatable not found! (Executor ไม่รองรับ)")
    return -- จบการทำงานทันทีถ้าไม่รองรับ
end

-- 3. ดึงตาราง Metatable ของตัวเกม (game) มาเก็บไว้
-- Metatable เปรียบเสมือน "คู่มือการทำงานเบื้องหลัง" ของ object นั้นๆ
local mt = getrawmetatable(game)

-- 4. สำรองฟังก์ชัน __namecall ตัวเดิมเก็บไว้
-- __namecall คือฟังก์ชันที่จะถูกเรียกทำงานเมื่อ object ในเกมมีการเรียก method (เช่น game:GetService(...))
-- เราต้องเก็บตัวเก่าไว้ เพื่อให้หลังจากเราแอบดูข้อมูลเสร็จ เราจะได้ส่งให้มันทำงานต่อได้ตามปกติ
local oldNamecall = mt.__namecall

-- 5. ปลดล็อก Metatable ให้แก้ไขได้
-- ปกติ Metatable ของเกมจะถูกล็อกเป็น Read-only (อ่านได้อย่างเดียว) เราต้องปลดล็อกก่อนเพื่อแทรกโค้ดเราลงไป
setreadonly(mt, false)

-- 6. ฟังก์ชันช่วยแปลงข้อมูล (Arguments) ให้เป็นตัวหนังสือ (String)
-- ใช้สำหรับแปลงข้อมูลที่ดักจับได้ เพื่อเอาไปโชว์ใน Log
local function SafeArgsString(args)
    -- ใช้ pcall (Protected Call) เพื่อป้องกัน Error 
    -- ถ้าข้อมูลตัวไหนแปลงเป็นตัวหนังสือไม่ได้ โปรแกรมจะได้ไม่หยุดทำงาน
    local success, result = pcall(function()
        local str = ""
        -- วนลูปดูข้อมูลทุกตัวที่ส่งมา
        for i, v in pairs(args) do
            str = str .. tostring(v) .. ", " -- แปลงเป็น string แล้วต่อด้วยลูกน้ำ
        end
        return str
    end)
    
    -- ถ้าแปลงสำเร็จให้ส่งค่ากลับ ถ้าไม่สำเร็จให้บอกว่า Error
    if success then return result else return "Error parsing args" end
end

-- 7. *** หัวใจสำคัญ *** การเขียนทับ (Hook) ฟังก์ชัน __namecall
-- เราสร้างฟังก์ชันใหม่ขึ้นมาแทนที่ตัวเดิม (newcclosure ช่วยให้ตรวจจับยากขึ้น)
mt.__namecall = newcclosure(function(self, ...)
    
    -- ดึงชื่อ Method ที่กำลังถูกเรียกใช้ (เช่น "FireServer", "Kick", "WalkTo")
    local method = getnamecallmethod()
    
    -- แปลง method เป็นตัวหนังสือ แล้วเช็คว่าใช่คำสั่งส่งข้อมูลไป Server ไหม?
    -- "FireServer" = ส่งข้อมูลไป (RemoteEvent)
    -- "InvokeServer" = ส่งข้อมูลไปและรอตอบกลับ (RemoteFunction)
    if tostring(method) == "FireServer" or tostring(method) == "InvokeServer" then
        
        -- เก็บข้อมูล (Arguments) ที่ส่งมาทั้งหมดใส่ตัวแปร args
        local args = {...}
        -- เก็บชื่อของ Remote ที่ถูกเรียกใช้
        local remoteName = tostring(self.Name)
        -- แปลงข้อมูล args เป็นข้อความเพื่อเตรียมแสดงผล
        local argsData = SafeArgsString(args)
        
        -- 8. แยกการทำงาน (Spawn Thread) *** สำคัญมากสำหรับมือถือ ***
        -- เราใช้ task.spawn เพื่อแยกการแสดงผล Log ออกจาก Thread หลักของเกม
        -- ข้อดี: ทำให้เกมไม่สะดุด และลดโอกาสที่ GUI จะค้างหรือชนกับระบบเกม
        task.spawn(function()
            pcall(function()
                -- ส่งข้อความเข้าสู่ระบบ Log GUI ของพี่เอฟ
                AddLog("[Spy] " .. remoteName .. " : " .. argsData)
            end)
        end)
    end

    -- 9. ส่งคืนการทำงานให้ฟังก์ชันเดิม (oldNamecall)
    -- สำคัญที่สุด! ถ้าไม่มีบรรทัดนี้ เกมจะหยุดทำงาน (เพราะคำสั่งไปไม่ถึง Server)
    return oldNamecall(self, ...)
end)

-- 10. ล็อก Metatable กลับให้เป็นเหมือนเดิม
-- เพื่อความปลอดภัยและทำให้เกมจับผิดได้ยากขึ้น
setreadonly(mt, true)

-- แจ้งเตือนเมื่อติดตั้งระบบดักจับเสร็จสมบูรณ์
AddLog("Spy Started! Check logs now.")