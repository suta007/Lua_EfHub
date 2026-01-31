
# Fluent UI Library - Full API Documentation

This document serves as a technical reference for the Fluent UI library in Roblox. Use this context to generate valid Luau code for creating user interfaces.

## 1. Library Initialization

```lua
local Fluent = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/main.lua"))()
local SaveManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://github.com/dawid-scripts/Fluent/releases/latest/download/Addons/InterfaceManager.lua"))()

```

## 2. Window Creation

```lua
local Window = Fluent:CreateWindow({
    Title = "Fluent UI",
    SubTitle = "by dawid",
    TabWidth = 160,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true, -- Background blur
    Theme = "Dark", -- Dark, Light, Blood, Cobalt, Rose
    MinimizeKey = Enum.KeyCode.LeftControl
})

```

## 3. Tabs and Sections

```lua
local Tab = Window:AddTab({ Title = "Main", Icon = "home" }) -- Icons use Lucide icons
local Section = Tab:AddSection("Section Title")

```

## 4. UI Elements

### Button

```lua
Tab:AddButton({
    Title = "Button Title",
    Description = "Optional description",
    Callback = function()
        print("Button clicked")
    end
})

```

### Toggle

```lua
local Toggle = Tab:AddToggle("MyToggle", {Title = "Toggle", Default = false })

Toggle:OnChanged(function(Value)
    print("Toggle changed:", Value)
end)

-- Methods:
Toggle:SetValue(true)

```

### Slider

```lua
local Slider = Tab:AddSlider("MySlider", {
    Title = "Slider",
    Description = "Slider description",
    Default = 10,
    Min = 0,
    Max = 100,
    Rounding = 1,
    Callback = function(Value)
        print("Slider changed:", Value)
    end
})

-- Methods:
Slider:OnChanged(function(Value) end)
Slider:SetValue(50)

```

### Dropdown

```lua
local Dropdown = Tab:AddDropdown("MyDropdown", {
    Title = "Dropdown",
    Values = {"One", "Two", "Three"},
    Multi = false,
    Default = 1,
})

Dropdown:OnChanged(function(Value)
    print("Selected:", Value)
end)

-- Methods:
Dropdown:SetValue("Two")
Dropdown:SetValues({"New", "Options"})

```

### Input

```lua
local Input = Tab:AddInput("MyInput", {
    Title = "Input",
    Default = "Default text",
    Placeholder = "Enter text...",
    Numeric = false, -- Only numbers allowed
    Finished = false, -- Only callback on Enter
    Callback = function(Value)
        print("Input changed:", Value)
    end
})

```

### Colorpicker

```lua
local Colorpicker = Tab:AddColorpicker("MyColorpicker", {
    Title = "Colorpicker",
    Default = Color3.fromRGB(96, 205, 255)
})

Colorpicker:OnChanged(function()
    print("Color changed:", Colorpicker.Value)
end)

```

### Keybind

```lua
local Keybind = Tab:AddKeybind("MyKeybind", {
    Title = "Keybind",
    Mode = "Toggle", -- Hold, Toggle, Always
    Default = "LeftControl",
    Callback = function(Value)
        print("Keybind clicked:", Value)
    end,
    ChangedCallback = function(NewBind)
        print("Bind changed:", NewBind)
    end
})

```

### Paragraph & Labels

```lua
local Paragraph = Tab:AddParagraph({
    Title = "Paragraph Title",
    Content = "This is the content of the paragraph."
})

-- Methods:
Paragraph:SetTitle("New Title")
Paragraph:SetDesc("New Content")

```

## 5. Notifications

```lua
Fluent:Notify({
    Title = "Notification",
    Content = "This is a notification",
    SubContent = "Optional sub-content",
    Duration = 5 -- Seconds
})

```

## 6. Dialogs

```lua
Window:Dialog({
    Title = "Confirmation",
    Content = "Are you sure?",
    Buttons = {
        {
            Title = "Confirm",
            Callback = function() print("Confirmed") end
        },
        {
            Title = "Cancel",
            Callback = function() print("Cancelled") end
        }
    }
})

```

## 7. Window Methods

* `Window:SelectTab(1)` - Selects a tab by index.
* `Window:Minimize()` - Toggles the minimize state.

