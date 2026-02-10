--[[
    Decompiled Luau Code: SeedShopController
    
    หมายเหตุ: นี่เป็นการพยายาม reconstruct จาก bytecode
    โค้ดอาจไม่สมบูรณ์ 100% แต่แสดงโครงสร้างและฟังก์ชันหลักๆ
--]]

-- ===== MODULE SETUP =====
local SeedShopController = {}

-- ===== DEPENDENCIES =====
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local TweenService = game:GetService("TweenService")
local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

-- Modules
local Modules = ReplicatedStorage:WaitForChild("Modules")
local GuiController = require(Modules:WaitForChild("GuiController"))
local DataService = require(Modules:WaitForChild("DataService"))
local UpdateService = require(Modules:WaitForChild("UpdateService"))
local NumberUtil = require(Modules:WaitForChild("NumberUtil"))
local SignalModule = require(Modules:WaitForChild("Signal"))
local CurrencyData = require(Modules:WaitForChild("CurrencyData"))
local RebirthUnlocks = require(Modules:WaitForChild("RebirthUnlocks"))
local TradeController = require(Modules:WaitForChild("TradeController"))
local GiftController = require(Modules:WaitForChild("GiftController"))
local SeedShopConfig = require(Modules:WaitForChild("SeedShopConfig"))
local ShopTabHandler = require(Modules:WaitForChild("ShopTabHandler"))
local NPCLevelHandler = require(Modules:WaitForChild("NPCLevelHandler"))
local SoundPlayer = require(Modules:WaitForChild("SoundPlayer"))

-- Data
local SeedShopData = require(ReplicatedStorage:WaitForChild("SeedShopData"))
local DailySeedShopData = require(ReplicatedStorage:WaitForChild("DailySeedShopData"))
local PlantTraitsData = require(ReplicatedStorage:WaitForChild("PlantTraitsData"))

-- ===== CONSTANTS =====
local AB_RESTOCK_TIMER_NEW = "AB_RestockTimer_NEW"
local RESTOCK_TIMERS = {
    "SeedShopRestock_1",
    "SeedShopRestock_2", 
    "SeedShopRestock_3"
}

-- ===== LOCAL VARIABLES =====
local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")

local currentCategory = "Daily Deals"
local seedStocks = {}
local forcedSeedEndTimestamp = nil
local refreshTime = 0

-- UI Elements
local shopFrame = nil
local mainFrame = nil
local scrollingFrame = nil
local itemTemplate = nil

-- ===== UTILITY FUNCTIONS =====

-- ฟังก์ชันจัดรูปแบบตัวเลขแบบกระชับ
local function compactFormat(number)
    return NumberUtil:Comma_Module(number)
end

-- ฟังก์ชันแปลงสีให้มืดลง
local function darkenColor(color, amount)
    local h, s, v = color:ToHSV()
    return Color3.fromHSV(h, s, v * (1 - amount))
end

-- ฟังก์ชันจัดการเวลา
local function formatShopTime(timestamp)
    local timeRemaining = timestamp - os.clock()
    if timeRemaining <= 0 then
        return "Now"
    end
    
    local hours = math.floor(timeRemaining / 3600)
    local minutes = math.floor((timeRemaining % 3600) / 60)
    local seconds = math.floor(timeRemaining % 60)
    
    if hours > 0 then
        return string.format("%dh %dm", hours, minutes)
    elseif minutes > 0 then
        return string.format("%dm %ds", minutes, seconds)
    else
        return string.format("%ds", seconds)
    end
end

-- ===== STOCK MANAGEMENT =====

-- ดึงข้อมูล Stock
local function fetchStockInfo()
    local serverTime = workspace:GetServerTimeNow()
    local data = DataService:GetData()
    
    if not data then return end
    
    seedStocks = data.SeedStocks or {}
    forcedSeedEndTimestamp = data.ForcedSeedEndTimestamp
    refreshTime = data.RefreshTime or UpdateService:GetRefreshTime()
    
    return seedStocks
end

-- อัพเดท Stock
local function updateStock(seedName, newStock)
    if not seedStocks[seedName] then
        seedStocks[seedName] = {}
    end
    
    seedStocks[seedName].Stock = newStock
    seedStocks[seedName].MaxStock = seedStocks[seedName].MaxStock or 100
end

-- รีเซ็ต Stock
local function resetStock()
    for seedName, stockData in pairs(seedStocks) do
        stockData.Stock = stockData.MaxStock
    end
