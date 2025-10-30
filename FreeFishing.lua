local plr = game:GetService("Players").LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local Effects = workspace:WaitForChild("Effects")
local action = game.ReplicatedStorage.Fishing.Remotes.Action
local https = game:GetService('HttpService')
local FishingModule = require(game:GetService("ReplicatedStorage").Fishing.Assets.Client) if FishingModule and FishingModule._fishCaught then hookfunction(FishingModule._fishCaught, function() end)end
for _,v in next,workspace.Ocean.OceanMeshes:GetDescendants() do
    if v:IsA('BasePart') then
        v.CanCollide = true
    end
    if v.Name:find('Bone') then
        v:Destroy()
    end
end
local function sendKey(v,t)
    spawn(function()
        keypress(v)
        wait(t)
        keyrelease(v)
    end)
end
task.spawn(function()
    while true do
        sendKey(0x20,1)
        wait(120)
    end
end)
local gui = Instance.new("ScreenGui")
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")
local btn = Instance.new("TextButton")
btn.Size = UDim2.new(0, 120, 0, 120)
btn.Position = UDim2.new(0.5, -60, 0.8, 0)
btn.Text = "Create Part"
btn.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
btn.Parent = gui
btn.MouseButton1Click:Connect(function()
    local p = workspace:FindFirstChild('Part')
    if p then
        p:Destroy()
    end
	local root = character:WaitForChild("HumanoidRootPart")
    local part = Instance.new("Part")
    part.Anchored = true
    part.Size = Vector3.new(32, 1, 32)
    part.CanCollide = true
    part.Parent = workspace
    part.Position = root.Position - Vector3.new(0, root.Size.Y/2 + part.Size.Y*1.2, 0)
    task.spawn(function()
        while task.wait() do
            part.Color = Color3.fromHSV(tick() % 5 / 5, 1, 1)
        end
    end)
end)
local btn2 = Instance.new("TextButton")
btn2.Size = UDim2.new(0, 120, 0, 120)
btn2.Position = UDim2.new(0.5, -170, 0.8, 0)
btn2.Text = "Lock Character"
btn2.BackgroundColor3 = Color3.fromRGB(50, 150, 255)
btn2.Parent = gui
btn2.MouseButton1Click:Connect(function()
    local root = character:WaitForChild("HumanoidRootPart")
    if root and not root:FindFirstChild("NoFall") and not root:FindFirstChild('NoFall') then
        local bv = Instance.new("BodyVelocity")
        bv.Name = "NoFall"
        bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
        bv.Velocity = Vector3.new(0, 0, 0)
        bv.P = 1000
        bv.Parent = root
    elseif root:FindFistChild('NoFall') then
        root.NoFall:Destroy()
    end
end)

task.spawn(function()
    while task.wait() do
        if not (function()
            for _,v in next,character:GetChildren() do
                if v.Name:find('Rod') then
                    return true
                end
            end
        end)() then
            continue
        end
        if https:JSONDecode(game.ReplicatedStorage['Stats' .. plr.Name].Inventory.Inventory.Value)[getgenv().Bait..' Fish Bait'] == nil then
            continue
        end
        action:InvokeServer({
            Action = "Throw",
            Goal = (character.HumanoidRootPart.Position + Vector3.new(0, -5, -20)),
            Bait = (getgenv().Bait.." Fish Bait")
        })
        game:GetService("StarterGui"):SetCore("SendNotification", {
            Title = "Radiant Macro - Free",
            Text = "Throwed Bait : "..getgenv().Bait,
            Icon = "rbxassetid://78102893621750"
        })
        wait(0.75)
        action:InvokeServer({
            Action = "Landed",
        })
        local bobble = Effects:WaitForChild(plr.Name .. "'s hook")
        if bobble and bobble:IsA("BasePart") then
            repeat wait(0.5) until bobble:GetAttribute('Caught')
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Radiant Macro - Free",
                Text = "Caught !",
                Icon = "rbxassetid://78102893621750"
            })
            wait(getgenv().Delay)
            action:InvokeServer({ Action = "Reel" })
            game:GetService("StarterGui"):SetCore("SendNotification", {
                Title = "Radiant Macro - Free",
                Text = "Got Fish !",
                Icon = "rbxassetid://78102893621750"
            })
            wait(1)
            action:InvokeServer({ Action = "HookReturning" })
            action:InvokeServer({ Action = "Cancel" })
        end
        wait(1)
    end
end)
