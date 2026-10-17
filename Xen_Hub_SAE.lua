-- Xen Hub SAE | WindUI Blue Edition
-- Auto features ported from NSR Nasi Rendang script.
-- Requires the NSR steal module (tbl / steal) to be loaded in the same executor session.
-- If the steal module is NOT loaded, auto features will show a notification and do nothing.

local Players = game:GetService("Players")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local Workspace = game:GetService("Workspace")
local player = Players.LocalPlayer

local WINDUI_URL = "https://github.com/Footagesus/WindUI/releases/latest/download/main.lua"
local ok, WindUI = pcall(function()
    return loadstring(game:HttpGet(WINDUI_URL))()
end)
if not ok or not WindUI then
    warn("[Xen Hub SAE] WindUI failed to load.")
    return
end

local BLUE      = Color3.fromRGB(45, 135, 255)
local DARK_BLUE = Color3.fromRGB(12, 24, 46)
local LOGO_ASSET  = "rbxassetid://80181657463949"
local REQUIRED_KEY = "XenOwnerOnly"

-- ─── State ────────────────────────────────────────────────────────────────────
local notificationsEnabled  = true
local loadedTabs            = false
local fpsBoostOn            = false
local cleanVisualsOn        = false
local autoRejoinOn          = false
local autoRejoinBusy        = false
local autoVisualCleanupOn   = false
local disabledEffects       = {}
local originalLighting = {
    GlobalShadows           = Lighting.GlobalShadows,
    Brightness              = Lighting.Brightness,
    EnvironmentDiffuseScale = Lighting.EnvironmentDiffuseScale,
    EnvironmentSpecularScale= Lighting.EnvironmentSpecularScale,
}

-- ─── NSR steal module reference (populated lazily) ───────────────────────────
-- The NSR script stores its steal table in the shared environment.
-- We look it up at toggle-time so this hub works even if the NSR script is
-- loaded after this hub.
local function getSteal()
    return rawget(getgenv and getgenv() or {}, "steal")
        or rawget(getfenv and getfenv(0) or {}, "steal")
        or (rawget(shared, "steal"))
        or nil
end

-- ─── Notifications ────────────────────────────────────────────────────────────
local function notify(title, content, duration)
    if not notificationsEnabled then return end
    pcall(function()
        WindUI:Notify({
            Title    = title,
            Content  = content,
            Duration = duration or 4,
            Icon     = "info",
        })
    end)
end

local function notifyNoModule()
    notify("NSR Module Missing",
        "The NSR steal module (tbl/steal) is not loaded. Load it first, then toggle again.", 6)
end

-- ─── Window ───────────────────────────────────────────────────────────────────
local Window = WindUI:CreateWindow({
    Title       = "Xen Hub SAE",
    Icon        = LOGO_ASSET,
    Author      = "Xen",
    Folder      = "XenHubSAE",
    Size        = UDim2.fromOffset(600, 520),
    Transparent = true,
    Theme       = "Dark",
    User        = { Enabled = true, Anonymous = false },
})

pcall(function()
    Window:SetTheme({
        Accent     = BLUE,
        Background = DARK_BLUE,
        Outline    = Color3.fromRGB(35, 75, 130),
        Text       = Color3.fromRGB(235, 243, 255),
    })
end)

-- ─── Access tab (always visible) ──────────────────────────────────────────────
local AccessTab = Window:Tab({ Title = "Access", Icon = "key-round" })
AccessTab:Paragraph({
    Title = "Xen Hub SAE",
    Desc  = "Blue Edition • Enter the owner key to open the utility tabs.",
})
local enteredKey = ""
AccessTab:Input({
    Title       = "Owner Key",
    Placeholder = "Enter key...",
    Callback    = function(value) enteredKey = tostring(value or "") end,
})

-- ─── Visual helpers ───────────────────────────────────────────────────────────
local function applyVisualSettings()
    local effectsShouldBeDisabled = fpsBoostOn or cleanVisualsOn
    if fpsBoostOn then
        Lighting.GlobalShadows             = false
        Lighting.EnvironmentDiffuseScale   = 0
        Lighting.EnvironmentSpecularScale  = 0
    else
        Lighting.GlobalShadows             = originalLighting.GlobalShadows
        Lighting.EnvironmentDiffuseScale   = originalLighting.EnvironmentDiffuseScale
        Lighting.EnvironmentSpecularScale  = originalLighting.EnvironmentSpecularScale
    end
    if effectsShouldBeDisabled then
        for _, obj in ipairs(Lighting:GetDescendants()) do
            if obj:IsA("PostEffect") then
                if disabledEffects[obj] == nil then disabledEffects[obj] = obj.Enabled end
                obj.Enabled = false
            end
        end
    else
        for effect, wasEnabled in pairs(disabledEffects) do
            if effect and effect.Parent then
                pcall(function() effect.Enabled = wasEnabled end)
            end
        end
        table.clear(disabledEffects)
    end
