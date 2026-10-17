-- Universal ESP Hub
-- For your own Roblox Studio game
-- UI: Wind UI

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local LocalPlayer = Players.LocalPlayer

local WindUI = loadstring(game:HttpGet(
    "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
))()

local Window = WindUI:CreateWindow({
    Title = "Universal ESP Hub",
    Icon = "eye",
    Author = "Xen",
    Folder = "UniversalESP",
    Size = UDim2.fromOffset(580, 460),
    Transparent = true,
    Theme = "Dark",
})

local ESPEnabled = false
local NamesEnabled = true
local HighlightsEnabled = true
local TeamCheck = false
local MaxDistance = 1000

local ESPObjects = {}

local function clearESP(player)
    local data = ESPObjects[player]
    if not data then return end

    if data.highlight then
        data.highlight:Destroy()
    end

    if data.billboard then
        data.billboard:Destroy()
    end

    ESPObjects[player] = nil
end

local function createESP(player)
    if player == LocalPlayer then return end
    clearESP(player)

    local character = player.Character
    if not character then return end

    local root = character:FindFirstChild("HumanoidRootPart")
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if not root or not humanoid then return end

    local highlight = Instance.new("Highlight")
    highlight.Name = "UniversalESPHighlight"
    highlight.FillColor = Color3.fromRGB(0, 100, 255)
    highlight.OutlineColor = Color3.fromRGB(80, 180, 255)
    highlight.FillTransparency = 0.65
    highlight.OutlineTransparency = 0
    highlight.Adornee = character
    highlight.Enabled = HighlightsEnabled
    highlight.Parent = character

    local billboard = Instance.new("BillboardGui")
    billboard.Name = "UniversalESPLabel"
    billboard.Adornee = root
    billboard.Size = UDim2.fromOffset(200, 45)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true
    billboard.Enabled = NamesEnabled
    billboard.Parent = root

    local label = Instance.new("TextLabel")
    label.Size = UDim2.fromScale(1, 1)
    label.BackgroundTransparency = 1
    label.TextColor3 = Color3.fromRGB(80, 180, 255)
    label.TextStrokeTransparency = 0.3
    label.TextScaled = true
    label.Font = Enum.Font.GothamBold
    label.Parent = billboard

    ESPObjects[player] = {
        highlight = highlight,
        billboard = billboard,
        label = label,
    }
end

local function refreshESP()
    for _, player in ipairs(Players:GetPlayers()) do
        clearESP(player)
        if ESPEnabled then
            createESP(player)
        end
    end
end

local ESPTab = Window:Tab({
    Title = "ESP",
    Icon = "eye",
})

ESPTab:Toggle({
    Title = "Enable Player ESP",
    Default = false,
    Callback = function(value)
        ESPEnabled = value
        refreshESP()
    end,
})

ESPTab:Toggle({
    Title = "Player Names & Distance",
    Default = true,
    Callback = function(value)
        NamesEnabled = value
        for _, data in pairs(ESPObjects) do
            data.billboard.Enabled = value
        end
    end,
})

ESPTab:Toggle({
    Title = "Highlight ESP",
    Default = true,
    Callback = function(value)
        HighlightsEnabled = value
        for _, data in pairs(ESPObjects) do
            data.highlight.Enabled = value
        end
    end,
})

ESPTab:Toggle({
    Title = "Team Check",
    Default = false,
    Callback = function(value)
        TeamCheck = value
    end,
})

ESPTab:Button({
    Title = "Refresh ESP",
    Callback = function()
        refreshESP()
    end,
})

local SettingsTab = Window:Tab({
    Title = "Settings",
    Icon = "settings",
})

SettingsTab:Slider({
    Title = "Maximum ESP Distance",
    Value = {
        Min = 100,
        Max = 2000,
        Default = 1000,
    },
    Callback = function(value)
        MaxDistance = value
    end,
})

RunService.RenderStepped:Connect(function()
    for player, data in pairs(ESPObjects) do
        local character = player.Character
        local root = character and character:FindFirstChild("HumanoidRootPart")
        local humanoid = character and character:FindFirstChildOfClass("Humanoid")
        local myCharacter = LocalPlayer.Character
        local myRoot = myCharacter and myCharacter:FindFirstChild("HumanoidRootPart")

        if not root or not humanoid or not myRoot then
            data.billboard.Enabled = false
            data.highlight.Enabled = false
            continue
        end

        local distance = (root.Position - myRoot.Position).Magnitude
        local sameTeam = TeamCheck
            and LocalPlayer.Team ~= nil
            and player.Team == LocalPlayer.Team

        local visible = ESPEnabled
            and distance <= MaxDistance
            and not sameTeam
            and humanoid.Health > 0

        data.billboard.Enabled = visible and NamesEnabled
        data.highlight.Enabled = visible and HighlightsEnabled

        data.label.Text = string.format(
            "%s\nHP: %d | %.0f studs",
            player.DisplayName,
            humanoid.Health,
            distance
        )
    end
end)

Players.PlayerAdded:Connect(function(player)
    player.CharacterAdded:Connect(function()
        task.wait(1)
        if ESPEnabled then
            createESP(player)
        end
    end)
end)

Players.PlayerRemoving:Connect(clearESP)

SettingsTab:Button({
    Title = "Unload Hub",
    Callback = function()
        ESPEnabled = false
        for player in pairs(ESPObjects) do
            clearESP(player)
        end
        Window:Destroy()
    end,
})
