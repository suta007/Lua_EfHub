local v1 = {}
local _ = workspace.CurrentCamera
local v_u_2 = require(game.ReplicatedStorage.Modules.SkyboxManager)
local v_u_3 = script.Sky
v_u_2.AddSkybox(v_u_3)
local v_u_4 = false
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = require(v5.Modules.SoundPlayer)
game:GetService("TweenService")
local v_u_7 = game:GetService("RunService")
local v_u_8 = require(v5.Data.SoundData)
local v_u_9 = nil
local v_u_10 = nil
local v_u_11 = nil
local v_u_12 = CFrame.new(-103.257, 150, -12.826)
local function v_u_26(p13)
	-- upvalues: (ref) v_u_11, (copy) v_u_7
	if not (v_u_11 and v_u_11.Parent) then return end
	if not MothershipReady then
		while not MothershipReady do
			task.wait()
		end
	end
	for _, v14 in p13 do
		if not (v_u_11 and v_u_11.Parent) then break end
		local v_u_15 = CFrame.new(v14 + Vector3.new(0, 50, 0))
		local v_u_16 = v_u_11:GetPivot()
		local v17 = (v_u_16.Position - v_u_15.Position).Magnitude / 80
		local v_u_18 = math.clamp(v17, 1.5, 6)
		local v_u_19 = os.clock()
		local v_u_20 = false
		local v_u_21 = nil
		v_u_21 = v_u_7.Heartbeat:Connect(function()
			-- upvalues: (copy) v_u_19, (copy) v_u_18, (copy) v_u_16, (copy) v_u_15, (ref) v_u_11, (ref) v_u_21, (ref) v_u_20
			local v22 = (os.clock() - v_u_19) / v_u_18
			local v23 = math.clamp(v22, 0, 1)
			local v24 = 1 - (1 - v23) ^ 2
			local v25 = v_u_16.Position:Lerp(v_u_15.Position, v24)
			v_u_11:PivotTo(v_u_16.Rotation:Lerp(v_u_15.Rotation, v24) + v25)
			if v23 >= 1 then
				v_u_21:Disconnect()
				v_u_20 = true
			end
		end)
		while not v_u_20 do
			task.wait()
		end
		task.wait(math.random(15, 30) / 10)
	end
end
local function v_u_39()
	-- upvalues: (copy) v_u_12, (copy) v_u_7
	local v_u_27 = script.UFO:Clone()
	v_u_27.Parent = workspace.Terrain
	local v28 = math.random() * 3.141592653589793 * 2
	local v29 = v_u_12.Position
	local v30 = math.cos(v28) * 800
	local v31 = math.sin(v28) * 800
	local v32 = v29 + Vector3.new(v30, 200, v31)
	local v_u_33 = CFrame.lookAt(v32, v_u_12.Position)
	v_u_27:PivotTo(v_u_33)
	v_u_27:ScaleTo(0.05)
	local v_u_34 = os.clock()
	local v_u_35 = nil
	v_u_35 = v_u_7.Heartbeat:Connect(function()
		-- upvalues: (copy) v_u_34, (copy) v_u_33, (ref) v_u_12, (copy) v_u_27, (ref) v_u_35
		local v36 = (os.clock() - v_u_34) / 6
		local v37 = math.clamp(v36, 0, 1)
		local v38 = 1 - (1 - v37) ^ 2
		v_u_27:PivotTo((v_u_33:Lerp(v_u_12, v38)))
		v_u_27:ScaleTo(v38 * 2.95 + 0.05)
		if v37 >= 1 then
			v_u_35:Disconnect()
			MothershipReady = true
		end
	end)
	return v_u_27
end
local function v_u_56(p_u_40)
	-- upvalues: (copy) v_u_7
	if p_u_40 and p_u_40.PrimaryPart then
		local v_u_41 = p_u_40:GetPivot()
		local v42 = math.random() * 3.141592653589793 * 2
		local v43 = v_u_41.Position
		local v44 = math.cos(v42) * 800
		local v45 = math.sin(v42) * 800
		local v_u_46 = v43 + Vector3.new(v44, 200, v45)
		local v_u_47 = p_u_40:GetScale()
		local v_u_48 = os.clock()
		local v_u_49 = nil
		v_u_49 = v_u_7.Heartbeat:Connect(function()
			-- upvalues: (copy) v_u_48, (copy) v_u_41, (copy) v_u_46, (copy) p_u_40, (copy) v_u_47, (ref) v_u_49
			local v50 = (os.clock() - v_u_48) / 5
			local v51 = math.clamp(v50, 0, 1)
			local v52 = v51 ^ 2
			local v53 = v_u_41.Position:Lerp(v_u_46, v52)
			p_u_40:PivotTo(CFrame.lookAt(v53, v_u_46))
			local v54 = p_u_40
			local v55 = v_u_47 * (1 - v52)
			v54:ScaleTo((math.max(0.05, v55)))
			if v51 >= 1 then
				v_u_49:Disconnect()
				p_u_40:Destroy()
			end
		end)
	end
