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

    local AlienEventSection = Tabs.Event:AddCollapsibleSection("Alien Event", false)
    AlienEventSection:AddToggle("tgAlienEventEnable", { Title = "Alien Event Enable", Default = false, Callback = function(Value) Core.QuickSave() end })
end

return Event
