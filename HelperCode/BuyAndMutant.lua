-- This code combines the functionality of buying a pet and mutating it. By Gemini AI
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")
local Backpack = LocalPlayer:WaitForChild("Backpack")
local targetUUID = nil
------------------------------------------------------
-- 0. Optimization (จาก AutoBuy)
------------------------------------------------------
Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0
Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

for _, v in pairs(workspace:GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") then
        v:Destroy()
    end
end
settings().Rendering.QualityLevel = "Level01"

------------------------------------------------------
-- 1. UI Initialization (Fluent)
------------------------------------------------------
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "EfHub All-in-One: Grow a Garden",
    SubTitle = "by EfHub",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Resize = true,
    MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Home = Window:AddTab({
        Title = "Home / Logs",
        Icon = "home"
    }),
    AutoBuy = Window:AddTab({
        Title = "Auto Buy",
        Icon = "shopping-cart"
    }),
    Mutation = Window:AddTab({
        Title = "Pet Mutation",
        Icon = "flask-conical"
    })
}

Window:SelectTab(1)

------------------------------------------------------
-- 2. Logging System
------------------------------------------------------
local MaxLines = 50
local FullHistoryTable = {}
local DisplayTable = {}
local IsPaused = false
local LogDisplay = nil

-- สร้าง Log Display ในหน้า Home
LogDisplay = Tabs.Home:AddParagraph({
    Title = "System Logs",
    Content = "Waiting for initialization..."
})

local function AddLog(message)
    if IsPaused then
        return
    end
    local timestamp = os.date("%X")
    local entry = string.format("[%s] %s", timestamp, message)

    table.insert(FullHistoryTable, entry)
    table.insert(DisplayTable, entry)
    if #DisplayTable > MaxLines then
        table.remove(DisplayTable, 1)
    end

    if LogDisplay then
        LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
    end
end

-- Wrapper Functions
local function InfoLog(msg)
    AddLog("📋 " .. msg)
end
local function WarnLog(msg)
    AddLog("⚠️ " .. msg)
end
local function ErrorLog(msg)
    AddLog("❌ " .. msg)
end
local function SuccessLog(msg)
    AddLog("✅ " .. msg)
end

-- ปุ่มควบคุม Log
Tabs.Home:AddButton({
    Title = "Clear Logs",
    Callback = function()
        DisplayTable = {}
        LogDisplay:SetDesc("")
    end
})

Tabs.Home:AddButton({
    Title = "Copy All Logs",
    Callback = function()
        if setclipboard then
            setclipboard(table.concat(FullHistoryTable, "\n"))
            Fluent:Notify({
                Title = "Success",
                Content = "Copied to clipboard!",
                Duration = 2
            })
        end
    end
})

------------------------------------------------------
-- 3. Floating Button (Android)
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")
local UICorner = Instance.new("UICorner")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui")
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "Btn"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(71, 1, 255)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "EF"
ToggleButton.TextColor3 = Color3.white
ToggleButton.Draggable = true
ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize()
end)

UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

------------------------------------------------------
-- 4. Auto Buy Logic
------------------------------------------------------
local AutoBuyEnabled = false
local BuyList = {
    ["ROOT/SeedStocks/Shop/Stocks"] = {
        Enabled = true,
        BuyAll = false,
        RemoteName = "BuySeedStock",
        ArgType = "SeedMode",
        Items = {"Orange Tulip", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus",
                 "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk",
                 "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco",
                 "Crimson Thorn", "Zebrazinkle", "Octobloom", "Beast Buttercup", "Bonanza Bloom"}
    },
    ["ROOT/GearStock/Stocks"] = {
        Enabled = true,
        BuyAll = false,
        RemoteName = "BuyGearStock",
        ArgType = "NormalMode",
        Items = {"Watering Can", "Trading Ticket", "Trowel", "Recall Wrench", "Basic Sprinkler", "Advanced Sprinkler",
                 "Godly Sprinkler", "Master Sprinkler", "Grandmaster Sprinkler", "Levelup Lollipop", "Medium Toy",
                 "Medium Treat", "Pet Lead", "Harvest Tool", "Magnifying Glass", "Cleaning Spray", "Favorite Tool",
                 "Cleansing Pet Shard"}
    },
    ["ROOT/PetEggStock/Stocks"] = {
        Enabled = true,
        BuyAll = true,
        RemoteName = "BuyPetEgg",
        ArgType = "NormalMode",
        Items = {"Common Egg", "Uncommon Egg", "Rare Egg", "Legendary Egg", "Mythical Egg", "Bug Egg", "Jungle Egg",
                 "Gem Egg"}
    },
    ["ROOT/EventShopStock/Santa's Stash/Stocks"] = {
        Enabled = true,
        BuyAll = false,
        RemoteName = "BuyEventShopStock",
        ArgType = "EventMode",
        EventArg = "Santa's Stash",
        Items = {"Pet Shard HyperHunger", "Santa's Stocking", "Santa's Surprise Present", "Christmas Present"}
    },
    ["ROOT/EventShopStock/New Years Shop/Stocks"] = {
        Enabled = true,
        BuyAll = false,
        RemoteName = "BuyEventShopStock",
        ArgType = "EventMode",
        EventArg = "New Years Shop",
        Items = {"Dragon's Firework", "New Year's Egg"}
    },
    ["ROOT/DailyDealStock/Stocks"] = {
        Enabled = true,
        BuyAll = false,
        RemoteName = "BuyDailySeedShopStock",
        ArgType = "NormalMode",
        Items = {"Mega Snack", "Ultra Snack", "Giga Snack"}
    }
}

