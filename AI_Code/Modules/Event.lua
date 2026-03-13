-- Modules/Event.lua
local Event = {}
local Core = nil
local UI = nil

function Event.Init(RefCore, RefUI)
    Core = RefCore
    UI = RefUI
    -- Real Event logic (Alien, Setup flags) fits here completely 
    Event.BuildUI()
end

function Event.BuildUI()
    local Tabs = UI.Tabs
    local Options = UI.Options

    local PetTable = {}
    local PetData = require(Core.ReplicatedStorage.Data.PetRegistry.PetList)
    for petName, _ in pairs(PetData) do table.insert(PetTable, petName) end
    table.sort(PetTable)

    local AlienEventSection = Tabs.Event:AddCollapsibleSection("Alien Event", false)
    AlienEventSection:AddToggle("tgAlienEventEnable", { Title = "Alien Event Enable", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddDropdown("ddAlienLoadout", { Title = "Alien Event Type", Values = { 1, 2, 3, 4, 5, 6 }, Default = 6, Multi = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddDropdown("ddAlienPet", { Title = "Alien Pet", Values = PetTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddDropdown("ddAlienMaxPet", { Title = "Alien Max Pet", Values = { 1, 2, 3, 4, 5, 6, 7, 8 }, Default = 3, Multi = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienAutoClaim", { Title = "Alien Auto Claim", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienAutoHatch", { Title = "Alien Auto Hatch", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienDefaultPetMode", { Title = "Default Pet Mode", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienDefaultPlaceEggs", { Title = "Default Place Eggs", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienDefaultHatchEggs", { Title = "Default Hatch Eggs", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAlienDefaultSellPets", { Title = "Default Sell Pets", Default = false, Callback = function(Value) Core.QuickSave() end })
    AlienEventSection:AddToggle("tgAutoGiftAlien", { Title = "Auto Gift Alien Pet", Default = false, Callback = function(Value) Core.QuickSave() end })
end

return Event
