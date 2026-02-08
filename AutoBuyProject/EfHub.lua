local Fluent = loadstring(game:HttpGet(
    "https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau"))()
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/SaveManager.luau"))()
local InterfaceManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/master/Addons/InterfaceManager.luau"))()
local CollapsibleAddon = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/Core/CollapsibleSection.lua"))()

CollapsibleAddon(Fluent)
local DevMode = true
local DevNoti
local IsLoading = true
local QuickSave
local GetSelectedItems

local GetPetUUID
local GetPetName
local GetPetAge
local EquipPet
local UnequipPet
local SwapPetLoadout
local heldPet
local heldItemName
local heldItemUUID

local ShopKey = {
    Seed = "ROOT/SeedStocks/Shop/Stocks",
    Gear = "ROOT/GearStock/Stocks",
    Egg = "ROOT/PetEggStock/Stocks",
    Santa = "ROOT/EventShopStock/Santa's Stash/Stocks",
    NewYear = "ROOT/EventShopStock/New Years Shop/Stocks",
    Traveling = "ROOT/TravelingMerchantShopStock/Stocks"
}

local BuyList = {
    [ShopKey.Seed] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuySeedStock",
        ArgType = "SeedMode"
    },
    [ShopKey.Gear] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuyGearStock",
        ArgType = "NormalMode"
    },
    [ShopKey.Egg] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuyPetEgg",
        ArgType = "NormalMode"
    },
    [ShopKey.Traveling] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuyTravelingMerchantShopStock",
        ArgType = "NormalMode"
    },
    [ShopKey.Santa] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuyEventShopStock",
        ArgType = "EventMode",
        EventArg = "Santa's Stash"
    },
    [ShopKey.NewYear] = {
        Enabled = false,
        BuyAll = false,
        Items = {},
        RemoteName = "BuyEventShopStock",
        ArgType = "EventMode",
        EventArg = "New Years Shop"
    }
}