Tabs.AutoBuy:AddToggle("MasterAutoBuy", {
    Title = "Enable Auto Buy",
    Default = false,
    Callback = function(Value)
        AutoBuyEnabled = Value
    end
})

local function ProcessBuy(ShopKey, StockData)
    if not AutoBuyEnabled then
        return
    end
    local Setting = BuyList[ShopKey]
    if not Setting or not Setting.Enabled then
        return
    end

    local Remote = GameEvents:FindFirstChild(Setting.RemoteName)
    if not Remote then
        return
    end

    for itemId, itemInfo in pairs(StockData) do
        local ItemName = itemInfo.EggName or itemId
        local StockAmount = tonumber(itemInfo.Stock) or 0
        local ShouldBuy = false

        -- InfoLog(string.format("Found %s : %s", ItemName, StockAmount)) -- Optional: Uncomment to spam log

        if Setting.BuyAll then
            ShouldBuy = true
        else
            for _, TargetName in ipairs(Setting.Items) do
                if TargetName == ItemName then
                    ShouldBuy = true
                    break
                end
            end
        end

        if ShouldBuy and StockAmount > 0 then
            for i = 1, StockAmount do
                local Args = {}
                if Setting.ArgType == "SeedMode" then
                    Args = {"Shop", ItemName}
                elseif Setting.ArgType == "EventMode" then
                    Args = {ItemName, Setting.EventArg}
                else
                    Args = {ItemName}
                end

                Remote:FireServer(unpack(Args))
            end
            SuccessLog(string.format("Bought %s x%s", ItemName, StockAmount))
        end
    end
end

------------------------------------------------------
-- 5. Mutation Logic
------------------------------------------------------
local MutationEnabled = false
local TargetPet = "Bald Eagle"
local TargetMutant = "GiantGolem" -- ชื่อเป้าหมายหลังกลายพันธุ์ (เพื่อกันไม่ให้เอาตัวที่เป็นแล้วไปทำซ้ำ)
local TargetLevel = 50
local LevelLoadout = 1
local MutantLoadout = 3
local ClaimLoadout = 2
local LoadoutWaitTime = 8.0 -- ปรับลดลงเล็กน้อยเพื่อให้ไวขึ้น (Safe: 10)

-- UI Controls for Mutation
Tabs.Mutation:AddToggle("MasterMutation", {
    Title = "Enable Auto Mutation",
    Description = "Auto Level Up -> Mutate -> Claim",
    Default = false,
    Callback = function(Value)
        MutationEnabled = Value
        if Value then
            WarnLog("Mutation Started...")
            task.spawn(function()
                -- Trigger check immediately
                local currentUUID = GetPetUUID(TargetPet)
                if currentUUID then
                    local _, age = GetPetAge(currentUUID)
                    if age and age >= TargetLevel then
                        InfoLog("Pet ready on start. Executing...")
                        MakeMutant(currentUUID)
                    end
                end
            end)
        end
    end
})

Tabs.Mutation:AddInput("TargetPetName", {
    Title = "Target Pet Name",
    Default = "Bald Eagle",
    Callback = function(Value)
        TargetPet = Value
    end
})

-- Mutation Functions
function GetPetUUID(petName)
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" then
            local name = string.match(item.Name, "^(.-)%s*%[") or item.Name
            if string.find(name, TargetPet) then
                if not string.find(name, TargetMutant) then
                    return item:GetAttribute("PET_UUID")
                end
            end
        end
    end
    return nil
end

