local g = game
local s = settings()
pcall(function()
    s.Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
for _,v in pairs(g:GetDescendants()) do
    if v:IsA("BasePart") then
        v.Material = Enum.Material.Plastic
        v.Reflectance = 0
    elseif v:IsA("Decal") or v:IsA("Texture") then
        v:Destroy()
    elseif v:IsA("ParticleEmitter") or v:IsA("Trail") then
        v.Enabled = false
    elseif v:IsA("Explosion") then
        v.BlastPressure = 0
        v.BlastRadius = 0
    end
end
lighting = g:GetService("Lighting")
lighting.GlobalShadows = false
lighting.FogEnd = 1e9
lighting.Brightness = 0
lighting.EnvironmentDiffuseScale = 0
lighting.EnvironmentSpecularScale = 0
for _,v in pairs(lighting:GetChildren()) do
    if v:IsA("PostEffect") then
        v.Enabled = false
    end
end
