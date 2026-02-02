--[[ Roblox lua script]]
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.ResetOnSpawn = false
ScreenGui.Name = "MiniBuy"
ScreenGui.Parent = game:GetService("CoreGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 150, 0, 40)
Frame.Position = UDim2.new(0.5, -110, 0.5, -60)
Frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
Frame.Parent = ScreenGui
Frame.Draggable = true
Frame.Active = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 10)
UICorner.Parent = Frame

local MiniLog = Instance.new("TextBox")
MiniLog.Size = UDim2.new(0, 140, 0, 20)
MiniLog.Position = UDim2.new(0, 5, 0, 15)
MiniLog.Text = "MiniLog"
MiniLog.TextColor3 = Color3.fromRGB(0, 255, 0)
MiniLog.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
MiniLog.Parent = Frame
MiniLog.TextWrapped = true
MiniLog.TextXAlignment = Enum.TextXAlignment.Left
MiniLog.TextYAlignment = Enum.TextYAlignment.Top
--MiniLog.TextSize = 10
MiniLog.TextScaled = true

--[[ Test TextBox  ]]
MiniLog.Text = "Script Started"
--[[ End Test TextBox  ]]
local DataStream = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("DataStream")
local LocalPlayer = game:GetService("Players").LocalPlayer

local BuyCount={}
local BuyList ={
    ["ROOT/EventShopStock/Santa's Stash/Stocks"] = {
        Items={"Christmas Present","Hot Chocolate Mug","Pet Shard HyperHunger"},
        EventArg="Santa's Stash"
    },
    ["ROOT/EventShopStock/New Years Shop/Stocks"] = {
        Items={"Dragon's Firework","New Year's Egg"},
        EventArg="New Years Shop"
    }
}
local FocusList ={"Pet Shard HyperHunger"}

local function BuyItems(Key, Content)
    local Setting = BuyList[Key]
    if not Setting then return end

    for itemId, itemInfo in pairs(Content) do
        local ItemName = itemInfo.EggName or itemId 
        local StockAmount = tonumber(itemInfo.Stock) or 0
        for _, BuyItemName in ipairs(Setting.Items) do
            if BuyItemName == ItemName and StockAmount > 0 then
                for i=1, StockAmount do
                    local Args = {ItemName, Setting.EventArg}
                    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock"):FireServer(unpack(Args))
                    BuyCount[ItemName] = (BuyCount[ItemName] or 0) + 1
                    -- if FocusList[ItemName] then
                    MiniLog.Text = string.format("[%s] Bought %s : %d", os.date("%X"), ItemName, BuyCount[ItemName])
                    -- end
                    task.wait(0.2)
                end
            end
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
            task.spawn(function()
                BuyItems(Key, Content)
            end)
        end
    end
end)

--[[ Loop Auto buy in first run]]
for Key, Setting in pairs(BuyList) do
    for _, ItemName in ipairs(Setting.Items) do
        local Args = {ItemName, Setting.EventArg}
        game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("BuyEventShopStock"):FireServer(unpack(Args))
        BuyCount[ItemName] = (BuyCount[ItemName] or 0) + 1
        -- if FocusList[ItemName] then
        MiniLog.Text = string.format("[%s] Bought %s : %d", os.date("%X"), ItemName, BuyCount[ItemName])
        -- end
        task.wait(0.2)
    end
end