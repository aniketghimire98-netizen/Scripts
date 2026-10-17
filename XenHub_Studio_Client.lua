-- XenHub_Studio_Client.lua
-- For YOUR OWN Roblox experience only.
-- Install WindUI as a ModuleScript named "WindUI" in ReplicatedStorage.
-- Put this file in StarterPlayer > StarterPlayerScripts as a LocalScript.
-- Matching server script: XenHub_Studio_Server.lua (put in ServerScriptService).
--
-- The client key is a UI gate, NOT secure authentication. Server-side permissions
-- protect the teleport request. This is not intended for use in other people's games.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local LocalPlayer = Players.LocalPlayer
local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
local TeleportRequest = ReplicatedStorage:WaitForChild("XenTeleportRequest")

local ACCESS_KEY = "Keyedesp"
local MAX_DISTANCE = 250
local LOCK_SMOOTHNESS = 0.18

local WindUI = require(ReplicatedStorage:WaitForChild("WindUI"))
local Window = WindUI:CreateWindow({
    Title = "Xen Hub",
    Icon = "shield",
    Author = "Xen",
    Folder = "XenHub",
    Size = UDim2.fromOffset(560, 420),
    Transparent = true,
    Theme = "Dark",
})

local unlocked = false
local tabsCreated = false
local selectedPlayerName = nil
local lockEnabled = false
local espEnabled = false
local npcEspEnabled = false
local teamCheck = false
local fovEnabled = true
local fovSize = 180
local playerHighlights = {}
local npcHighlights = {}
local currentTarget = nil
local aimTab, espTab, teleportTab, settingsTab

local function notify(title, message)
    pcall(function()
        WindUI:Notify({ Title = title, Content = message, Duration = 3 })
    end)
end

local function getRoot(model)
    return model and (model:FindFirstChild("HumanoidRootPart") or model:FindFirstChild("Head"))
end

local function getHumanoid(model)
    return model and model:FindFirstChildOfClass("Humanoid")
end

local function validModel(model)
    local hum = getHumanoid(model)
    return hum and hum.Health > 0 and getRoot(model) ~= nil
end

local function sameTeam(player)
    return teamCheck and LocalPlayer.Team ~= nil and player.Team == LocalPlayer.Team
end

local function listPlayerNames()
    local names = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and validModel(player.Character) then
            table.insert(names, player.Name)
        end
    end
    table.sort(names)
    return names
end

local function getPlayerByName(name)
    if not name then return nil end
    for _, player in ipairs(Players:GetPlayers()) do
        if player.Name == name and player ~= LocalPlayer then
            return player
        end
    end
    return nil
end

local function removeHighlight(container, model)
    local obj = container[model]
    if obj then
        obj:Destroy()
        container[model] = nil
    end
end

local function setHighlight(container, model, color)
    if not model or not model.Parent then return end
    if not container[model] then
        local h = Instance.new("Highlight")
        h.Name = "XenESPHighlight"
        h.Adornee = model
        h.FillTransparency = 0.82
        h.OutlineTransparency = 0.05
        h.DepthMode = Enum.HighlightDepthMode.Occluded
        h.Parent = PlayerGui
        container[model] = h
    end
    container[model].OutlineColor = color
    container[model].FillColor = color
end

local function clearHighlights(container)
    for model, highlight in pairs(container) do
        if highlight then highlight:Destroy() end
        container[model] = nil
    end
end

local function updatePlayerESP()
    if not espEnabled then
        clearHighlights(playerHighlights)
        return
    end
    local active = {}
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and validModel(player.Character) and not sameTeam(player) then
            active[player.Character] = true
            setHighlight(playerHighlights, player.Character, Color3.fromRGB(65, 145, 255))
        end
    end
    for model in pairs(playerHighlights) do
        if not active[model] or not model.Parent then removeHighlight(playerHighlights, model) end
    end
end

local function updateNPCEsp()
    if not npcEspEnabled then
        clearHighlights(npcHighlights)
        return
    end
    local active = {}
    local tagged = CollectionService:GetTagged("AimTarget")
    for _, model in ipairs(tagged) do
        if model:IsA("Model") and validModel(model) then
            local isPlayerCharacter = false
            for _, player in ipairs(Players:GetPlayers()) do
                if player.Character == model then isPlayerCharacter = true break end
            end
            if not isPlayerCharacter then
                active[model] = true
                setHighlight(npcHighlights, model, Color3.fromRGB(255, 190, 70))
            end
        end
    end
    for model in pairs(npcHighlights) do
        if not active[model] or not model.Parent then removeHighlight(npcHighlights, model) end
    end
end

