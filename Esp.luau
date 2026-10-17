-- Compact Box ESP Hub
-- Wind UI | Roblox Studio
-- Features: Player Name, Distance, Box Highlight

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

-- Load Wind UI
local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "Compact ESP",
    Icon = "eye",
    Author = "Xen",
    Folder = "CompactESP",
    Size = UDim2.fromOffset(520, 400),
    Transparent = true,
    Theme = "Dark",
})

-- Remove ESP
local function removeESP(player)
    local data = ESP_OBJECTS[player]

    if data then
        if data.Highlight then
            data.Highlight:Destroy()
        end

        if data.Billboard then
            data.Billboard:Destroy()
        end

        ESP_OBJECTS[player] = nil
    end
end

-- Create ESP
local function createESP(player)
    if player == LocalPlayer then
        return
    end

    removeESP(player)

    local character = player.Character
    if not character then
        return
    end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")

    if not root or not humanoid then
        return
    end

    -- Box-style character highlight
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

    -- Small name and distance label
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
local function refreshESP()
    for _, player in ipairs(Players:GetPlayers()) do
        removeESP(player)

        if ESP_ENABLED then
            createESP(player)
        end
    end
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
        refreshESP()
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
    Title = "Refresh Players",
    Callback = function()
        refreshESP()
    end,
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

-- Update labels and visibility
Connections.Update = RunService.RenderStepped:Connect(function()
    local myCharacter = LocalPlayer.Character
    local myRoot = myCharacter
        and myCharacter:FindFirstChild("HumanoidRootPart")

    if not myRoot then
        return
    end

    for player, data in pairs(ESP_OBJECTS) do
        local character = player.Character
        local root = character
            and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character
            and character:FindFirstChildOfClass("Humanoid")

        if root and humanoid then
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
        else
            data.Billboard.Enabled = false
            data.Highlight.Enabled = false
        end
    end
end)

-- Handle new players
Connections.PlayerAdded = Players.PlayerAdded:Connect(function(player)
    Connections[player] = player.CharacterAdded:Connect(function()
        task.wait(0.5)

        if ESP_ENABLED then
            createESP(player)
        end
    end)

    if player.Character and ESP_ENABLED then
        createESP(player)
    end
end)

Connections.PlayerRemoving = Players.PlayerRemoving:Connect(function(player)
    removeESP(player)

    if Connections[player] then
        Connections[player]:Disconnect()
        Connections[player] = nil
    end
end)

-- Unload
SettingsTab:Button({
    Title = "Unload Hub",
    Callback = function()
        for _, connection in pairs(Connections) do
            if typeof(connection) == "RBXScriptConnection" then
                connection:Disconnect()
            end
        end

        for player in pairs(ESP_OBJECTS) do
            removeESP(player)
        end

        Window:Destroy()
    end,
})

print("Compact ESP Hub loaded successfully!")
