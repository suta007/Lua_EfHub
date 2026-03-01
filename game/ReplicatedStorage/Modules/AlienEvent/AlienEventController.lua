local v1 = game:GetService("ReplicatedStorage")
local v_u_2 = game:GetService("RunService")
local v3 = game:GetService("Players")
game:GetService("TweenService")
require(v1.Modules.GuiController)
require(v1.Modules.Trove)
require(v1.Modules.ItemImageFinder)
require(v1.Modules.NumberUtil)
require(v1.Modules.CommaFormatNumber)
require(v1.Modules.GiveServiceCommon)
require(v1.Modules.UpdateService)
require(v1.Modules.Signal)
require(v1.Modules.DataService)
require(v1.Modules.GardenGuideModules.ImageCycle)
local v4 = require(v1.Modules.EventService)
require(v1.Modules.QuestsController)
require(v1.Comma_Module)
local v_u_5 = require(v1.Code.Spr)
require(v1.Modules.MarketController)
require(v1.Modules.UIComponents.QuestView)
local _ = require(v1.Data.SharedCycleHandlerData).HeartstruckRain
require(v1.Data.DevProductIds)
local v_u_6 = require(v1.Data.PetRegistry)
local v_u_7 = require(v1.Data.PetRegistry.PetMutationRegistry)
local v_u_8 = v3.LocalPlayer.PlayerGui:WaitForChild("Shop_UI")
local v9 = v4.new("AlienEventController", "Alien Event")
local v_u_10 = v1.GameEvents.AlienEvent.SubmitPet
local function v_u_16(p11, p12)
	-- upvalues: (copy) v_u_7
	local v13 = v_u_7.PetMutationRegistry[p12]
	if v13 then
		local v14 = v13.Color
		if v14 then
			for _, v15 in p11:GetDescendants() do
				if (v15:IsA("BasePart") or v15:IsA("UnionOperation")) and not v15:HasTag("Effect") then
					if v15:IsA("UnionOperation") then v15.UsePartColor = true end
					v15.Color = v15.Color:Lerp(v14, 0.75)
				end
			end
		end
	else
		return
	end
end
local function v_u_36(p17, p18, p19, p20, p21)
	-- upvalues: (copy) v_u_6, (copy) v_u_16, (copy) v_u_5, (copy) v_u_2
	if p17 then
		if p17.Character then
			local v22 = p17.Character:GetPivot()
			local v23 = v_u_6.PetList[p18]
			local v_u_24 = p20:Clone()
			for _, v25 in v_u_24:GetDescendants() do
				if v25:IsA("BasePart") then
					v25.CanCollide = false
					v25.CanQuery = false
					v25.CanTouch = false
					v25.Anchored = true
				end
			end
			v_u_24:PivotTo(v22)
			v_u_24.Parent = workspace.CurrentCamera
			if p19 then v_u_16(v_u_24, p19) end
			local v26 = v_u_24:FindFirstChild("AnimationController")
			if v26 then v26 = v26:FindFirstChild("Animator") end
			if v26 and (v23.Animations and v23.Animations.Idle) then
				local v27 = v26:LoadAnimation(v23.Animations.Idle)
				v27.Looped = true
				v27:Play()
			end
			local v_u_28 = v_u_24:GetScale()
			local v29 = {
				["Pivot"] = CFrame.new(p21 - Vector3.new(0, 3, 0), p21),
			}
			v_u_5.target(v_u_24, 0.5, 0.3, v29)
			local v_u_30 = os.clock()
			local v_u_35 = v_u_2.RenderStepped:Connect(function()
				-- upvalues: (copy) v_u_30, (copy) v_u_24, (copy) v_u_28
				local v31 = (os.clock() - v_u_30) / 6
				local v32 = math.clamp(v31, 0, 1)
				local v33 = v_u_24
				local v34 = v_u_28 * (1 - v32 * 0.9)
				v33:ScaleTo((math.max(0.01, v34)))
			end)
			v_u_5.completed(v_u_24, function()
				-- upvalues: (copy) v_u_35, (copy) v_u_24
				v_u_35:Disconnect()
				v_u_24:Destroy()
			end)
		end
	else
		return
	end
end
function v9.OnStarted(p37)
	-- upvalues: (copy) v_u_8, (copy) v_u_10, (copy) v_u_36
	local v_u_38 = game.Workspace.Interaction:WaitForChild("UpdateItems", 300):WaitForChild("AlienStand", 300):WaitForChild("UFO", 300)
	local v39 = v_u_8:WaitForChild("Frame", 30):WaitForChild("ScrollingFrame", 30):WaitForChild("UFOShardsFrame", 30)
	if v39 then v39.Visible = true end
	p37:Bind(v_u_10.OnClientEvent:Connect(function(p_u_40, p41)
		-- upvalues: (ref) v_u_36, (copy) v_u_38
		for v_u_42, v_u_43 in p41 do
			task.spawn(function()
				-- upvalues: (copy) v_u_43, (copy) v_u_42, (ref) v_u_36, (copy) p_u_40, (ref) v_u_38
				if v_u_43.Clone and v_u_43.Clone.Parent then
					local v44 = v_u_43.Clone:Clone()
					v44.Parent = workspace.CurrentCamera
					task.wait(0.25 * v_u_42)
					v_u_36(p_u_40, v_u_43.PetType, v_u_43.MutationName, v44, v_u_38.Position)
				end
			end)
		end
	end))
end
function v9.OnEnded(_) end
function v9.Open(_) end
function v9.Close(_) end
v9:Initialize()
return v9
