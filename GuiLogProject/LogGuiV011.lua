--[[
    My Custom Log Console GUI
    by EfHub
    Version: 0.1.1]]
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

-- [[ 1. สร้างหน้าจอหลัก ]]
local Window = Fluent:CreateWindow({
    Title = "Log Console 0.1",
    SubTitle = "by EfHub",
    TabWidth = 80,
    Size = UDim2.fromOffset(830, 525),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 2. ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือเปลี่ยนเป็น PlayerGui ถ้าไม่ติด
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "LOG"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize() -- กดเพื่อ ย่อ/ขยาย หน้าจอ Fluent
end)

------------------------------------------------------
-- 3. ระบบ Log และปุ่มควบคุมพื้นฐาน
------------------------------------------------------
local MaxLines = 20
local DisplayTable = {}
local FullHistoryTable = {}
local IsPaused = false
local LogDisplay = nil 

Tabs.Main:AddToggle("PauseSwitch", {
    Title = "Pause Logging",
    Default = false,
    Callback = function(Value) IsPaused = Value end
})

Tabs.Main:AddButton({
    Title = "Clear Logs",
    Callback = function()
        DisplayTable = {}
        FullHistoryTable = {}
        if LogDisplay then LogDisplay:SetDesc("") end
    end
})

LogDisplay = Tabs.Main:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
})

local function AddLog(message)
    if IsPaused then return end

    local timestamp = os.date("%X")
    local entry = string.format("[%s] %s", timestamp, message)
    
    table.insert(FullHistoryTable, 1, entry)
    table.insert(DisplayTable, 1, entry)
    if #DisplayTable > MaxLines then
        table.remove(DisplayTable, #DisplayTable)
    end
    
    if LogDisplay then
        LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
    end
end

local function InfoLog(message) AddLog("📋 " .. message) end
local function SuccessLog(message) AddLog("✅ " .. message) end

------------------------------------------------------
-- 4. รันการทำงาน (Loop เทส)
------------------------------------------------------
InfoLog("Script Loaded!")

task.spawn(function()
    while true do -- รันยาวๆ ไม่ต้องมีระบบเช็คหยุด
        task.wait(2)
        SuccessLog("Bot is running normally...")
    end
end)

-- Anti-AFK แบบธรรมดา
game:GetService("Players").LocalPlayer.Idled:Connect(function()
    game:GetService("VirtualUser"):CaptureController()
    game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)