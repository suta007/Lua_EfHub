local Fluent = loadstring(game:HttpGetAsync(
    "https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGetAsync(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGetAsync(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()

local Window = Fluent:CreateWindow({
    Title = "Grow a Garden", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 100,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Buy = Window:AddTab({
        Title = "Auto Buy",
        Icon = "shopping-cart"
    }),
    Pet = Window:AddTab({
        Title = "Auto Pet",
        Icon = "bone"
    }),
    Farm = Window:AddTab({
        Title = "Auto Farm",
        Icon = "tree-pine"
    }),
    Log = Window:AddTab({
        Title = "Log Console",
        Icon = "terminal"
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    })
}
local Options = Fluent.Options
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)
SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/GAG")
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)
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
ToggleButton.BackgroundColor3 = Color3.fromRGB(101, 1, 1)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "EfHub"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize() -- กดเพื่อ ย่อ/ขยาย หน้าจอ Fluent
end)

local buySeedEnable = Tabs.Buy:AddToggle("buySeedEnable", {
    Title = "Buy Seeds",
    Default = false
})
local buySeedAll = Tabs.Buy:AddToggle("buySeedAll", {
    Title = "Buy All Seeds",
    Default = false
})
local SeedFilter = Tabs.Buy:AddInput("SeedFilter", {
    Title = "Search",
    Default = ""
})
local SeedData = require(game:GetService("ReplicatedStorage").Data.SeedData) -- This is table data of seeds
local SeedTable = {}
for seedName, seedInfo in pairs(SeedData) do
    table.insert(SeedTable, seedName)
end

local SeedList = Tabs.Buy:AddDropdown("SeedList", {
    Title = "Seeds",
    Description = "Select seeds to buy",
    Values = SeedTable,
    Multi = true,
    Default = {},
    displayer = true,
    Searchable = true
})

SeedList:OnChanged(function(Value)
    SaveManager:Save(SaveManager.CurrentConfig)
end)

local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local LogDisplay = nil

-- ปุ่ม Clear
Tabs.Log:AddButton({
    Title = "Clear Logs",
    Callback = function()
        DisplayTable = {}
        if LogDisplay then
            LogDisplay:SetDesc("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
        end
    end
})

LogDisplay = Tabs.Log:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------

local function AddLog(message)

    local entry = string.format("[%s] %s", os.date("%X"), message)

    -- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
    table.insert(DisplayTable, entry)
    if #DisplayTable > MaxLines then
        table.remove(DisplayTable, 1)
    end
    if LogDisplay then
        LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
    end
end

SaveManager:LoadAutoloadConfig()