-- FOV ring is a normal ScreenGui element, centered on the screen.
local fovGui = Instance.new("ScreenGui")
fovGui.Name = "XenFOVCircle"
fovGui.ResetOnSpawn = false
fovGui.IgnoreGuiInset = true
fovGui.Parent = PlayerGui

local fovCircle = Instance.new("Frame")
fovCircle.Name = "Circle"
fovCircle.AnchorPoint = Vector2.new(0.5, 0.5)
fovCircle.Position = UDim2.fromScale(0.5, 0.5)
fovCircle.Size = UDim2.fromOffset(fovSize, fovSize)
fovCircle.BackgroundTransparency = 1
fovCircle.Visible = fovEnabled
fovCircle.Parent = fovGui

local fovCorner = Instance.new("UICorner")
fovCorner.CornerRadius = UDim.new(1, 0)
fovCorner.Parent = fovCircle

local fovStroke = Instance.new("UIStroke")
fovStroke.Thickness = 1.5
fovStroke.Color = Color3.fromRGB(75, 155, 255)
fovStroke.Transparency = 0.12
fovStroke.Parent = fovCircle

local function getTargetModel(target)
    if typeof(target) == "Instance" and target:IsA("Player") then
        return target.Character
    end
    if typeof(target) == "Instance" and target:IsA("Model") then
        return target
    end
    return nil
end

local function getNPCs()
    local out = {}
    for _, item in ipairs(CollectionService:GetTagged("AimTarget")) do
        if item:IsA("Model") and validModel(item) then
            local isPlayerCharacter = false
            for _, p in ipairs(Players:GetPlayers()) do
                if p.Character == item then isPlayerCharacter = true break end
            end
            if not isPlayerCharacter then table.insert(out, item) end
        end
    end
    return out
end

local function getTargetCandidates(mode)
    local out = {}
    if mode == "NPCs" then
        return getNPCs()
    end
    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer and player.Character and validModel(player.Character) and not sameTeam(player) then
            table.insert(out, player)
        end
    end
    return out
end

local targetMode = "Players"

