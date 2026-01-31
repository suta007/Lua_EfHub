local Lighting = game:GetService("Lighting")
local Terrain = game:GetService("Workspace").Terrain

Lighting.GlobalShadows = false
Lighting.FogEnd = 9e9
Lighting.Brightness = 0

Terrain.WaterWaveSize = 0
Terrain.WaterWaveSpeed = 0
Terrain.WaterReflectance = 0
Terrain.WaterTransparency = 0

for _, v in pairs(game:GetService("Workspace"):GetDescendants()) do
    if v:IsA("BasePart") and not v:IsA("MeshPart") then
        v.Material = Enum.Material.SmoothPlastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") or v:IsA("ParticleEmitter") then
        v:Destroy()
    end
end

settings().Rendering.QualityLevel = "Level01"

task.wait(1)