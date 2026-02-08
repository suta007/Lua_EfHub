rconsoleclear()

local mt = getrawmetatable(game) -- (1) ดึงตาราง Metatable ของ game ออกมา
local oldNamecall = mt.__namecall -- (2) เก็บฟังก์ชันดั้งเดิมไว้ (Backup) เพื่อใช้เรียกตอนจบ
setreadonly(mt, false) -- (3) ปลดล็อกให้แก้ไขได้ (ปกติจะเป็น Read-only)

-- (4) เขียนทับฟังก์ชัน __namecall ด้วยฟังก์ชันใหม่ของเรา
mt.__namecall = newcclosure(function(self, ...)
    local method = getnamecallmethod() -- (4.1) เช็คว่าเกมสั่ง Method ชื่ออะไร?
    local args = {...} -- (4.2) ข้อมูลที่ส่งมาคืออะไร?

    -- rconsoleprint("ข้อความ")
    rconsoleprint("Namecall Method: " .. method)
    rconsoleprint("Arguments: " .. table.concat(args, ", "))

    return oldNamecall(self, ...)
end)

setreadonly(mt, true) -- (6) ล็อคกลับเหมือนเดิม