end

-- ===== AB TESTING =====

local function checkABTest()
    local ClientABTests = require(ReplicatedStorage.Client.ClientABTests)
    
    if ClientABTests:HasBeenAssignedThisABTest(AB_RESTOCK_TIMER_NEW) then
        return ClientABTests:GetAttributeAsync(AB_RESTOCK_TIMER_NEW)
    end
    
    return false
end

-- ===== RESTOCK TIMER =====

local restockTimerEnabled = false
local restockTimerConnections = {}

local function setupRestockTimer()
    if not checkABTest() then return end
    
    restockTimerEnabled = true
    
    -- แสดง Restock Timer UI
    for _, timerName in ipairs(RESTOCK_TIMERS) do
        local timerFrame = shopFrame:FindFirstChild(timerName)
        if timerFrame then
            timerFrame.Visible = true
        end
    end
end

local function updateRefreshLabel()
    local timeUntilRefresh = refreshTime - os.clock()
    
    if timeUntilRefresh <= 0 then
        return "Restocking..."
    else
        return "New seeds in " .. formatShopTime(refreshTime)
    end
end

local function startRestockTimer()
    if not restockTimerEnabled then return end
    
    local function updateTimer()
        local refreshLabel = shopFrame:FindFirstChild("RefreshLabel")
        if refreshLabel and refreshLabel:IsA("TextLabel") then
            refreshLabel.Text = updateRefreshLabel()
        end
        
        -- Rainbow effect สำหรับ background
        local rainbowBG = shopFrame:FindFirstChild("RainbowBackground")
        if rainbowBG then
            local uiGradient = rainbowBG:FindFirstChild("UIGradient")
            if uiGradient then
                local hue = (os.clock() % 10) / 10
                local color = Color3.fromHSV(hue, 1, 1)
                uiGradient.Color = ColorSequence.new(color)
            end
        end
    end
    
    -- อัพเดททุก frame
    local connection = game:GetService("RunService").Heartbeat:Connect(updateTimer)
    table.insert(restockTimerConnections, connection)
end

-- ===== SHOP UI MANAGEMENT =====

local function isItemLocked(seedName)
    local levelLocks = SeedShopConfig.LevelLocks or {}
    
    if levelLocks[seedName] then
        local requiredLevel = levelLocks[seedName]
        local playerLevel = NPCLevelHandler:GetNPCLevel()
        
        if playerLevel < requiredLevel then
            return true, "NPC Friend Level Needed: lvl" .. requiredLevel
        end
    end
    
    -- ตรวจสอบ Rebirth requirement
    local rebirthData = DataService:GetPath("RebirthData/TotalRebirths")
    local requiredRebirths = RebirthUnlocks:GetRemainingRebirthsNeededForItem(seedName)
    
    if requiredRebirths and requiredRebirths > 0 then
        return true, "Ascensions Required: " .. requiredRebirths
    end
    
    return false, nil
end

