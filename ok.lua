repeat wait() until game:IsLoaded()
task.spawn(function()
    newcclosure(function()
        while task.wait() do
            if game.Players.LocalPlayer.PlayerGui["khu v\225\187\177c \196\145\225\186\191n"].Enabled then
                local u1 = { game:GetService("ReplicatedStorage"):WaitForChild("SpawnLocations"):WaitForChild("Spawn1") }
                local u3 = game.Players.LocalPlayer.PlayerGui["khu v\225\187\177c \196\145\225\186\191n"]
                local function u7()
                    u3.Enabled = false
                end
                local v8 = u1[1]
                local v9 = game.Players.LocalPlayer
                local v10 = v9 and (v9.Character and v9.Character:FindFirstChild("HumanoidRootPart"))
                if v10 then
                    v10.CFrame = v8.CFrame
                end
                u7()
            end
        end
    end)()
end)

for k,v in pairs(getgc(true)) do 
    if pcall(function() return rawget(v,"indexInstance") end) and type(rawget(v,"indexInstance")) == "table" and (rawget(v,"indexInstance"))[1] == "kick" then
        setreadonly(v,false)
        v.tvk = {"kick",function() bypass = true return game.Workspace:WaitForChild("") end}
        setreadonly(v,true)
    end
end

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/vinhuchi/rblx/main/FixedFluent.lua"))()
local SaveManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/SaveManager.lua"))()
local InterfaceManager = loadstring(game:HttpGet("https://raw.githubusercontent.com/dawid-scripts/Fluent/master/Addons/InterfaceManager.lua"))()

