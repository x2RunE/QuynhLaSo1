local g = game
local s = settings()
local lighting = g:GetService("Lighting")
pcall(function()
    s.Rendering.QualityLevel = Enum.QualityLevel.Level01
end)
local function optimize(obj)
    if obj:IsA("BasePart") then
        obj.Material = Enum.Material.Plastic
        obj.Reflectance = 0
    elseif obj:IsA("Decal") or obj:IsA("Texture") then
        obj:Destroy()
    elseif obj:IsA("ParticleEmitter") or obj:IsA("Trail") then
        obj.Enabled = false
    elseif obj:IsA("Explosion") then
        obj.BlastPressure = 0
        obj.BlastRadius = 0
    end
end
for _,v in pairs(g:GetDescendants()) do
    optimize(v)
end
g.DescendantAdded:Connect(optimize)
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
-- Disable UI

local plr = game:GetService("Players").LocalPlayer
local pg = plr:WaitForChild("PlayerGui")
for _,v in ipairs(pg:GetDescendants()) do
    if v:IsA("ScreenGui") then
        v.Enabled = false
    end
end
pg.DescendantAdded:Connect(function(v)
    if v:IsA("ScreenGui") then
        v.Enabled = false
    end
end)
