local script = game:GetService("Players").LocalPlayer:WaitForChild("NPC")
local v_u_1 = workspace:WaitForChild("NPCs")
while not v_u_1:GetAttribute("OptimizationComplete") do
    task.wait()
end
local v_u_2 = game:GetService("TweenService")
local v_u_3 = game:GetService("ReplicatedStorage")
local v_u_4 = game:GetService("UserInputService")
require(game.ReplicatedStorage:WaitForChild("Queue"))
local v_u_5 = require(game.ReplicatedStorage:WaitForChild("DialoguesList"))
local v_u_6 = require(game.ReplicatedStorage:WaitForChild("GuideModule"))
local v_u_7 = require(game.ReplicatedStorage:WaitForChild("Quests"))
local v_u_8 = require(game.ReplicatedStorage:WaitForChild("Util"))
local v9 = require(game.ReplicatedStorage.Modules:WaitForChild("Flags"))
require(game.ReplicatedStorage.Util.ProcessUtil)
require(game.ReplicatedStorage.Util.InstanceWatch)
local v_u_10 = require(game.ReplicatedStorage.Util.FunctionQueue).test("NPC", 2, 3)
local v_u_11 = require(game.ReplicatedStorage.Util.tasklib)("NPC", 0.002, false)
local v_u_12 = Instance.new("Highlight")
v_u_12.FillTransparency = 0.7
v_u_12.FillColor = Color3.new(1, 1, 1)
v_u_12.OutlineTransparency = 0
v_u_12.Parent = script
local v_u_13 = nil
local v_u_14 = nil
for _, v15 in pairs(v_u_3.Assets:WaitForChild("NPCAura"):GetChildren()) do
    v_u_8.ResizeModel(v15, 0.75, v15.Position)
    local v16 = v15.RingMesh
    v16.Size = v16.Size * 0.98
    for _, v17 in pairs(v15:GetDescendants()) do
        if v17:IsA("Beam") then
            v17.Segments = v17.Segments * 2
        end
    end
