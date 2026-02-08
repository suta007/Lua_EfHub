local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Gient Golem", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 0,
    Size = UDim2.fromOffset(830, 525),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({
        Title = "Log Console",
        Icon = "terminal"
    })
}

Window:SelectTab(1)

------------------------------------------------------
-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "MU_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือเปลี่ยนเป็น PlayerGui ถ้าไม่ติด
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(1, 1, 71)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "MU"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize() -- กดเพื่อ ย่อ/ขยาย หน้าจอ Fluent
end)
------------------------------------------------------
-- 1. ประกาศตัวแปรระบบ (จองที่ไว้ก่อน)
------------------------------------------------------
local MaxLines = 50 -- จำนวนบรรทัดที่จะโชว์
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
    end
})

-- ปุ่ม Copy All
Tabs.Main:AddButton({
    Title = "Copy All Logs",
    -- Description = "คัดลอกประวัติทั้งหมดลง Clipboard",
    Callback = function()
        if setclipboard then
            setclipboard(table.concat(FullHistoryTable, "\n"))
            Fluent:Notify({
                Title = "Success",
                Content = "Copied all logs!",
                Duration = 2
            })
        else
            Fluent:Notify({
                Title = "Error",
                Content = "Executor not supported",
                Duration = 2
            })
        end
    end
})

-- ปุ่ม Clear
Tabs.Main:AddButton({
    Title = "Clear Logs",
    Callback = function()
        DisplayTable = {}
        FullHistoryTable = {}
        if LogDisplay then
            LogDisplay:SetDesc("") -- ตอนนี้ปุ่มจะรู้จัก LogDisplay แล้ว
        end
    end
})

------------------------------------------------------
-- 3. สร้างหน้าจอแสดงผล (อยู่ด้านล่าง)
------------------------------------------------------

-- สร้าง Paragraph แล้วเอาไปใส่ในตัวแปรที่จองไว้
LogDisplay = Tabs.Main:AddParagraph({
    Title = "Recent Logs",
    Content = "System initialized..."
})

------------------------------------------------------
-- 4. ฟังก์ชัน AddLog
------------------------------------------------------

local function AddLog(ts, message)
    if IsPaused then
        return
    end
    local entry
    local Addtime = ts or false
    if Addtime then
        local timestamp = os.date("%X")
        entry = string.format("[%s] %s", timestamp, message)
    else
        entry = message
    end

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
        LogDisplay:SetDesc(table.concat(DisplayTable, "\n"))
    end
end

------------------------------------------------------
-- 5. [NEW] ฟังก์ชันเสริม (Wrapper Functions) ที่พี่เอฟต้องการ
------------------------------------------------------
local function InfoLog(message)
    AddLog(true, "📋 " .. message)
end

local function WarnLog(message)
    AddLog(true, "⚠️ " .. message)
end

local function ErrorLog(message)
    AddLog(true, "❌ " .. message)
end

local function SuccessLog(message)
    AddLog(true, "✅ " .. message)
end

------------------------------------------------------
-- 6. Test Loop (ทดสอบดูความสวยงาม)
------------------------------------------------------
InfoLog("Script initialized successfully.")
task.wait(0.5)
SuccessLog("Connected to server.")

local VirtualUser = game:GetService("VirtualUser")
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local GameEvents = game:GetService("ReplicatedStorage"):WaitForChild("GameEvents")
local DataStream = GameEvents:WaitForChild("DataStream")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

-- Packet 1: Key=ROOT/GardenGuide/PetData/Bald Eagle/MaxLevel

local Mutation = true
local TargetPet = "Bald Eagle"
local TargetMutant = "GiantGolem"
local targetUUID = nil
local TargetLevel = 50
local LevelLoadout = 1
local MutantLoadout = 3 -- "Bug สลับ Loadout 2 -> 3"
local ClaimLoadout = 2 -- "Bug สลับ Loadout 3 -> 2"
local LoadoutWaitTime = 10.0
local Mutanting = false

