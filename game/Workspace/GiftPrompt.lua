-- Decompiled with Konstant V2.1, a fast Luau decompiler made in Luau by plusgiant5 (https://discord.gg/brNTY8nX8t)
-- Decompiled on 2026-02-20 03:18:39
-- Luau version 6, Types version 3
-- Time taken: 0.004946 seconds

local Players_upvr = game:GetService("Players")
local LocalPlayer_upvr = Players_upvr.LocalPlayer
local Character_upvw = LocalPlayer_upvr.Character
if not Character_upvw then
	Character_upvw = LocalPlayer_upvr.CharacterAdded:Wait()
end
local function DisableProximityPromptsForLocalCharacter_upvr() -- Line 8, Named "DisableProximityPromptsForLocalCharacter"
	--[[ Upvalues[1]:
		[1]: Character_upvw (read and write)
	]]
	local HumanoidRootPart = Character_upvw:WaitForChild("HumanoidRootPart")
	if not HumanoidRootPart then
	else
		for _, v_3 in HumanoidRootPart:GetChildren() do
			if v_3:IsA("ProximityPrompt") then
				v_3.Enabled = false
			end
		end
	end
end
LocalPlayer_upvr.CharacterAdded:Connect(function(arg1) -- Line 16
	--[[ Upvalues[2]:
		[1]: Character_upvw (read and write)
		[2]: DisableProximityPromptsForLocalCharacter_upvr (readonly)
	]]
	Character_upvw = arg1
	DisableProximityPromptsForLocalCharacter_upvr()
end)
DisableProximityPromptsForLocalCharacter_upvr()
local var11_upvw = false
local function HasFruitToolEquipped() -- Line 25
	--[[ Upvalues[2]:
		[1]: Character_upvw (read and write)
		[2]: var11_upvw (read and write)
	]]
	-- KONSTANTWARNING: Variable analysis failed. Output will have some incorrect variable assignments
	local var13 = Character_upvw:FindFirstChildWhichIsA("Tool")
	if var13 then
		var13 = Character_upvw:FindFirstChildWhichIsA("Tool"):FindFirstChild("Weight")
	end
	if var13 == nil then
	else
	end
	var11_upvw = true
end
Character_upvw.ChildAdded:Connect(HasFruitToolEquipped)
Character_upvw.ChildRemoved:Connect(HasFruitToolEquipped)
task.spawn(function() -- Line 35
	--[[ Upvalues[3]:
		[1]: Players_upvr (readonly)
		[2]: LocalPlayer_upvr (readonly)
		[3]: var11_upvw (read and write)
	]]
	while true do
		task.wait(0.1)
		for _, v in Players_upvr:GetPlayers(), nil do
			if v ~= LocalPlayer_upvr then
				local Character_2 = v.Character
				if Character_2 then
					local HumanoidRootPart_2 = Character_2:FindFirstChild("HumanoidRootPart")
					if HumanoidRootPart_2 then
						for _, v_2 in HumanoidRootPart_2:GetChildren() do
							if v_2:IsA("ProximityPrompt") then
								v_2.Enabled = var11_upvw
							end
						end
					end
				end
			end
		end
	end
end)
