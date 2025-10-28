pcall(function()
repeat wait() until game:IsLoaded()

local function RequestAPI(u,m,d)
    if m == 'post' then
        return http_request({
            Url = u,
            Method = "POST",
            Headers = {
                ["Content-Type"] = "application/json"
            },
            Body = cloneref(game:GetService('HttpService')):JSONEncode(d)
        })
    elseif m == 'get' then
        print('Nah')
    end
end
local localCheckRadiant, radiantCheck = pcall(function()
    return RequestAPI(
        'https://wl-9i8x.onrender.com/whitelist',
        'post',
    {
        key = getgenv().Key,
        hwid = gethwid()
    })
end)
if localCheckRadiant and radiantCheck.StatusCode ~= 200 and radiantCheck.StatusCode ~= 201 then
    game.Players.LocalPlayer:Kick("You're blacklisted \n reason : Try to crack Radiant Hub Script")
    local r = rawget(getrawmetatable(game.Players.LocalPlayer), "Kick") or game.Players.LocalPlayer.Kick
    r(game.Players.LocalPlayer, "You're blacklisted \n reason : Try to crack Radiant Hub Script")
    task.wait(3)
    game:Shutdown()
end
pcall(function()
	local old
	old = hookmetamethod(game, "__namecall", function(self, ...)
		local method = getnamecallmethod()
		local args = { ... }
		if not checkcaller() and (method == "FireServer" or method == "InvokeServer") then
			local remote = tostring(self)
			local arg1 = tostring(args[1] or ""):lower()
            local arg2 = tostring(args[2] or ""):lower()
			if
				remote == "getPlayerPosition" or
				remote == "requestCFrame" or remote == 'server' or
				arg1:find("pos") or arg1:find("far") or arg1:find("teleport") or
				arg1:find("fast") or arg1:find("too") or arg1:find("clip") or
                arg1:find("high") or arg1:find('overlap') or arg1:find('check') or arg1:find('tp') or arg1:find('fly')
                or arg2:find('scripterror') or arg2:find('spoofed')
			then
				return nil
			end
		end
		return old(self, ...)
	end)
	loadstring(game:HttpGet("https://raw.githubusercontent.com/Pixeluted/adoniscries/main/Source.lua"))()
end)

if game.PlaceId == 1730877806 then
    pcall(function()
        task.spawn(function()
            while task.wait(2) do
                if getgenv().PrivateCode then
                    game.ReplicatedStorage.Events.reserved:InvokeServer(getgenv().PrivateCode)
                end
            end
        end)
    end)
    task.spawn(function()
        while task.wait(2) do
            if getgenv().PrivateCode then
                pcall(function()
                    local regularButton = game.Players.LocalPlayer.PlayerGui.chooseType.Frame.Options.Regular
                    if regularButton then
                        local connections = getconnections(regularButton.MouseButton1Click)
                        for _, connection in pairs(connections) do
                            connection:Fire()
                        end
                    end
                end)
            end
        end
    end)
end

local Fluent = loadstring(game:HttpGet("https://raw.githubusercontent.com/vinhuchi/rblx/main/FixedFluent.lua"))()

repeat wait() until Fluent

size = UDim2.fromOffset(395, 305)
twd = 100
local Window = Fluent:CreateWindow({
    Title = "Radiant Macro",
    SubTitle = "- GPO",
    TabWidth = twd,
    Size = size,
    Theme = "Dark",
    MinimizeKey = Enum.KeyCode.RightControl
})

local Options = Fluent.Options

local plr = game:GetService("Players").LocalPlayer
local character = plr.Character or plr.CharacterAdded:Wait()
local runs = game:GetService("RunService")
local tps = cloneref(game:GetService("TeleportService"))
local repstorage = cloneref(game:GetService("ReplicatedStorage"))
local tweens = cloneref(game:GetService("TweenService"))
local uis = game:GetService("UserInputService")
local https = game:GetService('HttpService')
local cls = game:GetService("CollectionService")

local tw,isTweening
local function tween(v, speed, high)
    if not character then return end
    if not character.HumanoidRootPart then return end
    if not character.Humanoid then return end
    if plr.Character and plr.Character:FindFirstChild("HumanoidRootPart") then
        character.Humanoid.Sit = false
        local rootPart = plr.Character:FindFirstChild("HumanoidRootPart")
        if typeof(v) == "Vector3" then v = CFrame.new(v) end
        local pos = Vector3.new(v.Position.X, high or v.Position.Y, v.Position.Z)
        local rot = rootPart.CFrame - rootPart.Position
        v = CFrame.new(pos) * rot
        local distance = (rootPart.Position - v.Position).Magnitude
        local time = distance / speed
        local tweeninfo = TweenInfo.new(time, Enum.EasingStyle.Linear, Enum.EasingDirection.Out)
        tw = tweens:Create(rootPart, tweeninfo, { CFrame = v })
        tw:Play()
        return tw
    end
end

local function equipGun()
    pcall(function()
        if plr.Backpack:FindFirstChild('Rifle') then
            character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Rifle'))
        elseif not plr.Backpack:FindFirstChild('Rifle') and not character:FindFirstChild('Rifle') and
            https:JSONDecode(game.ReplicatedStorage['Stats' .. plr.Name].Inventory.Inventory.Value)['Rifle'] == 1 then
            game.ReplicatedStorage.Events.Tools:InvokeServer('equip', 'Rifle')
        end
    end)
end

local Options = Fluent.Options

local Tabs = {
    General = Window:AddTab({
        Title = "Main Game",
        Icon = ""
    }),
    Auto = Window:AddTab({
        Title = "Auto Tasks",
        Icon = ""
    }),
    BattleRoyal = Window:AddTab({
        Title = "Battle Royal",
        Icon = ""
    })
}
Window:SelectTab(1)

-- Tab 1 : Main Game

Tabs.General:AddParagraph({
    Title = "```",
    Content = "Auto Leveling"
})

local General_AutoFarm = Tabs.General:AddToggle("AutoFarm", {
    Title = "Auto Farm Level [ Fishman ]",
    Description = "",
    Default = false
})

local General_FastGun = Tabs.General:AddToggle("FastGun", {
    Title = "Fast Reload Gun",
    Description = "",
    Default = false
})

local General_TweenToFishman = Tabs.General:AddToggle("TweenToFishman", {
    Title = "Tween To Fishman Cave",
    Description = "",
    Default = false
})

Tabs.General:AddParagraph({
    Title = "```",
    Content = "Auto Upgrade Mastery"
})

local General_SelectStats = Tabs.General:AddDropdown("SelectStats", {
    Title = "Select Stats",
    Description = "",
    Values = {"Strength", "Stamina", "Defense", "GunMastery", "SwordMastery"},
    Multi = false,
    Default = "GunMastery"
})

local General_UpStats = Tabs.General:AddToggle("UpStats", {
    Title = "Auto Up Stats",
    Description = "",
    Default = false
})

Tabs.General:AddParagraph({
    Title = "```",
    Content = "Visual Functions"
})

local General_IslandESP = Tabs.General:AddToggle("IslandESP", {
    Title = "Islands ESP",
    Description = ""
})

Tabs.General:AddParagraph({
    Title = "```",
    Content = "Auto Candies Farm"
})

local General_CandiesFarm = Tabs.General:AddToggle("CandiesFarm", {
    Title = "Auto Farm Candies",
    Description = ""
})

local General_SelectItem = Tabs.General:AddDropdown("SelectItem", {
    Title = "Select Item",
    Description = "",
    Values = {"SP Reset - 10", "Droot - 25", "Race RR - 25", "Custom Spirit Color - 50",'Spare Fruit Bag - 250','Blood Scythe - 500','Rare Fruit Chest - 250'},
    Multi = false,
    Default = ""
})

local General_AutoBuyCandiesItem = Tabs.General:AddToggle("AutoBuyCandiesItem", {
    Title = "Auto Buy Items",
    Description = ""
})

-- Tab : Auto Tasks

local Auto_InputPlayerNumber = Tabs.Auto:AddInput('InputPlayerNumber',{
    Title = "Input Player Number",
    Description = "",
    Default = 1,
    Placeholder = "Example: 2",
    Numeric = true, -- Only allows numbers
    Finished = true, -- Only calls callback when you press enter
    Callback = function(Value)
        Fluent:Notify({
            Title = "Radiant Hub Macro - Value Updated",
            Content = "Current value is " .. Value,
            SubContent = "SubContent",
            Duration = 3
        })
    end
})

local Auto_AutoLeavePlayerNumber = Tabs.Auto:AddToggle('AutoLeavePlayerNumber',{
    Title = 'Auto Leave Player Number',
    Description = '',
    Default = false
})

local Auto_AntiAFK = Tabs.Auto:AddToggle('AntiAFK',{
    Title = 'Anti AFK ( Jump )',
    Description = '[ Android / iOS or PC with window focused ]',
    Default = true
})

local Auto_SelectTimeLeave = Tabs.BattleRoyal:AddDropdown("SelectTimeLeave", {
    Title = "Select Time",
    Description = "",
    Values = {"10 Mins", "20 Mins","30 Mins"},
    Multi = false,
    Default = "10 Mins"
})

local Auto_SelectAction = Tabs.BattleRoyal:AddDropdown("SelectAction", {
    Title = "Select Action After Time",
    Description = "",
    Values = {"Leave the game", "Join main menu","Rejoin private server"},
    Multi = false,
    Default = "Leave the game"
})

local Auto_LeaveAfterTime = Tabs.Auto:AddToggle('LeaveAfterTime',{
    Title = 'Do Act After Time',
    Description = '[ IMPORTANT TO AVOID BAN ]',
    Default = true
})

task.spawn(function()
    while wait() and Options.LeaveAfterTime.Value do
        pcall(function()
            if (os.clock() / 60) >= tonumber(Options.SelectTimeLeave.Value:sub(1,2)) then
                if Options.SelectAction.Value == 'Leave the game' then
                    game:Shutdown()
                elseif Options.SelectAction.Value == 'Join main menu' or Options.SelectAction.Value == 'Rejoin private server' then
                    tps:Teleport(1730877806,plr)
                end
                break
            end
        end)
    end
end)

-- Tab 2 : Battle Royal

Tabs.BattleRoyal:AddParagraph({
    Title = "```",
    Content = "Combat Functions"
})

local BattleRoyal_TPWalk = Tabs.BattleRoyal:AddToggle("TPWalk", {
    Title = "Fast Walk [ No Stun ;) ]",
    Description = "",
    Default = false
})

local BattleRoyal_InfJump = Tabs.BattleRoyal:AddToggle("InfJump", {
    Title = "Inf Jump",
    Description = "",
    Default = false
})

local BattleRoyal_Spin = Tabs.BattleRoyal:AddToggle("Spin", {
    Title = "Spin [ Fun :) ]",
    Description = "",
    Default = false
})

Tabs.BattleRoyal:AddParagraph({
    Title = "```",
    Content = "Visual Functions"
})

local BattleRoyal_SelectChest = Tabs.BattleRoyal:AddDropdown("SelectChest", {
    Title = "Select Chest",
    Description = "",
    Values = {"Mythical Chest", "Legendary Chest", "Epic Chest", "Rare Chest", "Uncommon Chest", "Common Chest"},
    Multi = true,
    Default = {}
})

local BattleRoyal_ESPChest = Tabs.BattleRoyal:AddToggle("ESPChest", {
    Title = "Enable ESP Chest",
    Description = "",
    Default = false
})

local BattleRoyal_ESPPlayer = Tabs.BattleRoyal:AddToggle('ESPPlayer', {
    Title = "Enable ESP Player",
    Description = "",
    Default = false
})

-- Event handling

task.spawn(function()
	while task.wait(30) and Options.AutoFarm.Value do
		local char = plr.Character or plr.CharacterAdded:Wait()
		local hum = char:FindFirstChildOfClass("Humanoid")
		if hum and hum.MoveToFinished then
			local root = char:FindFirstChild("HumanoidRootPart")
			if root then
				local pos = root.Position + Vector3.new(0, 0, 1)
				hum:MoveTo(pos)
				hum.MoveToFinished:Wait()
			end
		end
	end
end)

Auto_AntiAFK:OnChanged(function()
    task.spawn(function()
        while Options.AntiAFK.Value do
            keypress(0x20)
            wait(1)
            keyrelease(0x20)
            wait(120)
        end
    end)
end)

Auto_AutoLeavePlayerNumber:OnChanged(function()
    task.spawn(function()
        while Options.AutoLeavePlayerNumber.Value and wait() do
            if (#game.Players:GetPlayers()) >= Options.InputPlayerNumber.Value then
                plr:Kick('Radiant Hub Macro : Safe :)')
                break
            end
        end
    end)
end)

task.spawn(function()
    while wait() do
        if Options.CandiesFarm.Value then
            local args = {"Sky Walk2",{char = game:GetService("Players").LocalPlayer.Character,cf = CFrame.new()}}
            game.ReplicatedStorage.Events.Skill:InvokeServer(unpack(args))
            task.wait(0.5)
            game.ReplicatedStorage.Events.Skill:InvokeServer(unpack(args))
        end
        wait(2)
    end
end)

task.spawn(function()
    while task.wait() do
        pcall(function()
            local hrp = plr.Character and plr.Character:FindFirstChild("HumanoidRootPart")
            if Options.CandiesFarm.Value or Options.AutoFarm.Value then
                if hrp and not hrp:FindFirstChild("NoFall") and not hrp:FindFirstChild('NoFall') then
                    local bv = Instance.new("BodyVelocity")
                    bv.Name = "NoFall"
                    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                    bv.Velocity = Vector3.new(0, 0, 0)
                    bv.P = 1000
                    bv.Parent = hrp
                end
            elseif hrp:FindFirstChild('NoFall') then
                hrp:FindFirstChild('NoFall'):Destroy()
            end
        end)
    end
end)

local function esp(p)
	if p == plr then return end
	local function create()
		if not Options.ESPPlayer.Value then return end
		if game.CoreGui:FindFirstChild(p.Name.."_ESP") then return end
		local char = p.Character
		if not char then return end
		local head = char:FindFirstChild("Head")
		local hrp = char:FindFirstChild("HumanoidRootPart")
		local hum = char:FindFirstChildOfClass("Humanoid")
		if not head or not hrp or not hum then return end
		local f = Instance.new("Folder", game.CoreGui)
		f.Name = p.Name.."_ESP"
		local gui = Instance.new("BillboardGui", f)
		gui.Adornee = head
		gui.Size = UDim2.new(0, 100, 0, 150)
		gui.StudsOffset = Vector3.new(0, 1, 0)
		gui.AlwaysOnTop = true
		gui.MaxDistance = 99999
		local label = Instance.new("TextLabel", gui)
		label.Size = UDim2.new(1, 0, 0, 100)
		label.BackgroundTransparency = 1
		label.TextColor3 = Color3.new(1,1,1)
		label.TextStrokeTransparency = 0
		label.Font = Enum.Font.SourceSansBold
		label.TextSize = 16
		label.TextYAlignment = Enum.TextYAlignment.Top
		local con; con = runs.RenderStepped:Connect(function()
			if not Options.ESPPlayer.Value then
				if f then f:Destroy() end
				if con then con:Disconnect() end
				return
			end
			if not p.Character or not p.Character:FindFirstChild("HumanoidRootPart") then
				if f then f:Destroy() end
				if con then con:Disconnect() end
				return
			end
			local dist = (plr.Character and plr.Character:FindFirstChild("HumanoidRootPart"))
				and (plr.Character.HumanoidRootPart.Position - p.Character.HumanoidRootPart.Position).Magnitude
				or 0
			local hp = math.floor(p.Character:FindFirstChildOfClass("Humanoid").Health + 0.5)
			label.Text = "Name: "..p.Name.."\nHP: "..hp.."\nDist: "..math.floor(dist)
		end)
		p.CharacterAdded:Connect(function()
			if f then f:Destroy() end
			if con then con:Disconnect() end
		end)
		p.AncestryChanged:Connect(function()
			if not p:IsDescendantOf(game) then
				if f then f:Destroy() end
				if con then con:Disconnect() end
			end
		end)
	end
	task.spawn(function()
		while p and p.Parent == game.Players do
			if Options.ESPPlayer.Value and not game.CoreGui:FindFirstChild(p.Name.."_ESP") then
				create()
			elseif not Options.ESPPlayer.Value and game.CoreGui:FindFirstChild(p.Name.."_ESP") then
				game.CoreGui[p.Name.."_ESP"]:Destroy()
			end
			task.wait(1)
		end
	end)
end

for _,v in pairs(game.Players:GetPlayers()) do esp(v) end
game.Players.PlayerAdded:Connect(esp)

BattleRoyal_ESPPlayer:OnChanged(function()
	task.spawn(function()
		pcall(function()
			if not Options.ESPPlayer.Value then
				for _,v in pairs(game.CoreGui:GetChildren()) do
					if string.find(v.Name,'_ESP') then
						v:Destroy()
					end
				end
			end
		end)
	end)
end)

local ctable = {
    Vector3.new(-7620, 26, -449),
    Vector3.new(-7625, 26, -375),
    Vector3.new(-7681, 26, -427),
    Vector3.new(-7680, 26, -504),
    Vector3.new(-7514, 26, -743),
    Vector3.new(-7417, 26, -742),
    Vector3.new(-7370, 26, -509),
    Vector3.new(-7382, 26, -491)
}
local function equipPumpkinBag()
    for _, bag in ipairs({' Corn Basket', ' Basket', ' Bag'}) do
        if character:FindFirstChild('Pumpkin'..bag) then
            break
        end
        if plr.Backpack:FindFirstChild('Pumpkin'..bag) and not character:FindFirstChild('Pumpkin'..bag) then
            character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Pumpkin'..bag))
            break
        elseif not plr.Backpack:FindFirstChild('Pumpkin'..bag) and not character:FindFirstChild('Pumpkin'..bag) then
            local inv = https:JSONDecode(game.ReplicatedStorage['Stats' .. plr.Name].Inventory.Inventory.Value)
            if inv['Pumpkin'..bag] == 1 then
                game.ReplicatedStorage.Events.Tools:InvokeServer('equip', 'Pumpkin'..bag)
                wait(0.5)
                character.Humanoid:EquipTool(plr.Backpack:FindFirstChild('Pumpkin'..bag))
                break
            elseif bag == ' Bag' then
                Fluent:Notify({
                    Title = "Radiant Hub Macro - GPO",
                    Content = "Buy pumpkin bag with 5k peli !",
                    SubContent = "",
                    Duration = 3
                })
                wait(3)
            end
        end
    end
end
General_CandiesFarm:OnChanged(function()
    task.spawn(function()
        if tw then tw:Cancel() end
        while wait() and plr:DistanceFromCharacter(Vector3.new(-7466, 39, -598)) <= 400 and Options.CandiesFarm.Value do
            pcall(function()
                for _,i in ipairs(ctable) do
                    if not Options.CandiesFarm.Value and character:GetAttribute('SpeedBypass') < 15 then
                        break
                    end
                    equipPumpkinBag()
                    tween(character.HumanoidRootPart.Position,40,110).Completed:Wait()
                    if not Options.CandiesFarm.Value and character:GetAttribute('SpeedBypass') < 15 then
                        break
                    end
                    tween(i,60,110).Completed:Wait()
                    if not Options.CandiesFarm.Value and character:GetAttribute('SpeedBypass') < 15 then
                        break
                    end
                    tween(i,60).Completed:Wait()
                    local p=game.Players.LocalPlayer
                    local r=p.Character:WaitForChild("HumanoidRootPart")
                    local c,m=nil,9e9
                    for _,v in next,workspace.Islands.Spooksville.Building:GetChildren() do
                        local d=v:FindFirstChild("eventDoor")
                        local f=d and d:FindFirstChild("Frame")
                        local pr=f and f:FindFirstChildOfClass("ProximityPrompt")
                        if pr then
                            local dist=(r.Position-f.Position).Magnitude
                            if dist<m then m, c=dist, pr end
                        end
                    end
                    if c then fireproximityprompt(c)
                        wait(1)
                        repeat wait()
                            tween(character.HumanoidRootPart.Position,30,40).Completed:Wait()
                        until not character:FindFirstChild('Stun') and not character:FindFirstChild('iFrame')
                        wait(1)
                    end
                end
            end)
        end
    end)
end)
BattleRoyal_ESPChest:OnChanged(function()
    task.spawn(function()
        while task.wait(0.3) do
            pcall(function()
                if Options.ESPChest then
                    for _, m in workspace.Effects:GetChildren() do
                        if m:IsA("Model") and #m.Name >= 24 then
                            if game.CoreGui:FindFirstChild(m.Name.."_ESP") then continue end
                            local p = m:FindFirstChildOfClass("MeshPart")
                            local t = p and p:FindFirstChildOfClass("ProximityPrompt")
                            local name = t and t.ObjectText
                            if name and Options.SelectChest.Value[name] then
                                local b = Instance.new("BillboardGui", game.CoreGui)
                                b.Name = m.Name .. "_ESP"
                                b.Adornee = m
                                b.Size = UDim2.new(0, 100, 0, 50)
                                b.StudsOffset = Vector3.new(0, 2, 0)
                                b.AlwaysOnTop = true
                                local l = Instance.new("TextLabel", b)
                                l.Size = UDim2.new(1, 0, 1, 0)
                                l.BackgroundTransparency = 1
                                l.TextColor3 = Color3.new(1, 0, 0)
                                l.TextScaled = true
                                l.Text = name
                            end
                        end
                    end
                else
                    for _,v in pairs(game.CoreGui:GetChildren()) do
                        if string.find(v.Name,'_ESP') then
                            v:Destroy()
                        end
                    end
                end
            end)
        end
    end)
end)
-- local args = {
-- 	"skyWalkTrainer"
-- }
-- game:GetService("ReplicatedStorage"):WaitForChild("Events"):WaitForChild("learnStyle"):FireServer(unpack(args))

task.spawn(function()
    while task.wait() do
        pcall(function()
            if character.Humanoid:GetState() == Enum.HumanoidStateType.Freefall then
                if isTweening then
                    character.HumanoidRootPart.Velocity = Vector3.new(0, -0.000001, 0)
                end
            end
        end)
    end
end)
General_AutoFarm:OnChanged(function()
    task.spawn(function()
        if tw then tw:Cancel() end
        while task.wait() and Options.AutoFarm.Value do
            pcall(function()
                if character:FindFirstChild('Rifle') or plr.Backpack:FindFirstChild('Rifle') then
                    local l = plr.PlayerGui.HUD.Main.Bars.Experience.Detail.Level.Text
                    local level = tonumber(string.sub(l, 7, string.len(l)));
                    if level >= 190 and not plr.PlayerGui.Quest.Enabled then
                        tween(Vector3.new(7736, -2176, -17222),65).Completed:Wait()
                        game.ReplicatedStorage.Events.Quest:InvokeServer(unpack({
                            [1] = {
                                [1] = "takequest",
                                [2] = "Help becky"
                            }
                        }))
                        tween(Vector3.new(7822, -2154.868, -17139), 65).Completed:Wait()
                        tween(Vector3.new(7822, -2160, -17139),50).Completed:Wait()
                    end
                    for _, v in next,(workspace.NPCs:GetChildren()) do
                        if v.Name == "Fishman Karate User" and v.Humanoid.Health > 0 and v.HumanoidRootPart then
                            repeat
                                task.wait()
                                equipGun()
                                game.ReplicatedStorage.Events.CIcklcon.gunFunctions:InvokeServer('reload', {
                                    Gun = 'Rifle'
                                })
                                if not Options.FastGun.Value then
                                    task.wait(require(game.ReplicatedStorage.Modules.GunHandle).reloadTimes['Rifle'])
                                end
                                game.ReplicatedStorage.Events.CIcklcon:FireServer('fire', {
                                    Start = character.HumanoidRootPart.CFrame,
                                    Gun = "Rifle",
                                    joe = "true",
                                    Position = workspace.NPCs['Fishman Karate User'].Head.CFrame.Position
                                })
                            until not v or v.Humanoid.Health <= 0 or not v.HumanoidRootPart or
                                not Options.AutoFarm.Value
                        end
                    end
                else
                    equipGun()
                end
            end)
        end
    end)
end)

General_TweenToFishman:OnChanged(function()
    task.spawn(function()
        pcall(function()
            if Options.TweenToFishman.Value then
                tween(Vector3.new(1840, -4, -12156), 60).Completed:Wait()
            else
                if tw then
                    tw:Cancel()
                end
            end
        end)
    end)
end)
General_UpStats:OnChanged(function()
    task.spawn(function()
        while task.wait() and Options.UpStats.Value do
            pcall(function()
                game.ReplicatedStorage.Events.stats:FireServer(Options.SelectStats.Value, nil, game.ReplicatedStorage['Stats'..plr.Name].Stats.SkillPoints.Value)
            end)
        end
    end)
end)
General_IslandESP:OnChanged(function()
    task.spawn(function()
        pcall(function()
            if Options.IslandESP.Value then
                local function createESPLabel(object)
                    local billboard = Instance.new("BillboardGui")
                    billboard.Adornee = object
                    billboard.Size = UDim2.new(0, 100, 0, 50)
                    billboard.StudsOffset = Vector3.new(0, 2, 0)
                    billboard.AlwaysOnTop = true
                    local textLabel = Instance.new("TextLabel", billboard)
                    textLabel.Size = UDim2.new(1, 0, 1, 0)
                    textLabel.BackgroundTransparency = 1
                    textLabel.TextColor3 = Color3.fromRGB(255, 0, 0)
                    textLabel.TextScaled = true
                    textLabel.Text = object.Name
                    billboard.Parent = game.CoreGui
                end
                for _, obj in ipairs(workspace.Islands:GetChildren()) do
                    if obj:IsA("Model") then
                        createESPLabel(obj)
                    end
                end
            else
                for _, gui in ipairs(game.CoreGui:GetChildren()) do
                    if gui:IsA("BillboardGui") then
                        gui:Destroy()
                    end
                end
            end
        end)
    end)
end)
BattleRoyal_TPWalk:OnChanged(function()
    task.spawn(function()
        while Options.TPWalk.Value and task.wait() do
            pcall(function()
                local char = game.Players.LocalPlayer.Character
                local hrp = char:FindFirstChild("HumanoidRootPart")
                local hum = char and char:FindFirstChildWhichIsA("Humanoid")
                hum:ChangeState(Enum.HumanoidStateType.Running)
                for _, v in pairs({char,char.HumanoidRootPart}) do
                    for _, v2 in pairs(v:GetChildren()) do
                        if v2.Name == "Stun" or v2.Name == "Dizzed"
                        or v2.Name == "PB" then
                            v2:Destroy()
                        end
                    end
                end
                local c = game.Players.LocalPlayer.Character
                if character:GetAttribute('SpeedBypass') > 50 then
                    c:TranslateBy(hum.MoveDirection * character:GetAttribute('SpeedBypass') * task.wait())
                else
                    c:TranslateBy(hum.MoveDirection * 50 * task.wait())
                end
            end)
        end
    end)
end)
task.spawn(function()
	while task.wait() do
		if character.Humanoid:GetState() == Enum.HumanoidStateType.Physics then
			character.Humanoid:ChangeState(Enum.HumanoidStateType.Running)
		end
	end
end)
character.DescendantAdded:Connect(function(v)
	if v:IsA("BallSocketConstraint") or v:IsA("RopeConstraint") then
		v:Destroy()
	end
end)
character:GetPropertyChangedSignal("Parent"):Connect(function()
	if character.Parent == workspace:FindFirstChild("Ragdolls") then
		character.Parent = workspace
	end
end)
BattleRoyal_InfJump:OnChanged(function()
    task.spawn(function()
        pcall(function()
            character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Jumping, true)
            character.Humanoid:SetStateEnabled(Enum.HumanoidStateType.Freefall, true)
            uis.JumpRequest:Connect(function()
                if character.Humanoid and character.Humanoid:GetState() ~= Enum.HumanoidStateType.Dead and
                    Options.InfJump.Value then
                    character.Humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
                end
            end)
        end)
    end)
end)
runs.RenderStepped:Connect(function()
    if Options.InfJump.Value then
        for _,v in {workspace.Env,workspace.Islands,workspace.Ships} do
            if v then
                for _,v2 in pairs(v:GetChildren()) do
                    if v2.Name == 'ACB' or v2.Name == 'FG' then
                        v2:Destroy()
                    end
                end
            end
        end
        local p = Instance.new("Part")
        p.Size = Vector3.new(30, 1 , 30)
        p.Position = character.HumanoidRootPart.Position - Vector3.new(0, 6.5, 0)
        p.Anchored = true
        p.Transparency = 1
        p.CanCollide = false
        p.Name = "ACB"
        p.Material = 'Grass'
        p.Parent = workspace.Env or workspace.Islands or workspace.Ships
        game.Debris:AddItem(p, 0.2)
        local part = Instance.new("Part")
        part.Size = Vector3.new(30, 1 , 30)
        part.Anchored = true
        part.CanCollide = false
        part.Transparency = 1
        part.Position = character.HumanoidRootPart.Position - Vector3.new(0, 6.5, 0)
        part.Name = "FG"
        part.Material = 'Grass'
        part.Parent = workspace.Env or workspace.Islands or workspace.Ships
        game.Debris:AddItem(part, 0.15)
    end
end)
BattleRoyal_Spin:OnChanged(function()
    task.spawn(function()
        pcall(function()
            if Options.Spin.Value then
                character.Humanoid.StateChanged:Connect(function(old, new)
                    if new == Enum.HumanoidStateType.Physics or new == Enum.HumanoidStateType.Ragdoll then
                        character.Humanoid:ChangeState(Enum.HumanoidStateType.GettingUp)
                    end
                end)
                for i, v in pairs(character.HumanoidRootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
                local Spin = Instance.new("BodyAngularVelocity")
                Spin.Name = "Spinning"
                Spin.Parent = character.HumanoidRootPart
                Spin.MaxTorque = Vector3.new(0, math.huge, 0)
                Spin.AngularVelocity = Vector3.new(0, 100, 0)
            else
                for i, v in pairs(character.HumanoidRootPart:GetChildren()) do
                    if v.Name == "Spinning" then
                        v:Destroy()
                    end
                end
            end
        end)
    end)
end)
require(game:GetService("ReplicatedStorage").Modules.Client.Notification).DisplayMessage('<Color=Red><TextStrokeTransparency=0> Radiant Hub Macro Loaded ',true)
end)
