repeat wait() until game.Players.LocalPlayer and game:GetService('ReplicatedStorage')
local plr = game.Players.LocalPlayer
plr:WaitForChild('PlayerGui')
task.wait(0.06)
if plr.PlayerGui:FindFirstChild('LoadingGUI') then
    task.wait(0.06)
    if plr.PlayerGui.LoadingGUI:FindFirstChild('CanvasGroup') then
        plr.PlayerGui.LoadingGUI.CanvasGroup.BackgroundColor3 = getgenv().Custom.LoadingBackground or Color3.fromRGB(255,245,210)
        plr.PlayerGui.LoadingGUI.CanvasGroup.Circle2.BackgroundColor3 = getgenv().Custom.LoadingBackground or Color3.fromRGB(255,245,210)
        plr.PlayerGui.LoadingGUI.CanvasGroup.LogoText.Image = (getgenv().Custom.LoadingImg or 'rbxassetid://115020142752299')
    end
end
for _,v in next,game.ReplicatedFirst:GetDescendants() do
    if v:IsA('ScreenGui') and v.Name == 'LoadingGUI' then
        if v:FindFirstChild('CanvasGroup') then
            v.CanvasGroup.BackgroundColor3 = getgenv().Custom.LoadingBackground or Color3.fromRGB(255,245,210)
            v.CanvasGroup.Circle2.BackgroundColor3 = getgenv().Custom.LoadingBackground or Color3.fromRGB(255,245,210)
            v.CanvasGroup.LogoText.Image = (getgenv().Custom.LoadingImg or 'rbxassetid://115020142752299')
        end
    end
end
repeat wait() until game:IsLoaded()
pcall(function()
    pcall(function()
        local crabRemote = game.ReplicatedStorage:FindFirstChild("Crab_Strangler")
        if crabRemote then
            crabRemote:Destroy()
        end
        pcall(function()
            if getconnections then
                for i,v in next,getconnections(game:GetService('ScriptContext').Error) do v:Disable() end
            end
        end)
    end)
    task.wait(1.25)
end)
