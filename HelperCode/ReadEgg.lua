local upvals = debug.getupvalues(
	getconnections(game:GetService("ReplicatedStorage").GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function
)

local upvals = debug.getupvalues(
	getconnections(game:GetService("ReplicatedStorage").GameEvents.EggReadyToHatch_RE.OnClientEvent)[1].Function
)

local event = game:GetService("ReplicatedStorage").GameEvents.EggReadyToHatch_RE.OnClientEvent
local all_connections = getconnections(event)

local event = game:GetService("ReplicatedStorage").GameEvents.EggReadyToHatch_RE.OnClientEvent
local connections = getconnections(event)

print("--- 🔍 เริ่มการสแกนตะกร้าแม่ (Total: " .. #connections .. ") ---")

for i, conn in pairs(connections) do
	print(string.format("\n📌 Connection ลำดับที่ [%d]", i))

	local func = conn.Function
	if func then
		-- ล้วง Upvalues ของฟังก์ชันนี้
		local upvals = debug.getupvalues(func)
		print("   จำนวน Upvalues ที่พบ:", #upvals)

		for idx, val in pairs(upvals) do
			local valType = type(val)
			print(string.format("   Index [%d] | Type: %s | Value: %s", idx, valType, tostring(val)))

			-- ถ้าเจอ Table ให้ลองส่องดู Key ข้างใน เผื่อเจอน้ำหนัก (Weight)
			if valType == "table" then
				local count = 0
				for k, v in pairs(val) do
					if count < 5 then -- ดูตัวอย่างแค่ 5 อันพอ
						print(string.format("      -> [Key]: %s | [Value]: %s", tostring(k), tostring(v)))
						count = count + 1
					end
				end
			end
		end
	else
		print("   ❌ ไม่พบฟังก์ชันที่เชื่อมต่อ")
	end
end
print("\n--- ✅ สแกนเสร็จสิ้น ---")
