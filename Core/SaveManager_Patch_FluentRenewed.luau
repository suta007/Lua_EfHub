-- SaveManager_Patch_FluentRenewed_FINAL.luau
-- Stable / Type-Safe / Fluent-Renewed Compatible

local HttpService = game:GetService("HttpService")

local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Addons/SaveManager.luau"
))()

-- backup original methods
local _Save = SaveManager.Save
local _Load = SaveManager.Load

-------------------------------------------------
-- Helpers
-------------------------------------------------

local function SafeJSONDecode(v)
    local ok, res = pcall(HttpService.JSONDecode, HttpService, v)
    if ok then return res end
    return nil
end

local function EncodeValue(value, option)
    -- ColorPicker (Color3 → table)
    if option.Type == "ColorPicker" and typeof(value) == "Color3" then
        return HttpService:JSONEncode({
            R = value.R,
            G = value.G,
            B = value.B
        })
    end

    -- Table types (MultiDropdown, Keybind, etc.)
    if typeof(value) == "table" then
        return HttpService:JSONEncode(value)
    end

    return value
end

-------------------------------------------------
-- SAVE (Transactional, No Side Effects)
-------------------------------------------------

function SaveManager:Save(name)
    local options = self.Library and self.Library.Options
    if not options then
        return _Save(self, name)
    end

    local backup = {}

    for id, opt in pairs(options) do
        backup[id] = opt.Value
        opt.Value = EncodeValue(opt.Value, opt)
    end

    local ok, err = pcall(function()
        _Save(self, name)
    end)

    -- restore immediately (IMPORTANT)
    for id, opt in pairs(options) do
        opt.Value = backup[id]
    end

    if not ok then
        error(err)
    end
end

-------------------------------------------------
-- LOAD (Strict Type Restore)
-------------------------------------------------

function SaveManager:Load(name)
    _Load(self, name)

    local options = self.Library and self.Library.Options
    if not options then return end

    for _, opt in pairs(options) do
        local raw = opt.Value

        -- Only care about string (saved JSON)
        if typeof(raw) ~= "string" then
            continue
        end

        -- Decide expected type using DEFAULT (stateless & safe)
        local expectTable =
            typeof(opt.Default) == "table"
            or opt.Type == "MultiDropdown"
            or opt.Type == "Keybind"
            or opt.Type == "ColorPicker"

        if not expectTable then
            continue
        end

        local decoded = SafeJSONDecode(raw)
        if typeof(decoded) ~= "table" then
            continue
        end

        -- ColorPicker restore
        if opt.Type == "ColorPicker" then
            if decoded.R and decoded.G and decoded.B then
                decoded = Color3.new(decoded.R, decoded.G, decoded.B)
            else
                continue
            end
        end

        -- Final safe apply
        local ok = pcall(function()
            opt:SetValue(decoded)
        end)

        if not ok then
            -- fallback to default (prevents nil concat / next crash)
            opt.Value = opt.Default
        end
    end
end

return SaveManager
