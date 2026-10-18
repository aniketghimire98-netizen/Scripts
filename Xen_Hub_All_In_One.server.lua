-- Xen Hub all-in-one package for YOUR OWN Roblox Studio game.
-- IMPORTANT:
-- This file contains both the server handler and client UI code, but Roblox
-- scripts run in different contexts. Do not paste this entire file into one Script.
-- For correct server-wide replication, split at the clearly marked sections below:
--   1) SERVER SECTION -> Script in ServerScriptService
--   2) CLIENT SECTION -> LocalScript in StarterPlayerScripts (or your supported UI loader)
--
-- A single executable Script cannot safely run both server and client UI code.
-- This combined file is provided in one file for convenience and has explicit sections.

--====================== SERVER SECTION ======================
-- Place this section in ServerScriptService as XenHideSelfServer.server.lua.
-- Xen Hub: server-wide invisibility for a Roblox Studio game you own
-- Place this Script in ServerScriptService as XenHideSelfServer.server.lua.
-- The server creates the RemoteEvent, validates requests, and changes the requesting
-- player's character so the appearance replicates to other clients.

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")

local EVENT_NAME = "XenHideSelfEvent"
local remote = ReplicatedStorage:FindFirstChild(EVENT_NAME)
if not remote then
    remote = Instance.new("RemoteEvent")
    remote.Name = EVENT_NAME
    remote.Parent = ReplicatedStorage
end

local hidden = {}
local original = {}

local function rememberAndSet(instance, property, value, player)
    original[player] = original[player] or {}
    original[player][instance] = original[player][instance] or {}
    if original[player][instance][property] == nil then
        original[player][instance][property] = instance[property]
    end
    instance[property] = value
end

local function applyHidden(player, character, shouldHide)
    if not character then return end

    if shouldHide then
        for _, descendant in ipairs(character:GetDescendants()) do
            if descendant:IsA("BasePart") then
                rememberAndSet(descendant, "Transparency", 1, player)
                if descendant.Name == "HumanoidRootPart" then
                    -- Keep root collision/physics unchanged; only make it invisible.
                    rememberAndSet(descendant, "Transparency", 1, player)
                end
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                rememberAndSet(descendant, "Transparency", 1, player)
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")
                or descendant:IsA("Beam") then
                rememberAndSet(descendant, "Enabled", false, player)
            end
        end

        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            for _, accessory in ipairs(character:GetChildren()) do
                if accessory:IsA("Accessory") then
                    for _, item in ipairs(accessory:GetDescendants()) do
                        if item:IsA("BasePart") then
                            rememberAndSet(item, "Transparency", 1, player)
                        end
                    end
                end
            end
        end
    else
        local saved = original[player]
        if saved then
            for instance, properties in pairs(saved) do
                if instance and instance.Parent then
                    for property, value in pairs(properties) do
                        pcall(function()
                            instance[property] = value
                        end)
                    end
                end
            end
        end
        original[player] = nil
    end
end

local function hookCharacter(player, character)
    task.wait(0.2)
    if hidden[player] then
        applyHidden(player, character, true)
    end

    character.DescendantAdded:Connect(function(descendant)
        if not hidden[player] then return end
        task.defer(function()
            if not descendant.Parent or not hidden[player] then return end
            if descendant:IsA("BasePart") then
                rememberAndSet(descendant, "Transparency", 1, player)
            elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
                rememberAndSet(descendant, "Transparency", 1, player)
            elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail")
                or descendant:IsA("Beam") then
                rememberAndSet(descendant, "Enabled", false, player)
            end
        end)
    end)
end

remote.OnServerEvent:Connect(function(player, shouldHide)
    if typeof(shouldHide) ~= "boolean" then return end
    hidden[player] = shouldHide
    applyHidden(player, player.Character, shouldHide)
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function(character)
        hookCharacter(player, character)
    end)
    if player.Character then
        hookCharacter(player, player.Character)
    end
end)

Players.PlayerRemoving:Connect(function(player)
    hidden[player] = nil
    original[player] = nil
end)


--====================== CLIENT SECTION ======================
-- Place this section in a LocalScript in StarterPlayerScripts.
--[[
    Compact ESP Hub
    Wind UI
    For your own Roblox Studio game

    Features:
    - Compact player names and distance
    - Character outline ESP
    - Team check
    - Adjustable text size and distance
    - Player selection
    - Teleport near selected player
    - Current server information
]]

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")

local LocalPlayer = Players.LocalPlayer

-- Configuration
local ESP_COLOR = Color3.fromRGB(0, 150, 255)
local TEXT_SIZE = 12
local MAX_DISTANCE = 1000

local ESP_ENABLED = false
local NAME_DISTANCE_ENABLED = true
local BOX_ENABLED = true
local TEAM_CHECK = false