end

local function setFpsBoost(enabled)
    fpsBoostOn = enabled
    applyVisualSettings()
    notify("FPS Boost", enabled
        and "Reduced local shadows and post-processing effects."
        or "FPS Boost disabled; saved visual settings restored.")
end

local function setCleanVisuals(enabled)
    cleanVisualsOn = enabled
    applyVisualSettings()
    notify("Visual Cleanup", enabled
        and "Local post-processing effects are disabled."
        or "Visual cleanup disabled; saved effect states restored.")
end

-- Keep newly-created local post-processing effects consistent with active visual toggles.
Lighting.DescendantAdded:Connect(function(object)
    if autoVisualCleanupOn and (fpsBoostOn or cleanVisualsOn) and object:IsA("PostEffect") then
        if disabledEffects[object] == nil then disabledEffects[object] = object.Enabled end
        object.Enabled = false
    end
end)

-- Auto-rejoin retries a failed teleport; does not bypass game access controls.
TeleportService.TeleportInitFailed:Connect(function(failedPlayer, result)
    if failedPlayer ~= player or not autoRejoinOn or autoRejoinBusy then return end
    autoRejoinBusy = true
    notify("Auto Rejoin", "Teleport failed (" .. tostring(result) .. "). Retrying shortly.")
    task.delay(3, function()
        if autoRejoinOn and player and player.Parent then
            pcall(function() TeleportService:Teleport(game.PlaceId, player) end)
        end
        task.delay(5, function() autoRejoinBusy = false end)
    end)
end)