end
local function v_u_71(p57)
	-- upvalues: (ref) v_u_4, (copy) v_u_2, (copy) v_u_3, (ref) v_u_9, (copy) v_u_6, (copy) v_u_8, (ref) v_u_10, (ref) v_u_11, (copy) v_u_12, (copy) v_u_39
	if v_u_4 == true then
		return
	else
		v_u_4 = true
		if p57 then
			game.Lighting.ClockTime = 16
			game.TweenService
				:Create(game.Lighting, TweenInfo.new(0.1), {
					["Ambient"] = Color3.fromRGB(63, 77, 138),
					["ExposureCompensation"] = 1,
					["Brightness"] = 0.6,
				})
				:Play()
			game.TweenService
				:Create(game.Lighting.NightColor, TweenInfo.new(0.1), {
					["Brightness"] = 0.15,
					["TintColor"] = Color3.fromRGB(142, 176, 255),
					["Contrast"] = 0.1,
				})
				:Play()
			game.Lighting.SunRays.Intensity = 0.028
			v_u_2.UpdateSkybox(v_u_3, 4)
			local v58 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
			}
			local v59 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
				["PlaybackSpeed"] = 0.4,
			}
			v_u_9 = v_u_6:PlaySound(v_u_8.Weather.Ambience, v58, nil, nil)
			v_u_10 = v_u_6:PlaySound(v_u_8.Weather.Ambience2, v59, nil, nil)
			local v60 = script.AAurora:Clone()
			v60.Parent = workspace.WeatherVisuals
			for _, v61 in v60:GetDescendants() do
				if v61:IsA("ParticleEmitter") then v61.Enabled = true end
			end
			local v62 = script.Radiance:Clone()
			v62.Parent = workspace.BasePlate.TopBaseplate
			v62.Enabled = true
			if v_u_11 then v_u_11:Destroy() end
			local v63 = script.UFO:Clone()
			v63.Parent = workspace.Terrain
			v63:PivotTo(v_u_12)
			v63:ScaleTo(3)
			v_u_11 = v63
			MothershipReady = true
		else
			game.TweenService
				:Create(game.Lighting, TweenInfo.new(5), {
					["ClockTime"] = 21,
				})
				:Play()
			task.wait(5)
			v_u_2.UpdateSkybox(v_u_3, 4)
			game.Lighting.ClockTime = 3
			task.wait(2)
			game.TweenService
				:Create(game.Lighting, TweenInfo.new(5), {
					["Ambient"] = Color3.fromRGB(64, 74, 138),
					["ExposureCompensation"] = 1,
					["Brightness"] = 0.6,
					["ClockTime"] = 16,
				})
				:Play()
			game.TweenService
				:Create(game.Lighting.NightColor, TweenInfo.new(5), {
					["Brightness"] = 0.1,
					["TintColor"] = Color3.fromRGB(146, 240, 129),
					["Contrast"] = 0.1,
				})
				:Play()
			game.Lighting.SunRays.Enabled = true
			local v64 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
			}
			local v65 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
				["PlaybackSpeed"] = 0.4,
			}
			v_u_9 = v_u_6:PlaySound(v_u_8.Weather.Ambience, v64, nil, nil)
			v_u_10 = v_u_6:PlaySound(v_u_8.Weather.Ambience2, v65, nil, nil)
			game.TweenService
				:Create(v_u_9, TweenInfo.new(1), {
					["Volume"] = 0.1,
				})
				:Play()
			game.TweenService
				:Create(v_u_10, TweenInfo.new(1), {
					["Volume"] = 0.1,
				})
				:Play()
			task.wait(3)
			if v_u_11 then v_u_11:Destroy() end
			v_u_11 = v_u_39()
			local v66 = script.AAurora:Clone()
			v66.Parent = workspace.WeatherVisuals
			local v67 = script.Radiance:Clone()
			v67.Parent = workspace.BasePlate.TopBaseplate
			v67.Enabled = true
			for _, v68 in v66:GetDescendants() do
				if v68:IsA("Beam") then
					local v69 = v68.Width0
					local v70 = v68.Width1
					v68.Width0 = 0
					v68.Width1 = 0
					game.TweenService
						:Create(v68, TweenInfo.new(4), {
							["Width0"] = v69,
							["Width1"] = v70,
						})
						:Play()
				elseif v68:IsA("ParticleEmitter") then
					v68.Enabled = true
				end
			end
			task.wait(10)
			game.TweenService
				:Create(game.Lighting.SunRays, TweenInfo.new(2), {
					["Intensity"] = 0.028,
				})
				:Play()
		end
	end
