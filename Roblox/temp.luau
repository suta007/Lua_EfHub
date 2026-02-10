game:GetService("ReplicatedStorage").Data.PetRegistry.PetMutationRegistry


game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Daily.ScrollingFrame.Cocomango._StockValue.Value

game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Daily.ScrollingFrame.Seeds["Orange Tulip"]._StockValue
game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Daily.ScrollingFrame.Seeds.Banana._StockValue
game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Daily.ScrollingFrame.Seeds.Rafflesia._StockValue


game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame.Apple.Frame.Value

game:GetService("Players").LocalPlayer.PlayerGui.Seed_Shop.Frame.ScrollingFrame.Apple.Frame.Value

game:GetService("Players").LocalPlayer.PlayerGui.TravelingMerchantShop_UI.Frame.ScrollingFrame["Cooking Pot"].Frame.Value



local LocalPlayer = game:GetService("Players").LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local DailySeed = playerGui:WaitForChild("Seed_Shop"):WaitForChild("Daily"):WaitForChild("ScrollingFrame")
local DailySeedData={}

for _, item in ipairs(scrollingFrame:GetChildren()) do
    local stockChild = item:FindFirstChild("_StockValue")
    if stockChild then
        local itemId = item.Name
        local Stock = stockChild.Value
        --print(string.format("สินค้า: %s | จำนวนคงเหลือ: %d", itemName, currentStock))
    end
end

local DailySeedChildren = DailySeed:WaitForChild("Seeds")
for _, item in ipairs(DailySeed:GetChildren()) do
    local stockChild = item:FindFirstChild("_StockValue")
    if stockChild then
        local itemId = item.Name
        local Stock = stockChild.Value
        --print(string.format("สินค้า: %s | จำนวนคงเหลือ: %d", itemName, currentStock))
    end
end

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