end
local v_u_18 = {}
local v_u_19 = v_u_8.Signal2.new()
local v_u_20 = {}
local v_u_21 = {}
task.spawn(function()
    local v_u_22 = game.Players.LocalPlayer
    while task.wait(0.3333333333333333) do
        local v_u_23 = os.clock()
        if v_u_13 then
            task.spawn(function()
                local v24 = v_u_22.Character
                local v25
                if v24 then
                    v25 = v24:FindFirstChild("HumanoidRootPart")
                else
                    v25 = v24
                end
                if v24 then
                    v24 = v24:FindFirstChild("Humanoid")
                end
                for _, v26 in pairs(v_u_21) do
                    if v26.DelayTimestamp - v_u_23 <= 0 then
                        local v27 = v26.Root.CFrame.Y
                        if math.abs(v27) > 500000 then
                            print("fixed NaN npc?")
                            local v28 = v26.Root:GetAttribute("__OriginalCFrame")
                            v26.Root.CFrame = v28
                        end
                        local v29 = not v25 and 999999 or (v25.Position - v26.Root.Position).magnitude
                        local v30 = v29 > 500
                        if v30 then
                            v26.DelayTimestamp = os.clock() + 1
                        end
                        if v26.Model.Parent == v_u_1 and v30 then
                            local v31 = v_u_18
                            local v32 = v26.Model
                            local v33 = v26.Root.Position
                            v31[v32] = "derendering" .. tostring(v33)
                            local v34 = v_u_18
                            local v35 = v26.Model
                            local v36 = v26.Root.Position
                            v34[v35] = "derenderingstart" .. tostring(v36)
                            v26.Model.Parent = game.ReplicatedStorage.NPCs
                            local v37 = v26.Model:FindFirstChildOfClass("Humanoid")
                            local v38 = v26.Model:FindFirstChild("Head")
                            if v37 and v38 then
                                v37.Parent = v38
                            end
                            local v39 = v26.Model:FindFirstChildWhichIsA("Shirt")
                            if v39 then
                                v39.ShirtTemplate = ""
                            end
                            local v40 = v26.Model:FindFirstChildWhichIsA("Pants")
                            if v40 then
                                v40.PantsTemplate = ""
                            end
                            local v41 = v26.Model:FindFirstChild("Head")
                            if v41 and v41:FindFirstChildWhichIsA("Decal") then
                                v41:FindFirstChildWhichIsA("Decal").Texture = ""
                            end
                            for _, v42 in pairs(v26.Model:GetChildren()) do
                                if v42:IsA("Accessory") then
                                    for _, v43 in pairs(v42:GetDescendants()) do
                                        if v43:IsA("SpecialMesh") then
                                            v43.MeshId = ""
                                            v43.TextureId = ""
                                        end
                                    end
                                end
                            end
                            v26.FixedLimbs = false
                            local v44 = v_u_18
                            local v45 = v26.Model
                            local v46 = v26.Root.Position
                            v44[v45] = "derenderingfin" .. tostring(v46)
                        elseif (v26.Model.Parent == game.ReplicatedStorage.NPCs or not v26.hasSetUp) and v29 < 500 then
                            local v47 = v_u_18
                            local v48 = v26.Model
                            local v49 = v26.Root.Position
                            v47[v48] = "rendering" .. tostring(v49)
                            local v50 = v_u_18
                            local v51 = v26.Model
                            local v52 = v26.Root.Position
                            v50[v51] = "renderingstart" .. tostring(v52)
                            v26.hasSetUp = true
                            local v53 = v26.Model:FindFirstChild("Head")
                            local v54 = v53 and v53:FindFirstChildOfClass("Humanoid")
                            if v54 then
                                v54.Parent = v26.Model
                            end
                            v26.Model.Parent = v_u_1
                            local v55 = v26.Model:FindFirstChild("Proxy_Shirt")
                            if v55 and (v55:IsA("StringValue") and v26.Model:FindFirstChildWhichIsA("Shirt")) then
                                local v56 = v26.Model:FindFirstChildWhichIsA("Shirt")
                                v56.ShirtTemplate = v_u_8.Graphics.SmartScale(v55:GetAttribute("ShirtTemplate"))
                                v56.Color3 = v55:GetAttribute("Color3")
                            end
                            local v57 = v26.Model:FindFirstChild("Proxy_Pants")
                            if v57 and (v57:IsA("StringValue") and v26.Model:FindFirstChildWhichIsA("Pants")) then
                                local v58 = v26.Model:FindFirstChildWhichIsA("Pants")
                                v58.PantsTemplate = v_u_8.Graphics.SmartScale(v57:GetAttribute("PantsTemplate"))
                                v58.Color3 = v57:GetAttribute("Color3")
                            end
                            local v59 = v26.Model:GetAttribute("FaceId")
                            if v59 and (v26.Model:FindFirstChild("Head") and v26.Model.Head:FindFirstChild("face")) then
                                v26.Model.Head.face.Texture = v_u_8.Graphics.SmartScale(v59)
                            end
                            for _, v60 in pairs(v26.Model:GetChildren()) do
                                if v60:IsA("Accessory") or v60:IsA("Hat") then
                                    for _, v61 in pairs(v60:GetDescendants()) do
                                        if v61.Name == "Proxy_SpecialMesh" then
                                            local v62 = v61.Parent:FindFirstChildWhichIsA("SpecialMesh")
                                            for _, v63 in pairs({
                                                "MeshId",
                                                "MeshType",
                                                "Offset",
                                                "Scale",
                                                "TextureId",
                                                "VertexColor"
                                            }) do
                                                local v64 = v61:GetAttribute(v63)
                                                if v63 == "TextureId" then
                                                    v64 = v_u_8.Graphics.SmartScale(v64)
                                                end
                                                v62[v63] = v64
                                            end
                                        end
                                    end
                                end
                            end
                            if not v26.GUI.InteractionLock:Get():IsLocked() then
                                v26.Model:SetAttribute("EmitIndex", math.random(1, 100000000))
                            end
                            if not v26.FixedLimbs then
                                v26.FixedLimbs = true
                                local v65 = v26.Model:FindFirstChild("RightLowerArm")
                                if v65 then
                                    v65 = v65:FindFirstChild("RightElbow")
                                end
                                if v65 and v65.C0.X < 0.01 then
                                    v65.C0 = v65.C0 * CFrame.new(0.01, 0, 0)
                                end
                                local v66 = v26.Model:FindFirstChild("LeftLowerArm")
                                if v66 then
                                    v66 = v66:FindFirstChild("LeftElbow")
                                end
                                if v66 and v66.C0.X > -0.01 then
                                    v66.C0 = v66.C0 * CFrame.new(-0.01, 0, 0)
                                end
                                local v67 = v26.Model:FindFirstChild("RightLowerLeg")
                                if v67 then
                                    v67 = v67:FindFirstChild("RightKnee")
                                end
                                if v67 and v67.C0.X < 0.01 then
                                    v67.C0 = v67.C0 * CFrame.new(0.01, 0, 0)
                                end
                                local v68 = v26.Model:FindFirstChild("LeftLowerLeg")
                                if v68 then
                                    v68 = v68:FindFirstChild("LeftKnee")
                                end
                                if v68 and v68.C0.X > -0.01 then
                                    v68.C0 = v68.C0 * CFrame.new(-0.01, 0, 0)
                                end
                            end
                            local v69 = v_u_18
                            local v70 = v26.Model
                            local v71 = v26.Root.Position
                            v69[v70] = "renderingend" .. tostring(v71)
                        elseif not v_u_13.Active and v25 then
                            local v72 = v_u_18
                            local v73 = v26.Model
                            local v74 = v26.Root.Position
                            v72[v73] = "dialoguelock" .. tostring(v74)
                            local v75 = v_u_18
                            local v76 = v26.Model
                            local v77 = v26.Root.Position
                            v75[v76] = "dialoguelock2" .. tostring(v77)
                            local v78 = v25.Size.magnitude + v26.Root.Size.magnitude
                            local v79 = 25 + v78
                            local v80 = 2 + v78
                            if not (v26.Model:FindFirstChild("NPCConfig") and (v26.Model.NPCConfig:GetAttributes() or {}) or {}).IgnoreWatch then
                                if v29 < v79 and not v26.Model:GetAttribute("Stationary") then
                                    if v_u_20[v26.Model] == nil and _G.dialogueModel == nil then
                                        v_u_19:Fire(v26.Model, true)
                                    end
                                else
                                    local v81 = v_u_20[v26.Model]
                                    if typeof(v81) == "number" then
                                        v_u_19:Fire(v26.Model, nil)
                                    end
                                end
                            end
                            if v24 and (v24.Health > 0 and (v29 < v80 and not v26.Model:GetAttribute("LockedInteraction"))) then
                                v26.GUI.BG.Enabled = true
                                if v_u_14 == nil or v26.Refresh then
                                    v_u_14 = v26
                                    v26.GUI.BusyLock:Unlock("_General")
                                    if v26.GUI.InteractionLock:Get():IsLocked() then
                                        v_u_12.Adornee = nil
                                    elseif not v26.Model:GetAttribute("NoAura") then
                                        v_u_12.Adornee = v26.Model
                                        v_u_12.FillColor = v26.Info.Color:Lerp(Color3.new(1, 1, 1), 0.3333333333333333)
                                        v_u_12.OutlineColor = v26.Info.Color:Lerp(Color3.new(1, 1, 1), 0.3333333333333333)
                                    end
                                end
                            elseif (v26.GUI.BG.Enabled or v26.Refresh) and v_u_14 == v26 then
                                v_u_14 = nil
                                v_u_12.Adornee = nil
                                v26.GUI.BusyLock:Lock("_General")
                            end
                            if v_u_14 then
                                _G.tapCooldown = os.clock() + 0.3333333333333333 + 0.016666666666666666
                            end
                            local v82 = v_u_18
                            local v83 = v26.Model
                            local v84 = v26.Root.Position
                            v82[v83] = "dialoguelockfin" .. tostring(v84)
                        end
                    end
                end
            end)
        end
    end
end)
task.spawn(function()
    local v_u_85 = 0
    while true do
        repeat
            local v_u_86, v87 = v_u_19:Wait()
        until v_u_86 and v87
        v_u_85 = v_u_85 + 1
        v_u_20[v_u_86] = v_u_85
        local v_u_88 = true
        local v_u_92 = v_u_19:Connect(function(p89, p90, p91)
            if p89 == v_u_86 then
                if not p90 then
                    if not p91 then
                        task.wait(0.05)
                    end
                    v_u_88 = false
                end
            else
                return
            end
        end)
        task.defer(function()
            local v93 = v_u_86.HumanoidRootPart.CFrame
            if v_u_86.HumanoidRootPart:GetAttribute("__OriginalCFrame") then
                v93 = v_u_86.HumanoidRootPart:GetAttribute("__OriginalCFrame")
            else
                v_u_86.HumanoidRootPart:SetAttribute("__OriginalCFrame", v93)
            end
            local v94 = v93.Y
            if math.abs(v94) > 500000 then
                print("fixed NaN npc?")
                v93 = v_u_86.HumanoidRootPart:GetAttribute("__OriginalCFrame")
                v_u_86.HumanoidRootPart.CFrame = v93
            end
            local v95 = 0.016666666666666666
            while v_u_88 and v_u_20[v_u_86] == v_u_85 do
                local v96 = game.Players.LocalPlayer.Character
                if v96 then
                    v96 = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
                end
                if not v96 then
                    break
                end
                local v97 = v96.Position
                local v98 = -0.2 * (v97 - v_u_86.HumanoidRootPart.Position).Magnitude + 7
                local v99 = math.clamp(v98, 1, 5)
                local v100 = v_u_86.HumanoidRootPart.CFrame
                local v101 = CFrame.lookAt
                local v102 = v_u_86.HumanoidRootPart.Position
                local v103 = v97.X
                local v104 = v_u_86.HumanoidRootPart.Position.Y
                local v105 = v97.Z
                local v106 = v100:Lerp(v101(v102, (Vector3.new(v103, v104, v105))), v99 * v95)
                local v107 = v106.Y
                if math.abs(v107) > 500000 then
                    local v108 = v_u_86.HumanoidRootPart.CFrame.Y
                    if math.abs(v108) > 500000 then
                        v_u_86.HumanoidRootPart.CFrame = v_u_86.HumanoidRootPart:GetAttribute("__OriginalCFrame")
                    end
                    break
                end
                v_u_86.HumanoidRootPart.CFrame = v106
                v95 = task.wait()
            end
            v_u_92:Disconnect()
            if v_u_20[v_u_86] == v_u_85 then
                v_u_20[v_u_86] = nil
            end
            local v109 = os.clock()
            while os.clock() - v109 < 2 and v_u_20[v_u_86] == nil do
                v_u_86.HumanoidRootPart.CFrame = v_u_86.HumanoidRootPart.CFrame:Lerp(CFrame.new(v_u_86.HumanoidRootPart.Position) * (v93 - v93.Position), v95 * 2.5)
                v95 = task.wait()
            end
            if v_u_20[v_u_86] == nil then
                local v110 = v_u_86.HumanoidRootPart:GetAttribute("__OriginalCFrame") or v93
                v_u_86.HumanoidRootPart.CFrame = CFrame.new(v_u_86.HumanoidRootPart.Position) * (v110 - v110.Position)
                v_u_86.HumanoidRootPart:SetAttribute("__OriginalCFrame", nil)
            end
        end)
    end
end)
local v_u_111 = {
    {
        ["Color"] = Color3.fromRGB(255, 230, 0),
        ["Text"] = "QUEST"
    },
    {
        ["Color"] = Color3.fromRGB(0, 255, 0),
        ["Text"] = "SHOP"
    },
    {
        ["Color"] = Color3.fromRGB(255, 0, 255),
        ["Text"] = "INVENTORY"
    },
    {
        ["Color"] = Color3.fromRGB(255, 255, 255),
        ["Text"] = "MISC."
    }
}
local v_u_112 = {}
Random.new()
local v_u_113 = {}
local function v_u_124(p114, p115)
    local function v121(p116, p117)
        if p116.PrimaryPart then
            if (workspace.CurrentCamera.CFrame.Position - p116.PrimaryPart.CFrame.Position).Magnitude < 50 then
                if p116:GetAttribute("DistanceCulled") then
                    p116:SetAttribute("DistanceCulled", false)
                    for _, v118 in pairs(p116:GetDescendants()) do
                        if v118:GetAttribute("EnableMe") then
                            v118.Enabled = true
                        end
                    end
                    local v119 = p116:FindFirstChildWhichIsA("Humanoid")
                    if not v119 and p116:FindFirstChild("Head") then
                        v119 = p116.Head:FindFirstChildWhichIsA("Humanoid")
                    end
                    p117.Parent = v119
                    return
                end
            elseif not p116:GetAttribute("DistanceCulled") and p117:GetAttribute("IdleLoaded") then
                p116:SetAttribute("DistanceCulled", true)
                for _, v120 in pairs(p116:GetDescendants()) do
                    if v120:GetAttribute("EnableMe") then
                        v120.Enabled = false
                    end
                end
                p117.Parent = nil
            end
        end
    end
    if p114 then
        v121(p114, p115)
    else
        for v122, v123 in pairs(v_u_113) do
            v121(v122, v123)
        end
    end