local ESP_OBJECTS = {}
local Connections = {}
local SelectedPlayer = nil
local Unloaded = false

-- Wind UI
local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "Compact ESP Hub",
    Icon = "eye",
    Author = "Xen",
    Folder = "CompactESP",
    Size = UDim2.fromOffset(520, 400),
    Transparent = true,
    Theme = "Dark",
})

-- Notification helper
local function Notify(title, content)
    WindUI:Notify({
        Title = title,
        Content = content,
        Duration = 3,
    })
end

-- Remove a player's ESP
local function RemoveESP(player)
    local data = ESP_OBJECTS[player]
    if not data then return end

    if data.Highlight then
        data.Highlight:Destroy()
    end

    if data.Billboard then
        data.Billboard:Destroy()
    end

    ESP_OBJECTS[player] = nil
end

-- Create ESP for a character
local function CreateESP(player)
    if player == LocalPlayer or player ~= SelectedPlayer or Unloaded then return end

    RemoveESP(player)

    local character = player.Character
    if not character then return end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then return end

    -- Character outline
    local highlight = Instance.new("Highlight")
    highlight.Name = "CompactESPHighlight"
    highlight.Adornee = character
    highlight.FillColor = ESP_COLOR
    highlight.OutlineColor = ESP_COLOR
    highlight.FillTransparency = 1
    highlight.OutlineTransparency = 0
    highlight.DepthMode = Enum.HighlightDepthMode.Occluded
    highlight.Enabled = BOX_ENABLED
    highlight.Parent = character

    -- Compact label
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "CompactESPLabel"
    billboard.Adornee = root
    billboard.Size = UDim2.fromOffset(150, 22)
    billboard.StudsOffset = Vector3.new(0, 3.2, 0)
    billboard.AlwaysOnTop = false
    billboard.Enabled = NAME_DISTANCE_ENABLED
    billboard.Parent = root

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = ESP_COLOR
    label.TextSize = TEXT_SIZE
    label.TextScaled = false
    label.Font = Enum.Font.Gotham
    label.TextStrokeTransparency = 0.4
    label.Parent = billboard

    ESP_OBJECTS[player] = {
        Highlight = highlight,
        Billboard = billboard,
        Label = label,
    }
end

-- Refresh ESP
local function RefreshESP()
    for _, player in ipairs(Players:GetPlayers()) do
        RemoveESP(player)
    end

    if ESP_ENABLED and SelectedPlayer and SelectedPlayer.Parent then
        CreateESP(SelectedPlayer)
    end
end

-- Server-wide invisibility request (requires the companion ServerScript below)
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local HideSelfEvent = ReplicatedStorage:FindFirstChild("XenHideSelfEvent")

local function RequestHideSelf(value)
    if not HideSelfEvent then
        Notify("Hide Myself", "Server script is missing. Add XenHideSelfServer.server.lua in ServerScriptService.")
        return
    end
    HideSelfEvent:FireServer(value)
end

-- ESP tab
local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "eye",
})

ESPTab:Toggle({
    Title = "Enable ESP",
    Default = false,
    Callback = function(value)
        ESP_ENABLED = value
        RefreshESP()
    end,
})

ESPTab:Toggle({
    Title = "Hide Myself (Server-Wide)",
    Default = false,
    Callback = function(value)
        RequestHideSelf(value)
    end,
})

ESPTab:Toggle({
    Title = "Name + Distance",
    Default = true,
    Callback = function(value)
        NAME_DISTANCE_ENABLED = value

        for _, data in pairs(ESP_OBJECTS) do
            data.Billboard.Enabled = value
        end
    end,
})

ESPTab:Toggle({
    Title = "Box Highlight",
    Default = true,
    Callback = function(value)
        BOX_ENABLED = value

        for _, data in pairs(ESP_OBJECTS) do
            data.Highlight.Enabled = value
        end
    end,
})

ESPTab:Toggle({
    Title = "Team Check",
    Default = false,
    Callback = function(value)
        TEAM_CHECK = value
    end,
})

ESPTab:Button({
    Title = "Refresh ESP",
    Callback = RefreshESP,
})

-- Settings tab
local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

SettingsTab:Slider({
    Title = "Text Size",
    Value = {
        Min = 8,
        Max = 16,
        Default = 12,
    },
    Callback = function(value)
        TEXT_SIZE = value

        for _, data in pairs(ESP_OBJECTS) do
            data.Label.TextSize = value
        end
    end,
})

SettingsTab:Slider({
    Title = "Maximum Distance",
    Value = {
        Min = 100,
        Max = 2000,
        Default = 1000,
    },
    Callback = function(value)
        MAX_DISTANCE = value
    end,
})

