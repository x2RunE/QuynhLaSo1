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
    if getgenv().Kaitun then
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/bbc757ff9e647eb956ea5e0243158663.lua"))()
    else
        loadstring(game:HttpGet("https://api.luarmor.net/files/v3/loaders/7ff3bd5d1081c93c8eec4788572f2c6c.lua"))() 
    end
elseif place_id[game.PlaceId] == "Blox Fruits" then
    loadstring(game:HttpGet("https://pandadevelopment.net/virtual/file/1e48400962a52bef"))()
end
