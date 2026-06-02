repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
while true do
  writefile(game.Players.LocalPlayer.Name.."_IMT_RCN.txt",tostring(math.floor(tick()) - 25200))
  task.wait(5)
end