local function GetPetUUID(petName)
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" then
            local name = string.match(item.Name, "^(.-)%s*%[")
            if string.find(name, TargetPet) then
                if not string.find(name, TargetMutant) then
                    WarnLog("Found pet in backpack: " .. name .. " (UUID: " .. item:GetAttribute("PET_UUID") .. ")")
                    return item:GetAttribute("PET_UUID")
                end
            end
        end
    end

    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    for _, pet in ipairs(scrollFramePath:GetChildren()) do
        if pet:FindFirstChild("Main") then
            if string.find(pet.Main.PET_TYPE.Text, petName) then
                if not string.find(pet.Main.PET_TYPE.Text, TargetMutant) then
                    WarnLog("Found pet in ActivePetUI: " .. pet.Main.PET_TYPE.Text .. " (UUID: " .. pet.Name .. ")")
                    return pet.Name -- ใช้ชื่อ object เป็น UUID แทน
                end
            end
        end
    end
    return nil
end

local function GetPetName(uuid)
    -- local name = nil
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            return string.match(item.Name, "^(.-)%s*%[")
        end
    end
    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    local targetPet = scrollFramePath:FindFirstChild(uuid)
    if targetPet then
        return targetPet.Main.PET_TYPE.Text
    end
    return nil
end

local function GetPetAge(uuid)
    local age = nil
    local FoundPet = false
    pcall(function()
        UnequipPet(uuid)
        task.wait(0.2)
        EquipPet(uuid)
        task.wait(0.5)
    end)
    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    local targetPet = scrollFramePath:FindFirstChild(uuid)
    if targetPet then
        -- name = nil
        -- weight = nil
        age = tonumber(string.match(targetPet.Main.PET_AGE.Text, "%d+"))
        FoundPet = true
    end

    if not FoundPet then
        for _, item in ipairs(Backpack:GetChildren()) do
            if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
                -- name = string.match(item.Name, "^(.-)%s*%[")
                -- weight = tonumber(string.match(item.Name, "%[([%d%.]+)%s*KG%]"))
                age = tonumber(string.match(item.Name, "%[%s*Age%s*(%d+)%s*%]"))
                FoundPet = true
                break
            end
        end
    end
    return FoundPet, age
end

local function heldPet(uuid) -- find uuid in backpack and select it
    for _, item in ipairs(Backpack:GetChildren()) do
        if item:GetAttribute("ItemType") == "Pet" and item:GetAttribute("PET_UUID") == uuid then
            Humanoid:EquipTool(item)
            return true
        end
    end
    return false
end

local function SwapPetLoadout(Loadout) -- Loadout is int 1-6
    local args = {"SwapPetLoadout", Loadout}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

local function EquipPet(uuid)
    local args = {"EquipPet", uuid}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

local function UnequipPet(uuid)
    local args = {"UnequipPet", uuid}
    GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
end

local function CheckAge(uuid)
    UnequipPet(uuid) -- Swaps to loadout 4 to check pet age
    task.wait(0.5)
    EquipPet(uuid)
    task.wait(1.5)
    local scrollFramePath = LocalPlayer.PlayerGui.ActivePetUI.Frame.Main.PetDisplay.ScrollingFrame
    local targetPet = scrollFramePath:FindFirstChild(uuid)
    if targetPet then
        return tonumber(string.match(targetPet.Main.PET_AGE.Text, "%d+"))
    end
    return nil
end

local function MakeMutant(uuid)

    SwapPetLoadout(MutantLoadout)
    task.wait(LoadoutWaitTime)
    Character:PivotTo(CFrame.new(-236.17, 4.50, 14.36))
    task.wait(0.2)
    heldPet(uuid)
    task.wait(1)
    -- local args = {"MakeMutant", uuid}
    -- GameEvents:WaitForChild("PetsService"):FireServer(unpack(args))
    local args = {"SubmitHeldPet"}
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetMutationMachineService_RE")
        :FireServer(unpack(args))
    task.wait(0.5)
    local args = {"PetAssets", TargetPet}
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("ReplicationChannel"):FireServer(
        unpack(args))
    task.wait(1)
    local args = {"StartMachine"}
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetMutationMachineService_RE")
        :FireServer(unpack(args))
    Mutanting = true
end

