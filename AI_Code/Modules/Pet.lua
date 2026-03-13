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

    local PetTable = {}
    local PetData = require(Core.ReplicatedStorage.Data.PetRegistry.PetList)
    for petName, _ in pairs(PetData) do table.insert(PetTable, petName) end
    table.sort(PetTable)

    local MutantData = require(Core.ReplicatedStorage.Data.PetRegistry.PetMutationRegistry)
    local MutantTable = {}
    for mutantName, mutantInfo in pairs(MutantData["PetMutationRegistry"]) do
        if type(mutantInfo) == "table" and mutantInfo.EnumId then table.insert(MutantTable, mutantName) end
    end
    table.sort(MutantTable)

    local PetWorkSection = Tabs.Pet:AddCollapsibleSection("Pet Farming", false)
    PetWorkSection:AddDropdown("PetMode", { Title = "Pet Mode", Description = "Select Pet Mode", Values = { "Nightmare", "Elephant", "Mutant", "Level" }, Default = "Nightmare", Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddToggle("PetModeEnable", { Title = "Enable Pet Farm", Default = false, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddDropdown("TargetPetDropdown", { Title = "Target Pet", Values = PetTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddToggle("UseFavoriteOnly", { Title = "Use Favorite Pet Only", Default = false, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddDropdown("TargetMutantDropdown", { Title = "Target Mutant", Values = MutantTable, Multi = false, Default = "", Searchable = true, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddInput("AgeLimitInput", { Title = "Age Limit", Default = 50, Filter = "Number", Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddInput("LoadOutDelay", { Title = "Loadout Switch Delay time", Default = 10, Filter = "Number", Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddDropdown("LevelSlots", { Title = "Select Loadout", Values = { 1, 2, 3, 4, 5, 6 }, Default = 1, Multi = false, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddDropdown("TimeSlots", { Title = "Select Time Slot", Values = { 1, 2, 3, 4, 5, 6 }, Default = 2, Multi = false, Callback = function(Value) Core.QuickSave() end })
    PetWorkSection:AddDropdown("MutantSlots", { Title = "Select Mutant Slot", Values = { 1, 2, 3, 4, 5, 6 }, Default = 3, Multi = false, Callback = function(Value) Core.QuickSave() end })

    local AutoAgeBreakSection = Tabs.Pet:AddCollapsibleSection("Auto Age Break")
    AutoAgeBreakSection:AddToggle("AAB_Enabled", { Title = "Enable Auto Age Break", Default = false, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddDropdown("AAB_PetType", { Title = "Select Pet Type", Values = PetTable, Default = "", Multi = false, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddInput("AAB_TargetAge", { Title = "Target Break Age", Default = 125, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddToggle("AAB_CheckWeight", { Title = "Check Dupe Weight?", Default = false, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddDropdown("AAB_WeightCond", { Title = "Weight Condition", Values = { "<=", ">=" }, Default = "<=", Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddInput("AAB_WeightVal", { Title = "Dupe Weight Value", Default = 10, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddToggle("AAB_CheckAge", { Title = "Check Dupe Age?", Default = false, Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddDropdown("AAB_AgeCond", { Title = "Age Condition", Values = { "<=", ">=" }, Default = "<=", Callback = function(Value) Core.QuickSave() end })
    AutoAgeBreakSection:AddInput("AAB_AgeVal", { Title = "Dupe Age Value", Default = 30, Numeric = true, Callback = function(Value) Core.QuickSave() end })

    local FruitTable = {}
    local SeedData = require(Core.ReplicatedStorage.Data.SeedData)
    for FruitName, _ in pairs(SeedData) do table.insert(FruitTable, FruitName) end
    table.sort(FruitTable)

    local PetFeedSection = Tabs.Pet:AddCollapsibleSection("Pet Feeding", false)
    PetFeedSection:AddToggle("AutoFeedPet", { Title = "Auto Feed", Default = false, Callback = function(Value) Core.QuickSave() end })
    PetFeedSection:AddToggle("AllowAllFood", { Title = "Allow All Food", Default = false, Callback = function(Value) Core.QuickSave() end })
    PetFeedSection:AddDropdown("AllowFoodType", { Title = "Allow Food Type", Values = FruitTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    PetFeedSection:AddSlider("PetHungerPercent", { Title = "Pet Hunger Percent", Min = 1, Max = 100, Default = 80, Rounding = 1, Callback = function(Value) Core.QuickSave() end })

    local PetGiftSection = Tabs.Pet:AddCollapsibleSection("Auto Accept Pet gift", false)
    PetGiftSection:AddToggle("tgAcceptPetGift", { Title = "Enable Auto Accept", Default = false, Callback = function(Value) Core.QuickSave() end })
    PetGiftSection:AddInput("inPetGiftDelay", { Title = "Accept Delay (s)", Default = 0.1, Filter = "Number", Callback = function(Value) Core.QuickSave() end })

    local HatchSection = Tabs.Pet:AddCollapsibleSection("Auto Hatch Eggs", false)
    HatchSection:AddToggle("tgPlaceEggsEn", { Title = "Place Eggs", Default = false, Callback = function(Value) Core.QuickSave() end })
    local AllEggTable = {}
    local AllPetEggs = require(Core.ReplicatedStorage.Data.PetRegistry.PetEggs)
    for EggName, _ in pairs(AllPetEggs) do table.insert(AllEggTable, EggName) end
    HatchSection:AddDropdown("ddPlaceEgg", { Title = "Select Eggs", Values = AllEggTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipMaxEggs", { Title = "Max Eggs", Default = 3, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSpeedEggSlot", { Title = "Select Speed Loadout", Values = { 1, 2, 3, 4, 5, 6 }, Default = 1, Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipPlaceEggDelay", { Title = "Place Eggs Delay", Default = 0.2, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddToggle("tgAutoHatchEn", { Title = "Auto Hatch", Default = false, Callback = function(Value) Core.QuickSave() end })
    local tempTable = { "ALL" }
    for i, v in ipairs(AllEggTable) do table.insert(tempTable, v) end
    HatchSection:AddDropdown("ddEggHatch", { Title = "Select Egg to Hatch", Values = tempTable, Multi = true, Default = { "ALL" }, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddHatchSlot", { Title = "Select Hatch Loadout", Values = { 1, 2, 3, 4, 5, 6 }, Default = 2, Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipHatchDelay", { Title = "Hatch Egg Delay", Default = 0.2, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipSpecialHatchWeight", { Title = "Special Hatch Weight", Default = 0, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSpecialHatchType", { Title = "Special Hatch Pet", Values = PetTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSpecialHatchSlot", { Title = "Select Hatch Loadout", Values = { 1, 2, 3, 4, 5, 6 }, Default = 4, Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddToggle("tgSellPetEn", { Title = "Auto Sell Pet", Default = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSellPetSlot", { Title = "Select Sell Pet Loadout", Values = { 1, 2, 3, 4, 5, 6 }, Default = 3, Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSellPetType", { Title = "Sell Pet Type", Values = PetTable, Multi = true, Default = {}, Searchable = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSellMode", { Title = "Sell Pet Mode", Values = { "ALL", "White list", "Black list" }, Default = "White list", Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipSellWeight", { Title = "Sell Pet Weight", Default = 0, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddDropdown("ddSellWeightMode", { Title = "Sell Weight Mode", Values = { "Below", "Above" }, Default = "Below", Multi = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddToggle("tgSellMutantPet", { Title = "Sell Mutant Pet", Default = false, Callback = function(Value) Core.QuickSave() end })
    HatchSection:AddInput("ipSellPetDelay", { Title = "Sell Pet Delay", Default = 0.2, Numeric = true, Finished = true, Callback = function(Value) Core.QuickSave() end })
end

return Pet
