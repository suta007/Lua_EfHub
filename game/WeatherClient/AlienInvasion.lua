local v1 = {}
Random.new()
local _ = workspace.CurrentCamera
local v2 = RaycastParams.new()
v2.FilterDescendantsInstances = { workspace.Terrain, workspace }
v2.FilterType = Enum.RaycastFilterType.Include
local v_u_3 = false
local function v4()
	-- upvalues: (ref) v_u_3
	v_u_3 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_3
		game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
			["Ambient"] = Color3.fromRGB(139, 226, 209)
		}):Play()
		while v_u_3 do
			task.wait(0.25)
		end
		game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
			["Ambient"] = game.Lighting:GetAttribute("DefaultAmbient")
		}):Play()
	end)
end
workspace:GetAttributeChangedSignal("AlienInvasionEvent"):Connect(function()
	-- upvalues: (ref) v_u_3
	if workspace:GetAttribute("AlienInvasionEvent") then
		v_u_3 = true
		task.spawn(function()
			-- upvalues: (ref) v_u_3
			game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
				["Ambient"] = Color3.fromRGB(139, 226, 209)
			}):Play()
			while v_u_3 do
				task.wait(0.25)
			end
			game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
				["Ambient"] = game.Lighting:GetAttribute("DefaultAmbient")
			}):Play()
		end)
	else
		v_u_3 = false
	end
end)
if workspace:GetAttribute("AlienInvasionEvent") then
	task.defer(v4)
else
	v_u_3 = false
end
return v1
local v1 = {}
Random.new()
local _ = workspace.CurrentCamera
local v2 = RaycastParams.new()
v2.FilterDescendantsInstances = { workspace.Terrain, workspace }
v2.FilterType = Enum.RaycastFilterType.Include
local v_u_3 = false
local function v4()
	-- upvalues: (ref) v_u_3
	v_u_3 = true
	task.spawn(function()
		-- upvalues: (ref) v_u_3
		game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
			["Ambient"] = Color3.fromRGB(139, 226, 209)
		}):Play()
		while v_u_3 do
			task.wait(0.25)
		end
		game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
			["Ambient"] = game.Lighting:GetAttribute("DefaultAmbient")
		}):Play()
	end)
end
workspace:GetAttributeChangedSignal("AlienInvasionEvent"):Connect(function()
	-- upvalues: (ref) v_u_3
	if workspace:GetAttribute("AlienInvasionEvent") then
		v_u_3 = true
		task.spawn(function()
			-- upvalues: (ref) v_u_3
			game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
				["Ambient"] = Color3.fromRGB(139, 226, 209)
			}):Play()
			while v_u_3 do
				task.wait(0.25)
			end
			game.TweenService:Create(game.Lighting, TweenInfo.new(3), {
				["Ambient"] = game.Lighting:GetAttribute("DefaultAmbient")
			}):Play()
		end)
	else
		v_u_3 = false
	end
end)
if workspace:GetAttribute("AlienInvasionEvent") then
	task.defer(v4)
else
	v_u_3 = false
end
return v1
