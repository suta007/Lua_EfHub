local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") then
        v:Destroy()
    end
end

settings().Rendering.QualityLevel = "Level01"

task.wait(1)

--[[ Log GUI ]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "EfHub Auto Buy 0.12", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 0,
    Size = UDim2.fromOffset(580, 380),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    --MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
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

--[[ Tabs.Main.AddToggle("AutoBuy", {
    Title = "Auto Buy",
    Default = false,
    Callback = function(Value) 
        AutoBuy = Value 
    end
}) ]]

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


--[[ Auto Buy ]]
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")

local BuyList ={
    ["ROOT/SeedStocks/Shop/Stocks"]={
        Enabled=true,
        BuyAll=false,
        Items= {"Orange Tulip", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco", "Crimson Thorn", "Zebrazinkle", "Octobloom", "Beast Buttercup", "Bonanza Bloom"},
        RemoteName="BuySeedStock",
        ArgType="SeedMode"
    },
    ["ROOT/GearStock/Stocks"]={
        Enabled=true,
        BuyAll=false,
        Items={"Watering Can", "Trading Ticket","Trowel","Recall Wrench","Basic Sprinkler","Advanced Sprinkler","Godly Sprinkler","Master Sprinkler","Grandmaster Sprinkler","Levelup Lollipop","Medium Toy","Medium Treat","Pet Lead","Harvest Tool","Magnifying Glass","Cleaning Spray","Favorite Tool","Harvest Tool","Cleansing Pet Shard"},
        RemoteName="BuyGearStock",
        ArgType="NormalMode"
    },
    ["ROOT/PetEggStock/Stocks"]={
        Enabled=true,
        BuyAll=true,
        Items={"Common Egg","Uncommon Egg","Rare Egg","Legendary Egg","Mythical Egg","Bug Egg","Jungle Egg","Gem Egg"},
        RemoteName="BuyPetEgg",
        ArgType="NormalMode"
    },
    ["ROOT/EventShopStock/Santa's Stash/Stocks"]={
        Enabled=true,
        BuyAll=false,
        Items={"Pet Shard HyperHunger","Santa's Stocking","Santa's Surprise Present","Christmas Present"},
        RemoteName="BuyEventShopStock",
        ArgType="EventMode",
        EventArg="Santa's Stash"
    },
    ["ROOT/EventShopStock/New Years Shop/Stocks"]={
        Enabled=true,
        BuyAll=false,
        Items={"Dragon's Firework","New Year's Egg"},
        RemoteName="BuyEventShopStock",
        ArgType="EventMode",
        EventArg="New Years Shop"
    },
}

local DailyBuyList = {
    ["ROOT/DailyDealStock/Stocks"] = {
        Enabled = true,
        Items = {"Mega Snack", "Ultra Snack", "Giga Snack"},
        RemoteName = "BuyDailySeedShopStock",
        ArgType = "NormalMode"
    }
}


local function BuyItems(ShopKey, StockData)
    local Setting = BuyList[ShopKey]
    if not Setting or not Setting.Enabled then return end
    
    -- [Optimization] หา Remote รอไว้ก่อนเข้าลูปสินค้า
    local Remote = GameEvents:FindFirstChild(Setting.RemoteName)
    if not Remote then return end

    for itemId, itemInfo in pairs(StockData) do
        local ItemName = itemInfo.EggName or itemId 
        local StockAmount = tonumber(itemInfo.Stock) or 0
        local BuyEnabled = false -- ตั้งค่าเริ่มต้นเป็นไม่ซื้อ
        local StockInfo = string.format("[%s] Found %s : %s", os.date("%X"), ItemName, StockAmount)
        InfoLog(StockInfo)
        -- [Logic Fix] เช็คเงื่อนไข
        if Setting.BuyAll then
            BuyEnabled = true -- [แก้จุดที่ 1] ไม่ต้องใส่ local ข้างหน้า
        else
            for _, TargetName in ipairs(Setting.Items) do
                if TargetName == ItemName then
                    BuyEnabled = true
                    break
                end
            end
        end

        -- [Logic Fix] ถ้าผ่านเกณฑ์ค่อยซื้อ และ ค่อยแสดง Log
        if BuyEnabled == true and StockAmount > 0 then

            -- วนลูปซื้อ
            for i = 1, StockAmount do
                local Args = {}
                if Setting.ArgType == "SeedMode" then
                    Args = {"Shop", ItemName}
                elseif Setting.ArgType == "EventMode" then
                    Args = {ItemName, Setting.EventArg}
                else
                    Args = {ItemName}
                end
                
                -- [Optimization] ยิง Remote ตรงๆ ไม่ต้อง WaitForChild แล้ว
                Remote:FireServer(unpack(Args))
            end
            BuyEnabled = false -- รีเซ็ตสถานะซื้อ
            
            -- [แก้จุดที่ 2] แสดง Log เฉพาะตอนซื้อจริงเท่านั้น
            local LogMessage = string.format("[%s] Bought %s : %s", os.date("%X"), ItemName, StockAmount)
            SuccessLog(LogMessage)
        end
    end
end

DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
    if Type ~= "UpdateData" then return end
    if not string.find(Profile, LocalPlayer.Name) then return end

    for _, Packet in ipairs(Data) do
        local Key = Packet[1]
        local Content = Packet[2]

        if BuyList[Key] then
            InfoLog(Key .. " - Processing purchase..." )
            task.spawn(function()
                BuyItems(Key, Content)
            end)
        end
    end
end)




--[[ Anti-AFK ]]--
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

SuccessLog("Script loaded successfully.")