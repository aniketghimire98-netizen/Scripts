-- AimSystem_Studio.lua
-- For your OWN Roblox Studio experience.
-- Place this as a LocalScript in StarterPlayer > StarterPlayerScripts.
-- This is a normal in-game camera targeting mechanic, not an executor script.
--
-- Features:
--   * Player / NPC target modes
--   * Cycle target
--   * Smooth camera aim
--   * Lock-on toggle
--   * Adjustable range
--
-- NPC setup:
--   Add NPC Models to Workspace and ensure each has a Humanoid and
--   HumanoidRootPart (or Head). Optional: tag NPC models "AimTarget"
--   with CollectionService to restrict NPC targeting to tagged models.

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local CollectionService = game:GetService("CollectionService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local MAX_DISTANCE = 250
local SMOOTHNESS = 0.18
local mode = "Players" -- "Players" or "NPCs"
local lockEnabled = false
local currentTarget = nil

local function getCharacterTargetPart(model)
    if not model then return nil end
    return model:FindFirstChild("HumanoidRootPart")
        or model:FindFirstChild("Head")
end

local function getModelHumanoid(model)
    if not model then return nil end
    return model:FindFirstChildOfClass("Humanoid")
end

local function isAliveModel(model)
    local humanoid = getModelHumanoid(model)
    return humanoid and humanoid.Health > 0 and getCharacterTargetPart(model) ~= nil
end

local function getTargetModel(target)
    if typeof(target) ~= "Instance" then return nil end
    if target:IsA("Player") then
        return target.Character
    end
    if target:IsA("Model") then
        return target
    end
    return nil
end

local function getTargets()
    local targets = {}

    if mode == "Players" then
        for _, player in ipairs(Players:GetPlayers()) do
            if player ~= localPlayer and player.Character and isAliveModel(player.Character) then
                local part = getCharacterTargetPart(player.Character)
                local myCharacter = localPlayer.Character
                local myRoot = myCharacter and getCharacterTargetPart(myCharacter)
                if part and myRoot and (part.Position - myRoot.Position).Magnitude <= MAX_DISTANCE then
                    table.insert(targets, player)
                end
            end
        end
    else
        local tagged = CollectionService:GetTagged("AimTarget")
        local candidates = {}

        if #tagged > 0 then
            for _, item in ipairs(tagged) do
                if item:IsA("Model") then
                    table.insert(candidates, item)
                end
            end
        else
            -- If no models are tagged, scan Workspace for NPC-like models.
            for _, item in ipairs(workspace:GetDescendants()) do
                if item:IsA("Model") and getModelHumanoid(item) then
                    table.insert(candidates, item)
                end
            end
        end

        local playerCharacters = {}
        for _, player in ipairs(Players:GetPlayers()) do
            if player.Character then
                playerCharacters[player.Character] = true
            end
        end

        local myCharacter = localPlayer.Character
        local myRoot = myCharacter and getCharacterTargetPart(myCharacter)

        for _, model in ipairs(candidates) do
            if model ~= myCharacter and not playerCharacters[model] and isAliveModel(model) then
                local part = getCharacterTargetPart(model)
                if part and myRoot and (part.Position - myRoot.Position).Magnitude <= MAX_DISTANCE then
                    table.insert(targets, model)
                end
            end
        end
    end

    local myCharacter = localPlayer.Character
    local myRoot = myCharacter and getCharacterTargetPart(myCharacter)
    if myRoot then
        table.sort(targets, function(a, b)
            local modelA = getTargetModel(a)
            local modelB = getTargetModel(b)
            local partA = getCharacterTargetPart(modelA)
            local partB = getCharacterTargetPart(modelB)
            if not partA then return false end
            if not partB then return true end
            return (partA.Position - myRoot.Position).Magnitude
                < (partB.Position - myRoot.Position).Magnitude
        end)
    end

    return targets
end

local function getTargetName(target)
    if not target then return "None" end
    if target:IsA("Player") then return target.DisplayName .. " (@" .. target.Name .. ")" end
    return target.Name
end

local function setTarget(target)
    currentTarget = target
end

-- WindUI key gate + compact WindUI interface.
-- For your OWN Roblox Studio experience. Keep the key as a simple access gate,
-- not as a security boundary: client-side keys can be read from client scripts.
local WINDUI_URL = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
local KEY_CODE = "Keyedesp"

local WindUI
local ok, result = pcall(function()
    return loadstring(game:HttpGet(WINDUI_URL))()
end)

if ok then
    WindUI = result
else
    warn("WindUI could not be loaded: " .. tostring(result))
    return
end

local Window = WindUI:CreateWindow({
    Title = "Xen Aim System",
    Icon = "target",
    Author = "Xen",
    Folder = "XenAimSystem",
    Size = UDim2.fromOffset(500, 360),
    Transparent = true,
    Theme = "Dark",
})

local keyAccepted = false
local KeyTab = Window:Tab({
    Title = "Key System",
    Icon = "key-round",
})

KeyTab:Paragraph({
    Title = "Access Key Required",
    Desc = "Enter the access key to open the targeting controls.",
})

KeyTab:Input({
    Title = "Access Key",
    Desc = "Enter the key exactly as provided.",
    Placeholder = "Enter key...",
    Callback = function(value)
        if tostring(value) == KEY_CODE then
            keyAccepted = true
            WindUI:Notify({
                Title = "Key Accepted",
                Content = "Access granted. Opening aim controls.",
                Duration = 3,
            })
        else
            keyAccepted = false
            WindUI:Notify({
                Title = "Invalid Key",
                Content = "That key is incorrect.",
                Duration = 3,
            })
        end
    end,
})

KeyTab:Button({
    Title = "Unlock",
    Desc = "Unlock the aim controls after entering the correct key.",
    Callback = function()
        if keyAccepted then
            local success, err = pcall(function()
                Window:SelectTab("Aim")
            end)
            if not success then
                WindUI:Notify({
                    Title = "Key Accepted",
                    Content = "Key accepted. Select the Aim tab to continue.",
                    Duration = 4,
                })
            end
        else
            WindUI:Notify({
                Title = "Key Required",
                Content = "Enter the correct key first.",
                Duration = 3,
            })
        end
    end,
})

local AimTab = Window:Tab({
    Title = "Aim",
    Icon = "crosshair",
})

AimTab:Paragraph({
    Title = "Target Status",
    Desc = "Mode: Players | Target: None",
})

local function refreshTargetLabel()
    -- Paragraph APIs vary across WindUI versions, so update through notifications
    -- only when selecting a target; target state is also printed to output.
    print("[Xen Aim System] Mode:", mode, "Target:", getTargetName(currentTarget))
end

AimTab:Button({
    Title = "Switch Target Mode",
    Desc = "Toggle between Players and NPCs.",
    Callback = function()
        mode = (mode == "Players") and "NPCs" or "Players"
        currentTarget = nil
        WindUI:Notify({
            Title = "Target Mode",
            Content = "Now targeting: " .. mode,
            Duration = 3,
        })
        refreshTargetLabel()
    end,
})

AimTab:Button({
    Title = "Next Target",
    Desc = "Cycle to the next nearby player or NPC.",
    Callback = function()
        local targets = getTargets()
        if #targets == 0 then
            currentTarget = nil
            WindUI:Notify({
                Title = "No Targets",
                Content = "No valid targets found in range.",
                Duration = 3,
            })
        else
            local index = 0
            for i, target in ipairs(targets) do
                if target == currentTarget then
                    index = i
                    break
                end
            end
            currentTarget = targets[(index % #targets) + 1]
            WindUI:Notify({
                Title = "Target Selected",
                Content = getTargetName(currentTarget),
                Duration = 3,
            })
        end
        refreshTargetLabel()
    end,
})

AimTab:Toggle({
    Title = "Lock-On Camera",
    Desc = "Smoothly focus the camera on the selected target.",
    Value = false,
    Callback = function(value)
        lockEnabled = value
    end,
})

AimTab:Slider({
    Title = "Target Range",
    Desc = "Maximum target distance in studs.",
    Step = 50,
    Value = {
        Min = 50,
        Max = 1000,
        Default = MAX_DISTANCE,
    },
    Callback = function(value)
        MAX_DISTANCE = tonumber(value) or MAX_DISTANCE
    end,
})

AimTab:Button({
    Title = "Unload",
    Desc = "Stop camera targeting and close this UI.",
    Callback = function()
        lockEnabled = false
        RunService:UnbindFromRenderStep("StudioAimSystemCamera")
        Window:Destroy()
    end,
})

RunService:BindToRenderStep("StudioAimSystemCamera", Enum.RenderPriority.Camera.Value + 1, function()
    camera = workspace.CurrentCamera
    rangeLabel.Text = "Range: " .. MAX_DISTANCE .. " studs"

    if not lockEnabled or not currentTarget then
        return
    end

    local model = getTargetModel(currentTarget)
    if not model or not model.Parent or not isAliveModel(model) then
        currentTarget = nil
        refreshTargetLabel()
        return
    end

    local targetPart = getCharacterTargetPart(model)
    local myCharacter = localPlayer.Character
    local myRoot = myCharacter and getCharacterTargetPart(myCharacter)

    if not targetPart or not myRoot then
        return
    end

    if (targetPart.Position - myRoot.Position).Magnitude > MAX_DISTANCE then
        currentTarget = nil
        refreshTargetLabel()
        return
    end

    local desired = CFrame.lookAt(camera.CFrame.Position, targetPart.Position)
    camera.CFrame = camera.CFrame:Lerp(desired, math.clamp(SMOOTHNESS, 0.01, 1))
end)

script.Destroying:Connect(function()
    RunService:UnbindFromRenderStep("StudioAimSystemCamera")
end)

refreshTargetLabel()
