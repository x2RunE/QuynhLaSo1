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
    [2753915549] = 'Blox Fruits',
    [14890802310] = 'Bizarre Lineage',
    [80469437126309] = 'MM2'
}
if not getgenv().Custom then
    getgenv().Custom = {
        LoadingBackground = Color3.fromRGB(255,245,210),
        LoadingImg = 'rbxassetid://115020142752299',
        WebhookImg = nil
    }
end
if place_id[game.PlaceId] == "Grand Piece Online" then
    local exc_name = getexecutorname()
    if not exc_name:find("Volt") and not exc_name:find("Arceus") and not exc_name:find('delta') and not exc_name:find('Codex') then
          loadstring(game:HttpGet("https://raw.githubusercontent.com/x2RunE/QuynhLaSo1/refs/heads/main/data/gpo-bypass.lua"))()
    end
    if getgenv().LowCPU then loadstring(game:HttpGet('https://raw.githubusercontent.com/x2RunE/QuynhLaSo1/refs/heads/main/data/fps-booster.lua'))() end
    if getgenv().Kaitun then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/18a9ecec334aad902e1711861cde0861.lua"))()
    else
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7ff3bd5d1081c93c8eec4788572f2c6c.lua"))() 
    end
elseif place_id[game.PlaceId] == 'Bizarre Lineage' then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/3b69a1c7da2bfc3b76fdf66a74beb618.lua"))()
elseif place_id[game.PlaceId] == "Blox Fruits" then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/59774ddab40ca9e20397165d10849ceb.lua"))()
elseif place_id[game.PlaceId] == "MM2" then
    loadstring(game:HttpGet("https://api.luarmor.net/files/v4/loaders/09c65cb64bfa8b122254f33985d9650e.lua"))()
end