local function createShopItemFrame(seedName, seedData)
    local itemFrame = itemTemplate:Clone()
    itemFrame.Name = seedName
    itemFrame.Parent = scrollingFrame
    
    -- ตั้งค่ารูปภาพ
    local seedImage = itemFrame:FindFirstChild("ShopItem_Image")
    if seedImage then
        seedImage.Image = seedData.FruitIcon or ""
    end
    
    -- ตั้งค่าชื่อ
    local seedText = itemFrame:FindFirstChild("Seed_Text")
    if seedText then
        seedText.Text = seedData.SeedName or seedName
    end
    
    -- ตั้งค่าราคา
    local costText = itemFrame:FindFirstChild("Cost_Text")
    if costText then
        if seedData.Price then
            costText.Text = "¢" .. compactFormat(seedData.Price)
        elseif seedData.Robux_Buy then
            costText.Text = string.format(":robux: %d", seedData.Robux_Buy)
        end
    end
    
    -- ตั้งค่า Stock
    local stockText = itemFrame:FindFirstChild("Stock_Text")
    if stockText then
        local currentStock = seedStocks[seedName] and seedStocks[seedName].Stock or 0
        local maxStock = seedStocks[seedName] and seedStocks[seedName].MaxStock or 100
        
        if currentStock > 0 then
            stockText.Text = string.format("X%d Stock", currentStock)
            stockText.TextColor3 = Color3.fromRGB(255, 255, 255)
        else
            stockText.Text = "NO STOCK"
            stockText.TextColor3 = Color3.fromRGB(255, 0, 0)
        end
    end
    
    -- ตรวจสอบการล็อค
    local isLocked, lockReason = isItemLocked(seedName)
    local lockedFrame = itemFrame:FindFirstChild("LockedFrame")
    
    if lockedFrame then
        lockedFrame.Visible = isLocked
        
        if isLocked and lockReason then
            local unlockInfo = lockedFrame:FindFirstChild("UnlockInfo")
            if unlockInfo then
                unlockInfo.Text = lockReason
            end
        end
    end
    
    -- Rarity colors
    local rarity = seedData.Rarity or "Common"
    local rarityBG = itemFrame:FindFirstChild("Rarity_BG")
    local rarityText = itemFrame:FindFirstChild("Rarity_Text")
    
    if rarityBG then
        local rarityColors = {
            Common = Color3.fromRGB(150, 150, 150),
            Uncommon = Color3.fromRGB(76, 175, 80),
            Rare = Color3.fromRGB(33, 150, 243),
            Epic = Color3.fromRGB(156, 39, 176),
            Legendary = Color3.fromRGB(255, 193, 7),
            Mythic = Color3.fromRGB(255, 87, 34),
            Transcendent = Color3.fromRGB(255, 255, 255)
        }
        
        rarityBG.ImageColor3 = rarityColors[rarity] or rarityColors.Common
    end
    
    if rarityText then
        rarityText.Text = rarity
    end
    
    -- Limited banner
    if seedData.IsLimited then
        local limitedBanner = itemFrame:FindFirstChild("LimitedBanner")
        if limitedBanner then
            limitedBanner.Visible = true
            
            local timerLabel = limitedBanner:FindFirstChild("Timer")
            if timerLabel and seedData.EndTime then
                timerLabel.Text = formatShopTime(seedData.EndTime)
            end
        end
    end
    
    return itemFrame
end

-- ===== PURCHASE SYSTEM =====

local function buySeed(seedName, quantity)
    quantity = quantity or 1
    
    local seedData = SeedShopData[seedName]
    if not seedData then
        print("Seed not found:", seedName)
        return
    end
    
    -- ตรวจสอบ Stock
    local currentStock = seedStocks[seedName] and seedStocks[seedName].Stock or 0
    if currentStock < quantity then
        -- แสดง notification
        local NotificationG = require(Modules.NotificationG)
        NotificationG:CreateNotification("Not enough stock!")
        return
    end
    
    -- ตรวจสอบการล็อค
    local isLocked = isItemLocked(seedName)
    if isLocked then
        return
    end
    
    -- ส่งคำขอซื้อไปยัง server
    local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
    local BuySeedEvent = GameEvents:WaitForChild("BuySeedStock")
    
    BuySeedEvent:FireServer(seedName, quantity, "buy")
    
    -- เล่นเสียง
    SoundPlayer:PlaySound("Click")
end

-- ===== GIFT SYSTEM =====

local function giftSeed(seedName, targetPlayer)
    local GiftController = require(Modules.GiftController)
    
    -- ตรวจสอบว่าสามารถให้ของขวัญได้หรือไม่
    if not GiftController:CanGift() then
        return
    end
    
    -- แสดง Gift UI
    GiftController:PromptGiftFromGiftId(seedName, targetPlayer)
end

-- ===== CATEGORY & TAB SYSTEM =====

local function setCurrentCategory(category)
    currentCategory = category
    
    -- อัพเดท UI
    if shopFrame then
        local categoryLabel = shopFrame:FindFirstChild("CurrentCategory")
        if categoryLabel then
            categoryLabel.Text = category
        end
    end
end

local function setupTabs()
    local ShopTabData = require(ReplicatedStorage:WaitForChild("ShopTabData"))
    local tabHandler = ShopTabHandler:CreateOrGetTabHandler()
    
    tabHandler.OnTabSelected:Connect(function(tabName)
        setCurrentCategory(tabName)
        redrawShop()
    end)
end

-- ===== SHOP DRAWING =====

local function clearShop()
    if not scrollingFrame then return end
    
    for _, child in ipairs(scrollingFrame:GetChildren()) do
        if child:IsA("Frame") and child.Name ~= "UIListLayout" and child.Name ~= "ItemPadding" then
            child:Destroy()
        end
    end
