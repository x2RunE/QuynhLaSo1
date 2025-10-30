local plr = game:GetService("Players").LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local Effects = workspace:WaitForChild("Effects")
local action = game.ReplicatedStorage.Fishing.Remotes.Action
local https = game:GetService('HttpService')
local FishingModule = require(game:GetService("ReplicatedStorage").Fishing.Assets.Client) if FishingModule and FishingModule._fishCaught then hookfunction(FishingModule._fishCaught, function() end)end
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
