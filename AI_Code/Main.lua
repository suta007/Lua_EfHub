-- Main.lua Entry Point
local Main = {}

local function LoadModule(name)
    local source = "https://raw.githubusercontent.com/suta007/Lua_EfHub/refs/heads/master/AI_Code/Modules/" .. name .. ".lua"
    mod = loadstring(game:HttpGet(source))()
    return mod
end

local Core = LoadModule("Core")
local UI = LoadModule("UI")
local Shop = LoadModule("Shop")
local Farming = LoadModule("Farming")
local Pet = LoadModule("Pet")
local Event = LoadModule("Event")

function Main.SyncBackgroundTasks()
    -- Start up Farming tasks
    Core.ToggleTask("AutoPlant", UI.Options.tgPlantFruitEnable and UI.Options.tgPlantFruitEnable.Value, function()
        pcall(Farming.AutoPlant)
        task.wait(tonumber(UI.Options.inPlantDelay and UI.Options.inPlantDelay.Value) or 0.3)
    end)

    Core.ToggleTask("CollectFruit1", UI.Options.tgCollectFruitEnable and UI.Options.tgCollectFruitEnable.Value, function() Farming.CollectFruitWorker(1) end)
    Core.ToggleTask("CollectFruit2", UI.Options.tgCollectFruitEnable2 and UI.Options.tgCollectFruitEnable2.Value, function() Farming.CollectFruitWorker(2) end)
    
    Core.ToggleTask("HardCoreBuy", UI.Options.HardCoreBuyEnable and UI.Options.HardCoreBuyEnable.Value, Shop.HardCoreBuy)

    -- Missing tasks such as Pet, Age break, Selling all, etc. covered here briefly
end

function Main.Init()
    print("EfHub V2 Initialize")
    UI.Init(Core)
    Shop.Init(Core, UI)
    Farming.Init(Core, UI)
    Pet.Init(Core, UI)
    Event.Init(Core, UI)
    
    UI.InitSaveManager(Main.SyncBackgroundTasks)
    Core.SuccessLog("Script V2 Modular Loaded Successfully!")
end

Main.Init()