end
task.spawn(function()
	-- upvalues: (copy) v_u_26
	local v72 = game.ReplicatedStorage:WaitForChild("GameEvents"):WaitForChild("UFOWave", 30)
	if v72 then
		v72.OnClientEvent:Connect(function(p73)
			-- upvalues: (ref) v_u_26
			v_u_26(p73)
		end)
	end
end)
local function v_u_78(p74)
	-- upvalues: (ref) v_u_4, (ref) v_u_11, (copy) v_u_56, (ref) v_u_9, (ref) v_u_10, (copy) v_u_2, (copy) v_u_3
	if v_u_4 == false then
		return
	else
		v_u_4 = false
		if not p74 then
			local v_u_75 = workspace.BasePlate.TopBaseplate:FindFirstChild("Radiance")
			if v_u_75 ~= nil then
				v_u_75.Enabled = false
				task.delay(2, function()
					-- upvalues: (copy) v_u_75
					if v_u_75 then v_u_75:Destroy() end
				end)
			end
			game.TweenService
				:Create(game.Lighting, TweenInfo.new(5), {
					["ClockTime"] = 21,
				})
				:Play()
			game.TweenService
				:Create(game.Lighting.NightColor, TweenInfo.new(5), {
					["Brightness"] = 0,
					["Contrast"] = 0,
					["TintColor"] = Color3.fromRGB(255, 255, 255),
				})
				:Play()
			game.TweenService
				:Create(game.Lighting.SunRays, TweenInfo.new(2), {
					["Intensity"] = 0,
				})
				:Play()
			task.wait(5)
			local v_u_76 = workspace.WeatherVisuals:FindFirstChild("AAurora")
			if v_u_76 then
				task.spawn(function()
					-- upvalues: (copy) v_u_76
					for _, v_u_77 in v_u_76:GetDescendants() do
						if v_u_77:IsA("Beam") then
							task.spawn(function()
								-- upvalues: (copy) v_u_77
								game.TweenService
									:Create(v_u_77, TweenInfo.new(4), {
										["Width0"] = 0,
										["Width1"] = 0,
									})
									:Play()
							end)
						elseif v_u_77:IsA("ParticleEmitter") then
							v_u_77.Enabled = false
						end
					end
					task.wait(7)
					if v_u_76 then v_u_76:Destroy() end
				end)
			end
			if v_u_11 then v_u_56(v_u_11) end
			game.TweenService
				:Create(v_u_9, TweenInfo.new(1), {
					["Volume"] = 0,
				})
				:Play()
			game.TweenService
				:Create(v_u_10, TweenInfo.new(1), {
					["Volume"] = 0,
				})
				:Play()
			v_u_2.UpdateSkybox(v_u_3, 0)
			game.Lighting.ClockTime = 3
			game.TweenService
				:Create(game.Lighting, TweenInfo.new(5), {
					["Ambient"] = Color3.fromRGB(138, 138, 138),
					["ExposureCompensation"] = 0.2,
					["Brightness"] = 2,
					["ClockTime"] = 14,
				})
				:Play()
			task.wait(1)
			v_u_9:Stop()
			v_u_10:Stop()
			task.wait(5)
			game.Lighting.SunRays.Enabled = false
		end
	end
end
workspace:GetAttributeChangedSignal("AlienChaos"):Connect(function()
	-- upvalues: (copy) v_u_71, (copy) v_u_78
	if workspace:GetAttribute("AlienChaos") then
		v_u_71()
	else
		v_u_78()
	end
end)
if workspace:GetAttribute("AlienChaos") then
	task.defer(function()
		-- upvalues: (copy) v_u_71
		v_u_71(true)
	end)
elseif v_u_4 ~= false then
	v_u_4 = false
end
return v1
