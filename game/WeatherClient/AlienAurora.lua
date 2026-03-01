local v1 = {}
local _ = workspace.CurrentCamera
local v_u_2 = require(game.ReplicatedStorage.Modules.SkyboxManager)
local v_u_3 = script.Sky
v_u_2.AddSkybox(v_u_3)
local v_u_4 = false
local v5 = game:GetService("ReplicatedStorage")
local v_u_6 = require(v5.Modules.SoundPlayer)
local v_u_7 = require(v5.Data.SoundData)
local v_u_8 = nil
local v_u_9 = nil
local function v_u_23(p10)
	-- upvalues: (ref) v_u_4, (copy) v_u_2, (copy) v_u_3, (ref) v_u_8, (copy) v_u_6, (copy) v_u_7, (ref) v_u_9
	if v_u_4 == true then
		return
	else
		v_u_4 = true
		if p10 then
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
			local v11 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
			}
			local v12 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
				["PlaybackSpeed"] = 0.4,
			}
			v_u_8 = v_u_6:PlaySound(v_u_7.Weather.Ambience, v11, nil, nil)
			v_u_9 = v_u_6:PlaySound(v_u_7.Weather.Ambience2, v12, nil, nil)
			local v13 = script.AAurora:Clone()
			v13.Parent = workspace.WeatherVisuals
			for _, v14 in v13:GetDescendants() do
				if v14:IsA("ParticleEmitter") then v14.Enabled = true end
			end
			local v15 = script.Radiance:Clone()
			v15.Parent = workspace.BasePlate.TopBaseplate
			v15.Enabled = true
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
			local v16 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
			}
			local v17 = {
				["RollOffMaxDistance"] = 10000,
				["RollOffMinDistance"] = 10,
				["RollOffMode"] = Enum.RollOffMode.Linear,
				["Looped"] = true,
				["Volume"] = 0,
				["PlaybackSpeed"] = 0.4,
			}
			v_u_8 = v_u_6:PlaySound(v_u_7.Weather.Ambience, v16, nil, nil)
			v_u_9 = v_u_6:PlaySound(v_u_7.Weather.Ambience2, v17, nil, nil)
			game.TweenService
				:Create(v_u_8, TweenInfo.new(1), {
					["Volume"] = 0.1,
				})
				:Play()
			game.TweenService
				:Create(v_u_9, TweenInfo.new(1), {
					["Volume"] = 0.1,
				})
				:Play()
			task.wait(3)
			local v18 = script.AAurora:Clone()
			v18.Parent = workspace.WeatherVisuals
			local v19 = script.Radiance:Clone()
			v19.Parent = workspace.BasePlate.TopBaseplate
			v19.Enabled = true
			for _, v20 in v18:GetDescendants() do
				if v20:IsA("Beam") then
					local v21 = v20.Width0
					local v22 = v20.Width1
					v20.Width0 = 0
					v20.Width1 = 0
					game.TweenService
						:Create(v20, TweenInfo.new(4), {
							["Width0"] = v21,
							["Width1"] = v22,
						})
						:Play()
				elseif v20:IsA("ParticleEmitter") then
					v20.Enabled = true
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
local function v_u_28(p24)
	-- upvalues: (ref) v_u_4, (ref) v_u_8, (ref) v_u_9, (copy) v_u_2, (copy) v_u_3
	if v_u_4 == false then
		return
	else
		v_u_4 = false
		if not p24 then
			local v_u_25 = workspace.BasePlate.TopBaseplate:FindFirstChild("Radiance")
			if v_u_25 ~= nil then
				v_u_25.Enabled = false
				task.delay(2, function()
					-- upvalues: (copy) v_u_25
					if v_u_25 then v_u_25:Destroy() end
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
			local v_u_26 = workspace.WeatherVisuals:FindFirstChild("AAurora")
			if v_u_26 then
				task.spawn(function()
					-- upvalues: (copy) v_u_26
					for _, v_u_27 in v_u_26:GetDescendants() do
						if v_u_27:IsA("Beam") then
							task.spawn(function()
								-- upvalues: (copy) v_u_27
								game.TweenService
									:Create(v_u_27, TweenInfo.new(4), {
										["Width0"] = 0,
										["Width1"] = 0,
									})
									:Play()
							end)
						elseif v_u_27:IsA("ParticleEmitter") then
							v_u_27.Enabled = false
						end
					end
					task.wait(7)
					if v_u_26 then v_u_26:Destroy() end
				end)
			end
			game.TweenService
				:Create(v_u_8, TweenInfo.new(1), {
					["Volume"] = 0,
				})
				:Play()
			game.TweenService
				:Create(v_u_9, TweenInfo.new(1), {
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
			v_u_8:Stop()
			v_u_9:Stop()
			task.wait(5)
			game.Lighting.SunRays.Enabled = false
		end
	end
end
workspace:GetAttributeChangedSignal("AlienAurora"):Connect(function()
	-- upvalues: (copy) v_u_23, (copy) v_u_28
	if workspace:GetAttribute("AlienAurora") then
		v_u_23()
	else
		v_u_28()
	end
end)
if workspace:GetAttribute("AlienAurora") then
	task.defer(function()
		-- upvalues: (copy) v_u_23
		v_u_23(true)
	end)
elseif v_u_4 ~= false then
	v_u_4 = false
end
return v1
