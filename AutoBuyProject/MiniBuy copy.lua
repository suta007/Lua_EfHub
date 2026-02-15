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
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local DataStream = eplicatedStorage:WaitForChild("GameEvents"):WaitForChild("DataStream")
local LocalPlayer = game:GetService("Players").LocalPlayer

local BuyCount = {}
local BuyList = {
	["ROOT/EventShopStock/Santa's Stash/Stocks"] = {
		Items = { "Christmas Present", "Hot Chocolate Mug", "Pet Shard HyperHunger" },
		EventArg = "Santa's Stash",
		RemoteName = "BuyEventShopStock",
		ArgType = "EventMode",
	},
	["ROOT/EventShopStock/New Years Shop/Stocks"] = {
		Items = { "Dragon's Firework", "New Year's Egg" },
		EventArg = "New Years Shop",
		RemoteName = "BuyEventShopStock",
		ArgType = "EventMode",
	},
	["ROOT/SeedStocks/Daily Deals/Stocks"] = {
		Enabled = true,
		BuyAll = true,
		Items = {},
		RemoteName = "BuyDailySeedShopStock",
		ArgType = "NormalMode",
	},
}
local FocusList = { "Pet Shard HyperHunger" }

local function BuyItems(ShopKey, StockData)
	local Setting = BuyList[ShopKey]
	if not Setting or not Setting.Enabled then
		return
	end
	local Remote = RemoteCache[Setting.RemoteName]
	if not Remote then
		Remote = GameEvents:FindFirstChild(Setting.RemoteName)
		if Remote then
			RemoteCache[Setting.RemoteName] = Remote
		end
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
				BuyCount[ItemName] = (BuyCount[ItemName] or 0) + 1
				MiniLog.Text = string.format("Bought %s : %d", ItemName, BuyCount[ItemName])
				task.wait(0.1)
			end
			BuyEnabled = false
		end
	end
end

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
			task.spawn(function()
				BuyItems(Key, Content)
			end)
		end
	end
end)

pcall(function()
	local GetData_result = DataService:GetData()
	if GetData_result then
		local DailyStocks = GetData_result.SeedStocks["Daily Deals"].Stocks
		if DailyStocks then
			ProcessBuy("ROOT/SeedStocks/Daily Deals/Stocks", DailyStocks)
		end
		local SantaStocks = GetData_result.EventShopStock["Santa's Stash"].Stocks
		if SantaStocks then
			ProcessBuy("ROOT/EventShopStock/Santa's Stash/Stocks", SantaStocks)
		end
		local NewYearStocks = GetData_result.EventShopStock["New Years Shop"].Stocks
		if NewYearStocks then
			ProcessBuy("ROOT/EventShopStock/New Years Shop/Stocks", NewYearStocks)
		end
	end
end)
