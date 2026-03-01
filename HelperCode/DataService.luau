local Fluent = loadstring(
	game:HttpGet("https://github.com/ActualMasterOogway/Fluent-Renewed/releases/latest/download/Fluent.luau")
)()

local Window = Fluent:CreateWindow({
	Title = "Console Log",
	SubTitle = "by EfHub",
	TabWidth = 0,
	Size = UDim2.fromOffset(1200, 768),
	Resize = true,
	-- MinSize = Vector2.new(470, 380),
	Acrylic = true,
	Theme = "Darker",
	MinimizeKey = Enum.KeyCode.RightControl,
})

local Tabs = {
	Main = Window:AddTab({ Title = "Log Console", Icon = "terminal" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 100 -- จำนวนบรรทัดที่จะโชว์
local MaxFullHistory = 1000 -- จำนวนบรรทัดสูงสุดของประวัติทั้งหมด
local DisplayTable = {} -- ตารางเก็บข้อความโชว์
local FullHistoryTable = {} -- ตารางเก็บประวัติทั้งหมด
local IsPaused = false

-- [สำคัญ] ประกาศตัวแปร LogDisplay ไว้ก่อน เพื่อให้ปุ่มรู้จักตัวแปรนี้
local LogDisplay = nil

------------------------------------------------------
-- 2. สร้างปุ่มควบคุม (อยู่ด้านบน)
------------------------------------------------------

-- ปุ่มหยุด (Pause)
Tabs.Main:AddToggle("PauseSwitch", {
	Title = "Pause Logging",
	Default = false,
	Callback = function(Value)
		IsPaused = Value
	end,
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
	Title = "Copy All Logs",
	--Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
	Callback = function()
		if setclipboard then
			setclipboard(table.concat(FullHistoryTable, "\n"))
			Fluent:Notify({ Title = "Success", Content = "Copied all logs!", Duration = 2 })
		else
			Fluent:Notify({ Title = "Error", Content = "Executor not supported", Duration = 2 })
		end
	end,
})

-- ปุ่ม Clear
Tabs.Main:AddButton({
	Title = "Clear Logs",
	Callback = function()
		DisplayTable = {}
		FullHistoryTable = {}
		if LogDisplay then
			LogDisplay:SetValue("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
		end
	end,
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph("LogDisplay", {
	Title = "Recent Logs",
	Content = "System initialized...",
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------
local function AddLog(message)
	if IsPaused then
		return
	end
	local entry = message
	-- เก็บลงประวัติทั้งหมด
	table.insert(FullHistoryTable, entry)
	if #FullHistoryTable > MaxFullHistory then
		table.remove(FullHistoryTable, 1)
	end

	-- เก็บลงตารางแสดงผล (จำกัดบรรทัด)
	table.insert(DisplayTable, entry)
	if #DisplayTable > MaxLines then
		table.remove(DisplayTable, 1)
	end

	-- อัปเดตหน้าจอ
	if LogDisplay then
		local TempText = ""
		TempText = table.concat(DisplayTable, "\n")
		LogDisplay:SetValue(TempText)
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

local function TimeLog(message)
	local timestamp = os.date("%X")
	local entry = string.format("[%s] %s", timestamp, message)
	AddLog(entry)
end
------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)

local ReplicatedStorage = game:GetService("ReplicatedStorage")
local DataService = require(ReplicatedStorage.Modules.DataService)
local GetData_result = DataService:GetData()

local function GetEggStock()
	local EggStock = GetData_result.PetEggStock.Stocks
	--[[ 	for i=1 to 3 do 
		AddLog("Eggname : "..tostring(EggStock[i].EggName).." Stock : "..tostring(EggStock[i].Stock).
	end *]]
	for i, v in ipairs(EggStock) do
		AddLog("Eggname : " .. tostring(v.EggName) .. " Stock : " .. tostring(v.Stock))
	end
end

task.wait(2)
GetEggStock()

--GetData_result.SeedStocks.Shop

local SeedStocks = GetData_result.SeedStocks.Shop.Stocks
local inventory = GetData_result and GetData_result.PetsData and GetData_result.PetsData.PetInventory
local function ShowData(tbl, indent)
	indent = 1
	local spacing = string.rep("  ", indent)
	for k, v in pairs(tbl) do
		if type(v) == "table" then -- แก้ไข: ใส่ "" ครอบ table
			for k2, v2 in pairs(v) do
				if type(v2) == "table" then
					AddLog(
						spacing
							.. "GetData_result.PetEggStock.Stocks."
							.. tostring(k)
							.. "."
							.. tostring(k2)
							.. " is table"
					)
				else
					AddLog(
						spacing
							.. "GetData_result.PetEggStock.Stocks."
							.. tostring(k)
							.. "."
							.. tostring(k2)
							.. "="
							.. tostring(v2)
					)
				end
				task.wait(0.1)
			end

			task.wait(0.1)
		else
			AddLog("GetData_result.PetEggStock.Stocks." .. tostring(k) .. "=" .. tostring(v))
		end
		task.wait(0.1)
	end
	ErrorLog("Finish")
end

ShowData(inventory, 1)

--[[ โครงสร้าง Table
  GetData_result.SeedStocks.Shop.Stocks.Carrot.Stock=21
  GetData_result.SeedStocks.Shop.Stocks.Strawberry.Stock=6
  GetData_result.SeedStocks.Shop.Stocks.Broccoli.Stock=1
  GetData_result.SeedStocks.Shop.Stocks.Tomato.Stock=1
  GetData_result.SeedStocks.Shop.Stocks.Blueberry.Stock=2
]]

--[[
📋 Script initialized successfully.
  GetData_result.SeedStocks.Shop.Stocks.Carrot is table
  GetData_result.SeedStocks.Shop.Stocks.Corn is table
  GetData_result.SeedStocks.Shop.Stocks.Watermelon is table
  GetData_result.SeedStocks.Shop.Stocks.Strawberry is table
  GetData_result.SeedStocks.Shop.Stocks.Broccoli is table
  GetData_result.SeedStocks.Shop.Stocks.Potato is table
  GetData_result.SeedStocks.Shop.Stocks.Tomato is table
  GetData_result.SeedStocks.Shop.Stocks.Blueberry is table
GetData_result.SeedStocks.Shop.Seed=479353879
❌ Finish


📋 Script initialized successfully.
  GetData_result.SeedStocks.Shop.Stocks.Carrot.Stock=21
  GetData_result.SeedStocks.Shop.Stocks.Carrot.MaxStock=21
  GetData_result.SeedStocks.Shop.Stocks.Strawberry.Stock=6
  GetData_result.SeedStocks.Shop.Stocks.Strawberry.MaxStock=6
  GetData_result.SeedStocks.Shop.Stocks.Broccoli.Stock=1
  GetData_result.SeedStocks.Shop.Stocks.Broccoli.MaxStock=1
  GetData_result.SeedStocks.Shop.Stocks.Tomato.Stock=1
  GetData_result.SeedStocks.Shop.Stocks.Tomato.MaxStock=1
  GetData_result.SeedStocks.Shop.Stocks.Blueberry.Stock=2
  GetData_result.SeedStocks.Shop.Stocks.Blueberry.MaxStock=2
❌ Finish
]]

--[[
GetData_result.GearStock.Gear=479353871
GetData_result.GearStock.Stocks is table
* GetData_result.SeedStocks.Shop is table
* GetData_result.SeedStocks.Daily Deals is table
GetData_result.PetEggStock.Egg=474435006
GetData_result.PetEggStock.Stocks is table
GetData_result.TravelingMerchantShopStock.Stocks is table
GetData_result.TravelingMerchantShopStock.MerchantStartTime=0
GetData_result.TravelingMerchantShopStock.LifetimePurchases is table
GetData_result.CosmeticData.Inventory is table
GetData_result.CosmeticData.MutableStats is table
GetData_result.CosmeticData.Equipped is table

GetData_result.EventShopStock. is table
GetData_result.EventShopStock.New Years Shop is table
GetData_result.EventShopStock.Santa's Stash is table


* GetData_result.PetAgeBreakMachine.PetReady=false
* GetData_result.PetAgeBreakMachine.TimeLeft=0
* GetData_result.PetAgeBreakMachine.IsRunning=false

* GetData_result.PetMutationMachine.PetReady=false
* GetData_result.PetMutationMachine.TimeLeft=0
* GetData_result.PetMutationMachine.IsRunning=false


GetData_result.GardenGuide.PetData is table
GetData_result.GardenGuide.FoodData is table
GetData_result.GardenGuide.PlantData is table
GetData_result.GardenGuide.MutationData is table
GetData_result.GardenGuide.CosmeticData is table

* GetData_result.CookingPot.IsCooking=false
* GetData_result.CookingPot.CookTimeTotal=0
* GetData_result.CookingPot.MutationChance=0
* GetData_result.CookingPot.SubmittedIngredients is table

GetData_result.Settings.PetShopButton=false
GetData_result.Settings.ToggleNotifications=true
GetData_result.Settings.PlantableCollisions=true
GetData_result.Settings.RecieveGifts=true
GetData_result.Settings.Sounds=true
GetData_result.Settings.KeepPetOnGround=true
GetData_result.Settings.PerformanceMode=true
GetData_result.Settings.Textures=true
GetData_result.Settings.Audio=true
GetData_result.Settings.PetMutationVFX=false
GetData_result.Settings.CropMutationVFX=false
GetData_result.Settings.TradeRequests=true
GetData_result.Settings.YourFarmIcon=true
GetData_result.Settings.Tips=true
GetData_result.Settings.LowerPlantFXQuality=true
GetData_result.Settings.AutoCloseActivePetsUI=true
GetData_result.Settings.VisualEffects=true
GetData_result.Settings.PetScaling=false
GetData_result.Settings.FavoriteIcons=true
GetData_result.Settings.Music=true
GetData_result.Settings.PetUpdateRate=0.035
GetData_result.Settings.GearShopButton=false


GetData_result.PetsData.SelectedPetLoadout=1
GetData_result.PetsData.PetInventory is table
GetData_result.PetsData.PetIncubatorData is table
GetData_result.PetsData.MaxLoadoutSlots=4
GetData_result.PetsData.PetPouchUses=0
GetData_result.PetsData.MutableStats is table
GetData_result.PetsData.PetEggIncubatorData is table
GetData_result.PetsData.PurchasedEggSlots=0
GetData_result.PetsData.PurchasedEquipSlots=5
GetData_result.PetsData.PurchasedPetInventorySlots=0
GetData_result.PetsData.EquippedPets is table
GetData_result.PetsData.PetLoadouts is table
]]
