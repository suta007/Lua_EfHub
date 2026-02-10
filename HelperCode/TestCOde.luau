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
					Args = { "Shop", ItemName }
				elseif Setting.ArgType == "EventMode" then
					Args = { ItemName, Setting.EventArg }
				else
					Args = { ItemName }
				end
				Remote:FireServer(unpack(Args))
				task.wait(0.1)
			end
			BuyEnabled = false

			--local LogMessage = string.format("Bought %s : %s", ItemName, StockAmount)
			--DevNoti(LogMessage)
		end
	end
end




local StockData = {
    ["Carrot Seed"] = {
        ["Stock"] = 5,
        ["EggName"] = "Carrot Seed" -- ใส่หรือไม่ใส่ก็ได้ ถ้าไม่ใส่ Code จะใช้ key "Carrot Seed" แทน
    },
    ["Banana Seed"] = {
        ["Stock"] = 4
    }
}