function GetPetAge(uuid)
    local age = nil
    local FoundPet = false
    -- Check Backpack
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            age = tonumber(string.match(item.Name, "%[%s*Age%s*(%d+)%s*%]"))
            FoundPet = true
            break
        end
    end
    -- Check UI if not in backpack name (sometimes name doesn't update)
    if not FoundPet then
        pcall(function()
            local scrollFrame = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
            local targetUi = scrollFrame:FindFirstChild(uuid)
            if targetUi then
                age = tonumber(string.match(targetUi.Main.PET_AGE.Text, "%d+"))
                FoundPet = true
            end
        end)
    end
    return FoundPet, age
end

function SwapPetLoadout(Loadout)
    GameEvents:WaitForChild("PetsService"):FireServer("SwapPetLoadout", Loadout)
end

function EquipPet(uuid)
    GameEvents:WaitForChild("PetsService"):FireServer("EquipPet", uuid)
end

function UnequipPet(uuid)
    GameEvents:WaitForChild("PetsService"):FireServer("UnequipPet", uuid)
end

function heldPet(uuid)
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            if Character and Character:FindFirstChild("Humanoid") then
                Character.Humanoid:EquipTool(item)
                return true
            end
        end
    end
    return false
end

function MakeMutant(uuid)
    InfoLog("Process: Making Mutant...")
    SwapPetLoadout(MutantLoadout)
    task.wait(LoadoutWaitTime)

    if heldPet(uuid) then
        task.wait(1)
        GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer("SubmitHeldPet")
        task.wait(0.5)
        GameEvents:WaitForChild("ReplicationChannel"):FireServer("PetAssets", TargetPet)
        task.wait(1)
        GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer("StartMachine")
        InfoLog("Sent mutation request.")
    else
        ErrorLog("Failed to hold pet for mutation.")
    end
end

function ClaimPet()
    InfoLog("Process: Claiming Mutant...")
    SwapPetLoadout(ClaimLoadout)
    task.wait(LoadoutWaitTime)

    GameEvents:WaitForChild("PetMutationMachineService_RE"):FireServer("ClaimMutatedPet")
    SuccessLog("Claimed Mutant Pet!")

    task.wait(1)
    if Character and Character:FindFirstChild("Humanoid") then
        Character.Humanoid:UnequipTools()
    end
    task.wait(2)
    -- Loop check again
    CheckMutationLoop()
end

function CheckMutationLoop()
    if not MutationEnabled then
        return
    end

    targetUUID = GetPetUUID(TargetPet)
    if targetUUID then
        local found, age = GetPetAge(targetUUID)
        age = age or 1

        if found then
            if age < TargetLevel then
                -- Leveling logic
                InfoLog(string.format("Pet Age: %d. Swapping to Loadout %d for leveling...", age, LevelLoadout))
                SwapPetLoadout(LevelLoadout)
                task.wait(LoadoutWaitTime)
                EquipPet(targetUUID)
            else
                -- Mutation logic
                InfoLog(string.format("Pet Age: %d (MAX). Swapping to Loadout %d for mutation...", age, MutantLoadout))
                UnequipPet(targetUUID)
                task.wait(0.5)
                MakeMutant(targetUUID)
            end
        else
            WarnLog("Pet found but age unknown.")
        end
    else
        InfoLog("No target pet found in backpack. Waiting...")
    end
end

------------------------------------------------------
-- 6. Main Event Listener (Combined)
------------------------------------------------------
DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
    if Type ~= "UpdateData" then
        return
    end
    if not string.find(Profile, LocalPlayer.Name) then
        return
    end

    for _, Packet in ipairs(Data) do
        local Key = Packet[1]
        local Content = Packet[2]

        -- 6.1 Logic Auto Buy
        if AutoBuyEnabled and BuyList[Key] then
            task.spawn(function()
                ProcessBuy(Key, Content)
            end)
        end

        -- 6.2 Logic Mutation
        if MutationEnabled then
            local CheckLevelKey = "ROOT/GardenGuide/PetData/" .. TargetPet .. "/MaxLevel"

            -- Case: Level Up
            if Key == CheckLevelKey then
                local age = tonumber(Content) or 0
                InfoLog("Pet Level Updated: " .. age)
                if age >= TargetLevel then
                    -- local uuid = GetPetUUID(TargetPet)
                    -- local uuid = targetUUID
                    -- if uuid then
                    UnequipPet(targetUUID)
                    task.wait(0.5)
                    MakeMutant(targetUUID)
                    -- end
                end
            end

            -- Case: Pet Ready to Claim
            if Key == "ROOT/PetMutationMachine/PetReady" then
                ClaimPet()
            end
        end
    end
end)

------------------------------------------------------
-- 7. Anti-AFK
------------------------------------------------------
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

InfoLog("EfHub All-in-One Loaded.")
