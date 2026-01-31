--[[ Auto Buy ]]
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")

local BuyList ={
    ["ROOT/SeedStocks/Shop/Stocks"]={
        Enabled=true,
        BuyAll=false,
        Items= {"Orange Tulip", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco", "Crimson Thorn", "Zebrazinkle", "Octobloom", "Beast Buttercup", "Bonanza Bloom"},
        --[[ {"Carrot", "Broccoli", "Strawberry", "Potato", "Blueberry", "Brussels Sprout", "Orange Tulip", "Buttercup", "Cocomango", "Tomato", "Corn", "Daffodil", "Watermelon", "Pumpkin", "Apple", "Bamboo", "Coconut", "Cactus", "Dragon Fruit", "Mango", "Grape", "Mushroom", "Pepper", "Cacao", "Sunflower", "Beanstalk", "Ember Lily", "Sugar Apple", "Burning Bud", "Giant Pinecone", "Elder Strawberry", "Romanesco", "Crimson Thorn", "Zebrazinkle", "Octobloom", "Beast Buttercup", "Bonanza Bloom"}, ]]
        RemoteName="BuySeedStock",
        ArgType="SeedMode"
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
                elseif Setting.ArgType == "NormalMode" then
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