end
task.spawn(function()
    local function v125()
        while task.wait(1) do
            v_u_124()
        end
    end
    while task.wait() do
        print(pcall(v125))
    end
end)
game.Players.LocalPlayer.Chatted:Connect(function(p126)
    if p126 == "/npcstatus" then
        for v127, v128 in pairs(v_u_18) do
            print(v127, v128)
        end
    end
end)
local function v_u_210(p_u_129, p_u_130, p_u_131, p_u_132)
    local v133 = next
    local v134, v135 = v_u_1:GetChildren()
    for _, v_u_136 in v133, v134, v135 do
        if not v_u_136:GetAttribute("NPCReady") and (v_u_136.Name == p_u_129 and not v_u_136:GetAttribute("task")) then
            v_u_136:SetAttribute("task", true)
            v_u_11:defer(function()
                if not v_u_136:GetAttribute("Optimized") then
                    v_u_136:GetAttributeChangedSignal("Optimized"):Wait()
                end
                v_u_136.Parent = game.ReplicatedStorage.NPCs
                v_u_18[v_u_136] = "WaitForHead"
                if v_u_136:WaitForChild("Head") then
                    local v137 = v_u_136:WaitForChild("Head"):FindFirstChild("AlignPosition")
                    if v137 then
                        v137:Destroy()
                    end
                    v_u_18[v_u_136] = "Yield_setup"
                    v_u_11:yieldto(function()
                        v_u_18[v_u_136] = "Yield_setup1"
                        v_u_136:SetAttribute("task", nil)
                        v_u_136:SetAttribute("NPCReady", true)
                        local v_u_138 = v_u_136:FindFirstChildWhichIsA("Humanoid")
                        if v_u_138 then
                            v_u_138.Parent = v_u_136.Head
                        else
                            v_u_138 = Instance.new("Humanoid")
                            if not v_u_136:FindFirstChild("Torso") then
                                v_u_138.RigType = Enum.HumanoidRigType.R15
                            end
                            v_u_138.Name = "NPC"
                            v_u_138.Parent = v_u_136.Head
                            v_u_138.NameDisplayDistance = 40
                            v_u_138.DisplayDistanceType = "Subject"
                            v_u_138.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
                            v_u_138.DisplayName = ""
                            v_u_138.BreakJointsOnDeath = false
                            v_u_138.AutoRotate = false
                            v_u_138.RequiresNeck = false
                            v_u_138.EvaluateStateMachine = false
                        end
                        v_u_18[v_u_136] = "Yield_setup2"
                        local v_u_139 = v_u_111[p_u_131]
                        if v_u_139 then
                            local v_u_140 = v_u_136:FindFirstChild("HumanoidRootPart") or v_u_136:FindFirstChild("Torso")
                            v_u_140.Anchored = true
                            if v_u_140 and p_u_131 == 1 then
                                local v141 = p_u_130().InternalQuestName
                                if v141 then
                                    local v142 = v_u_7[v141]
                                    local v143 = {}
                                    for _, v144 in pairs(v142) do
                                        if v144.LevelReq then
                                            local v145 = v144.LevelReq
                                            table.insert(v143, v145)
                                        end
                                    end
                                    v_u_6:AppendNPCData(v_u_140, {
                                        ["Levels"] = v143,
                                        ["NPCName"] = p_u_129,
                                        ["InternalQuestName"] = v141,
                                        ["Position"] = v_u_140.Position
                                    })
                                end
                            end
                            v_u_18[v_u_136] = "Yield_setup3"
                            local v_u_146 = false
                            if v_u_136:FindFirstChild("NPC") then
                                if v_u_136.Name == "Mysterious Entity" then
                                    v_u_136.NPC.DisplayName = game.Players.LocalPlayer.Name
                                    spawn(function()
                                        if not game.Players.LocalPlayer.Character then
                                            game.Players.LocalPlayer.CharacterAdded:Wait()
                                        end
                                        repeat
                                            wait(1)
                                        until game.Players.LocalPlayer:HasAppearanceLoaded() and v_u_136.Parent == workspace.NPCs
                                        local v_u_147 = game.Players:CreateHumanoidModelFromDescription(game.Players:GetHumanoidDescriptionFromUserId(game.Players.LocalPlayer.CharacterAppearanceId), Enum.HumanoidRigType.R15)
                                        pcall(function()
                                            v_u_147.Head:FindFirstChildWhichIsA("Decal").Texture = v_u_147.Head:FindFirstChildWhichIsA("Decal").Texture
                                        end)
                                        for _, v148 in pairs(v_u_147:GetChildren()) do
                                            if v148:IsA("Shirt") or (v148:IsA("Pants") or (v148:IsA("BodyColors") or v148:IsA("Accessory"))) then
                                                local v_u_149 = v148:Clone()
                                                if v_u_149:IsA("Accessory") then
                                                    pcall(function()
                                                        if not v_u_149:FindFirstChild("Animator", true) then
                                                            local v150 = v_u_149:FindFirstChild("AccessoryWeld", true)
                                                            v150.Part1 = v_u_136[v150.Part1.Name]
                                                            v_u_149.Parent = v_u_136
                                                        end
                                                    end)
                                                else
                                                    v_u_149.Parent = v_u_136
                                                end
                                            elseif v148:IsA("BasePart") and v_u_136:FindFirstChild(v148.Name) then
                                                v_u_136[v148.Name].Color = v148.Color
                                            end
                                        end
                                    end)
                                else
                                    v_u_146 = v_u_136.Name == "DojoHiddenRoom" and true or v_u_146
                                end
                            end
                            v_u_18[v_u_136] = "Yield_setup4"
                            v_u_18[v_u_136] = "Yield_setup5"
                            v_u_11:yieldto(function()
                                v_u_18[v_u_136] = "cfg_load_1"
                                v_u_136.Parent = workspace
                                local v_u_151 = v_u_136:FindFirstChild("NPCConfig") and v_u_136.NPCConfig:GetAttributes() or {}
                                if v_u_136:FindFirstChild("idle") and v_u_136.idle.ClassName == "Animation" then
                                    local v_u_152
                                    if v_u_113[v_u_136] then
                                        v_u_152 = v_u_113[v_u_136]:LoadAnimation(v_u_136.idle)
                                    else
                                        v_u_152 = v_u_138:LoadAnimation(v_u_136.idle)
                                    end
                                    v_u_18[v_u_136] = "wait_idle_load_1"
                                    task.spawn(function()
                                        v_u_18[v_u_136] = "wait_idle_load_2"
                                        while task.wait() do
                                            v_u_18[v_u_136] = "wait_idle_load_3"
                                            local v153 = v_u_152.Speed
                                            v_u_152:AdjustSpeed(999)
                                            v_u_152.DidLoop:Wait()
                                            v_u_152:AdjustSpeed(v153)
                                            if v_u_136.Parent then
                                                local v_u_154 = true
                                                v_u_10:Yield("WaitForIdleLoad", function()
                                                    local v155 = false
                                                    for _, v156 in pairs(v_u_136:GetDescendants()) do
                                                        if v156:IsA("Bone") or v156:IsA("Motor6D") then
                                                            v155 = true
                                                            if not v156.Transform:FuzzyEq(CFrame.new()) then
                                                                v_u_154 = false
                                                                break
                                                            end
                                                        end
                                                    end
                                                    if not v155 then
                                                        v_u_154 = false
                                                    end
                                                end)
                                                if not v_u_154 then
                                                    break
                                                end
                                            end
                                        end
                                        v_u_18[v_u_136] = "wait_idle_load_4"
                                        if v_u_113[v_u_136] then
                                            v_u_152.DidLoop:Wait()
                                            v_u_113[v_u_136]:SetAttribute("IdleLoaded", true)
                                            v_u_18[v_u_136] = "wait_idle_load_5"
                                            v_u_124(v_u_136, v_u_152)
                                            v_u_18[v_u_136] = "wait_idle_load_6"
                                        end
                                    end)
                                    v_u_152:Play()
                                elseif v_u_151.IgnoreIdleAnimation then
                                    local v157 = v_u_138:FindFirstChildWhichIsA("Animator")
                                    if v157 then
                                        v157:SetAttribute("IdleLoaded", true)
                                    end
                                else
                                    local v158 = {
                                        "18884840386",
                                        "18884841590",
                                        "18884842887",
                                        "18884844203"
                                    }
                                    local v159 = Instance.new("Animation")
                                    v159.Name = "idle"
                                    v159.AnimationId = "rbxassetid://" .. v158[p_u_132 or Random.new(#v_u_136.Name + 1):NextInteger(1, #v158)]
                                    local v_u_160
                                    if v_u_113[v_u_136] then
                                        v_u_160 = v_u_113[v_u_136]:LoadAnimation(v159)
                                    else
                                        v_u_160 = v_u_138:LoadAnimation(v159)
                                    end
                                    v_u_18[v_u_136] = "wait_idle_load_1"
                                    task.spawn(function()
                                        v_u_18[v_u_136] = "wait_idle_load_2"
                                        while task.wait() do
                                            v_u_18[v_u_136] = "wait_idle_load_3"
                                            local v161 = v_u_160.Speed
                                            v_u_160:AdjustSpeed(999)
                                            v_u_160.DidLoop:Wait()
                                            v_u_160:AdjustSpeed(v161)
                                            if v_u_136.Parent then
                                                local v_u_162 = true
                                                v_u_10:Yield("WaitForIdleLoad", function()
                                                    local v163 = false
                                                    for _, v164 in pairs(v_u_136:GetDescendants()) do
                                                        if v164:IsA("Bone") or v164:IsA("Motor6D") then
                                                            v163 = true
                                                            if not v164.Transform:FuzzyEq(CFrame.new()) then
                                                                v_u_162 = false
                                                                break
                                                            end
                                                        end
                                                    end
                                                    if not v163 then
                                                        v_u_162 = false
                                                    end
                                                end)
                                                if not v_u_162 then
                                                    break
                                                end
                                            end
                                        end
                                        v_u_18[v_u_136] = "wait_idle_load_4"
                                        if v_u_113[v_u_136] then
                                            v_u_160.DidLoop:Wait()
                                            v_u_113[v_u_136]:SetAttribute("IdleLoaded", true)
                                            v_u_18[v_u_136] = "wait_idle_load_5"
                                            v_u_124(v_u_136, v_u_160)
                                            v_u_18[v_u_136] = "wait_idle_load_6"
                                        end
                                    end)
                                    v_u_160:Play()
                                end
                                v_u_18[v_u_136] = "cfg_load_2"
                                v_u_113[v_u_136] = v_u_113[v_u_136] or v_u_138:FindFirstChildWhichIsA("Animator")
                                v_u_136.Parent = game.ReplicatedStorage.NPCs
                                local v_u_165 = v_u_3:WaitForChild("Assets"):WaitForChild("GUI"):WaitForChild("Talk"):Clone()
                                v_u_165.Parent = v_u_140
                                v_u_18[v_u_136] = "cfg_load_4"
                                local v_u_166 = v_u_3.Assets:WaitForChild("NPCAura"):WaitForChild(v_u_139.Text):Clone()
                                v_u_18[v_u_136] = "FloorNormal_1"
                                repeat
                                    task.wait(0.1)
                                until v_u_136:GetAttribute("FloorNormal") ~= nil
                                v_u_11:yieldto(function()
                                    v_u_18[v_u_136] = "FloorPos_yield_1"
                                    local v167 = v_u_136:GetAttribute("FloorPos")
                                    local v168 = v_u_136:GetAttribute("FloorNormal")
                                    local v_u_169 = CFrame.new(v167 + v168 * 0.1, v167 + v168) * CFrame.Angles(-1.5707963267948966, 0, 0)
                                    if v_u_140.Size.Z > 1.05 or v_u_140.Size.Z < 0.95 then
                                        v_u_8.ResizeModel(v_u_166, v_u_140.Size.Z, v_u_166.Position)
                                    end
                                    v_u_18[v_u_136] = "FloorPos_yield_2"
                                    local function v_u_176()
                                        for _, v_u_170 in pairs(v_u_166:GetDescendants()) do
                                            if v_u_170:IsA("BasePart") then
                                                v_u_170.CFrame = v_u_169 * (v_u_166.CFrame:inverse() * v_u_170.CFrame)
                                                if v_u_170.CFrame ~= v_u_170.CFrame then
                                                    ::l6::
                                                    warn("the npc model is in over 50k y axis?")
                                                    goto l7
                                                end
                                                local v171 = v_u_170.CFrame.Y
                                                if math.abs(v171) > 50000 then
                                                    goto l6
                                                end
                                                ::l7::
                                                v_u_170.Anchored = true
                                                v_u_170.CanQuery = false
                                                v_u_170.CanCollide = false
                                                v_u_170.CanTouch = false
                                            else
                                                if v_u_170:IsA("ParticleEmitter") then
                                                    v_u_170.LockedToPart = true
                                                    if v_u_136:GetAttribute("NoAura") then
                                                        v_u_170.Enabled = false
                                                    end
                                                end
                                                if v_u_170.Name == "EmitOnce" then
                                                    v_u_170.Enabled = false
                                                    v_u_136:GetAttributeChangedSignal("EmitIndex"):Connect(function()
                                                        v_u_170.TimeScale = 1
                                                        task.spawn(function()
                                                            v_u_170:Emit(1)
                                                            task.wait()
                                                            v_u_170.TimeScale = 0
                                                        end)
                                                    end)
                                                    v_u_136:SetAttribute("EmitIndex", math.random(1, 100000000))
                                                elseif v_u_170:IsA("ParticleEmitter") or v_u_170:IsA("Beam") then
                                                    if v_u_136:GetAttribute("NoAura") then
                                                        v_u_170.Enabled = false
                                                    end
                                                    if v_u_170.Enabled then
                                                        v_u_170:SetAttribute("EnableMe", true)
                                                        if v_u_136:GetAttribute("DistanceCulled") then
                                                            v_u_170.Enabled = false
                                                        end
                                                    end
                                                end
                                                if v_u_170:IsA("ParticleEmitter") and (v_u_170.SpreadAngle.X == 0 and v_u_170.SpreadAngle.Y == 0) then
                                                    v_u_170.SpreadAngle = Vector2.new(0.001, 0.001)
                                                end
                                            end
                                        end
                                        v_u_166.CFrame = v_u_169
                                        if v_u_166.CFrame == v_u_166.CFrame then
                                            local v172 = v_u_166.CFrame.Y
                                            if math.abs(v172) > 50000 then
                                                goto l25
                                            end
                                        else
                                            ::l25::
                                            local v173 = warn
                                            local v174 = "[REPORT THIS ERROR PLZ]"
                                            local v175 = v_u_136
                                            if v175 then
                                                v175 = v_u_136:GetFullName()
                                            end
                                            v173(v174, v175)
                                        end
                                    end
                                    v_u_136:GetAttributeChangedSignal("FloorPos"):Connect(function()
                                        local v177 = v_u_136:GetAttribute("FloorPos")
                                        local v178 = v_u_136:GetAttribute("FloorNormal")
                                        v_u_169 = CFrame.new(v177 + v178 * 0.1, v177 + v178) * CFrame.Angles(-1.5707963267948966, 0, 0)
                                        v_u_176()
                                    end)
                                    v_u_18[v_u_136] = "FloorPos_yield_3"
                                    v_u_176()
                                    v_u_136.PrimaryPart = v_u_140
                                    v_u_18[v_u_136] = "FloorPos_yield_4"
                                    if not v_u_136:GetAttribute("NoRing") then
                                        v_u_166.Parent = v_u_140
                                    end
                                    local v179 = (v_u_140.Position - v_u_136.Head.Position).Magnitude
                                    local v_u_180 = v_u_3:WaitForChild("Assets"):WaitForChild("GUI"):WaitForChild("QuestBBG"):Clone()
                                    v_u_180.Title.TextColor3 = v_u_139.Color
                                    v_u_180.Mark.TextColor3 = v_u_139.Color
                                    v_u_180.Title.Text = v_u_139.Text
                                    if p_u_131 == 1 then
                                        v_u_180.Size = UDim2.new(5, 20, 5, 20)
                                    elseif p_u_131 == 2 then
                                        v_u_180.Mark.Text = "$"
                                    end
                                    if v_u_136:GetAttribute("NoAura") then
                                        v_u_180.Title.Text = ""
                                        v_u_180.Mark.Text = ""
                                    end
                                    v_u_180.ExtentsOffsetWorldSpace = Vector3.new(0, 1, 0) * v179
                                    v_u_180.Parent = v_u_140
                                    local v_u_181 = v_u_3:WaitForChild("Assets"):WaitForChild("GUI"):WaitForChild("NPCName"):Clone()
                                    if v_u_136.Head.Transparency < 0.99 and not v_u_146 then
                                        v_u_181.NPC.Text = v_u_136.Name
                                        v_u_181.ExtentsOffsetWorldSpace = Vector3.new(0, 1, 0) * v179
                                        v_u_181.Parent = v_u_140
                                    end
                                    v_u_18[v_u_136] = "FloorPos_yield_5"
                                    v_u_165:WaitForChild("TextLabel")
                                    v_u_18[v_u_136] = "FloorPos_yield_6"
                                    local v_u_182 = nil
                                    local v_u_183 = nil
                                    v_u_165.TextLabel.TextTransparency = 1
                                    v_u_165.TextLabel.Position = UDim2.new(0.1, 0, 0, -40)
                                    v_u_165.TextLabel.TextStrokeTransparency = 1
                                    local v_u_184 = require(game.ReplicatedStorage.Modules.Util.Lock).new(true)
                                    local v_u_185 = require(game.ReplicatedStorage.Modules.Util.Lock).new(true)
                                    v_u_18[v_u_136] = "FloorPos_yield_7"
                                    v_u_185:Lock("_General")
                                    v_u_18[v_u_136] = "FloorPos_yield_8"
                                    local v_u_186 = {}
                                    local v_u_187 = false
                                    local v_u_188 = {
                                        ["Refresh"] = false,
                                        ["Model"] = v_u_136,
                                        ["Info"] = v_u_139,
                                        ["Root"] = v_u_136.Head,
                                        ["Object"] = v_u_112[v_u_136.Name],
                                        ["DelayTimestamp"] = 0
                                    }
                                    local function v_u_198()
                                        for _, v189 in pairs(v_u_186) do
                                            if v189.Tween then
                                                v189.Task:Cancel()
                                            end
                                        end
                                        table.clear(v_u_186)
                                        local v190 = v_u_184:IsLocked()
                                        local v191 = v190 and true or v_u_185:IsLocked()
                                        v_u_166.CFrame = v190 and CFrame.new(0, -workspace.FallenPartsDestroyHeight + 1, 0) or v_u_169
                                        if v_u_166.CFrame == v_u_166.CFrame then
                                            local v192 = v_u_166.CFrame.Y
                                            if math.abs(v192) <= 50000 then
                                                ::l12::
                                                if v190 then
                                                    v_u_187 = true
                                                    v_u_180.Enabled = false
                                                    v_u_181.Enabled = false
                                                    v_u_12.Adornee = nil
                                                    v_u_165.TextLabel.TextTransparency = 1
                                                    v_u_165.TextLabel.Position = UDim2.new(0.1, 0, 0, -40)
                                                    v_u_165.TextLabel.TextStrokeTransparency = 1
                                                    return
                                                elseif v_u_187 then
                                                    v_u_187 = false
                                                    v_u_188.Refresh = true
                                                    return
                                                else
                                                    v_u_188.Refresh = false
                                                    v_u_180.Enabled = true
                                                    v_u_181.Enabled = true
                                                    if v191 then
                                                        v_u_183 = v_u_2:Create(v_u_165.TextLabel, TweenInfo.new(0.4), {
                                                            ["Position"] = UDim2.new(0.1, 0, 0, -40),
                                                            ["TextTransparency"] = 1,
                                                            ["TextStrokeTransparency"] = 1
                                                        })
                                                        v_u_183:Play()
                                                        v_u_183.Completed:Once(function(p193)
                                                            v_u_183 = nil
                                                            if p193 == Enum.PlaybackState.Completed then
                                                                v_u_165.Enabled = false
                                                            end
                                                        end)
                                                        local v194 = v_u_186
                                                        local v195 = {
                                                            ["Task"] = v_u_183,
                                                            ["Tween"] = true
                                                        }
                                                        table.insert(v194, v195)
                                                    else
                                                        v_u_165.Enabled = true
                                                        v_u_182 = v_u_2:Create(v_u_165.TextLabel, TweenInfo.new(0.4), {
                                                            ["Position"] = UDim2.new(0.1, 0, 0, 0),
                                                            ["TextTransparency"] = 0,
                                                            ["TextStrokeTransparency"] = 0.3
                                                        })
                                                        v_u_182:Play()
                                                        local v196 = v_u_186
                                                        local v197 = {
                                                            ["Task"] = v_u_182,
                                                            ["Tween"] = true
                                                        }
                                                        table.insert(v196, v197)
                                                    end
                                                end
                                            end
                                        end
                                        print("ok2")
                                        goto l12
                                    end
                                    v_u_165.Enabled = false
                                    v_u_180.MarkImage.Visible = p_u_131 == 1
                                    v_u_180.Mark.Visible = p_u_131 ~= 1
                                    if v_u_151.TalkAdornee then
                                        v_u_165.Adornee = v_u_136:FindFirstChild(v_u_151.TalkAdornee)
                                    end
                                    if v_u_151.TypeAdornee then
                                        v_u_180.Adornee = v_u_136:FindFirstChild(v_u_151.TypeAdornee)
                                    end
                                    if v_u_151.NameAdornee then
                                        v_u_181.Adornee = v_u_136:FindFirstChild(v_u_151.NameAdornee)
                                    end
                                    v_u_18[v_u_136] = "updateLock_1"
                                    local function v_u_204(p199, p200, p201)
                                        local v202 = p199:IsLocked()
                                        local v203 = false
                                        if p201 and not v202 then
                                            p199:Lock(assert(p200))
                                            v_u_198()
                                            v203 = true
                                        elseif not p201 and v202 then
                                            p199:Unlock(assert(p200))
                                            v_u_198()
                                            v203 = true
                                        end
                                        if v_u_187 and not v203 then
                                            v_u_198()
                                        end
                                    end
                                    v_u_136.Parent = game.ReplicatedStorage.NPCs
                                    v_u_188.GUI = {
                                        ["BG"] = v_u_165,
                                        ["InteractionLock"] = {
                                            ["Lock"] = function(_, p205)
                                                v_u_204(v_u_184, p205, true)
                                            end,
                                            ["Unlock"] = function(_, p206)
                                                v_u_204(v_u_184, p206, false)
                                            end,
                                            ["Get"] = function()
                                                return v_u_184
                                            end
                                        },
                                        ["BusyLock"] = {
                                            ["Lock"] = function(_, p207)
                                                v_u_204(v_u_185, p207, true)
                                            end,
                                            ["Unlock"] = function(_, p208)
                                                v_u_204(v_u_185, p208, false)
                                            end,
                                            ["Get"] = function()
                                                return v_u_185
                                            end
                                        }
                                    }
                                    local v209 = v_u_21
                                    table.insert(v209, v_u_188)
                                    v_u_136:SetAttribute("NPCLoaded", true)
                                    v_u_18[v_u_136] = "added"
                                end)
                            end)
                        else
                            print("[IMPORTANT ERROR]", "Failed to fetch info for", p_u_129, p_u_131)
                        end
                    end)
                else
                    v_u_136:SetAttribute("task", nil)
                    warn("NPC didn\'t load because it\'s dead or headless...?", p_u_129)
                end
            end)
        end
    end
    v_u_6:SetDataReady(true)
end
local v216 = {
    ["new"] = function(p211, p212, p213, p214)
        v_u_112[p211] = {
            ["Name"] = p211,
            ["QuestType"] = p213,
            ["IdleId"] = p214
        }
        if p212 then
            v_u_112[p211].GetDialogue = p212
        end
        v_u_210(p211, p212, p213, p214)
        return v_u_112[p211]
    end,
    ["list"] = function()
        return v_u_112
    end,
    ["get"] = function(p215)
        return v_u_112[p215]
    end
}
v_u_1.ChildAdded:Connect(function(p217)
    local v218 = p217.Name
    if v_u_112[v218] then
        local v219 = v_u_112[v218].QuestType
        v_u_210(v218, v_u_112[v218].GetDialogue, v219, v_u_112[v218].IdleId)
    end
end)
v216.new("Blox Fruit Dealer", function(_)
    return v_u_5.FruitShop
end, 2)
v216.new("Advanced Fruit Dealer", function(_)
    return v_u_5.FruitShop2
end, 2)
v216.new("Weapon Dealer", function(_)
    return v_u_5.WeaponDealer
end, 2)
v216.new("Advanced Weapon Dealer", function(_)
    return v_u_5.AdvancedWeaponDealer
end, 2)
v216.new("Party Shop", function(_)
    return v_u_5.PartyShop
end, 2)
v216.new("Valentine Shop", function(_)
    return v_u_5.PartyShop
end, 2)
v216.new("Sword Dealer", function(_)
    return v_u_5.SwordDealer1
end, 2)
v216.new("Sword Dealer of the West", function(_)
    return v_u_5.SwordDealer2
end, 2)
v216.new("Sword Dealer of the East", function(_)
    return v_u_5.SwordDealer3
end, 2)
v216.new("Master Sword Dealer", function(_)
    return v_u_5.SwordDealer4
end, 2)
v216.new("Living Skeleton", function(_)
    return v_u_5.SwordDealer5
end, 2)
v216.new("Boat Dealer", function(_)
    return v_u_5.BoatDealer
end, 2)
v216.new("Marines Boat Dealer", function(_)
    return v_u_5.BoatDealerMarines
end, 2)
v216.new("Advanced Marines Boat Dealer", function(_)
    return v_u_5.BoatDealerMarines2
end, 2)
v216.new("Luxury Boat Dealer", function(_)
    return v_u_5.LuxuryBoatDealer
end, 2)
v216.new("Dark Step Teacher", function(_)
    return v_u_5.BlackLegTeacher
end, 2)
v216.new("Ability Teacher", function(_)
    return v_u_5.HakiTeacher
end, 2)
v216.new("Mad Scientist", function(_)
    return v_u_5.ElectroTeacher
end, 2)
v216.new("Instinct Teacher", function(_)
    return v_u_5.KenTeacher
end, 2)
v216.new("Water Kung-fu Teacher", function(_)
    return v_u_5.FishmanKarateTeacher
end, 2)
v216.new("Pirate Recruiter", function(_)
    return v_u_5.JoinPirates
end, 4)
v216.new("Marine Recruiter", function(_)
    return v_u_5.JoinMarines
end, 4)
v216.new("Set Home Point", function(_)
    return v_u_5.SpawnPoint
end, 4)
v216.new("Indra", function(_)
    return v_u_5.Indra
end, 4)
v216.new("Sick Man", function(_)
    return v_u_5.SickMan
end, 4)
v216.new("Rich Man", function(_)
    return v_u_5.RichMan
end, 4)
v216.new("Yoshi", function(_)
    return v_u_5.Yoshi
end, 2)
v216.new("Parlus", function(_)
    return v_u_5.Parlus
end, 2)
v216.new("Hasan", function(_)
    return v_u_5.Hasan
end, 2)
v216.new("Remove Blox Fruit", function(_)
    return v_u_5.FruitRemover
end, 2)
v216.new("Robotmega", function(_)
    return v_u_5.Robotmega
end, 4)
v216.new("Love Letter 1", function(_)
    return v_u_5.LoveLetter1
end, 4)
v216.new("Love Letter 2", function(_)
    return v_u_5.LoveLetter2
end, 4)
v216.new("Love Letter 3", function(_)
    return v_u_5.LoveLetter3
end, 4)
v216.new("Military Detective", function(_)
    return v_u_5.Detective
end, 4)
v216.new("Experienced Captain", function(_)
    return v_u_5.TravelDressrosa
end, 4)
v216.new("Sea Captain", function(_)
    return v_u_5.TravelMain
end, 4)
v216.new("Pirate Adventurer", function(_)
    return v_u_5.BuggyQuest1
end, 1)
v216.new("Bandit Quest Giver", function(_)
    return v_u_5.BanditQuest1
end, 1)
v216.new("Adventurer", function(_)
    return v_u_5.JungleQuest
end, 1)
v216.new("Desert Adventurer", function(_)
    return v_u_5.DesertQuest
end, 1)
v216.new("Villager", function(_)
    return v_u_5.SnowQuest
end, 1)
v216.new("Marine Leader", function(_)
    return v_u_5.MarineQuest
end, 1)
v216.new("Sky Adventurer", function(_)
    return v_u_5.SkyQuest
end, 1)
v216.new("Marine", function(_)
    return v_u_5.MarineQuest2
end, 1)
v216.new("Colosseum Quest Giver", function(_)
    return v_u_5.ColosseumQuest
end, 1)
v216.new("Jail Keeper", function(_)
    return v_u_5.PrisonerQuest
end, 1)
v216.new("Head Jailer", function(_)
    return v_u_5.ImpelQuest
end, 1)
v216.new("The Mayor", function(_)
    return v_u_5.MagmaQuest
end, 1)
v216.new("King Neptune", function(_)
    return v_u_5.FishmanQuest
end, 1)
v216.new("Mole", function(_)
    return v_u_5.SkyExp1Quest
end, 1)
v216.new("Sky Quest Giver 2", function(_)
    return v_u_5.SkyExp2Quest
end, 1)
v216.new("Freezeburg Quest Giver", function(_)
    return v_u_5.FountainQuest
end, 1)
v216.new("Bartilo", function(_)
    return v_u_5.Bartilo
end, 1)
v216.new("Bounty/Honor Expert", function(_)
    return v_u_5.BountyHonorExpert
end, 4)
v216.new("Manager", function(_)
    return v_u_5.Manager
end, 4)
v216.new("Customer", function(_)
    return v_u_5.Customer
end, 4)
v216.new("Nerd", function(_)
    return v_u_5.Nerd
end, 4)
v216.new("Alchemist", function(_)
    return v_u_5.Alchemist
end, 4)
v216.new("Legendary Sword Dealer ", function(_)
    return v_u_5.LegendarySwordDealer
end, 2)
v216.new("arowe", function(_)
    return v_u_5.Wenlocktoad
end, 4)
v216.new("The Strongest God", function(_)
    return v_u_5.Usoapp
end, 2)
v216.new("Sabi", function(_)
    return v_u_5.Sabi
end, 4)
v216.new("Cyborg", function(_)
    return v_u_5.Cyborg
end, 4)
v216.new("tort", function(_)
    return v_u_5.tort
end, 2)
v216.new("Plokster", function(_)
    return v_u_5.Plokster
end, 2)
v216.new("Trevor", function(_)
    return v_u_5.Trevor
end, 4)
v216.new("Mysterious Man", function(_)
    return v_u_5.MysteriousMan
end, 4)
v216.new("Martial Arts Master", function(_)
    return v_u_5.MartialArtsMaster
end, 4)
v216.new("Phoeyu, the Reformed", function(_)
    return v_u_5.DeathStepTeacher
end, 4)
v216.new("Mysterious Scientist", function(_)
    return v_u_5.MysteriousScientist
end, 4)
v216.new("arlthmetic", function(_)
    return v_u_5.junior
end, 4)
v216.new("Mysterious Entity", function(_)
    return v_u_5.MysteriousEntity
end, 4)
v216.new("Crew Captain", function(_)
    return v_u_5.FamousPirate
end, 4)
v216.new("Awakenings Expert", function(_)
    return v_u_5.AwakeningsExpert
end, 4)
v216.new("Doghouse", function(_)
    return v_u_5.DoghouseSpike
end, 4)
v216.new("Aura Editor", function(_)
    return v_u_5.EnhancementEditor
end, 4)
v216.new("Guashiem", function(_)
    return v_u_5.EctoplasmChecker
end, 4)
v216.new("El Rodolfo", function(_)
    return v_u_5.Ectoplasm1
end, 4)
v216.new("El Perro", function(_)
    return v_u_5.Ectoplasm2
end, 4)
v216.new("El Admin", function(_)
    return v_u_5.Ectoplasm3
end, 4)
v216.new("Experimic", function(_)
    return v_u_5.GhoulGiver
end, 4)
v216.new("Titles Specialist", function(_)
    return v_u_5.TitlesSpecialist
end, 4)
v216.new("rip_indra", function(_)
    return v_u_5.rip_indra
end, 4)
v216.new("Blox Fruit Gacha", function(_)
    return v_u_5.RandomFruitSeller
end, 2)
v216.new("Daigrock, the Sharkman", function(_)
    return v_u_5.SharkmanTeacher
end, 4)
v216.new("Barista Cousin", function(_)
    return v_u_5.MasterOfEnhancement
end, 2)
v216.new("Thunder God", function(_)
    return v_u_5.ThunderGod
end, 2)
v216.new(" ", function(_)
    return v_u_5.CyborgTrainer
end, 4)
v216.new("King Red Head", function(_)
    return v_u_5.RedHead
end, 4)
v216.new("Mr. Captain", function(_)
    return v_u_5.TravelZou
end, 4)
v216.new("Elite Hunter", function(_)
    return v_u_5.EliteHunter
end, 4)
v216.new("Player Hunter", function(_)
    return v_u_5.PlayerHunter
end, 4)
v216.new("Butler", function(_)
    return v_u_5.Butler
end, 4)
v216.new("Hungry Man", function(_)
    return v_u_5.ObservationV2
end, 4)
v216.new("Lunoven", function(_)
    return v_u_5.Lunoven
end, 4)
v216.new("Tacomura", function(_)
    return v_u_5.Tacomura
end, 4)
v216.new("erin", function(_)
    return v_u_5.Flashback
end, 4)
v216.new("layandikit12", function(_)
    return v_u_5.layandikit12
end, 4)
v216.new("Citizen", function(_)
    return v_u_5.Citizen
end, 1)
v216.new("Previous Hero", function(_)
    return v_u_5.PreviousHero
end, 4)
v216.new("Horned Man", function(_)
    return v_u_5.HornedMan
end, 1)
v216.new("Arena Trainer", function(_)
    return v_u_5.ArenaTrainer
end, 1)
v216.new("Magic Elf", function(_)
    return v_u_5.Xmas1
end, 2)
v216.new("Greedy Elf", function(_)
    return v_u_5.Xmas2
end, 2)
v216.new("Santa Claws", function(_)
    return v_u_5.Xmas3
end, 2)
v216.new("Death King", function(_)
    return v_u_5.Halloween1
end, 4)
v216.new("Mysterious Force", function(_)
    return v_u_5.TempleTeleport
end, 4)
v216.new("Mysterious Force3", function(_)
    return v_u_5.TempleTeleportBack
end, 4)
v216.new("Blacksmith", function(_)
    return v_u_5.Blacksmith
end, 4)
v216.new("Crypt Master", function(_)
    return v_u_5.CryptMaster
end, 4)
v216.new("Ancient One", function(_)
    return v_u_5.RaceV4Upgrader
end, 4)
v216.new("Dragon Talon Sage", function(_)
    return v_u_5.Scroll
end, 2)
v216.new("Uzoth", function(_)
    return v_u_5.TalonTeacher
end, 4)
v216.new("Dragon Hunter", function(_)
    return v_u_5.DragonHunter
end, 4)
v216.new("Dojo Trainer", function(_)
    return v_u_5.DojoTrainer
end, 4)
v216.new("Dragon Tamer", function(_)
    return v_u_5.DragonTamer
end, 2)
v216.new("Sealed King", function(_)
    return v_u_5.SealedKing
end, 4)
v216.new("Gravestone", function(_)
    return v_u_5.Gravestone
end, 4)
v216.new("drip_mama", function(_)
    return v_u_5.CakeSpawner
end, 4)
v216.new("Sweet Crafter", function(_)
    return v_u_5.SweetChalice
end, 4)
v216.new("Cake Scientist", function(_)
    return v_u_5.CakeScientist
end, 4)
v216.new("Sick Scientist", function(_)
    return v_u_5.SickScientist
end, 4)
v216.new("Ghost", function(_)
    return v_u_5.GhostPuzzle
end, 4)
v216.new("Skeleton Machine", function(_)
    return v_u_5.SkeletonMachine
end, 4)
v216.new("Ancient Monk", function(_)
    return v_u_5.GodhumanTeacher
end, 4)
v216.new("Shafi", function(_)
    return v_u_5.SanguineTeacher
end, 4)
v216.new("Spy", function(_)
    return v_u_5.Spy
end, 4)
v216.new("Shark Hunter", function(_)
    return v_u_5.SharkHunter
end, 2)
v216.new("Beast Hunter", function(_)
    return v_u_5.BeastHunter
end, 2)
v216.new("Fossil Expert", function(_)
    return v_u_5.FossilExpert
end, 2)
v216.new("Area 1 Quest Giver", function(_)
    return v_u_5.Area1Quest
end, 1)
v216.new("Area 2 Quest Giver", function(_)
    return v_u_5.Area2Quest
end, 1)
v216.new("Marine Quest Giver", function(_)
    return v_u_5.MarineQuest3
end, 1)
v216.new("Graveyard Quest Giver", function(_)
    return v_u_5.ZombieQuest
end, 1)
v216.new("Snow Quest Giver", function(_)
    return v_u_5.SnowMountainQuest
end, 1)
v216.new("Ice Quest Giver", function(_)
    return v_u_5.IceSideQuest
end, 1)
v216.new("Fire Quest Giver", function(_)
    return v_u_5.FireSideQuest
end, 1)
v216.new("Rear Crew Quest Giver", function(_)
    return v_u_5.ShipQuest1
end, 1)
v216.new("Front Crew Quest Giver", function(_)
    return v_u_5.ShipQuest2
end, 1)
v216.new("Frost Quest Giver", function(_)
    return v_u_5.FrostQuest
end, 1)
v216.new("Forgotten Quest Giver", function(_)
    return v_u_5.ForgottenQuest
end, 1)
v216.new("Pirate Port Quest Giver", function(_)
    return v_u_5.PiratePortQuest
end, 1)
v216.new("Dragon Crew Quest Giver", function(_)
    return v_u_5.DragonCrewQuest
end, 1)
v216.new("Hydra Town Quest Giver", function(_)
    return v_u_5.VenomCrewQuest
end, 1)
v216.new("Marine Tree Quest Giver", function(_)
    return v_u_5.MarineTreeIsland
end, 1)
v216.new("Deep Forest Quest Giver", function(_)
    return v_u_5.DeepForestIsland
end, 1)
v216.new("Deep Forest Area 2 Quest Giver", function(_)
    return v_u_5.DeepForestIsland2
end, 1)
v216.new("Turtle Adventure Quest Giver", function(_)
    return v_u_5.DeepForestIsland3
end, 1)
v216.new("Haunted Castle Quest Giver 1", function(_)
    return v_u_5.HauntedQuest1
end, 1)
v216.new("Haunted Castle Quest Giver 2", function(_)
    return v_u_5.HauntedQuest2
end, 1)
v216.new("Peanut Quest Giver", function(_)
    return v_u_5.NutsIslandQuest
end, 1)
v216.new("Ice Cream Quest Giver", function(_)
    return v_u_5.IceCreamIslandQuest
end, 1)
v216.new("Cake Quest Giver 1", function(_)
    return v_u_5.CakeQuest1
end, 1)
v216.new("Cake Quest Giver 2", function(_)
    return v_u_5.CakeQuest2
end, 1)
v216.new("Chocolate Quest Giver 1", function(_)
    return v_u_5.ChocQuest1
end, 1)
v216.new("Chocolate Quest Giver 2", function(_)
    return v_u_5.ChocQuest2
end, 1)
v216.new("Candy Cane Quest Giver", function(_)
    return v_u_5.CandyQuest1
end, 1)
v216.new("Tiki Quest Giver 1", function(_)
    return v_u_5.TikiQuest1
end, 1)
v216.new("Tiki Quest Giver 2", function(_)
    return v_u_5.TikiQuest2
end, 1)
v216.new("Tiki Quest Giver 3", function(_)
    return v_u_5.TikiQuest3
end, 1)
v216.new("Frozen Watcher", function(_)
    return v_u_5.LeviathanGate
end, 1)
v216.new("Draco Statue", function(_)
    return v_u_5.DracoStatue
end, 4)
v216.new("Divine", function(_)
    return v_u_5.Divine
end, 4)
v216.new("Barista", function(_)
    return v_u_5.Barista
end, 2)
if v9.SUBCLASSES_ENABLED == true then
    if v9.SUBCLASSES.Shipwright then
        v216.new("Shipwright Teacher", function(_)
            return v_u_5.ShipwrightNPC
        end, 4)
    end
    if v9.SUBCLASSES.Helmsman then
        v216.new("Helmsman Teacher", function(_)
            return v_u_5.HelmsmanNPC
        end, 4)
    end
end
v216.new("Dragon Wizard", function(_)
    return v_u_5.DragonWizard
end, 4, 2)
v216.new("DojoHiddenRoom", function(_)
    return v_u_5.DojoHiddenRoom
end, 4)
v216.new("Submarine Worker", function(_)
    return v_u_5.Submarine
end, 4)
v216.new("Secret Santa", function(_)
    return v_u_5.SecretSanta
end, 1)
_G.NPCReady = true
(function(p_u_220)
    v_u_13 = require(v_u_3:WaitForChild("DialogueController"))
    _G.dialogueModel = nil
    v_u_4.InputBegan:connect(function(p221, p222)
        if p222 or (not v_u_14 or (not p_u_220.Character or v_u_13.Active)) then
            return
        elseif v_u_4.GamepadEnabled or p221.UserInputState == Enum.UserInputState.Begin and (p221.UserInputType == Enum.UserInputType.MouseButton1 or p221.UserInputType == Enum.UserInputType.Touch) then
            if not p_u_220.Character.Busy.Value or p_u_220.Character:GetAttribute("NoDashing") then
                local v223 = v_u_14
                v223.GUI.BusyLock:Lock("_General")
                v_u_12.Adornee = nil
                local v_u_224 = p_u_220.Character.Busy.Value
                p_u_220.Character.Busy.Value = true
                _G.dialogueModel = v_u_14.Model
                for v225 in pairs(v_u_20) do
                    if v225 ~= v_u_14.Model then
                        v_u_19:Fire(v225, nil, true)
                    end
                end
                wait()
                local v226 = p_u_220.Character.Humanoid.WalkSpeed
                p_u_220.Character.Humanoid.WalkSpeed = 0
                local v_u_227 = false
                task.spawn(function()
                    local v228 = p_u_220.Character.Busy
                    local v229 = p_u_220.Character.Humanoid
                    while v_u_227 == false do
                        v228.Value = true
                        v229.WalkSpeed = 0
                        wait()
                    end
                    v228.Value = v_u_224
                    _G.dialogueModel = nil
                end)
                v_u_13:Start(v223.Object:GetDialogue(p_u_220))
                p_u_220.Character.Humanoid.WalkSpeed = v226
                v_u_227 = true
                p_u_220.Character.Busy.Value = v_u_224
                _G.dialogueModel = nil
                v_u_14 = nil
            end
        else
            return
        end
    end)
    v_u_4.TouchTap:connect(function(_, p230)
        if p230 or (not v_u_14 or (not p_u_220.Character or v_u_13.Active)) then
            return
        elseif not p_u_220.Character.Busy.Value then
            local v231 = v_u_14
            v231.GUI.BusyLock:Lock("_General")
            v_u_12.Adornee = nil
            local v_u_232 = p_u_220.Character.Busy.Value
            p_u_220.Character.Busy.Value = true
            _G.dialogueModel = v_u_14.Model
            for v233 in pairs(v_u_20) do
                if v233 ~= v_u_14.Model then
                    v_u_19:Fire(v233, nil, true)
                end
            end
            wait()
            local v234 = p_u_220.Character.Humanoid.WalkSpeed
            p_u_220.Character.Humanoid.WalkSpeed = 0
            local v_u_235 = false
            task.spawn(function()
                while v_u_235 == false do
                    p_u_220.Character.Busy.Value = true
                    p_u_220.Character.Humanoid.WalkSpeed = 0
                    task.wait()
                end
                p_u_220.Character.Busy.Value = v_u_232
                _G.dialogueModel = nil
            end)
            v_u_13:Start(v231.Object:GetDialogue(p_u_220))
            v_u_235 = true
            p_u_220.Character.Humanoid.WalkSpeed = v234
            p_u_220.Character.Busy.Value = v_u_232
            _G.dialogueModel = nil
            v_u_14 = nil
        end
    end)
end)(game.Players.LocalPlayer)
task.spawn(function()
    game.ReplicatedStorage:WaitForChild("Remotes"):WaitForChild("Prompt").OnClientEvent:Connect(function(p236)
        v_u_13:Start(v_u_5[p236])
    end)
end)
function _G.Dialogue(p237)
    v_u_13:Start(v_u_5[p237])
end
_G.DialogueController = v_u_13
function _G.GetQueue(p238)
    if p238 then
        for _, v239 in pairs(v_u_21) do
            if v239.Model == p238 then
                return v239
            end
        end
    end
    return v_u_21
end
repeat
    wait()
until game.Players.LocalPlayer and (game.Players.LocalPlayer.Team and (game.Players.LocalPlayer.Team ~= "" and game.Players.LocalPlayer.Team ~= "Neutral"))
game.Players.LocalPlayer.ChildAdded:Connect(function(p240)
    if p240.Name == "Banned" then
        v_u_13:Start(v_u_5.Exploiter)
    end
end)
if game.Players.LocalPlayer:FindFirstChild("Banned") then
    v_u_13:Start(v_u_5.Exploiter)
end
