local place_id = {
    [6360478118] = "Grand Piece Online",
    [11424731604] = "Grand Piece Online",
    [1730877806] = "Grand Piece Online",
    [7465136166] = "Grand Piece Online",
    [3978370137] = "Grand Piece Online",
    [6811831486] = 'Grand Piece Online',
    [85211729168715] = 'Blox Fruits',
    [79091703265657] = 'Blox Fruits',
    [100117331123089] = 'Blox Fruits'
}
if place_id[game.PlaceId] == "Grand Piece Online" then
    local ServiceNames = {"ReplicatedStorage","TweenService", "Players", "Workspace","RunService","UserInputService"}
    local Services = {}
    for _, Service in ipairs(ServiceNames) do 
        Services[Service] = cloneref(game:GetService(Service))
    end 
    local rs = Services.ReplicatedStorage
    local plrs = Services.Players
    local plr = plrs.LocalPlayer
    repeat
        task.wait(1.25)
    until rs and plr
    pcall(function()
        pcall(function()
            local crabRemote = rs:FindFirstChild("Crab_Strangler")
            if crabRemote then
                crabRemote:Destroy()
            end
        end)
        task.wait(1.25)
    end)
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