local function Mutation()
    if Mutation then
        targetUUID = GetPetUUID(TargetPet)
        if targetUUID then
            -- InfoLog("Found target pet: " .. TargetPet .. " (UUID: " .. targetUUID .. ")")
            local found, age = GetPetAge(targetUUID)
            if age == nil then
                age = 1
            end
            if found then
                InfoLog("Current age of " .. TargetPet .. ": " .. tostring(age))
                if age < 50 then
                    Character:PivotTo(CFrame.new(-16.63, 4.50, -64.73))
                    task.wait(0.3)
                    InfoLog("Swapping to loadout " .. LevelLoadout .. " to equip pet...")
                    SwapPetLoadout(LevelLoadout)
                    task.wait(LoadoutWaitTime)
                    InfoLog("Equipping pet...")
                    pcall(function()
                        EquipPet(targetUUID)
                    end)
                else
                    InfoLog(TargetPet .. " is level rised to " .. TargetLevel .. ". Swapping to mutant loadout " ..
                                MutantLoadout .. "...")
                    MakeMutant(targetUUID)
                end
            else
                WarnLog("Could not find age for pet with UUID: " .. targetUUID)
            end
        else
            ErrorLog("Target pet '" .. TargetPet .. "' not found in backpack.")
        end
    end
end

local function ClaimPet(uuid)
    InfoLog("Swapping to claim loadout " .. ClaimLoadout .. " to claim mutant pet...")
    SwapPetLoadout(ClaimLoadout)
    task.wait(LoadoutWaitTime)
    task.wait(5)
    local args = {"ClaimMutatedPet"}
    game:GetService("ReplicatedStorage"):WaitForChild("GameEvents"):WaitForChild("PetMutationMachineService_RE")
        :FireServer(unpack(args))
    InfoLog("Mutant pet claimed successfully!")
    task.wait(3)
    local mutantPetname = GetPetName(uuid)
    SuccessLog("Successfully claimed mutant pet: " .. tostring(mutantPetname))
    Mutanting = false
    if Character and Humanoid then
        Humanoid:UnequipTools()
    end
    task.wait(5)
    Mutation()
end

DataStream.OnClientEvent:Connect(function(Type, Profile, Data)
    if Type ~= "UpdateData" then
        return
    end

    if not Profile:find(LocalPlayer.Name) then
        return
    end

    for _, Packet in ipairs(Data) do
        local Key = Packet[1]
        local Content = Packet[2]
        -- local ChekcKey = "ROOT/GardenGuide/PetData/" .. TargetPet .. "/MaxLevel"
        -- local CheckKey2 = "ROOT/BadgeData/PetMaster"
        local age = 0
        if string.find(Key, "ROOT/GardenGuide/PetData") then
            -- if tonumber(Content) > 0 then
            age = tonumber(Content) or CheckAge(targetUUID)
            -- end
            InfoLog("Key 1 : Current max level of " .. TargetPet .. ": " .. tostring(age))
            if age >= TargetLevel then
                InfoLog(TargetPet .. " has reached level " .. TargetLevel .. ". Proceeding to swap loadout...")
                UnequipPet(targetUUID)
                task.wait(0.3)
                MakeMutant(targetUUID)
            end
        end
        if Key == "ROOT/BadgeData/PetMaster" then

            -- local found, age = GetPetAge(targetUUID)
            -- local age = nil
            -- task.spawn(function()
            local age = CheckAge(targetUUID) or 0
            task.wait(1)
            -- end)
            -- *age = age or 0
            InfoLog("Key 2 : Current max level of " .. TargetPet .. ": " .. tostring(age))
            if age >= TargetLevel then
                InfoLog(TargetPet .. " has reached level " .. TargetLevel .. ". Proceeding to swap loadout...")
                UnequipPet(targetUUID)
                task.wait(0.3)
                MakeMutant(targetUUID)
            end
        end

        if Key == "ROOT/PetMutationMachine/PetReady" then
            if Mutanting then
                ClaimPet(targetUUID)
            end
        end
    end
end)

LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)

task.wait(1)
Mutation()
WarnLog("Mutation Starting...")