local Window = Fluent:CreateWindow({
    Title = "DIT CDVN",
    SubTitle = " - By Radiant Hub",
    TabWidth = 120,
    Size = UDim2.fromOffset(580, 460),
    Acrylic = true,
    Theme = "Darker",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Options = Fluent.Options

local plr = game:GetService("Players").LocalPlayer
local character = plr.Character
local runs = game:GetService("RunService")
local tps = game:GetService("TeleportService")
local VIM = game:GetService("VirtualInputManager")
local VU = game:GetService("VirtualUser")
local repstorage = game:GetService("ReplicatedStorage")
local tweens = game:GetService("TweenService")
local uis = game:GetService("UserInputService")

plr.Idled:Connect(function()
    VU:Button2Down(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
    task.wait(1)
    VU:Button2Up(Vector2.new(0, 0), workspace.CurrentCamera.CFrame)
end)

plr.CharacterAdded:Connect(function(newCharacter)
    character = newCharacter
end)

-- settings

getgenv().distance = 100

-- script

newcclosure(function()
    local paths = {
        plr.PlayerScripts.PlayerScriptsLoader,
        plr.PlayerScripts.RbxCharacterSounds,
        plr.PlayerScripts.PlayerModule,
        plr.PlayerScripts.Controllers,
        plr.PlayerScripts.BloxbizSDK
    }
    for path in pairs(paths) do
        pcall(function()
            if path then path:Destroy() end
        end)
    end
    local remote = repstorage.Remotes["GetData "]
    local kickRemote = repstorage.KnitPackages._Index["sleitnick_knit@1.7.0"].knit.Services.DataService.RF:FindFirstChild("KickTuiDi")
    local mt = getrawmetatable(game)
    local old_namecall = mt.__namecall
    setreadonly(mt, false)
    mt.__namecall = newcclosure(function(self, ...)
        local method = getnamecallmethod()
        local args = {...}
        if self == remote and method == "FireServer" then
            return nil
        end
        if self == kickRemote and method == "FireServer" then
            return nil
        end
        return old_namecall(self, ...)
    end)
    setreadonly(mt, true)
end)()

local function getHandle()
    for _,v in pairs(character:GetChildren()) do
        if v:IsA("Tool") and v:FindFirstChild("Handle") then
            return v.Handle
        end
    end
end

-- Get player to attack
local targetTable = {}

task.spawn(function()
    while task.wait() do
        for i, player in pairs(game.Players:GetPlayers()) do
            if player ~= plr and player.Character and player.Character:FindFirstChild("Humanoid") and player.Character.Humanoid.Health > 0 and player.Character:FindFirstChild("HumanoidRootPart") then
                if (player.Character.HumanoidRootPart.Position - character.HumanoidRootPart.Position).Magnitude <= getgenv().distance then
                    local alreadyExists = false
                    for i2, v in pairs(targetTable) do
                        if v[1] == player then
                            alreadyExists = true
                            break
                        end
                    end
                    if not alreadyExists then
                        local targetTool = player.Character:FindFirstChildOfClass("Tool")
                        if targetTool and targetTool:FindFirstChild("Handle") then
                            table.insert(targetTable, {player, tick(), targetTool.Name})
                        end
                    end
                end
            end
        end
    end
end)


local function Attack()
    local handle = getHandle()
    if handle then
        for i,v in ipairs(targetTable) do
            if v[1] and (tick() - v[2]) <= 20 then
                if v[1].Character and v[1].Character:FindFirstChild("HumanoidRootPart") then
                    if (v[1].Character:FindFirstChild("HumanoidRootPart").Position - character.HumanoidRootPart.Position).Magnitude <= getgenv().distance then
                        for _,part in pairs(v[1].Character:GetChildren()) do
                            if part:IsA("BasePart") then
                                for i = 1,3 do
                                    firetouchinterest(handle, part, 0)
                                    task.wait()
                                    firetouchinterest(handle, part, 1)
                                end
                            end
                        end
                    end
                end
            else
                table.remove(targetTable,i)
            end
        end
    end
end

-- UI
local Tabs = {
    DIT = Window:AddTab({ Title = "DIT - Script", Icon = "swords" }),
    Settings = Window:AddTab({ Title = "Settings", Icon = "settings" }),
}

-- Tab : DIT CDVN - Script

Tabs.DIT:AddSection("⚔️ PVP functions")

local DIT_setDistance = Tabs.DIT:AddSlider("Slider", {
    Title = "Set Distance",
    Description = "Safe distance : Unlimited",
    Default = 100,
    Min = 20,
    Max = 1000,
    Rounding = 1,
    Callback = function(value)
        getgenv().distance = tonumber(value)
    end
})

local DIT_Hitbox = Tabs.DIT:AddToggle("Hitbox", 
{
    Title = "Far Attack Enabled", 
    Description = "Need weapon",
    Default = false,
    Callback = function(value)
        task.spawn(function()
            while value and task.wait() do
                Attack()
            end
        end)
    end 
})

local DIT_Spin = Tabs.DIT:AddToggle("Spin", 
{
    Title = "Spin Enabled [ Speed = 100 ]", 
    Description = "Make you stronger :)",
    Default = false,
    Callback = function(value)
        pcall(function()
            if value then
                for i,v in pairs(character.HumanoidRootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
                local Spin = Instance.new("BodyAngularVelocity")
                Spin.Name = "Spinning"
                Spin.Parent = character.HumanoidRootPart
                Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                Spin.AngularVelocity = Vector3.new(0,100,0)
            else
                for i,v in pairs(character.HumanoidRootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
            end
        end)
    end 
})

local DIT_TPWalk = Tabs.DIT:AddToggle("TPWalk", 
{
    Title = "TPWalk Enabled [ Speed = 20 ]", 
    Description = "Make you faster :)",
    Default = false,
    Callback = function(value)
        task.spawn(function()
            local chr = plr.Character
            local hum = chr and chr:FindFirstChildWhichIsA("Humanoid")
            local delta
            local heartbeatConnection
            pcall(function()
                while value and chr and hum and hum.Parent and task.wait() do
                    delta = runs.Heartbeat:Wait()
                    if hum.MoveDirection.Magnitude > 0 then
                        chr:TranslateBy(hum.MoveDirection * delta * 100)
                    end
                    for _,v in pairs(game:GetService("ReplicatedStorage"):GetChildren()) do
                        if string.find(v.Name,"Ragdoll") then
                            v:Destroy()
                            if game:GetService("CoreGui").RobloxGui["CoreScripts/PlayerRagdoll"] then
                                game:GetService("CoreGui").RobloxGui["CoreScripts/PlayerRagdoll"]:Destroy()
                            end
                        end
                    end
                end
            end)
        end)
    end 
})

Tabs.DIT:AddSection("🤑 Bug items")

Tabs.DIT:AddButton({
    Title = "> Get Phong Lon Hoang Kim 1 VND",
    Description = "",
    Callback = function()
        pcall(function()
            local args = {
                [1] = "Phong Lon (Hoàng Kim)"
            }
            repstorage:WaitForChild("KnitPackages"):WaitForChild("_Index"):WaitForChild("sleitnick_knit@1.7.0"):WaitForChild("knit"):WaitForChild("Services"):WaitForChild("ShopService"):WaitForChild("RE"):WaitForChild("buyItem"):FireServer(unpack(args))
        end)
    end
})


Tabs.DIT:AddSection("🥇 Elon Musk functions")

SaveManager:SetLibrary(Fluent)
InterfaceManager:SetLibrary(Fluent)

-- Ignore keys that are used by ThemeManager.

-- use case for doing it this way:
-- a script hub could have themes in a global folder
-- and game configs in a separate folder per game
InterfaceManager:SetFolder("RadiantHubV2")
SaveManager:SetFolder("RadiantHubV2/DIT CDVN")
SaveManager:LoadAutoloadConfig()
InterfaceManager:BuildInterfaceSection(Tabs.Settings)
SaveManager:BuildConfigSection(Tabs.Settings)

Window:SelectTab(1)
