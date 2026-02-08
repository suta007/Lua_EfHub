-- SaveManager_Patch_FluentRenewed.luau
-- SAFE / PARSER-AWARE / STATELESS
-- Designed specifically for Fluent-Renewed

local HttpService = game:GetService("HttpService")

-- Load original SaveManager
local SaveManager = loadstring(game:HttpGet(
    "https://raw.githubusercontent.com/ActualMasterOogway/Fluent-Renewed/main/Addons/SaveManager.luau"
))()

local _Save = SaveManager.Save
local _Load = SaveManager.Load

-- =========================
-- Utilities
-- =========================

local function EncodeTable(v)
    if typeof(v) == "table" then
        return HttpService:JSONEncode(v)
    end
    return v
end

local function SafeDecodeTable(v)
    if typeof(v) ~= "string" then return v end
    local ok, result = pcall(HttpService.JSONDecode, HttpService, v)
    if ok and typeof(result) == "table" then
        return result
    end
    return v
end

local function IsMultiDropdown(option)
    -- Fluent-Renewed multi dropdown identification
    return option
        and option.Type == "Dropdown"
        and option.Multi == true
        and typeof(option.Value) == "table"
end

-- =========================
-- PATCH: SAVE
-- =========================

function SaveManager:Save(name)
    local options = self.Library and self.Library.Options
    if not options then
        return _Save(self, name)
    end

    local backup = {}

    -- Encode only Multi-Dropdown tables
    for id, option in pairs(options) do
        if IsMultiDropdown(option) then
            backup[id] = option.Value
            option.Value = EncodeTable(option.Value)
        end
    end

    local success, err = pcall(_Save, self, name)

    -- Restore original values immediately
    for id, value in pairs(backup) do
        if options[id] then
            options[id].Value = value
        end
    end

    if not success then
        error(err)
    end
end

-- =========================
-- PATCH: LOAD
-- =========================

function SaveManager:Load(name)
    local success, err = pcall(_Load, self, name)
    if not success then
        error(err)
    end

    local options = self.Library and self.Library.Options
    if not options then return end

    -- Decode only Multi-Dropdown values
    for _, option in pairs(options) do
        if option.Type == "Dropdown" and option.Multi == true then
            local decoded = SafeDecodeTable(option.Value)
            if typeof(decoded) == "table" and typeof(option.SetValue) == "function" then
                option:SetValue(decoded)
            end
        end
    end
end

return SaveManager