local function nextTarget()
    local targets = getTargetCandidates(targetMode)
    if #targets == 0 then
        currentTarget = nil
        notify("Xen Aim", "No valid targets found. Tag NPCs as AimTarget.")
        return
    end
    local index = 0
    for i, target in ipairs(targets) do
        if target == currentTarget then index = i break end
    end
    currentTarget = targets[(index % #targets) + 1]
    notify("Target Selected", currentTarget:IsA("Player") and currentTarget.Name or currentTarget.Name)
end

local function getTargetName(target)
    if not target then return "None" end
    return target.Name
end

local function buildUnlockedTabs()
    if tabsCreated then return end
    tabsCreated = true

    aimTab = Window:Tab({ Title = "Aim", Icon = "crosshair" })
    espTab = Window:Tab({ Title = "ESP", Icon = "scan-eye" })
    teleportTab = Window:Tab({ Title = "Teleport", Icon = "move-3d" })
    settingsTab = Window:Tab({ Title = "Settings", Icon = "settings" })

    aimTab:Paragraph({
        Title = "Targeting",
        Desc = "For your own experience. Select a target, then enable camera lock-on.",
    })

    aimTab:Button({
        Title = "Switch Player / NPC Mode",
        Desc = "NPCs must be tagged with CollectionService tag AimTarget.",
        Callback = function()
            targetMode = targetMode == "Players" and "NPCs" or "Players"
            currentTarget = nil
            notify("Target Mode", targetMode)
        end,
    })

    aimTab:Button({
        Title = "Next Target",
        Desc = "Select the next valid target.",
        Callback = nextTarget,
    })

    aimTab:Toggle({
        Title = "Camera Lock-On",
        Desc = "Smoothly point the camera at the selected target.",
        Value = false,
        Callback = function(value) lockEnabled = value end,
    })

    espTab:Toggle({
        Title = "Player ESP",
        Desc = "Outline player characters in this experience.",
        Value = false,
        Callback = function(value)
            espEnabled = value
            updatePlayerESP()
        end,
    })

    espTab:Toggle({
        Title = "NPC ESP",
        Desc = "Outline NPC models tagged AimTarget.",
        Value = false,
        Callback = function(value)
            npcEspEnabled = value
            updateNPCEsp()
        end,
    })

    espTab:Toggle({
        Title = "Team Check",
        Desc = "Exclude players on your team from ESP and targeting.",
        Value = false,
        Callback = function(value)
            teamCheck = value
            updatePlayerESP()
        end,
    })

    teleportTab:Paragraph({
        Title = "Teleport to Player",
        Desc = "Choose a player from the dropdown, then request teleport. Server script authorizes the request.",
    })

    local dropdown
    dropdown = teleportTab:Dropdown({
        Title = "Select Player",
        Values = listPlayerNames(),
        Value = nil,
        AllowNone = true,
        Callback = function(value)
            selectedPlayerName = value
        end,
    })

    teleportTab:Button({
        Title = "Refresh Player List",
        Callback = function()
            local names = listPlayerNames()
            if dropdown and dropdown.Refresh then
                dropdown:Refresh(names)
            end
            notify("Players", "Player list refreshed.")
        end,
    })

    teleportTab:Button({
        Title = "Teleport Near Selected Player",
        Desc = "Available only if the server script authorizes you in your own game.",
        Callback = function()
            local target = getPlayerByName(selectedPlayerName)
            if not target then
                notify("Teleport", "Select a valid player first.")
                return
            end
            TeleportRequest:FireServer(target.UserId)
            notify("Teleport", "Teleport request sent.")
        end,
    })

    settingsTab:Toggle({
        Title = "Show FOV Circle",
        Value = true,
        Callback = function(value)
            fovEnabled = value
            fovCircle.Visible = value
        end,
    })

    settingsTab:Slider({
        Title = "FOV Circle Size",
        Desc = "Visual circle diameter in pixels.",
        Step = 10,
        Value = { Min = 80, Max = 500, Default = fovSize },
        Callback = function(value)
            fovSize = tonumber(value) or fovSize
            fovCircle.Size = UDim2.fromOffset(fovSize, fovSize)
        end,
    })

    settingsTab:Slider({
        Title = "Target Range",
        Desc = "Maximum lock-on distance in studs.",
        Step = 25,
        Value = { Min = 50, Max = 1000, Default = MAX_DISTANCE },
        Callback = function(value)
            MAX_DISTANCE = tonumber(value) or MAX_DISTANCE
        end,
    })

    notify("Unlocked", "Aim, ESP, Teleport and Settings tabs are now available.")
    pcall(function() Window:SelectTab("Aim") end)
end

local keyTab = Window:Tab({ Title = "Key System", Icon = "key-round" })
keyTab:Paragraph({
    Title = "Xen Hub Access",
    Desc = "Enter the access key to unlock Aim, ESP, Teleport and Settings.",
})

local enteredKey = ""
keyTab:Input({
    Title = "Access Key",
    Desc = "Enter the key exactly as shown to you.",
    Placeholder = "Enter key...",
    Callback = function(value)
        enteredKey = tostring(value or "")
    end,
})

keyTab:Button({
    Title = "Unlock Hub",
    Callback = function()
        if enteredKey == ACCESS_KEY then
            unlocked = true
            buildUnlockedTabs()
        else
            notify("Invalid Key", "The key is incorrect.")
        end
    end,
})

RunService:BindToRenderStep("XenHubAimCamera", Enum.RenderPriority.Camera.Value + 1, function()
    if not unlocked or not lockEnabled or not currentTarget then return end
    local camera = workspace.CurrentCamera
    local model = getTargetModel(currentTarget)
    local myCharacter = LocalPlayer.Character
    local myRoot = getRoot(myCharacter)
    local targetPart = getRoot(model)

    if not model or not model.Parent or not validModel(model) or not myRoot or not targetPart then
        currentTarget = nil
        return
    end

    if (targetPart.Position - myRoot.Position).Magnitude > MAX_DISTANCE then
        currentTarget = nil
        return
    end

    local viewport = camera.ViewportSize
    local screenPoint, onScreen = camera:WorldToViewportPoint(targetPart.Position)
    local center = Vector2.new(viewport.X / 2, viewport.Y / 2)
    local distanceFromCenter = (Vector2.new(screenPoint.X, screenPoint.Y) - center).Magnitude

    -- Keep lock-on within the visual FOV circle.
    if not onScreen or (fovEnabled and distanceFromCenter > fovSize / 2) then
        return
    end

    local desired = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
    camera.CFrame = camera.CFrame:Lerp(desired, math.clamp(LOCK_SMOOTHNESS, 0.01, 1))
end)

local updateTimer = 0
RunService.Heartbeat:Connect(function(dt)
    if not unlocked then return end
    updateTimer += dt
    if updateTimer >= 0.5 then
        updateTimer = 0
        updatePlayerESP()
        updateNPCEsp()
    end
end)

script.Destroying:Connect(function()
    RunService:UnbindFromRenderStep("XenHubAimCamera")
    clearHighlights(playerHighlights)
    clearHighlights(npcHighlights)
    if fovGui then fovGui:Destroy() end
end)
