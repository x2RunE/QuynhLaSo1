local place_id = {
    [6360478118] = "Grand Piece Online",
    [11424731604] = "Grand Piece Online",
    [1730877806] = "Grand Piece Online",
    [7465136166] = "Grand Piece Online",
    [3978370137] = "Grand Piece Online",
    [6811831486] = 'Grand Piece Online',
    [116480749200627] = 'Grand Piece Online',
    [7449423635] = 'Blox Fruits',
    [4442272183] = 'Blox Fruits',
    [2753915549] = 'Blox Fruits'
}
if place_id[game.PlaceId] == "Grand Piece Online" then
    repeat wait() until game.Players.LocalPlayer and game:GetService('ReplicatedStorage')
    local plr = game.Players.LocalPlayer
    plr:WaitForChild('PlayerGui')
    task.wait(0.06)
    if plr.PlayerGui:FindFirstChild('LoadingGUI') then
        task.wait(0.06)
        if plr.PlayerGui.LoadingGUI:FindFirstChild('CanvasGroup') then
            plr.PlayerGui.LoadingGUI.CanvasGroup.BackgroundColor3 = Color3.fromRGB(255,245,210)
            plr.PlayerGui.LoadingGUI.CanvasGroup.Circle2.BackgroundColor3 = Color3.fromRGB(255,245,210)
            plr.PlayerGui.LoadingGUI.CanvasGroup.LogoText.Image = 'rbxassetid://115020142752299'
        end
    end
    for _,v in next,game.ReplicatedFirst:GetDescendants() do
        if v:IsA('ScreenGui') and v.Name == 'LoadingGUI' then
            if v:FindFirstChild('CanvasGroup') then
                v.CanvasGroup.BackgroundColor3 = Color3.fromRGB(255,245,210)
                v.CanvasGroup.Circle2.BackgroundColor3 = Color3.fromRGB(255,245,210)
                v.CanvasGroup.LogoText.Image = 'rbxassetid://115020142752299'
            end
        end
    end
    repeat wait() until game:IsLoaded()
    pcall(function()
        pcall(function()
            local crabRemote = rs:FindFirstChild("Crab_Strangler")
            if crabRemote then
                crabRemote:Destroy()
            end
            pcall(function()
                if getconnections then
                    for _, v in pairs(getgc(true)) do
                        if type(v) == "function" then
                            local info = debug.getinfo(v)
                            local name = info.name:lower()
                            if name == "detected" or name == 'crash' then
                                hookfunction(v, function() end)
                            end
                         end
                     end
                     for i,v in next,getconnections(game:GetService('ScriptContext').Error) do v:Disconnect() end
                end
            end)
        end)
        task.wait(1.25)
    end)
    if getgenv().LowCPU then loadstring(game:HttpGet('https://raw.githubusercontent.com/x2RunE/QuynhLaSo1/refs/heads/main/data/fps-booster.lua'))() end
    if getgenv().Kaitun then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/0c77fdc97b797339625442ae88021b1e.lua"))()
    elseif getgenv().Santa then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/19b3855ecfbe969aa2e8a2fa2024d5e0.lua"))()
    elseif getgenv().ImpelDown then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/66bf2dd647d9d915717aa40ddbd8832e.lua"))()
    else
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7ff3bd5d1081c93c8eec4788572f2c6c.lua"))() 
    end
elseif place_id[game.PlaceId] == "Blox Fruits" then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/59774ddab40ca9e20397165d10849ceb.lua"))()
end