local Window = Fluent:CreateWindow({
    Title = "Grow a Garden",
    SubTitle = "by EfHub",
    TabWidth = 100,
    Size = UDim2.fromOffset(1200, 768),
    Resize = true,
    -- MinSize = Vector2.new(470, 380),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Tabs = {
    Buy = Window:AddTab({
        Title = "Buy",
        Icon = "shopping-cart"
    }),
    Pet = Window:AddTab({
        Title = "Pet",
        Icon = "bone"
    }),
    Farm = Window:AddTab({
        Title = "Farm",
        Icon = "tree-pine"
    }),
    Log = Window:AddTab({
        Title = "Console",
        Icon = "terminal"
    }),
    Settings = Window:AddTab({
        Title = "Settings",
        Icon = "settings"
    })
}
local Options = Fluent.Options

DevNoti = function(content)
    if DevMode then
        Fluent:Notify({
            Title = "EfHub - Dev Mode",
            Content = content,
            Duration = 5
        })
    end
end

GetSelectedItems = function(DropdownValue)
    local Items = {}
    if type(DropdownValue) == "table" then
        for Value, State in pairs(DropdownValue) do
            if State then
                table.insert(Items, Value)
            end
        end
    end
    return Items
end

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
    pcall(function()
        Window:Minimize()
    end)
end)

--[[
 local bntSave = Tabs.Settings:AddButton({
    Title = "Save Settings",
    Callback = function()
        SaveManager:Save("EfHub")
    end
})
local bntLoad = Tabs.Settings:AddButton({
    Title = "Load Settings",
    Callback = function()
        SaveManager:Load("EfHub")
    end
}) 
    ]]
--[[ 
Buy Seeds Section 
]]
local BuySeedSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Seeds", false)

local buySeedEnable = BuySeedSection:AddToggle("buySeedEnable", {
    Title = "Buy Seeds",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Seed].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buySeedAll = BuySeedSection:AddToggle("buySeedAll", {
    Title = "Buy All Seeds",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Seed].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local SeedData = require(game:GetService("ReplicatedStorage").Data.SeedShopData) -- This is table data of seeds
local SeedTable = {}
for seedName, seedInfo in pairs(SeedData) do
    table.insert(SeedTable, seedName)
end
table.sort(SeedTable)
local SeedList = BuySeedSection:AddDropdown("SeedList", {
    Title = "Seeds",
    Description = "Select seeds to buy",
    Values = SeedTable,
    Multi = true,
    Default = {},
    Searchable = true,
    Callback = function(Value)
        BuyList[ShopKey.Seed].Items = GetSelectedItems(Value)
        if QuickSave then
            QuickSave()
        end
    end
})

--[[
 Buy Gear Section
]]
local buyGearSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Gear", false)
local buyGearEnable = buyGearSection:AddToggle("buyGearEnable", {
    Title = "Buy Gear",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Gear].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buyGearAll = buyGearSection:AddToggle("buyGearAll", {
    Title = "Buy All Gear",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Gear].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local GearData = require(game:GetService("ReplicatedStorage").Data.GearShopData)
local GearTable = {}
for gearName, gearInfo in pairs(GearData["Gear"]) do
    table.insert(GearTable, gearName)
end
table.sort(GearTable)
local GearList = buyGearSection:AddDropdown("GearList", {
    Title = "Gear",
    Description = "Select gear to buy",
    Values = GearTable,
    Multi = true,
    Default = {},
    Searchable = true,
    Callback = function(Value)
        BuyList[ShopKey.Gear].Items = GetSelectedItems(Value)
        if QuickSave then
            QuickSave()
        end
    end
})

--[[
 Buy Pet Eggs Section
]]
local buyEggSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Pet Eggs", false)
local buyEggEnable = buyEggSection:AddToggle("buyEggEnable", {
    Title = "Buy Pet Eggs",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Egg].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buyEggAll = buyEggSection:AddToggle("buyEggAll", {
    Title = "Buy All Pet Eggs",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Egg].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local EggData = require(game:GetService("ReplicatedStorage").Data.PetEggData)
local EggTable = {}
for eggName, eggInfo in pairs(EggData) do
    table.insert(EggTable, eggName)
end
table.sort(EggTable)
local EggList = buyEggSection:AddDropdown("EggList", {
    Title = "Pet Eggs",
    Description = "Select pet eggs to buy",
    Values = EggTable,
    Multi = true,
    Default = {},
    Searchable = true,
    Callback = function(Value)
        BuyList[ShopKey.Egg].Items = GetSelectedItems(Value)
        if QuickSave then
            QuickSave()
        end
    end
})

--[[
 Buy Traveling Merchant Items Section
]]
local BuyTravelingSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Traveling Merchant Items", false)
local buyTravelingEnable = BuyTravelingSection:AddToggle("buyTravelingEnable", {
    Title = "Buy Traveling Merchant Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Traveling].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buyTravelingAll = BuyTravelingSection:AddToggle("buyTravelingAll", {
    Title = "Buy All Traveling Merchant Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Traveling].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local TravelingList = {}
local function TravelSelected(DropdownValue)
    if type(DropdownValue) == "table" then
        for Value, State in pairs(DropdownValue) do
            if State then
                table.insert(TravelingList, Value)
            end
        end
    end
    return TravelingList
end

local TravelingData = require(game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData)
local Traval = {}

local t = 1
for Name, data in pairs(TravelingData) do
    local TravalTable = {}
    if type(data.ShopData) == "table" then
        for itemName, itemInfo in pairs(data.ShopData) do
            table.insert(TravalTable, itemName)
        end
    end
    Traval[t] = BuyTravelingSection:AddDropdown("TravelingList" .. t, {
        Title = Name .. " Items",
        Description = "Select items to buy",
        Values = TravalTable,
        Multi = true,
        Default = {},
        Searchable = true,
        Callback = function(Value)
            BuyList[ShopKey.Traveling].Items = TravelSelected(Value)
            if QuickSave then
                QuickSave()
            end
        end
    })
    t = t + 1
end

--[[
 Buy Event Shop Items Section
]]

--[[
 Buy Santa's Stash Section
]]
local BuySantaSection = Tabs.Buy:AddCollapsibleSection("Auto Buy Santa's Stash Items", false)
local buySantaEnable = BuySantaSection:AddToggle("buySantaEnable", {
    Title = "Buy Santa's Stash Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Santa].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buySantaAll = BuySantaSection:AddToggle("buySantaAll", {
    Title = "Buy All Santa's Stash Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.Santa].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local EventData = require(game:GetService("ReplicatedStorage").Data.EventShopData)
local SantaTable = {}
for itemName, itemInfo in pairs(EventData["Santa's Stash"]) do
    table.insert(SantaTable, itemName)
end
table.sort(SantaTable)
local SantaList = BuySantaSection:AddDropdown("SantaList", {
    Title = "Santa's Stash Items",
    Description = "Select items to buy",
    Values = SantaTable,
    Multi = true,
    Default = {},
    Searchable = true,
    Callback = function(Value)
        BuyList[ShopKey.Santa].Items = GetSelectedItems(Value)
        if QuickSave then
            QuickSave()
        end
    end
})

--[[
 Buy New Years Shop Items Section
]]
local BuyNewYearSection = Tabs.Buy:AddCollapsibleSection("Auto Buy New Years Shop Items", false)
local buyNewYearEnable = BuyNewYearSection:AddToggle("buyNewYearEnable", {
    Title = "Buy New Years Shop Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.NewYear].Enabled = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local buyNewYearAll = BuyNewYearSection:AddToggle("buyNewYearAll", {
    Title = "Buy All New Years Shop Items",
    Default = false,
    Callback = function(Value)
        BuyList[ShopKey.NewYear].BuyAll = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local NewYearTable = {}
for itemName, itemInfo in pairs(EventData["New Years Shop"]) do
    table.insert(NewYearTable, itemName)
end
table.sort(NewYearTable)
local NewYearList = BuyNewYearSection:AddDropdown("NewYearList", {
    Title = "New Years Shop Items",
    Description = "Select items to buy",
    Values = NewYearTable,
    Multi = true,
    Default = {},
    Searchable = true,
    Callback = function(Value)
        BuyList[ShopKey.NewYear].Items = GetSelectedItems(Value)
        if QuickSave then
            QuickSave()
        end
    end
})

local PetSetting = {
    ["PetMode"] = {
        Enabled = false,
        Mode = "Nightmare",
        TargetMutant = "GiantGolem",
        TargetPet = "Tiger",
        LevelSlots = 1,
        TimeSlot = 3,
        MutantSlot = 2
    }
}

--[[ Auto Pet Tab]]
local PetWorkSection = Tabs.Pet:AddCollapsibleSection("Pet Farming", false)
local PetMode = PetWorkSection:AddDropdown("PetMode", {
    Title = "Pet Mode",
    Description = "Select Pet Mode",
    Values = {"Nightmare", "Elephant", "Mutant", "Level"},
    Multi = false,
    Default = "Nightmare",
    Searchable = true,
    Callback = function(Value)
        PetSetting["PetMode"].Mode = Value
        if QuickSave then
            QuickSave()
        end
    end
})
local PetModeEnable = PetWorkSection:AddToggle("PetModeEnable", {
    Title = "Enable Pet Farm",
    Default = false,
    Callback = function(Value)
        PetSetting["PetMode"].Enabled = Value
        if QuickSave then
            QuickSave()
        end
        -- call Some Function Here
    end
})
local PetData = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetList)
local PetTable = {}
for petName, petInfo in pairs(PetData) do
    table.insert(PetTable, petName)
end
table.sort(PetTable)
local TargetPetDropdown = PetWorkSection:AddDropdown("TargetPetDropdown", {
    Title = "Target Pet",
    Description = "Select Target Pet for Farming",
    Values = PetTable,
    Multi = false,
    Default = PetSetting["PetMode"].TargetPet,
    Searchable = true,
    Callback = function(Value)
        PetSetting["PetMode"].TargetPet = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local MutantData = require(game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry)
local MutantTable = {}
for mutantName, mutantInfo in pairs(MutantData["PetMutationRegistry"]) do
    table.insert(MutantTable, mutantName)
end
table.sort(MutantTable)
local TargetMutantDropdown = PetWorkSection:AddDropdown("TargetMutantDropdown", {
    Title = "Target Mutant",
    Description = "Select Target Mutant for Farming",
    Values = MutantTable,
    Multi = false,
    Default = PetSetting["PetMode"].TargetMutant,
    Searchable = true,
    Callback = function(Value)
        PetSetting["PetMode"].TargetMutant = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local LevelSlots = PetWorkSection:AddDropdown("LevelSlots", {
    Title = "Select Loadout",
    Values = {1, 2, 3, 4, 5, 6},
    Default = 1,
    Multi = false,
    Callback = function(Value)
        PetSetting["PetMode"].LevelSlots = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local TimeSlots = PetWorkSection:AddDropdown("TimeSlots", {
    Title = "Select Time Slot",
    Values = {1, 2, 3, 4, 5, 6},
    Default = 3,
    Multi = false,
    Callback = function(Value)
        PetSetting["PetMode"].TimeSlot = Value
        if QuickSave then
            QuickSave()
        end
    end
})

local MutantSlots = PetWorkSection:AddDropdown("MutantSlots", {
    Title = "Select Mutant Slot",
    Values = {1, 2, 3, 4, 5, 6},
    Default = 2,
    Multi = false,
    Callback = function(Value)
        PetSetting["PetMode"].MutantSlot = Value
        if QuickSave then
            QuickSave()
        end
    end
})

--[[ Log Section Not finished yet ]] --
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local DisplayTable = {} -- ตารางเก็บข้อความโชว์

Tabs.Log:AddButton({
    Title = "Test",
    Callback = function()
        local TestMessage = "BuyEn:" .. tostring(BuyList[ShopKey.Seed].Enabled) .. ", BuyAll:" ..
                                tostring(BuyList[ShopKey.Seed].BuyAll)
        DevNoti(TestMessage)
    end
})

Tabs.Log:AddButton({
    Title = "Test 2",
    Callback = function()
        -- use concat to convert table to string
        local Message = table.concat(BuyList[ShopKey.Traveling].Items, ", ")
        DevNoti("Selected Traveling Items: " .. Message)
    end
})

-- ปุ่ม Clear
--[[ Tabs.Log:AddButton({
    Title = "Clear Logs",
    Callback = function()
        DisplayTable = {}
        if LogDisplay then
            LogDisplay:SetDesc("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
        end
    end
}) ]]

--[[ local LogDisplay = Tabs.Log:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
}) ]]

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

--[[
 SaveManager and InterfaceManager Setup
]]
SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

SaveManager:SetIgnoreIndexes{}
InterfaceManager:SetFolder("EfHub")
SaveManager:SetFolder("EfHub/GAG")

InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

--[[
 Quick Save Function
]]
QuickSave = function()
    if not IsLoading then
        SaveManager:Save("EfHub")
    end
end

task.spawn(function()
    while not SaveManager.Options.SaveManager_ConfigList do
        task.wait()
    end
    SaveManager.Options.SaveManager_ConfigList:SetValue("EfHub")
    SaveManager:Load("EfHub")
    IsLoading = false
    Fluent:Notify({
        Title = "EfHub",
        Content = "Settings loaded automatically",
        Duration = 3
    })
end)
IsLoading = false

--[[
 Auto Buy System
]]
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")

local LocalPlayer = game:GetService("Players").LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

local VirtualUser = game:GetService("VirtualUser")

local function ProcessBuy(ShopKey, StockData)
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
        local BuyEnabled = false
        local StockInfo = string.format("Found %s : %s", ItemName, StockAmount)
        DevNoti(StockInfo)
        if Setting.BuyAll then
            BuyEnabled = true
        else
            for _, TargetName in ipairs(Setting.Items) do
                if TargetName == ItemName then
                    BuyEnabled = true
                    break
                end
            end
        end

        if BuyEnabled == true and StockAmount > 0 then

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
                task.wait(0.1)
            end
            BuyEnabled = false

            local LogMessage = string.format("Bought %s : %s", ItemName, StockAmount)
            DevNoti(LogMessage)
        end
    end
end

GetPetUUID = function(petName)
    local TargetPet = PetSetting["PetMode"].TargetPet
    local TargetMutant = "EfHub"
    if PetSetting["PetMode"].Mode == "Nightmare" then
        TargetMutant = "Nightmare"
    elseif PetSetting["PetMode"].Mode == "Mutant" then
        TargetMutant = PetSetting["PetMode"].TargetMutant
    end
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" then
            local name = string.trim(string.match(item.Name, "^(.-)%s*%["))
            if string.find(name, TargetPet) then
                if not string.find(name, TargetMutant) then
                    -- WarnLog("Found pet in backpack: " .. name .. " (UUID: " .. item:GetAttribute("PET_UUID") .. ")")
                    return item:GetAttribute("PET_UUID")
                end
            end
        end
    end

    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    for _, pet in ipairs(scrollFramePath:GetChildren()) do
        if pet:FindFirstChild("Main") then
            if string.find(pet.Main.PET_TYPE.Text, petName) then
                if not string.find(pet.Main.PET_TYPE.Text, TargetMutant) then
                    -- WarnLog("Found pet in ActivePetUI: " .. pet.Main.PET_TYPE.Text .. " (UUID: " .. pet.Name .. ")")
                    return pet.Name
                end
            end
        end
    end
    return nil
end

GetPetName = function(uuid)
    -- local name = nil
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            return string.trim(string.match(item.Name, "^(.-)%s*%["))
        end
    end
    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    local targetPet = scrollFramePath:FindFirstChild(uuid)
    if targetPet then
        return string.trim(targetPet.Main.PET_TYPE.Text)
    end
    return nil
end

EquipPet = function(uuid)
    local args = {"EquipPet", uuid}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

UnequipPet = function(uuid)
    local args = {"UnequipPet", uuid}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

SwapPetLoadout = function(Loadout) -- Loadout is int 1-6
    if (Loadout == 2) then
        Loadout = 3
    elseif (Loadout == 3) then
        Loadout = 2
    end
    local args = {"SwapPetLoadout", Loadout}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

heldPet = function(uuid) -- find uuid in backpack and select it
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            Humanoid:EquipTool(item)
            return true
        end
    end
    return false
end

heldItemUUID = function(uuid) -- find item in backpack and select it
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("c") == uuid then
            Humanoid:EquipTool(item)
            return true
        end
    end
    return false
end

heldItemName = function(itemName) -- find item in backpack and select it
    for _, item in ipairs(Backpack:GetChildren()) do
        local name = string.match(item.Name, "^(.-)%s*%[") or string.match(item.Name, "^(.-)%s*[xX]%d+") or item.Name
        name = string.trim(name)
        if name == itemName then
            Humanoid:EquipTool(item)
            return true
        end
    end
    return false
end

GetPetAge = function(uuid)
    local age = nil
    local FoundPet = false
    pcall(function()
        UnequipPet(uuid)
        task.wait(0.2)
        EquipPet(uuid)
        task.wait(0.5)
    end)
    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    local targetPet = scrollFramePath:FindFirstChild(uuid)
    if targetPet then
        age = tonumber(string.match(targetPet.Main.PET_AGE.Text, "%d+"))
        FoundPet = true
    end

    if not FoundPet then
        for _, item in ipairs(Backpack:GetChildren()) do
            if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
                age = tonumber(string.match(item.Name, "%[%s*Age%s*(%d+)%s*%]"))
                FoundPet = true
                break
            end
        end
    end
    return FoundPet, age
end

--[[ local function BuySeed(ItemName, Amount)
    local Remote = GameEvents:FindFirstChild("BuySeedStock")
    if not Remote then
        return
    end
    for i = 1, Amount do
        Remote:FireServer("Shop", ItemName)
    end
end ]]

--[[ DataStream Event Listener
    - Listen for stock updates and process purchases
]]

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

        if BuyList[Key] then
            -- InfoLog(Key .. " - Processing purchase..." )
            task.spawn(function()
                ProcessBuy(Key, Content)
            end)
        end
    end
end)

--[[ Anti-AFK ]]

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

-- DevNoti(tostring(IsLoading))

--[[ task.spawn(function()
    -- SeedTable
    for _, seedName in pairs(SeedTable) do
        BuySeed(seedName, 10)
        task.wait(0.1)
    end
end) ]]

--[[ Data
Shop Data
game:GetService("ReplicatedStorage").Data.SeedShopData
game:GetService("ReplicatedStorage").Data.GearShopData
game:GetService("ReplicatedStorage").Data.PetEggData
game:GetService("ReplicatedStorage").Data.DailySeedShopData
game:GetService("ReplicatedStorage").Data.EventShopData

game:GetService("ReplicatedStorage").Data.GiftData

game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.AmericanMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.FallMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.GnomeMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.HalloweenMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.HoneyMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.RareCosmeticMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.SafariMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.SkyMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.SprayMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.SprinklerMerchantShopData
game:GetService("ReplicatedStorage").Data.TravelingMerchant.TravelingMerchantData.SummerMerchantShopData


All Data
game:GetService("ReplicatedStorage").Data.SeedData
game:GetService("ReplicatedStorage").Data.PetRegistry.PetEggs
game:GetService("ReplicatedStorage").Data.PetRegistry.PetList
game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry

game:GetService("ReplicatedStorage").Data.CraftingData
game:GetService("ReplicatedStorage").Data.CraftingData.CraftingObjectRegistry
game:GetService("ReplicatedStorage").Data.CraftingData.CraftingRecipeRegistry

]]