end

local function redrawShop()
    clearShop()
    
    local category = currentCategory
    local seedsToDisplay = {}
    
    -- กรองเมล็ดพันธุ์ตาม category
    if category == "Daily Deals" then
        seedsToDisplay = DailySeedShopData or {}
    else
        for seedName, seedData in pairs(SeedShopData) do
            if seedData.Category == category and seedData.DisplayInShop then
                table.insert(seedsToDisplay, {name = seedName, data = seedData})
            end
        end
    end
    
    -- เรียงลำดับตาม LayoutOrder
    table.sort(seedsToDisplay, function(a, b)
        local orderA = a.data.LayoutOrder or 999
        local orderB = b.data.LayoutOrder or 999
        return orderA < orderB
    end)
    
    -- สร้าง item frames
    for _, seedInfo in ipairs(seedsToDisplay) do
        createShopItemFrame(seedInfo.name, seedInfo.data)
    end
end

-- ===== AD SYSTEM =====

local AdService = game:GetService("AdService")

local function checkForAds()
    local success, result = pcall(function()
        return AdService:GetAdAvailabilityNowAsync()
    end)
    
    if success and result then
        return result.IsAvailable
    end
    
    return false
end

local function showRewardedAd()
    if not checkForAds() then
        print("No ads available")
        return
    end
    
    local success, result = pcall(function()
        return AdService:ShowCompletedAsync()
    end)
    
    if success and result == "Completed" then
        -- ให้รางวัล restock
        resetStock()
        redrawShop()
        
        -- แสดง notification
        local NotificationG = require(Modules.NotificationG)
        NotificationG:CreateNotification('<font color="#ADD8E6"><b>Your Seed Shop stock has restocked!</b></font>')
    end
end

-- ===== RESTOCK ANIMATION =====

local function playRestockAnimation()
    if not shopFrame then return end
    
    local restockFever = Workspace:FindFirstChild("RestockFever")
    
    if restockFever then
        -- Tween rotation
        local tweenInfo = TweenInfo.new(
            1, -- Time
            Enum.EasingStyle.Linear,
            Enum.EasingDirection.InOut,
            -1, -- Repeat count (infinite)
            false, -- Reverse
            0 -- Delay
        )
        
        local tween = TweenService:Create(restockFever, tweenInfo, {
            Rotation = 360
        })
        
        tween:Play()
    end
    
    -- เล่นเสียง restock
    SoundPlayer:PlaySound("Restock_SFX")
end

-- ===== EVENTS =====

local function onStockUpdate()
    fetchStockInfo()
    redrawShop()
end

local function onRestock()
    resetStock()
    playRestockAnimation()
    
    task.wait(2)
    
    redrawShop()
end

-- ===== INITIALIZATION =====

function SeedShopController:Init()
    -- ดึง UI elements
    shopFrame = PlayerGui:WaitForChild("Seed_Shop")
    mainFrame = shopFrame:WaitForChild("Main_Frame")
    scrollingFrame = mainFrame:WaitForChild("ScrollingFrame")
    itemTemplate = ReplicatedStorage:WaitForChild("UITemplates"):WaitForChild("ShopItem")
    
    -- ตั้งค่า tabs
    setupTabs()
    
    -- ดึงข้อมูล stock เริ่มต้น
    fetchStockInfo()
    
    -- ตั้งค่า restock timer (ถ้า AB test enabled)
    setupRestockTimer()
    startRestockTimer()
    
    -- วาดร้านค้า
    redrawShop()
    
    -- เชื่อมต่อ events
    local GameEvents = ReplicatedStorage:WaitForChild("GameEvents")
    local RestockEvent = GameEvents:WaitForChild("SeedShopRestock")
    
    RestockEvent.OnClientEvent:Connect(onRestock)
    
    -- อัพเดทเมื่อมีการเปลี่ยนแปลง stock
    UpdateService.OnUpdated:Connect(onStockUpdate)
    
    print("SeedShopController initialized!")
end

-- ===== PUBLIC METHODS =====

function SeedShopController:GetCurrentCategory()
    return currentCategory
end

function SeedShopController:GetStocks()
    return seedStocks
end

function SeedShopController:BuySeed(seedName, quantity)
    return buySeed(seedName, quantity)
end

function SeedShopController:IsInTutorial()
    return LocalPlayer:GetAttribute("InTutorial") or false
end

return SeedShopController
