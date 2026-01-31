--[[ This script make for sending messages to my server]]
local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain
local Players = game:GetService("Players")
local VirtualUser = game:GetService("VirtualUser")
local LocalPlayer = Players.LocalPlayer

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") then
        v:Destroy()
    end
end

settings().Rendering.QualityLevel = "Level01"

task.wait(1)

--[[ Log GUI ]]

local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()

local Window = Fluent:CreateWindow({
    Title = "Rocker 0.1", -- .. Fluent.Version,
    SubTitle = "by EfHub",
    TabWidth = 0,
    Size = UDim2.fromOffset(580, 380),
    Resize = true, -- Resize this ^ Size according to a 1920x1080 screen, good for mobile users but may look weird on some devices
    --MinSize = Vector2.new(470, 380),
    Acrylic = true, -- The blur may be detectable, setting this to false disables blur entirely
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl -- Used when theres no MinimizeKeybind
})

local Tabs = {
    Main = Window:AddTab({ Title = "Rocker", Icon = "upload" }),
}

Window:SelectTab(1)

------------------------------------------------------
-- ระบบปุ่มลอย (Floating Button) สำหรับ Android
------------------------------------------------------
local ToggleGui = Instance.new("ScreenGui")
local ToggleButton = Instance.new("TextButton")

ToggleGui.Name = "EfHub_Toggle"
ToggleGui.Parent = game:GetService("CoreGui") -- หรือเปลี่ยนเป็น PlayerGui ถ้าไม่ติด
ToggleGui.ResetOnSpawn = false

ToggleButton.Name = "ToggleButton"
ToggleButton.Parent = ToggleGui
ToggleButton.BackgroundColor3 = Color3.fromRGB(130, 7, 164)
ToggleButton.Position = UDim2.new(0, 10, 0.5, 0)
ToggleButton.Size = UDim2.new(0, 50, 0, 50)
ToggleButton.Text = "R"
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Draggable = true

local UICorner = Instance.new("UICorner")
UICorner.CornerRadius = UDim.new(0, 25)
UICorner.Parent = ToggleButton

ToggleButton.MouseButton1Click:Connect(function()
    Window:Minimize() -- กดเพื่อ ย่อ/ขยาย หน้าจอ Fluent
end)

 --- Configuration ---
local WebURL = "https://gag.ef.in.th/gag.php" -- แก้ไข URL ของพี่เอฟที่นี่
local CodeToSend = "" -- ตัวแปรเก็บค่าที่จะส่ง

-- --- UI Elements ---

Tabs.Main:AddParagraph({
    Title = "Data Input",
    Content = "วางโค้ดในช่อง หรือกดปุ่ม Paste เพื่อดึงจาก Clipboard"
})

-- 1. สร้าง Input Field
local Input = Tabs.Main:AddInput("Input", {
    Title = "Lua Code",
    Default = "",
    Placeholder = "Waiting for data...",
    Numeric = false, 
    Finished = false, -- false = อัปเดตค่าทันทีที่พิมพ์/วาง
    Callback = function(Value)
        CodeToSend = Value
        -- อัปเดต Paragraph ด้านล่างทันทีที่มีการเปลี่ยนแปลง
        -- หมายเหตุ: ต้องเรียกผ่านฟังก์ชัน UpdatePreview ที่สร้างไว้ด้านล่าง (แต่เนื่องจาก Lua รันบรรทัดต่อบรรทัด เราจะประกาศ Preview ก่อนไม่ได้ จึงต้องใช้วิธีอ้างอิงทีหลัง หรือใช้ Logic ภายใน)
    end
})

-- 2. ปุ่ม Paste from Clipboard
Tabs.Main:AddButton({
    Title = "📋 Paste from Clipboard",
    Description = "วางข้อมูลจาก Clipboard ลงในช่อง Input ทันที",
    Callback = function()
        local clip = ""
        -- ตรวจสอบฟังก์ชัน Clipboard ของ Executor
        if getclipboard then
            clip = getclipboard()
        elseif Synapse and Synapse.get_clipboard then
            clip = Synapse.get_clipboard()
        end

        if clip and clip ~= "" then
            -- SetValue จะไปเรียก Callback ของ Input โดยอัตโนมัติ
            Input:SetValue(clip)
            Fluent:Notify({Title = "Pasted", Content = "วางข้อมูลเรียบร้อยแล้ว", Duration = 2})
        else
            Fluent:Notify({Title = "Error", Content = "Clipboard ว่างเปล่า", Duration = 2})
        end
    end
})

-- 3. Paragraph สำหรับแสดงผล (Preview)
local Preview = Tabs.Main:AddParagraph({
    Title = "Current Data Preview",
    Content = "..."
})

-- *เชื่อมต่อ Logic การอัปเดต*: แก้ไข Callback ของ Input เพื่อสั่งให้ Preview อัปเดตข้อความ
Input:OnChanged(function()
    if Input.Value == "" then
        Preview:SetDesc("...")
    else
        -- ตัดข้อความถ้ามันยาวเกินไปเพื่อกัน UI บัค (แสดงแค่ 500 ตัวอักษรแรก)
        local displayCheck = Input.Value
        if #displayCheck > 500 then
            displayCheck = string.sub(displayCheck, 1, 500) .. "\n... (ยังมีต่อ) ..."
        end
        Preview:SetDesc(displayCheck)
    end
end)


Tabs.Main:AddParagraph({
    Title = "Action",
    Content = "------------------------------------------------"
})

-- 4. ปุ่ม Send
Tabs.Main:AddButton({
    Title = "🚀 Send to Web Server",
    Description = "ส่งข้อมูลปัจจุบันไปยัง Server",
    Callback = function()
        -- ดึงค่าล่าสุดจาก Input โดยตรงเพื่อความชัวร์
        CodeToSend = Input.Value

        if CodeToSend == "" then
            Fluent:Notify({ Title = "Error", Content = "ไม่มีข้อมูลให้ส่ง", Duration = 3 })
            return
        end

        local response = request({
            Url = WebURL,
            Method = "POST",
            Headers = { ["Content-Type"] = "application/x-www-form-urlencoded" },
            Body = "is_api=true&content=" .. game:GetService("HttpService"):UrlEncode(CodeToSend)
        })

        if response.StatusCode == 200 then
            Fluent:Notify({ Title = "Success", Content = "ส่งข้อมูลสำเร็จ!", Duration = 5 })
            -- หากต้องการเคลียร์ค่าหลังส่ง ให้เอา Comment ออก
            -- Input:SetValue("") 
        else
            Fluent:Notify({ Title = "Failed", Content = "Error Code: " .. tostring(response.StatusCode), Duration = 5 })
        end
    end
})

--[[ Anti-AFK ]]--
LocalPlayer.Idled:Connect(function()
    VirtualUser:CaptureController()
    VirtualUser:ClickButton2(Vector2.new())
end)