-- Teleport tab
local TeleportTab = Window:Tab({
    Title = "Teleport",
    Icon = "map-pin",
})

local function GetPlayerNames()
    local names = {}

    for _, player in ipairs(Players:GetPlayers()) do
        if player ~= LocalPlayer then
            table.insert(names, player.Name)
        end
    end

    table.sort(names)
    return names
end

local PlayerDropdown = ESPTab:Dropdown({
    Title = "Select ESP Target",
    Values = GetPlayerNames(),
    Callback = function(value)
        SelectedPlayer = Players:FindFirstChild(value)
        RefreshESP()
        if SelectedPlayer then
            Notify("ESP Target", "Selected " .. SelectedPlayer.DisplayName)
        end
    end,
})

ESPTab:Button({
    Title = "Refresh Player List",
    Callback = function()
        PlayerDropdown:Refresh(GetPlayerNames())
        Notify("Players", "Player list refreshed.")
    end,
})

TeleportTab:Button({
    Title = "Teleport Near Player",
    Callback = function()
        if not SelectedPlayer
            or not SelectedPlayer.Parent
            or SelectedPlayer == LocalPlayer then

            Notify("Teleport", "Select a valid player first.")
            return
        end

        local character = LocalPlayer.Character
        local targetCharacter = SelectedPlayer.Character

        local myRoot = character
            and character:FindFirstChild("HumanoidRootPart")

        local targetRoot = targetCharacter
            and targetCharacter:FindFirstChild("HumanoidRootPart")

        if not myRoot or not targetRoot then
            Notify("Teleport", "A character is unavailable.")
            return
        end

        -- For your own Roblox Studio game.
        myRoot.CFrame = targetRoot.CFrame * CFrame.new(3, 0, 0)

        Notify("Teleport", "Moved near " .. SelectedPlayer.Name)
    end,
})

-- Server information
TeleportTab:Section({
    Title = "Current Server",
})

local ServerInfo = TeleportTab:Paragraph({
    Title = "Server Information",
    Content = "Job ID: " .. game.JobId
        .. "\nPlayers: " .. #Players:GetPlayers()
        .. "/" .. Players.MaxPlayers,
})

TeleportTab:Button({
    Title = "Refresh Server Information",
    Callback = function()
        Notify(
            "Server Information",
            "Players: " .. #Players:GetPlayers()
                .. "/" .. Players.MaxPlayers
        )
    end,
})

-- Update ESP
Connections.Update = RunService.RenderStepped:Connect(function()
    if Unloaded then return end

    local myCharacter = LocalPlayer.Character
    local myRoot = myCharacter
        and myCharacter:FindFirstChild("HumanoidRootPart")

    if not myRoot then return end

    for player, data in pairs(ESP_OBJECTS) do
        local character = player.Character
        local root = character
            and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character
            and character:FindFirstChildOfClass("Humanoid")

        if not root or not humanoid then
            data.Billboard.Enabled = false
            data.Highlight.Enabled = false
            continue
        end

        local distance = (root.Position - myRoot.Position).Magnitude

        local sameTeam = TEAM_CHECK
            and LocalPlayer.Team ~= nil
            and player.Team == LocalPlayer.Team

        local visible = ESP_ENABLED
            and distance <= MAX_DISTANCE
            and humanoid.Health > 0
            and not sameTeam

        data.Billboard.Enabled =
            visible and NAME_DISTANCE_ENABLED

        data.Highlight.Enabled =
            visible and BOX_ENABLED

        data.Label.Text = string.format(
            "%s [%.0fm]",
            player.DisplayName,
            distance
        )
    end
end)

-- New players and respawns
Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
    Connections[player] = player.CharacterAdded:Connect(function()
        task.wait(0.5)

        if ESP_ENABLED and player == SelectedPlayer and not Unloaded then
            CreateESP(player)
        end
    end)

    if player.Character and ESP_ENABLED and player == SelectedPlayer then
        CreateESP(player)
    end
end)

Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
    RemoveESP(player)

    if SelectedPlayer == player then
        SelectedPlayer = nil
        RefreshESP()
        if PlayerDropdown then
            PlayerDropdown:Refresh(GetPlayerNames())
        end
    end

    if Connections[player] then
        Connections[player]:Disconnect()
        Connections[player] = nil
    end
end)

-- Unload
SettingsTab:Button({
    Title = "Unload Hub",
    Callback = function()
        Unloaded = true
        ESP_ENABLED = false

        for _, connection in pairs(Connections) do
            if typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
            end
        end

        for player in pairs(ESP_OBJECTS) do
            RemoveESP(player)
        end

        Window:Destroy()
    end,
})

print("Compact ESP Hub loaded!")
