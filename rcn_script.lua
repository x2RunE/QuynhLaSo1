repeat wait() until game:IsLoaded() and game.Players.LocalPlayer
local plr = game.Players.LocalPlayer
while true do
  writefile(plr.Name.."_IMT_RCN.txt",tostring(math.floor(tick())))
  task.wait(5)
end
