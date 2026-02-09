local Lighting = game:GetService("Lighting")
local Terrain = workspace.Terrain

local function ApplyAntiLag()
    -- Lighting
    Lighting.GlobalShadows = false
    Lighting.FogEnd = 9e9
    Lighting.Brightness = 0
    Lighting.EnvironmentDiffuseScale = 0
    Lighting.EnvironmentSpecularScale = 0
    Lighting.OutdoorAmbient = Color3.new(0, 0, 0)

    -- Terrain Water
    Terrain.WaterWaveSize = 0
    Terrain.WaterWaveSpeed = 0
    Terrain.WaterReflectance = 0
    Terrain.WaterTransparency = 1

    -- Workspace optimize
    for i, v in ipairs(workspace:GetDescendants()) do
        if i % 200 == 0 then
            task.wait()
        end

        if v:IsA("BasePart") then
            v.Material = Enum.Material.SmoothPlastic
            v.Reflectance = 0

        elseif v:IsA("ParticleEmitter") then
            v.Enabled = false

        elseif v:IsA("Decal") or v:IsA("Texture") then
            v.Transparency = 1
        end
    end

    -- Rendering quality (safe)
    pcall(function()
        settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
    end)
end
