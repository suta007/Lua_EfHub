---@class Fluent
local Fluent = {}

---@class Window
local Window = {}

---@class Tab
local Tab = {}

---@class Element
local Element = {}

---@param options table
---@return Window
function Fluent:CreateWindow(options) end

---@param options table
---@return Tab
function Window:AddTab(options) end

---@param options table
---@return Element
function Tab:AddParagraph(options) end

---@param options table
---@return Element
function Tab:AddButton(options) end

---@param options table
---@return Element
function Tab:AddToggle(options) end

---@param text string
function Element:SetDesc(text) end

function Window:Minimize() end

return Fluent