-- ─── Main utility tabs (unlocked by key) ──────────────────────────────────────
local function createUtilityTabs()
    if loadedTabs then return end
    loadedTabs = true

    local HomeTab        = Window:Tab({ Title = "Home",        Icon = "house"       })
    local PerformanceTab = Window:Tab({ Title = "Performance", Icon = "gauge"        })
    local AutoTab        = Window:Tab({ Title = "Auto",        Icon = "repeat"       })
    local StealTab       = Window:Tab({ Title = "Steal",       Icon = "hand"         })
    local EventsTab      = Window:Tab({ Title = "Events",      Icon = "star"         })
    local VisualTab      = Window:Tab({ Title = "Visuals",     Icon = "eye"          })
    local GameInfoTab    = Window:Tab({ Title = "Game Info",   Icon = "gamepad-2"    })
    local SettingsTab    = Window:Tab({ Title = "Settings",    Icon = "settings"     })
    local LogsTab        = Window:Tab({ Title = "Logs",        Icon = "scroll-text"  })

    -- ── Home ──────────────────────────────────────────────────────────────────
    HomeTab:Paragraph({
        Title = "Welcome to Xen Hub SAE",
        Desc  = "Brand: Xen Hub SAE\nTag: Xen\nTheme: Blue\nLogo asset: 80181657463949",
    })
    HomeTab:Paragraph({
        Title = "Current Session",
        Desc  = "Player: " .. player.Name
              .. "\nUser ID: " .. tostring(player.UserId)
              .. "\nPlace ID: " .. tostring(game.PlaceId),
    })
    HomeTab:Button({
        Title    = "Refresh Session Info",
        Icon     = "refresh-cw",
        Callback = function()
            local s = getSteal()
            local stealInfo = s
                and ("\nSteal Claims: " .. tostring(s.Claims or 0)
                   .. "  |  Fails: " .. tostring(s.Fails or 0)
                   .. "  |  Activity: " .. tostring(s.Activity or "idle"))
                or "\nNSR steal module: not loaded"
            notify("Session Info",
                player.Name .. " • UID " .. tostring(player.UserId)
                .. " • Place " .. tostring(game.PlaceId) .. stealInfo, 6)
        end,
    })

    -- ── Performance ───────────────────────────────────────────────────────────
    PerformanceTab:Paragraph({
        Title = "Performance Utilities",
        Desc  = "These toggles change local visual settings only. They do not change server gameplay.",
    })
    PerformanceTab:Toggle({
        Title    = "FPS Boost",
        Desc     = "Disable local shadows and post-processing effects; restore saved settings when off.",
        Value    = false,
        Callback = function(value)
            local ok2, err = pcall(setFpsBoost, value)
            if not ok2 then warn("[Xen Hub SAE] FPS Boost error: " .. tostring(err)) end
        end,
    })

    -- ── Auto (quality-of-life) ────────────────────────────────────────────────
    AutoTab:Paragraph({
        Title = "Safe Automation",
        Desc  = "Client quality-of-life toggles. Auto Steal features are on the Steal tab.",
    })
    AutoTab:Toggle({
        Title    = "Auto Rejoin on Teleport Failure",
        Desc     = "Retries joining the current place if a teleport request fails.",
        Value    = false,
        Callback = function(value)
            autoRejoinOn = value
            notify("Auto Rejoin", value and "Enabled for teleport failures." or "Disabled.")
        end,
    })
    AutoTab:Toggle({
        Title    = "Auto Apply Visual Cleanup",
        Desc     = "When FPS Boost or Visual Cleanup is active, newly added local post-effects are disabled too.",
        Value    = false,
        Callback = function(value)
            autoVisualCleanupOn = value
            notify("Auto Visual Cleanup", value and "Enabled." or "Disabled.")
        end,
    })

    -- ── Steal tab ─────────────────────────────────────────────────────────────
    StealTab:Paragraph({
        Title = "Auto Steal — NSR Module",
        Desc  = "Requires the NSR Nasi Rendang steal module (tbl/steal) to be loaded first.\nAll toggles call steal.Start / steal.Stop and the sub-modules from that script.",
    })

    -- Auto Steal Eggs
    StealTab:Toggle({
        Title    = "Auto Steal Eggs",
        Desc     = "Starts the main egg-steal loop (steal.Start). Disable to stop.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s then notifyNoModule() return end
            if value then
                pcall(s.Start)
                notify("Auto Steal", "Egg steal loop started.")
            else
                pcall(s.Stop)
                notify("Auto Steal", "Egg steal loop stopped."
                    .. " Claims: " .. tostring(s.Claims or 0)
                    .. " | Fails: " .. tostring(s.Fails or 0))
            end
        end,
    })

    -- Instant Steal (Admin Abuse)
    StealTab:Toggle({
        Title    = "Instant Steal (Admin Abuse)",
        Desc     = "TP to egg → pick up → TP to safe zone. Only works during an Admin Abuse event.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.Instant then notifyNoModule() return end
            pcall(s.Instant, value)
            notify("Instant Steal", value
                and "Enabled — works ONLY during Admin Abuse event!"
                or "Disabled.")
        end,
    })

    -- Real Godmode
    StealTab:Toggle({
        Title    = "Real Godmode (Aura Bat + Anti Ragdoll)",
        Desc     = "steal.GOD — spoofs motor6D to prevent death animations.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.GOD and s.GOD.Start) then notifyNoModule() return end
            if value then pcall(s.GOD.Start) else pcall(s.GOD.Stop) end
            notify("Real Godmode", value and "Enabled." or "Disabled.")
        end,
    })

    -- Anti Hit Guard
    StealTab:Toggle({
        Title    = "Anti Hit Guard",
        Desc     = "steal.AHG — prevents the hit-guard from triggering while carrying an egg.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.AHG and s.AHG.Start) then notifyNoModule() return end
            if value then
                -- stop main steal if running
                if s.Running then pcall(s.Stop) end
                pcall(s.AHG.Start)
                notify("Anti Hit Guard", "Enabled.")
            else
                pcall(s.AHG.Stop)
                notify("Anti Hit Guard", "Disabled.")
            end
        end,
    })

    -- Auto Treadmill
    StealTab:Toggle({
        Title    = "Auto Treadmill",
        Desc     = "steal.TM — automatically walks the treadmill for speed boosts.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.TM and s.TM.Start) then notifyNoModule() return end
            if value then pcall(s.TM.Start) else pcall(s.TM.Stop) end
            notify("Auto Treadmill", value and "Enabled." or "Disabled.")
        end,
    })

    -- Instant Carry
    StealTab:Toggle({
        Title    = "Instant Carry Rare Egg (Manual Steal)",
        Desc     = "steal.IC — instantly picks up and carries a rare egg on touch.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.IC and s.IC.Start) then notifyNoModule() return end
            if value then pcall(s.IC.Start) else pcall(s.IC.Stop) end
            notify("Instant Carry", value and "Enabled." or "Disabled.")
        end,
    })

    -- One Tap Steal
    StealTab:Toggle({
        Title    = "One Tap Steal (No Hold)",
        Desc     = "steal.TAP — removes the hold requirement from egg-steal prompts.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.TAP and s.TAP.Sync) then notifyNoModule() return end
            -- TAP uses a Sync method that reads UIX; we set the flag directly
            if s.TAP.on ~= nil then s.TAP.on = value end
            pcall(s.TAP.Sync)
            notify("One Tap Steal", value and "Enabled." or "Disabled.")
        end,
    })

    -- Invisible Mode
    StealTab:Toggle({
        Title    = "Invisible Mode",
        Desc     = "steal.INVIS — makes your character invisible while stealing.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.INVIS and s.INVIS.Start) then notifyNoModule() return end
            if value then pcall(s.INVIS.Start) else pcall(s.INVIS.Stop) end
            notify("Invisible Mode", value and "Enabled." or "Disabled.")
        end,
    })

    -- Auto Hatch
    StealTab:Toggle({
        Title    = "Auto Hatch (Stolen Eggs)",
        Desc     = "steal.HATCH — automatically hatches eggs carried to your pen.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.HATCH and s.HATCH.Start) then notifyNoModule() return end
            if value then pcall(s.HATCH.Start) else pcall(s.HATCH.Stop) end
            notify("Auto Hatch", value and "Enabled." or "Disabled.")
        end,
    })

    -- Steal Speed Slider
    StealTab:Slider({
        Title    = "Auto Steal Speed %",
        Desc     = "Sets steal.SPEED_PCT — percentage of speed cap used during the steal loop.",
        Value    = 85,
        Min      = 10,
        Max      = 100,
        Callback = function(value)
            local s = getSteal()
            if not s then return end
            s.SPEED_PCT = value
        end,
    })

    -- Instant Steal Speed
    StealTab:Slider({
        Title    = "Instant Steal Force Speed (studs/s)",
        Desc     = "steal.INSTANT.LAJU — forced speed used in Instant Steal mode.",
        Value    = 3000,
        Min      = 500,
        Max      = 5000,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.INSTANT then return end
            s.INSTANT.LAJU = value
        end,
    })

    StealTab:Paragraph({
        Title = "Steal Status",
        Desc  = "Use Home > Refresh Session Info to see live claim/fail counts.",
    })

    -- ── Events tab ────────────────────────────────────────────────────────────
    EventsTab:Paragraph({
        Title = "Event Automation — NSR Module",
        Desc  = "Auto features for in-game events. Requires NSR steal module.",
    })

    -- Scramble Lab
    EventsTab:Toggle({
        Title    = "Auto Scramble Lab",
        Desc     = "steal.LAB — runs the Scramble Lab egg-stealing cycle automatically.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.LAB and s.LAB.Start) then notifyNoModule() return end
            if value then pcall(s.LAB.Start) else pcall(s.LAB.Stop) end
            notify("Scramble Lab", value and "Auto loop started." or "Stopped.")
        end,
    })

    -- Shooting Star
    EventsTab:Toggle({
        Title    = "Auto Catch Shooting Star",
        Desc     = "steal.STAR — teleports to and catches the shooting star when it spawns.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.STAR then notifyNoModule() return end
            -- STAR uses Start/Stop stored on the sub-table
            if value then
                pcall(function() s.STAR.Start() end)
            else
                pcall(function() s.STAR.Stop() end)
            end
            notify("Shooting Star", value and "Watching for stars." or "Stopped.")
        end,
    })

    -- Auto Race Rally
    EventsTab:Toggle({
        Title    = "Auto Race Rally",
        Desc     = "steal.RACE — joins and auto-runs the Race Rally event.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.RACE then notifyNoModule() return end
            if value then
                pcall(function() s.RACE.Start() end)
            else
                pcall(function() s.RACE.Stop() end)
            end
            notify("Race Rally", value and "Auto race enabled." or "Stopped.")
        end,
    })

    -- Race Speed
    EventsTab:Slider({
        Title    = "Race Speed (studs/s)",
        Desc     = "steal.RACE.LAJU_RAIL — movement speed used during auto race.",
        Value    = 270,
        Min      = 50,
        Max      = 600,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.RACE then return end
            s.RACE.LAJU_RAIL = value
        end,
    })

    -- Wisp Event
    EventsTab:Toggle({
        Title    = "Auto Wisp Event",
        Desc     = "steal.WISP — handles the wisp collection event automatically.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.WISP then notifyNoModule() return end
            if value then
                pcall(function() s.WISP.Start() end)
            else
                pcall(function() s.WISP.Stop() end)
            end
            notify("Wisp Event", value and "Auto wisp started." or "Stopped.")
        end,
    })

    EventsTab:Paragraph({
        Title = "Admin Abuse",
        Desc  = "The following features only work during an Admin Abuse event.",
    })

    -- AA: Instant Steal (duplicate shortcut on Events for convenience)
    EventsTab:Toggle({
        Title    = "AA — Instant Steal",
        Desc     = "steal.Instant — TP-grab method. Works only during an Admin Abuse event.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.Instant then notifyNoModule() return end
            pcall(s.Instant, value)
            notify("AA Instant Steal", value and "Enabled (Admin Abuse only)!" or "Disabled.")
        end,
    })

    -- AA: Auto Capture The Egg
    EventsTab:Toggle({
        Title    = "AA — Auto Capture The Egg",
        Desc     = "steal.AA.CTE — auto-captures the egg during Admin Abuse event.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.AA and s.AA.CTE and s.AA.CTE.Start) then notifyNoModule() return end
            if value then pcall(s.AA.CTE.Start) else pcall(s.AA.CTE.Stop) end
            notify("AA Capture Egg", value and "Enabled." or "Disabled.")
        end,
    })

    -- AA: Auto Collect Rings
    EventsTab:Toggle({
        Title    = "AA — Auto Collect Rings",
        Desc     = "steal.AA.RING — Light vs Darkness ring collector.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.AA and s.AA.RING and s.AA.RING.Start) then notifyNoModule() return end
            if value then pcall(s.AA.RING.Start) else pcall(s.AA.RING.Stop) end
            notify("AA Collect Rings", value and "Enabled." or "Disabled.")
        end,
    })

    -- AA: Rare Egg ESP
    EventsTab:Toggle({
        Title    = "AA — Rare Egg ESP",
        Desc     = "steal.AA.ESP — highlights rare eggs within ESP distance.",
        Value    = false,
        Callback = function(value)
            local s = getSteal()
            if not s or not (s.AA and s.AA.ESP and s.AA.ESP.Start) then notifyNoModule() return end
            if value then pcall(s.AA.ESP.Start) else pcall(s.AA.ESP.Stop) end
            notify("Rare Egg ESP", value and "Enabled." or "Disabled.")
        end,
    })

    -- AA: ESP Distance
    EventsTab:Slider({
        Title    = "AA — ESP Distance (studs)",
        Desc     = "steal.AA.ESP.JARAK — maximum stud range for Rare Egg ESP.",
        Value    = 1500,
        Min      = 200,
        Max      = 5000,
        Callback = function(value)
            local s = getSteal()
            if not s or not s.AA then return end
            if s.AA.ESP then s.AA.ESP.JARAK = value end
        end,
    })

    -- ── Visuals ───────────────────────────────────────────────────────────────
    VisualTab:Paragraph({
        Title = "Visual Cleanup",
        Desc  = "Disable or restore local post-processing effects.",
    })
    VisualTab:Toggle({
        Title    = "Clean Post-Processing",
        Desc     = "Turns off local Bloom, Blur, ColorCorrection, SunRays and similar PostEffects.",
        Value    = false,
        Callback = function(value)
            local ok2, err = pcall(setCleanVisuals, value)
            if not ok2 then warn("[Xen Hub SAE] Visual cleanup error: " .. tostring(err)) end
        end,
    })

    -- ── Game Info ─────────────────────────────────────────────────────────────
    GameInfoTab:Paragraph({
        Title = "Game Information",
        Desc  = "Game: " .. tostring(game.Name)
              .. "\nPlace ID: " .. tostring(game.PlaceId)
              .. "\nJob ID: " .. tostring(game.JobId),
    })
    GameInfoTab:Button({
        Title    = "Copy Place ID",
        Icon     = "copy",
        Callback = function()
            if typeof(setclipboard) == "function" then
                local s = pcall(setclipboard, tostring(game.PlaceId))
                notify("Copy Place ID", s and "Place ID copied." or "Clipboard access failed.")
            else
                notify("Copy Place ID", "Clipboard API is not available in this environment.")
            end
        end,
    })
    GameInfoTab:Button({
        Title    = "Copy Job ID",
        Icon     = "copy",
        Callback = function()
            if typeof(setclipboard) == "function" then
                local s = pcall(setclipboard, tostring(game.JobId))
                notify("Copy Job ID", s and "Job ID copied." or "Clipboard access failed.")
            else
                notify("Copy Job ID", "Clipboard API is not available in this environment.")
            end
        end,
    })

    -- ── Settings ──────────────────────────────────────────────────────────────
    SettingsTab:Toggle({
        Title    = "UI Notifications",
        Desc     = "Enable or disable Xen Hub pop-up notifications.",
        Value    = true,
        Callback = function(value)
            notificationsEnabled = value
            if value then notify("Settings", "Notifications enabled.") end
        end,
    })
    SettingsTab:Button({
        Title    = "Stop All Auto Features (NSR)",
        Icon     = "square",
        Callback = function()
            local s = getSteal()
            if s then
                pcall(s.Stop)
                if s.LAB  and s.LAB.Stop  then pcall(s.LAB.Stop)  end
                if s.GOD  and s.GOD.Stop  then pcall(s.GOD.Stop)  end
                if s.AHG  and s.AHG.Stop  then pcall(s.AHG.Stop)  end
                if s.TM   and s.TM.Stop   then pcall(s.TM.Stop)   end
                if s.IC   and s.IC.Stop   then pcall(s.IC.Stop)   end
                if s.TAP  and s.TAP.Stop  then pcall(s.TAP.Stop)  end
                if s.INVIS and s.INVIS.Stop then pcall(s.INVIS.Stop) end
                if s.HATCH and s.HATCH.Stop then pcall(s.HATCH.Stop) end
                if s.RACE and s.RACE.Stop then pcall(function() s.RACE.Stop() end) end
                if s.AA   and s.AA.CTE  and s.AA.CTE.Stop  then pcall(s.AA.CTE.Stop)  end
                if s.AA   and s.AA.RING and s.AA.RING.Stop then pcall(s.AA.RING.Stop) end
                if s.AA   and s.AA.ESP  and s.AA.ESP.Stop  then pcall(s.AA.ESP.Stop)  end
                if s.Instant then pcall(s.Instant, false) end
                notify("All Auto Features", "All NSR auto features stopped.", 5)
            else
                notify("All Auto Features", "NSR module not loaded — nothing to stop.", 4)
            end
        end,
    })
    SettingsTab:Button({
        Title    = "Restore Visual Defaults",
        Icon     = "rotate-ccw",
        Callback = function()
            setFpsBoost(false)
            setCleanVisuals(false)
            Lighting.Brightness = originalLighting.Brightness
            notify("Settings", "Saved visual settings restored.")
        end,
    })
    SettingsTab:Button({
        Title    = "Unload Xen Hub",
        Icon     = "power",
        Callback = function()
            pcall(function() setFpsBoost(false)   end)
            pcall(function() setCleanVisuals(false) end)
            pcall(function() Window:Destroy()      end)
        end,
    })

    -- ── Logs ──────────────────────────────────────────────────────────────────
    LogsTab:Paragraph({
        Title = "Session Log",
        Desc  = "Xen Hub SAE loaded successfully.\n"
              .. "Auto/Steal/Events tabs require NSR steal module (tbl/steal) in shared environment.\n"
              .. "Visual and Performance tabs are standalone.",
    })
    LogsTab:Button({
        Title    = "Check NSR Module Status",
        Icon     = "search",
        Callback = function()
            local s = getSteal()
            if s then
                notify("NSR Module", "Loaded ✓\nActivity: " .. tostring(s.Activity or "idle")
                    .. "\nRunning: " .. tostring(s.Running or false)
                    .. "\nClaims: " .. tostring(s.Claims or 0)
                    .. " | Fails: " .. tostring(s.Fails or 0), 7)
            else
                notify("NSR Module", "NOT loaded ✗\nLoad the NSR Nasi Rendang script first.", 6)
            end
        end,
    })

    notify("Xen Hub SAE", "Access granted. All utility tabs are ready.", 5)
end

-- ─── Key button ───────────────────────────────────────────────────────────────
AccessTab:Button({
    Title    = "Unlock Xen Hub",
    Icon     = "lock-open",
    Callback = function()
        if enteredKey == REQUIRED_KEY then
            createUtilityTabs()
        else
            notify("Invalid Key", "The key was not accepted.", 4)
        end
    end,
})

notify("Xen Hub SAE", "Loaded. Enter the key to open the utility tabs.", 5)
