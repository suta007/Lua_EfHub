-- Modules/Pet.lua
local Pet = {}
local Core = nil
local UI = nil

function Pet.Init(RefCore, RefUI)
    Core = RefCore
    UI = RefUI
    -- Real Pet Age Break, Mutation, Leveling Logic fits here completely
    Pet.BuildUI()
end

function Pet.BuildUI()
    local Tabs = UI.Tabs
    local Options = UI.Options

    local PetWorkSection = Tabs.Pet:AddCollapsibleSection("Pet Farming", false)
    PetWorkSection:AddDropdown("PetMode", { Title = "Pet Mode", Values = { "Nightmare", "Elephant", "Mutant", "Level" }, Default = "Nightmare", Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddToggle("PetModeEnable", { Title = "Enable Pet Farm", Default = false, Callback = function(Value) Core.QuickSave() end })
end

return Pet
