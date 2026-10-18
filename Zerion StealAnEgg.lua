-- discord.gg/syncrypt

local v1 = ...
local CFrame_ = CFrame
local cFrameNew = CFrame_ and CFrame_.new
local lookAt = CFrame_ and CFrame_.lookAt
local Angles = CFrame_ and CFrame_.Angles
local v6 = v1

local function v7(p1)
	if type(p1) ~= "function" then
		return false
	end

	local ok, result = pcall(p1, "e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e065224901555fb8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b", "", "d75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a")

	if not ok or result ~= true then
		return false
	end

	local ok2, result2 = pcall(p1, ("e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e065224901555fb8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b"):sub(1, 126) .. "00", "", "d75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a")

	if not ok2 or result2 ~= false then
		return false
	end

	local ok3, result3 = pcall(p1, "e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e065224901555fb8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b", "zeroin_differential_test", "d75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a")

	if not ok3 or result3 ~= false then
		return false
	end

	local ok4, result4 = pcall(p1, "e5564300c360ac729086e2cc806e828a84877f1eb8e5d974d873e065224901555fb8821590a33bacc61e39701cf9b46bd25bf5f0595bbe24655141438e7a100b", "", ("d75a980182b10ab7d54bfed3c964073a0ee172f3daa62325af021a68f707511a"):sub(1, 62) .. "00")

	if ok4 and result4 == false then
		return true
	end

	return false
end
local function v16(p2)
	if type(p2) ~= "table" or p2.valid ~= true then
		return false, "Execution rejected: Script was not launched via Zeroin Key System."
	end

	local ok, result = pcall(function()
		return game:GetService("RbxAnalyticsService"):GetClientId()
	end)
	local v19 = ok and result and result ~= "" and tostring(result) or tostring(game:GetService("Players").LocalPlayer.UserId)

	if tostring(p2.hwid) ~= v19 then
		return false, "Hardware ID mismatch: Unauthorized device detected."
	end

	local now = os.time()
	local v21 = now - (tonumber(p2.timestamp) or tonumber(p2.sessionTime) or now)

	if v21 > 300 or v21 < -100 then
		return false, "Session expired: Please re-authenticate via Zeroin Key System."
	end

	if not p2.signature or not p2.nonce then
		return false, "Security error: Cryptographic signature missing."
	end

	local verify = p2.verify

	if not v7(verify) then
		local v23 = tostring(p2.serverUrl or "https://zeroinhub.com")
		local ok2, result2 = pcall(function()
			return game:HttpGet(v23 .. "/api/ed25519")
		end)

		if ok2 and result2 and result2 ~= "" then
			local ok3, result3 = pcall(loadstring, result2)

			if ok3 and type(result3) == "function" then
				local ok4, result4 = pcall(result3)

				if ok4 and result4 and type(result4.verify) == "function" then
					verify = result4.verify
				end
			end
		end
	end

	if not v7(verify) then
		return false, "Security error: Cryptographic verification engine spoofed or unavailable."
	end

	local v30 = tostring(p2.nonce) .. "|true|" .. tostring(p2.message or "")
	local ok2, result2 = pcall(verify, tostring(p2.signature), v30, "8ea91cb482075e9bd4f19a3b0e2278a02efee3f20ab6d2b2812b235826b8f95e")

	if ok2 and result2 == true then
		return true
	end

	return false, "Security error: Signature verification failed (tampered payload detected)."
end

local v33, v34 = v16(v6)

if not v33 then
	pcall(function()
		game:GetService("Players").LocalPlayer:Kick("\n[Zeroin Security]\n" .. tostring(v34 or "Unauthorized execution.") .. "\nPlease launch the script via Zeroin Key System.")
	end)

	return
end

print("[Zeroin Hub] Authentication successful. Initializing script...")

local Players = game:GetService("Players")
local ReplicatedStorage = game:GetService("ReplicatedStorage")
local LocalPlayer = Players.LocalPlayer
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local Workspace = game:GetService("Workspace")
local genv = getgenv and getgenv() or _G

if type(genv.__ZeroinGlobalConnectionsCleanup) == "function" then
	pcall(genv.__ZeroinGlobalConnectionsCleanup)
end

local t1 = {}
local u43 = true

local function v44(p3)
	if p3 and not u43 then
		pcall(p3.Disconnect, p3)
	elseif p3 then
		table.insert(t1, p3)
	end

	return p3
end

genv.__ZeroinGlobalConnectionsCleanup = function()
	u43 = false

	for _, v in ipairs(t1) do
		pcall(v.Disconnect, v)
	end

	table.clear(t1)
end
genv.__ZeroinIdentityGetter = genv.getthreadidentity or genv.get_thread_identity or genv.getidentity or genv.getthreadcontext or genv.get_thread_context
genv.__ZeroinIdentitySetter = genv.setthreadidentity or genv.set_thread_identity or genv.setidentity or genv.setthreadcontext or genv.set_thread_context

local __ZeroinIdentitySetter = genv.__ZeroinIdentitySetter

if type(__ZeroinIdentitySetter) == "function" then
	pcall(__ZeroinIdentitySetter, 8)
	genv.__ZeroinUICapabilityIdentity = 8
end

genv.__ZeroinSetCapFps = function(p4)
	local v48 = math.clamp(math.floor(tonumber(p4) or 240), 1, 999)
	local setfpscap_ = rawget(_G, "setfpscap") or rawget(_G, "set_fps_cap") or type(setfpscap) == "function" and setfpscap

	if type(setfpscap_) == "function" then
		return pcall(setfpscap_, v48)
	end

	return false
end
genv.__ZeroinEnterUICallback = function()
end
genv.__ZeroinRunUICallback = function(p5, ...)
	return p5(...)
end
genv.__ZeroinWrapUICallback = function(p6)
	return p6
end
genv.__ZeroinResolveUIHost = function()
	local cloneref = genv.cloneref
	local LocalPlayer2 = Players.LocalPlayer
	local PlayerGui = LocalPlayer2

	if PlayerGui then
		PlayerGui = LocalPlayer2:FindFirstChildOfClass("PlayerGui") or LocalPlayer2:FindFirstChild("PlayerGui") or type(LocalPlayer2.WaitForChild) == "function" and LocalPlayer2:WaitForChild("PlayerGui", 5)
	end

	if type(cloneref) == "function" and PlayerGui then
		local ok, result = pcall(cloneref, PlayerGui)

		if ok and result then
			PlayerGui = result
		end
	end

	if PlayerGui then
		genv.__ZeroinUIHost = PlayerGui

		return PlayerGui
	end

	local __ZeroinUIHost = genv.__ZeroinUIHost

	if typeof(__ZeroinUIHost) == "Instance" and __ZeroinUIHost.Parent ~= nil and __ZeroinUIHost.Name ~= "RobloxGui" and pcall(function()
		local ScreenGui = Instance.new("ScreenGui")

		ScreenGui.Name = "__ZeroinProbe"
		ScreenGui.ResetOnSpawn = false
		ScreenGui.Parent = __ZeroinUIHost

		local Frame = Instance.new("Frame")

		Frame.Parent = ScreenGui
		Frame:Destroy()
		ScreenGui:Destroy()
	end) then
		return __ZeroinUIHost
	end

	local t2 = {}
	local t3 = {}

	local function v60(p7)
		if typeof(p7) == "Instance" and p7.Name ~= "RobloxGui" then
			if not t3[p7] then
				t3[p7] = true
				table.insert(t2, p7)
			end
		end
	end

	for _, v in ipairs({
		"gethui",
		"get_hidden_gui",
		"gethiddengui"
	}) do
		local v63 = genv[v]

		if type(v63) == "function" then
			local ok, result = pcall(v63)

			if ok then
				v60(result)
			end
		end
	end

	local ok, result = pcall(function()
		local CoreGui = game:GetService("CoreGui")

		return type(cloneref) == "function" and cloneref(CoreGui) or CoreGui
	end)

	if ok then
		v60(result)
	end

	local s1 = "UI host unavailable"

	for _, v in ipairs(t2) do
		local ok2, result2 = pcall(function()
			local ScreenGui = Instance.new("ScreenGui")

			ScreenGui.Name = "__ZeroinProbe"
			ScreenGui.ResetOnSpawn = false
			ScreenGui.Parent = v

			local Frame = Instance.new("Frame")

			Frame.Parent = ScreenGui
			Frame:Destroy()
			ScreenGui:Destroy()
		end)

		if ok2 then
			genv.__ZeroinUIHost = v

			return v
		end

		s1 = tostring(result2)
	end

	genv.__ZeroinUIHost = nil

	return nil, s1
end
genv.__ZeroinParentGui = function(p8)
	local v76, v77 = genv.__ZeroinResolveUIHost()

	if not v76 or typeof(p8) ~= "Instance" then
		return false, v77
	end

	if p8:IsA("ScreenGui") then
		pcall(function()
			p8.ResetOnSpawn = false
		end)
	end

	genv["__Stored_" .. tostring(p8.Name)] = p8

	local syn_ = genv.syn
	local protect_gui = syn_ and syn_.protect_gui or genv.protect_gui

	if type(protect_gui) == "function" then
		pcall(protect_gui, p8)
	end

	local ok, result = pcall(function()
		p8.Parent = v76
	end)

	return ok, result
end
pcall(function()
	local function v82(child)
		if child then
			if child:IsA("ScreenGui") then
				pcall(function()
					child.ResetOnSpawn = false
				end)

				local v83 = tostring(child.Name)

				if v83:find("Zeroin") or v83 == "NotifyGui" or v83 == "ToggleUIZeroin" then
					genv["__Stored_" .. v83] = child
				end
			end
		end
	end

	local v84 = genv.__ZeroinResolveUIHost()

	if v84 then
		for _, child in ipairs(v84:GetChildren()) do
			v82(child)
		end

		v44(v84.ChildAdded:Connect(v82))
	end

	v44(Players.LocalPlayer.CharacterAdded:Connect(function()
		task.wait(0.3)

		local v87 = genv.__ZeroinResolveUIHost()

		if v87 then
			for _, v in ipairs({
				"ZeroinOnTop",
				"ToggleUIZeroin",
				"ZeroinEggPanelUI",
				"NotifyGui",
				"ZeroinDiscordPrompt"
			}) do
				local v90 = genv["__Stored_" .. v]

				if v90 and typeof(v90) == "Instance" then
					pcall(function()
						v90.ResetOnSpawn = false

						if v90.Parent ~= v87 then
							v90.Parent = v87
						end
					end)
				end
			end
		end
	end))
end)

local v91, v92 = genv.__ZeroinResolveUIHost()

if not v91 then
	warn("[ZeroinUI] CoreGui unavailable: " .. tostring(v92))
end

pcall(function()
	local t4 = {
		"ZeroinOnTop",
		"ToggleUIZeroin",
		"NotifyGui",
		"ZeroinDiscordPrompt",
		"ZeroinEggPanelUI"
	}
	local t5 = {}
	local t6 = {}

	local function v96(p9)
		if not (typeof(p9) ~= "Instance" or t6[p9]) then
			t6[p9] = true
			table.insert(t5, p9)
		end
	end

	v96(LocalPlayer:FindFirstChildOfClass("PlayerGui"))
	v96(genv.__ZeroinUIHost)
	pcall(function()
		v96(game:GetService("CoreGui"))
	end)

	for _, v in ipairs({
		"gethui",
		"get_hidden_gui",
		"gethiddengui"
	}) do
		local v99 = genv[v]

		if type(v99) == "function" then
			local ok, result = pcall(v99)

			if ok then
				v96(result)
			end
		end
	end

	for _, v in ipairs(t5) do
		for _, v2 in ipairs(t4) do
			local v106 = v and v:FindFirstChild(v2)

			if v106 then
				v106:Destroy()
			end
		end
	end
end)

if type(genv.__ZeroinTweenRuntimeCleanup) == "function" then
	pcall(genv.__ZeroinTweenRuntimeCleanup)
end

if type(genv.__ZeroinScrambleCleanup) == "function" then
	pcall(genv.__ZeroinScrambleCleanup)
end

if type(genv.__ZeroinFuseCleanup) == "function" then
	pcall(genv.__ZeroinFuseCleanup)
end

if type(genv.__ZeroinAutoMutateCleanup) == "function" then
	pcall(genv.__ZeroinAutoMutateCleanup)
end

if type(genv.__ZeroinAntiAfkCleanup) == "function" then
	pcall(genv.__ZeroinAntiAfkCleanup)
end

if type(genv.__ZeroinVisualCleanup) == "function" then
	pcall(genv.__ZeroinVisualCleanup)
end

if type(genv.__ZeroinEggRuntimeCleanup) == "function" then
	pcall(genv.__ZeroinEggRuntimeCleanup)
end

if type(genv.__ZeroinAntiGuardCleanup) == "function" then
	pcall(genv.__ZeroinAntiGuardCleanup)
end

if type(genv.__ZeroinRiftCleanup) == "function" then
	pcall(genv.__ZeroinRiftCleanup)
end

if type(genv.__ZeroinBossCleanup) == "function" then
	pcall(genv.__ZeroinBossCleanup)
end

if type(genv.__ZeroinWebhookCleanup) == "function" then
	pcall(genv.__ZeroinWebhookCleanup)
end

genv.__ZeroinTweenRuntimeGeneration = (genv.__ZeroinTweenRuntimeGeneration or 0) + 1

local __ZeroinTweenRuntimeGeneration = genv.__ZeroinTweenRuntimeGeneration
local t7 = {
	KEY = "__FyyStealAnEggMovementSpoof",
	VERSION = 436,
	INTEGRITY_KEY = "__FyyStealAnEggIntegritySpoof",
	SIGNAL = "ClientCharacter: GetDebugSnapshot",
	HEADROOM = 1.35,
	CLAMP = 0.15,
	PADDING = 24,
	MULTIPLIER = 10,
	MIN_INPUT = 20,
	MAX_INPUT = 120,
	DEF_INPUT = 80,
	MIN_SPEED = 200,
	MAX_SPEED = 1200,
	DEF_SPEED = 800,
	FIELDS = {
		"LastObservedSample",
		"LastSample",
		"LastGoodSample",
		"LastGameplayTrustedSample",
		"LastValidatedSample",
		"LastValidatedGroundedSample",
		"LastConfirmedGroundSample",
		"CandidateGroundedSample"
	}
}
local KEY = t7.KEY
local VERSION = t7.VERSION
local INTEGRITY_KEY = t7.INTEGRITY_KEY
local SIGNAL = t7.SIGNAL
local HEADROOM = t7.HEADROOM
local CLAMP = t7.CLAMP
local PADDING = t7.PADDING
local MIN_SPEED = t7.MIN_SPEED
local MAX_SPEED = t7.MAX_SPEED
local DEF_SPEED = t7.DEF_SPEED
local FIELDS = t7.FIELDS
local u120
local v121 = tostring(math.random(100000, 999999))
local connection
local connection2
local t8 = {}
local u125
local v126

local function v127()
	for _, child in ipairs(Workspace:GetChildren()) do
		if child:IsA("BasePart") and child.Name == "__FyyHoverPad" and child ~= u120 then
			pcall(child.Destroy, child)
		end
	end
end
local function v130(p10)
	if u120 then
		if u120.Parent then
			local Character = LocalPlayer.Character
			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

			if not HumanoidRootPart or not Humanoid then
				return false
			end

			local Position = typeof(p10) == "Vector3" and p10 or HumanoidRootPart.Position

			u120.CFrame = cFrameNew(Position.X, Position.Y - (Humanoid.RigType == Enum.HumanoidRigType.R15 and HumanoidRootPart.Size.Y * 0.5 + math.max(Humanoid.HipHeight, 0.5) or HumanoidRootPart.Size.Y * 0.5 + 2) - 0.5 - 0.05, Position.Z)

			return true
		end
	end

	return false
end
local function v135()
	if not u120 or not u120.Parent or u120:GetAttribute("FyyStealRuntimeOwner") ~= v121 then
		v127()

		if u120 and u120.Parent then
			pcall(u120.Destroy, u120)
		end

		local Part = Instance.new("Part")

		Part.Name = "__FyyHoverPad"
		Part:SetAttribute("FyyStealRuntimeOwner", v121)
		Part.Anchored = true
		Part.CanCollide = true
		Part.CanQuery = true
		Part.CanTouch = false
		Part.CastShadow = false
		Part.Transparency = 1
		Part.Material = Enum.Material.SmoothPlastic
		Part.Size = Vector3.new(8, 1, 8)
		u120 = Part
		Part.Parent = Workspace
	end

	v130()

	if not connection then
		connection = RunService.PreSimulation:Connect(function()
			if not v130() then
				v135()
			end
		end)
	end

	if not connection2 then
		connection2 = RunService.PostSimulation:Connect(function()
			v130()
		end)
	end
end
local function v137()
	if connection then
		pcall(connection.Disconnect, connection)
		connection = nil
	end

	if connection2 then
		pcall(connection2.Disconnect, connection2)
		connection2 = nil
	end

	if u120 then
		pcall(u120.Destroy, u120)
		u120 = nil
	end

	v127()
end

v137()

local function v138()
	u125 = nil
end
local function v139(p11, p12)
	if p11 then
		if typeof(p12) == "CFrame" then
			u125 = {
				Character = LocalPlayer.Character,
				RootPart = p11,
				CFrame = p12
			}
		end
	end
end
local function v140()
	local v141 = u125

	if type(v141) ~= "table" or typeof(v141.CFrame) ~= "CFrame" then
		return false
	end

	if LocalPlayer.Character ~= v141.Character or not v141.RootPart or not v141.RootPart.Parent then
		u125 = nil

		return false
	end

	v135()
	v141.RootPart.AssemblyLinearVelocity = Vector3.zero
	v141.RootPart.AssemblyAngularVelocity = Vector3.zero
	v130(v141.CFrame.Position)
	v141.RootPart.CFrame = v141.CFrame
	v130(v141.CFrame.Position)

	return true
end
local function v142()
	local Character = LocalPlayer.Character
	local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

	for _, v in pairs(t8) do
		if type(v) == "table" then
			v.cancelled = true
		end
	end

	table.clear(t8)

	if HumanoidRootPart then
		HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
	end

	v138()
	v137()
end

genv.__ZeroinTweenRuntimeCleanup = function()
	for _, v in pairs(t8) do
		if type(v) == "table" then
			v.cancelled = true
		end
	end

	table.clear(t8)
	v138()
	v137()
end

local function v149()
	return getgenv and getgenv() or _G
end
local function v150()
	local v151 = v149()
	local v152 = v151[KEY]

	if type(v152) ~= "table" or v152.Version ~= VERSION then
		if type(v152) == "table" then
			v152.Enabled = false
		end

		v152 = {
			Version = VERSION,
			Installed = false,
			Enabled = false,
			Mode = "StateBaseline",
			Humanoid = nil,
			RootPart = nil,
			WalkSpeed = DEF_SPEED
		}
		v151[KEY] = v152
	end

	return v152
end
local function v153(p13, p14)
	local v154 = v150()

	if not v154 then
		return false
	end

	local Humanoid = p13 and p13:FindFirstChildOfClass("Humanoid")
	local HumanoidRootPart = p13 and p13:FindFirstChild("HumanoidRootPart")

	v154.Humanoid = Humanoid
	v154.RootPart = HumanoidRootPart
	v154.WalkSpeed = math.clamp(tonumber(p14) or DEF_SPEED, MIN_SPEED, MAX_SPEED * HEADROOM)
	v154.Enabled = false

	return Humanoid ~= nil and HumanoidRootPart ~= nil
end
local function v157()
	local v158 = v149()[KEY]

	if type(v158) == "table" then
		v158.Enabled = false
		v158.Humanoid = nil
		v158.RootPart = nil
	end
end
local function v159(p15, p16, p17)
	local u160

	if type(getcallbackvalue) == "function" and type(debug) == "table" and type(debug.getupvalue) == "function" then
		local Signal = ReplicatedStorage:FindFirstChild("Packages") and ReplicatedStorage.Packages:FindFirstChild("Signal")

		if Signal then
			local ok, result = pcall(require, Signal)

			if ok and type(result) == "table" and type(result.Invoked) == "function" then
				local ok2, result2 = pcall(result.Invoked, SIGNAL)

				if ok2 and result2 then
					local ok3, result3 = pcall(getcallbackvalue, result2, "OnInvoke")

					if ok3 and type(result3) == "function" then
						local ok4, result4 = pcall(debug.getinfo, result3)

						if ok4 then
							local function v170(p18, p19, p20)
								if u160 or type(p18) ~= "table" or p19 > 3 or p20[p18] then
									return
								end

								p20[p18] = true

								if rawget(p18, "Player") == p15 and rawget(p18, "Character") == p15.Character and rawget(p18, "Humanoid") == p16 and rawget(p18, "RootPart") == p17 and type(rawget(p18, "SampleHistory")) == "table" and type(rawget(p18, "Evidence")) == "table" then
									u160 = p18

									return
								end

								local n1 = 0

								for _, v in pairs(p18) do
									n1 += 1

									if n1 > 128 then
										break
									end

									if type(v) == "table" then
										v170(v, p19 + 1, p20)
									end
								end
							end

							local n2 = 1
							local nups = result4.nups or 0

							for i = n2, nups do
								local ok5, result5 = pcall(debug.getupvalue, result3, i)

								if not ok5 then
									continue
								end

								if type(result5) ~= "table" then
									continue
								end

								v170(result5, 0, {})

								if u160 then
									break
								end
							end
						end
					end
				end
			end
		end
	end

	if not u160 and type(getgc) == "function" then
		local ok, result = pcall(getgc, true)

		if ok and type(result) == "table" then
			for _, v in ipairs(result) do
				if type(v) == "table" and rawget(v, "Player") == p15 and rawget(v, "Character") == p15.Character and rawget(v, "Humanoid") == p16 and rawget(v, "RootPart") == p17 and type(rawget(v, "SampleHistory")) == "table" and type(rawget(v, "Evidence")) == "table" then
					u160 = v

					break
				end
			end
		end
	end

	return u160
end
local function v183(p21, p22, p23)
	if type(p21) ~= "table" then
		return false
	end

	local value = rawget(p21, "RootPart")
	local CFrame_2 = value and value.Parent and value.CFrame or nil
	local Position = CFrame_2 and CFrame_2.Position or nil
	local vector3 = typeof(p23) == "Vector3" and p23 or Vector3.zero

	local function v188(p24)
		if type(p24) == "table" then
			rawset(p24, "WalkSpeed", p22)

			if CFrame_2 then
				rawset(p24, "CFrame", CFrame_2)
				rawset(p24, "Position", Position)
				rawset(p24, "LinearVelocity", vector3)
				rawset(p24, "AngularVelocity", Vector3.zero)
			end
		end
	end

	for _, v in ipairs(FIELDS) do
		v188(rawget(p21, v))
	end

	local pairs_ = pairs
	local v192 = rawget(p21, "SampleHistory") or {}

	for _, v in pairs_(v192) do
		v188(v)
	end

	local pairs_2 = pairs
	local v196 = rawget(p21, "SafeGroundCheckpoints") or {}

	for _, v in pairs_2(v196) do
		v188(v)
	end

	local value2 = rawget(p21, "Evidence")

	if type(value2) == "table" then
		value2.Speed = 0
		value2.Teleport = 0
		value2.Flight = 0
	end

	local value3 = rawget(p21, "ImpulseContext")

	if type(value3) == "table" then
		local maxHorizontalSpeed = math.max(tonumber(value3.MaxHorizontalSpeed) or 0, p22)
		local v202 = math.max((tonumber(value3.ExpiresAt) or 0) - (tonumber(value3.StartedAt) or 0), CLAMP)

		value3.MaxHorizontalSpeed = maxHorizontalSpeed

		if Position then
			value3.OriginPosition = Position
		end

		value3.MaxHorizontalDistance = math.max(tonumber(value3.MaxHorizontalDistance) or 0, maxHorizontalSpeed * v202 + PADDING * 2)
		v188(value3.PreMovementSafeSample)
	end

	if rawget(p21, "CorrectionContext") == nil then
		rawset(p21, "FirstSuspiciousAt", nil)

		if rawget(p21, "ThreatLevel") == "Observing" then
			rawset(p21, "ThreatLevel", "Trusted")
		end
	end

	return true
end
local function v203()
	local v204 = v149()
	local v205 = v204[INTEGRITY_KEY]

	if type(v205) ~= "table" then
		v205 = {}
		v204[INTEGRITY_KEY] = v205
	end

	return v205
end
local function v206(p25, p26, p27)
	return type(p25) == "table" and rawget(p25, "Player") == LocalPlayer and rawget(p25, "Character") == LocalPlayer.Character and rawget(p25, "Humanoid") == p26 and rawget(p25, "RootPart") == p27
end
local function v207(p28, p29, p30)
	return v206(p28, p29, p30)
end
local function v208(p31, p32, p33)
	local v209 = v203()
	local State = v209.State

	if not v206(State, p31, p32) then
		local now = os.clock()

		if now < (v209.NextSearchAt or 0) then
			return false
		end

		v209.NextSearchAt = now + 0.2
		State = v159(LocalPlayer, p31, p32)
	end

	if not State then
		return false
	end

	if not v207(State, p31, p32) then
		v209.Enabled = false
		v209.Humanoid = p31
		v209.RootPart = p32
		v209.State = State

		return false
	end

	v209.NextSearchAt = 0
	v209.Enabled = true
	v209.Humanoid = p31
	v209.RootPart = p32
	v209.State = State
	v209.WalkSpeed = math.clamp(p33 * HEADROOM, MIN_SPEED, MAX_SPEED * HEADROOM)
	v209.TravelVelocity = Vector3.zero
	v183(State, v209.WalkSpeed, v209.TravelVelocity)

	return true
end
local function v212(p34, p35, p36, p37)
	local v213 = v149()[INTEGRITY_KEY]

	if type(v213) == "table" then
		if v213.Enabled and v213.Humanoid == p34 and v213.RootPart == p35 and v207(v213.State, p34, p35) then
			v213.WalkSpeed = math.clamp(p36 * HEADROOM, MIN_SPEED, MAX_SPEED * HEADROOM)

			if typeof(p37) == "Vector3" then
				v213.TravelVelocity = p37
			elseif typeof(v213.TravelVelocity) ~= "Vector3" then
				v213.TravelVelocity = Vector3.zero
			end

			return v183(v213.State, v213.WalkSpeed, v213.TravelVelocity)
		end
	end

	return false
end
local function v214(p38)
	local v215 = v149()[INTEGRITY_KEY]

	if type(v215) ~= "table" then
		return
	end

	if p38 == nil or v215.Humanoid == p38 then
		v215.Enabled = false
		v215.Humanoid = nil
		v215.RootPart = nil
		v215.State = nil
		v215.TravelVelocity = nil
		v215.NextSearchAt = 0
	end
end

local connection3

local function v217()
	if connection3 then
		return
	end

	connection3 = RunService.PreSimulation:Connect(function()
		if genv.__ZeroinTweenRuntimeGeneration ~= __ZeroinTweenRuntimeGeneration then
			local v218 = connection3

			connection3 = nil

			if v218 then
				pcall(v218.Disconnect, v218)
			end

			return
		end

		local Character = LocalPlayer.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not Character or not HumanoidRootPart or not Humanoid then
			return
		end

		local v222 = v126()

		v153(Character, v222 * HEADROOM)

		if not v212(Humanoid, HumanoidRootPart, v222) then
			v208(Humanoid, HumanoidRootPart, v222)
		end

		v140()
	end)
end
local function v223()
	if connection3 then
		pcall(connection3.Disconnect, connection3)
		connection3 = nil
	end

	v157()
	v214()
end

genv.__ZeroinTweenRuntimeCleanup = function()
	v142()
	v223()
end
v44(RunService.Heartbeat:Connect(function()
	local Character = LocalPlayer.Character
	local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

	if not HumanoidRootPart then
		return
	end

	local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity

	if Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude > 400 or math.abs(AssemblyLinearVelocity.Y) > 400 then
		HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(math.clamp(AssemblyLinearVelocity.X, -100, 100), math.clamp(AssemblyLinearVelocity.Y, -100, 100), math.clamp(AssemblyLinearVelocity.Z, -100, 100))
	end
end))
pcall(function()
	game:GetService("StarterGui"):SetCoreGuiEnabled(Enum.CoreGuiType.Health, false)
end)

local t9 = {
	k = 1000,
	m = 1000000,
	b = 1e9,
	t = 1e12,
	q = 1e15
}

local function v228(p39)
	local v229 = tostring(p39 or ""):lower():gsub("[%s,$]", ""):gsub("/s$", "")

	if v229 == "" then
		return 0, "0"
	end

	local match, v231 = v229:match("^([%d]+%.?[%d]*)([kmbtq]?)$")
	local v232 = tonumber(match)

	if v232 then
		return math.max(0, math.floor(v232 * (t9[v231] or 1) + 0.5)), v229
	end

	return nil
end

local zeroinConfig = {
	AutoSteal = false,
	StealMode = "Tween",
	StealZigzag = false,
	AutoRift = false,
	RiftTargetBanners = { "None" },
	IsRiftTrading = false,
	AutoScramble = false,
	AutoBuyScrambleShop = false,
	ScrambleShopItems = {},
	ScrambleShopAmount = 1,
	ScrambleShopInterval = 15,
	AutoCaptureEgg = false,
	StealFromPlayers = false,
	DropAtFirstArea = false,
	IsScrambleFarming = false,
	RiftRequiredCategories = {},
	RiftObjectiveCategories = {},
	RiftProtectedPetUids = {},
	StealAreas = { "None" },
	StealRarities = { "None" },
	StealNamesFilter = { "None" },
	StealMinValue = 0,
	StealMinValueInput = "0",
	AntiAFK = true,
	AutoReconnect = true,
	AutoPlace = false,
	PlaceRarities = { "None" },
	AutoHatch = false,
	AutoFuse = false,
	AutoFusePriority = "Lowest Rarity",
	AutoFuseRarities = { "All" },
	AutoFuseKeepPerPet = 1,
	AutoFuseMaxWeightKg = 0,
	IsFusing = false,
	AutoMutate = false,
	AutoMutateType = "Boss",
	AutoMutateRarities = {
		"Secret",
		"Eternal",
		"Divine",
		"Cosmic",
		"Mythic"
	},
	AutoMutateNames = {},
	AutoMutateMinValue = 0,
	AutoMutateMinValueInput = "0",
	SellAll = false,
	AutoSell = false,
	SellNames = { "None" },
	SellRarities = { "None" },
	AutoSellEgg = false,
	SellEggRarities = { "None" },
	WebhookEnabled = false,
	WebhookURL = "",
	TweenSpeedMultiplier = 80,
	AntiTreadmillMount = false,
	AutoTreadmillIdle = false,
	AntiGuardKnockback = true,
	GodMode = true,
	EggPredictUI = false,
	EggESP = false,
	PlacedEggESP = false,
	InventoryValueESP = true
}
local t10 = {}

local function v235(p40)
	if not p40 then
		return "Unknown"
	end

	local ok, result = pcall(function()
		return require(game:GetService("ReplicatedStorage").Data.Areas).Directory
	end)

	if ok and type(result) == "table" then
		for k, v in pairs(result) do
			if type(v) ~= "table" then
				continue
			end

			if type(v.DropTable) ~= "table" then
				continue
			end

			for _, v2 in ipairs(v.DropTable) do
				if v2[1] == p40 then
					return tostring(k)
				end
			end
		end
	end

	return "Unknown"
end

pcall(function()
	if type(isfile) ~= "function" or type(readfile) ~= "function" then
		return
	end

	local v242 = "Zeroin/Config/Zeroin_" .. tostring(game.GameId) .. ".json"

	if not isfile(v242) then
		return
	end

	local data = game:GetService("HttpService"):JSONDecode(readfile(v242))

	if type(data) ~= "table" then
		return
	end

	if type(data["Toggle_Auto Steal"]) == "boolean" then
		zeroinConfig.AutoSteal = data["Toggle_Auto Steal"]
	end

	if type(data["Dropdown_Filter By Rarity"]) == "table" then
		zeroinConfig.StealRarities = data["Dropdown_Filter By Rarity"]
	end

	if type(data["Dropdown_Filter By Area"]) == "table" then
		zeroinConfig.StealAreas = data["Dropdown_Filter By Area"]
	end

	if type(data["Dropdown_Filter By Egg Name"]) == "table" then
		zeroinConfig.StealNamesFilter = data["Dropdown_Filter By Egg Name"]
	end

	if type(data["Dropdown_Steal Mode"]) == "string" then
		zeroinConfig.StealMode = data["Dropdown_Steal Mode"]
	end

	if data.Input_Speed ~= nil and tonumber(data.Input_Speed) then
		zeroinConfig.TweenSpeedMultiplier = tonumber(data.Input_Speed)
	end

	if type(data["Toggle_Steal Zigzag"]) == "boolean" then
		zeroinConfig.StealZigzag = data["Toggle_Steal Zigzag"]
	end

	if data["Input_Steal By Value"] ~= nil then
		local v244, v245 = v228(data["Input_Steal By Value"])

		if v244 ~= nil then
			zeroinConfig.StealMinValue = v244
			zeroinConfig.StealMinValueInput = v245
		end
	end

	if type(data["Toggle_Anti Knock Back"]) == "boolean" then
		zeroinConfig.AntiGuardKnockback = data["Toggle_Anti Knock Back"]
	end

	if type(data["Toggle_God Mode"]) == "boolean" then
		zeroinConfig.GodMode = data["Toggle_God Mode"]
	end

	if type(data["Toggle_Auto Treadmill"]) == "boolean" then
		zeroinConfig.AutoTreadmillIdle = data["Toggle_Auto Treadmill"]
	end

	if type(data["Toggle_Anti AFK"]) == "boolean" then
		zeroinConfig.AntiAFK = data["Toggle_Anti AFK"]
	end

	if type(data["Toggle_Area Egg ESP"]) == "boolean" then
		zeroinConfig.EggESP = data["Toggle_Area Egg ESP"]
	elseif type(data["Toggle_Egg ESP"]) == "boolean" then
		zeroinConfig.EggESP = data["Toggle_Egg ESP"]
	end

	if type(data["Toggle_Inventory Value ESP"]) == "boolean" then
		zeroinConfig.InventoryValueESP = data["Toggle_Inventory Value ESP"]
	end

	if type(data["Input_Webhook URL"]) == "string" then
		zeroinConfig.WebhookURL = data["Input_Webhook URL"]
	end

	if type(data["Toggle_Webhook Logs"]) == "boolean" then
		zeroinConfig.WebhookEnabled = data["Toggle_Webhook Logs"]
	end

	if type(data["Toggle_Placed Egg ESP"]) == "boolean" then
		zeroinConfig.PlacedEggESP = data["Toggle_Placed Egg ESP"]
	end

	if type(data["Toggle_Auto Reconnect"]) == "boolean" then
		zeroinConfig.AutoReconnect = data["Toggle_Auto Reconnect"]
	end

	local toggleAutoTheRift = data["Toggle_Auto The Rift"]

	if type(toggleAutoTheRift) ~= "boolean" then
		toggleAutoTheRift = data["Toggle_Auto Riftborn"]
	end

	if type(toggleAutoTheRift) == "boolean" then
		zeroinConfig.AutoRift = toggleAutoTheRift
	end

	if type(data["Dropdown_Target Banner / Egg"]) == "table" then
		zeroinConfig.RiftTargetBanners = data["Dropdown_Target Banner / Egg"]

		local v247 = zeroinConfig.RiftTargetBanners[1]

		zeroinConfig.RiftTargetPrize = v247 ~= "None" and v247 or nil
	elseif type(data["Dropdown_Target Banner / Egg"]) == "string" then
		local dropdownTargetBannerEgg = data["Dropdown_Target Banner / Egg"]

		zeroinConfig.RiftTargetBanners = { dropdownTargetBannerEgg }
		zeroinConfig.RiftTargetPrize = dropdownTargetBannerEgg ~= "None" and dropdownTargetBannerEgg or nil
	end

	if type(data["Toggle_Auto Dr. Scramble"]) == "boolean" then
		zeroinConfig.AutoScramble = data["Toggle_Auto Dr. Scramble"]
	end

	if type(data["Toggle_Auto Buy Scramble Shop"]) == "boolean" then
		zeroinConfig.AutoBuyScrambleShop = data["Toggle_Auto Buy Scramble Shop"]
	end

	if type(data["Dropdown_Scramble Shop Items"]) == "table" then
		zeroinConfig.ScrambleShopItems = data["Dropdown_Scramble Shop Items"]
	end

	local v249 = tonumber(data["Input_Scramble Shop Amount"])

	if v249 then
		zeroinConfig.ScrambleShopAmount = math.clamp(math.floor(v249), 1, 100)
	end

	local v250 = tonumber(data["Input_Scramble Shop Interval"])

	if v250 then
		zeroinConfig.ScrambleShopInterval = math.clamp(v250, 1, 3600)
	end

	if type(data["Toggle_Steal From Players"]) == "boolean" then
		zeroinConfig.StealFromPlayers = data["Toggle_Steal From Players"]
	end

	if type(data["Toggle_Drop Egg At Forest"]) == "boolean" then
		zeroinConfig.DropAtFirstArea = data["Toggle_Drop Egg At Forest"]
	elseif type(data["Toggle_Drop At Forest"]) == "boolean" then
		zeroinConfig.DropAtFirstArea = data["Toggle_Drop At Forest"]
	elseif type(data["Toggle_Drop At First Area"]) == "boolean" then
		zeroinConfig.DropAtFirstArea = data["Toggle_Drop At First Area"]
	end

	if type(data["Toggle_Auto Capture The Egg"]) == "boolean" then
		zeroinConfig.AutoCaptureEgg = data["Toggle_Auto Capture The Egg"]
	end

	local toggleAutoPlaceEgg = data["Toggle_Auto Place Egg"]

	if type(toggleAutoPlaceEgg) ~= "boolean" then
		toggleAutoPlaceEgg = data["Toggle_Auto Place"]
	end

	if type(toggleAutoPlaceEgg) == "boolean" then
		zeroinConfig.AutoPlace = toggleAutoPlaceEgg
	end

	local toggleAutoHatchEgg = data["Toggle_Auto Hatch Egg"]

	if type(toggleAutoHatchEgg) ~= "boolean" then
		toggleAutoHatchEgg = data["Toggle_Auto Hatch"]
	end

	if type(toggleAutoHatchEgg) == "boolean" then
		zeroinConfig.AutoHatch = toggleAutoHatchEgg
	end

	if type(data["Dropdown_Place Egg Rarity"]) == "table" then
		zeroinConfig.PlaceRarities = data["Dropdown_Place Egg Rarity"]
	end

	if type(data["Toggle_Auto Fuse"]) == "boolean" then
		zeroinConfig.AutoFuse = data["Toggle_Auto Fuse"]
	end

	local dropdownFusePriority = data["Dropdown_Fuse Priority"]

	if type(dropdownFusePriority) == "table" then
		dropdownFusePriority = dropdownFusePriority[1]
	end

	if type(dropdownFusePriority) == "string" then
		zeroinConfig.AutoFusePriority = dropdownFusePriority
	end

	if type(data["Dropdown_Fuse Rarities"]) == "table" then
		zeroinConfig.AutoFuseRarities = data["Dropdown_Fuse Rarities"]
	end

	local v254 = tonumber(data["Input_Keep Pet Copies"]) or tonumber(data["Input_Keep Copies per Pet"])

	if v254 then
		zeroinConfig.AutoFuseKeepPerPet = math.max(0, math.floor(v254))
	end

	local v255 = tonumber(data["Input_Max Weight (Kg)"]) or tonumber(data["Input_Maximum Fuse Weight (Kg)"])

	if v255 then
		zeroinConfig.AutoFuseMaxWeightKg = math.max(0, v255)
	end

	if type(data["Toggle_Auto Consume Mutation"]) == "boolean" then
		zeroinConfig.AutoMutate = data["Toggle_Auto Consume Mutation"]
	end

	local dropdownMutationType = data["Dropdown_Mutation Type"]

	if type(dropdownMutationType) == "table" then
		dropdownMutationType = dropdownMutationType[1]
	end

	if type(dropdownMutationType) == "string" then
		zeroinConfig.AutoMutateType = dropdownMutationType
	end

	if type(data["Dropdown_Mutation Egg Rarities"]) == "table" then
		zeroinConfig.AutoMutateRarities = data["Dropdown_Mutation Egg Rarities"]
	end

	if type(data["Dropdown_Egg Names (Placed)"]) == "table" then
		zeroinConfig.AutoMutateNames = data["Dropdown_Egg Names (Placed)"]
	end

	if data["Input_Min Mutation Value /s"] ~= nil then
		local v257, v258 = v228(data["Input_Min Mutation Value /s"])

		if v257 ~= nil then
			zeroinConfig.AutoMutateMinValue = v257
			zeroinConfig.AutoMutateMinValueInput = v258
		end
	end

	if type(data["Toggle_Auto Sell Pet"]) == "boolean" then
		zeroinConfig.AutoSell = data["Toggle_Auto Sell Pet"]
	end

	if type(data["Toggle_Auto Sell Egg"]) == "boolean" then
		zeroinConfig.AutoSellEgg = data["Toggle_Auto Sell Egg"]
	end

	if type(data["Dropdown_Egg Rarity Filter"]) == "table" then
		zeroinConfig.SellEggRarities = data["Dropdown_Egg Rarity Filter"]
	end
end)

local EggState = require(game:GetService("ReplicatedStorage").Client.EggState)

EggState.GetAreaEggSnapshot = EggState.ReadFieldEggs
EggState.GetAreaEggRecord = EggState.ReadFieldEgg
EggState.RequestAreaEggSnapshot = EggState.SyncFieldEggs
EggState.RequestCarryAreaEgg = EggState.CarryFieldEgg
EggState.RequestDropHeldAreaEgg = EggState.DropFieldEgg
EggState.AreaEggCarryStateChanged = EggState.CarryChanged
EggState.AreaEggClaimed = EggState.FieldClaimed
EggState.AreaEggUpdated = EggState.FieldShifted
EggState.AreaEggRemoved = EggState.FieldGone
EggState.GetOwnerRuntimeRecords = EggState.ReadOwnerEggs
EggState.RequestEquipTool = EggState.WearEggTool
EggState.RequestPlaceEgg = EggState.PlantEgg
EggState.RequestHatchEgg = EggState.BeginHatch
EggState.RequestCompleteHatchEgg = EggState.FinishHatch
EggState.RequestRuntimeSnapshot = EggState.SyncOwnedEggs
EggState.RuntimeOwnerUpdated = EggState.OwnerRefreshed
EggState.RuntimeOwnerCleared = EggState.OwnerCleared

local PlotState = require(game:GetService("ReplicatedStorage").Client.PlotState)

PlotState.GetMySlot = PlotState.ResolveLocalSlot
PlotState.GetPlotsFolder = PlotState.ResolveFolder
PlotState.IsWorldPositionWithinLocalPlotBounds = PlotState.ContainsLocalPoint
PlotState.GetPlotData = PlotState.ResolvePlot

local AreaEggResetWall = require(game:GetService("ReplicatedStorage").Client.AreaEggResetWall)

AreaEggResetWall.IsClosed = AreaEggResetWall.IsSealed
v126 = function()
	return math.clamp(math.floor((tonumber(zeroinConfig.TweenSpeedMultiplier) or t7.DEF_INPUT) + 0.5), t7.MIN_INPUT, t7.MAX_INPUT) * t7.MULTIPLIER
end
zeroinConfig.applyStealValueInput = function(p41, p42)
	local v262, v263 = v228(p42)

	if v262 == nil then
		return false
	end

	p41.StealMinValue = v262
	p41.StealMinValueInput = v263

	return true
end

local function v264()
	return zeroinConfig.AutoSteal or zeroinConfig.AutoRift and next(zeroinConfig.RiftRequiredCategories) ~= nil
end
local function v265(p43)
	local v266 = zeroinConfig.AutoRift and type(p43) == "string"

	if v266 then
		v266 = (zeroinConfig.RiftObjectiveCategories[p43] or 0) > 0
	end

	return v266
end
local function v267(p44)
	return zeroinConfig.AutoRift and zeroinConfig.RiftProtectedPetUids[p44] == true
end
local function v268()
	local __ZeroinScrambleRuntime = genv.__ZeroinScrambleRuntime
	local v270 = __ZeroinScrambleRuntime and type(__ZeroinScrambleRuntime.isMovementBusy) == "function"

	v270 = v270 and __ZeroinScrambleRuntime:isMovementBusy()

	if zeroinConfig.IsStealing or zeroinConfig.IsRiftTrading or zeroinConfig.IsFusing or v270 then
		return false
	end

	if v264() then
		return os.clock() >= (zeroinConfig.StealPriorityUntil or 0)
	end

	return true
end
local function v271()
	local LocalPlayer2 = game:GetService("Players").LocalPlayer
	local t11 = {}

	t11.__index = t11
	t11.new = function()
		local obj = setmetatable({}, t11)

		obj.enabled = false
		obj.destroyed = false

		local getconnections_ = getconnections

		obj.getConnections = getconnections_ or get_signal_cons
		obj.idledConnections = {}

		return obj
	end
	t11._captureConnections = function(p45)
		if not p45.getConnections or not LocalPlayer2 then
			return
		end

		for _, v in ipairs(p45.getConnections(LocalPlayer2.Idled)) do
			if not table.find(p45.idledConnections, v) then
				table.insert(p45.idledConnections, v)
			end
		end
	end
	t11.setEnabled = function(p46, p47)
		if p46.destroyed then
			return false
		end

		local enabled = p47 == true

		p46.enabled = enabled

		if enabled then
			p46:_captureConnections()
		end

		for _, idledConnection in ipairs(p46.idledConnections) do
			pcall(function()
				if enabled then
					idledConnection:Disable()
				else
					idledConnection:Enable()
				end
			end)
		end

		return p46.enabled
	end
	t11.isEnabled = function(p48)
		return p48.enabled
	end
	t11.destroy = function(p49)
		if p49.destroyed then
			return
		end

		p49:setEnabled(false)
		p49.destroyed = true
		table.clear(p49.idledConnections)
	end

	return t11
end

local v281 = v271().new()

genv.__ZeroinAntiAfk = v281
v281:setEnabled(zeroinConfig.AntiAFK == true)

local function v282()
	v281:destroy()

	if genv.__ZeroinAntiAfk == v281 then
		genv.__ZeroinAntiAfk = nil
	end

	if genv.__ZeroinAntiAfkCleanup == v282 then
		genv.__ZeroinAntiAfkCleanup = nil
	end
end

genv.__ZeroinAntiAfkCleanup = v282

local u283 = false

local function v284()
	if u283 then
		return
	end

	u283 = true

	local genv2 = getgenv and getgenv()

	genv2 = genv2 or _G

	if genv2 and (genv2.SNE_AutoExecute or genv2.Zeroin_AutoExecute) then
		if type(genv2.writeAutoexecBootstrapper) == "function" then
			pcall(genv2.writeAutoexecBootstrapper)
		end
	end

	task.wait(3)

	local TeleportService = game:GetService("TeleportService")
	local LocalPlayer2 = game:GetService("Players").LocalPlayer
	local PlaceId = game.PlaceId
	local JobId = game.JobId
	local n3 = 0

	while true do
		n3 += 1
		pcall(function()
			if n3 <= 5 and JobId and #JobId > 0 then
				TeleportService:TeleportToPlaceInstance(PlaceId, JobId, LocalPlayer2)
			else
				TeleportService:Teleport(PlaceId, LocalPlayer2)
			end
		end)
		task.wait(6)
	end
end

pcall(function()
	local GuiService = game:GetService("GuiService")

	v44(GuiService.ErrorMessageChanged:Connect(function(p50)
		if zeroinConfig.AutoReconnect and p50 and #p50 > 0 then
			task.spawn(v284)
		end
	end))

	local errorMessage = GuiService:GetErrorMessage()

	if zeroinConfig.AutoReconnect and errorMessage and #errorMessage > 0 then
		task.spawn(v284)
	end
end)

local function v293()
	local lua

	if isfile and readfile and isfile("Zeroin_ZeroLib_cached_v15.lua") then
		pcall(function()
			lua = readfile("Zeroin_ZeroLib_cached_v15.lua")
		end)
	end

	if not lua or lua == "" or string.len(lua) < 100 then
		for i = 1, 3 do
			local ok, result = pcall(function()
				return game:HttpGet("https://raw.githubusercontent.com/iSylvesterr/library/1e50c1a/ZeroLib.lua")
			end)

			if ok and result and string.len(result) > 100 and not string.match(result, "404: Not Found") then
				lua = result

				if writefile then
					pcall(function()
						writefile("Zeroin_ZeroLib_cached_v15.lua", lua)
					end)
				end

				break
			end

			task.wait(1)
		end
	end

	if lua and string.len(lua) > 100 then
		if not genv.__ZeroinUIHost then
			warn("[ZeroinUI] CoreGui host is unavailable")

			return nil
		end

		lua = string.gsub(lua, "game:GetService%(\"CoreGui\"%)", "((getgenv and getgenv().__ZeroinUIHost) or _G.__ZeroinUIHost)")
		lua = string.gsub(lua, "game:GetService%('CoreGui'%)", "((getgenv and getgenv().__ZeroinUIHost) or _G.__ZeroinUIHost)")
		lua = string.gsub(lua, "(Instance%.new%s*%(%s*[\"']ScreenGui[\"']%s*%))", "(function() local _sg = %1; _sg.ResetOnSpawn = false; return _sg end)()")
		lua = string.gsub(lua, "ZeroinOnTop%.Destroying:Connect%s*%(%s*function%s*%(%s*%)%s*if%s+runCleanup%s+then%s+runCleanup%(true%)%s*end%s*end%)", "")
		lua = string.gsub(lua, "(:Connect%s*%(%s*function%s*%b())", "%1\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "(:Once%s*%(%s*function%s*%b())", "%1\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "(task%.spawn%s*%(%s*function%s*%b())", "%1\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "(task%.defer%s*%(%s*function%s*%b())", "%1\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "([^%w_%.])spawn%s*%(%s*function%s*(%b())", "%1spawn(function%2\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "(task%.wait%s*%b())", "%1\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "([^%w_%.])wait%s*(%b())", "%1wait%2\nif getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end")
		lua = string.gsub(lua, "(function%s+LoadConfigElements%s*%b())", [[%1
if getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end
]])
		lua = string.gsub(lua, "(function%s+[A-Za-z_][A-Za-z0-9_]*Func:Set%s*%b())", [[%1
if getgenv and getgenv().__ZeroinEnterUICallback then getgenv().__ZeroinEnterUICallback() elseif _G.__ZeroinEnterUICallback then _G.__ZeroinEnterUICallback() end
]])

		local v298 = string.find(lua, "function Items:AddInput", 1, true)
		local v299 = v298 and string.find(lua, "function Items:AddDropdown", v298, true)

		if v298 and v299 then
			local v300 = string.gsub(string.gsub(string.gsub(string.sub(lua, v298, v299 - 1), "local configKey = \"Input_\" %.%. InputConfig%.Title%s+if ConfigData%[configKey%] ~= nil then", [[local configKey = "Input_" .. InputConfig.Title
                local persistValue = InputConfig.Persist ~= false
                if not persistValue then
                    ConfigData[configKey] = nil
                    SaveConfig()
                elseif ConfigData[configKey] ~= nil then]], 1), "(InputTextBox%.TextColor3%s*=%s*Color3%.fromRGB%b())", "%1\n                InputTextBox.TextTransparency = InputConfig.Sensitive == true and 1 or 0", 1), "ConfigData%[configKey%] = Value%s+SaveConfig%(%)", [[if persistValue then
                        ConfigData[configKey] = Value
                    else
                        ConfigData[configKey] = nil
                    end
                    SaveConfig()]], 1)

			lua = string.sub(lua, 1, v298 - 1) .. v300 .. string.sub(lua, v299)
		end

		lua = string.gsub(lua, ":Connect%s*%(([A-Za-z_][A-Za-z0-9_%.]*)%)", ":Connect(((getgenv and getgenv().__ZeroinWrapUICallback) or _G.__ZeroinWrapUICallback)(%1))")
		lua = string.gsub(lua, ":Once%s*%(([A-Za-z_][A-Za-z0-9_%.]*)%)", ":Once(((getgenv and getgenv().__ZeroinWrapUICallback) or _G.__ZeroinWrapUICallback)(%1))")

		local chunk, v302 = loadstring(lua)

		if chunk then
			local ok, result = pcall(chunk)

			if ok and result then
				return result
			end

			warn("[ZeroinUI] Execution Error: " .. tostring(result))
		else
			warn("[ZeroinUI] Parse Error: " .. tostring(v302))
		end
	end

	return nil
end

local v305 = v293()

if not v305 then
	warn("Failed to load Zeroin UI Library!")

	return
end

local t12 = {}
local t13 = {}

local function v308(p51, p52)
	local t14 = {}

	if type(p51) == "table" then
		for k, v in pairs(p51) do
			if type(k) == "number" then
				table.insert(t14, v)
			elseif type(k) == "string" and v == true then
				table.insert(t14, k)
			end
		end
	else
		t14 = { p51 }
	end

	if p52 and t12[p52] then
		return t14
	end

	local v312 = p52 and t13[p52]
	local v313 = table.find(t14, "None") ~= nil
	local v314 = false

	if #t14 == 0 then
		t14 = { "None" }
		v314 = true
	elseif #t14 > 1 and v313 then
		if v312 == false then
			t14 = { "None" }
			v314 = true
		else
			local t15 = {}

			for _, v in ipairs(t14) do
				if v ~= "None" then
					table.insert(t15, v)
				end
			end

			t14 = t15
			v314 = true
		end
	end

	if p52 then
		t13[p52] = table.find(t14, "None") ~= nil
	end

	if v314 and p52 then
		t12[p52] = true
		pcall(function()
			p52:Set(t14)
		end)
		t12[p52] = nil
	end

	return t14
end
local function v318(p53)
	if not p53 or type(p53.GetValue) ~= "function" then
		return nil
	end

	local ok, result = pcall(function()
		return p53:GetValue()
	end)

	if not ok then
		return nil
	end

	if type(result) ~= "table" then
		if type(result) == "string" then
			return { result }
		end

		return nil
	end

	local t16 = {}

	for k, v in pairs(result) do
		if type(k) == "number" then
			table.insert(t16, v)
		elseif type(k) == "string" and v == true then
			table.insert(t16, k)
		end
	end

	return t16
end
local function v324(p54, p55, p56, p57)
	if zeroinConfig.SellAll then
		return true
	end

	if type(p56) ~= "table" or type(p57) ~= "table" then
		return false
	end

	local v325 = false

	if #p56 ~= 0 and not table.find(p56, "None") then
		if table.find(p56, "All") then
			v325 = true
		else
			v325 = table.find(p56, p54) ~= nil
		end
	end

	local v326 = false

	if #p57 ~= 0 and not table.find(p57, "None") then
		if table.find(p57, "All") then
			v326 = true
		else
			v326 = table.find(p57, p55) ~= nil
		end
	end

	return v325 or v326
end
local function v327(p58, p59)
	if type(p59) ~= "table" then
		return false
	end

	if #p59 == 0 or table.find(p59, "None") then
		return false
	end

	if table.find(p59, "All") then
		return true
	end

	return table.find(p59, p58) ~= nil
end
local function v328(p60)
	local HumanoidRootPart = p60 and p60:FindFirstChild("HumanoidRootPart")

	if HumanoidRootPart then
		HumanoidRootPart:SetAttribute("KillPartIgnore", true)
	end
end

local vector3 = Vector3.new(545, 71, -365)
local t17 = {
	CarryRetry = 0.25,
	CarryTimeout = 2,
	EarlyCarryDistance = 8,
	SafeStable = 0.35,
	ReturnValidation = 0.08,
	NextTarget = 0.05,
	SafeHandoff = 0.15
}

local function v332(p61)
	local clamp = math.clamp
	local floor = math.floor
	local tweenSpeedMultiplier = clamp(floor((tonumber(p61) or t7.DEF_INPUT) + 0.5), t7.MIN_INPUT, t7.MAX_INPUT)

	if math.abs((zeroinConfig.TweenSpeedMultiplier or 0) - tweenSpeedMultiplier) <= 0.001 then
		return
	end

	zeroinConfig.TweenSpeedMultiplier = tweenSpeedMultiplier

	local Humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
	local WalkSpeed = Humanoid and Humanoid.WalkSpeed or 0

	warn(string.format("[Spoof] speed level %d (%.0f stud/detik, WalkSpeed %.0f).", tweenSpeedMultiplier, v126(), WalkSpeed))
end

t8 = t8 or {}

local function v338(p62, p63, p64, p65, p66, p67, p68)
	if not p62 or not p63 or typeof(p64) ~= "CFrame" then
		return false
	end

	if p65 and p65() then
		return false
	end

	local v339 = t8[p62]

	if v339 then
		v339.cancelled = true
		t8[p62] = nil
	end

	local Parent = p62.Parent

	if not Parent then
		return false
	end

	v138()
	v328(Parent)
	v217()

	local CurrentCamera = workspace.CurrentCamera

	if CurrentCamera and CurrentCamera.CameraSubject ~= p63 then
		pcall(function()
			CurrentCamera.CameraSubject = p63
		end)
	end

	local AutoRotate = p63.AutoRotate

	p63.AutoRotate = false

	local v343 = p68 and math.max(p62.Position.Y, p64.Position.Y + 45, vector3.Y + 45) or nil
	local v344 = v343 and cFrameNew(p64.Position.X, v343, p64.Position.Z) * p64.Rotation or p64
	local v345 = math.clamp(v126(), t7.MIN_SPEED, t7.MAX_SPEED)

	v153(Parent, v345 * t7.HEADROOM)

	local t18 = {
		cancelled = false
	}

	t8[p62] = t18
	v135()

	local now
	local v348
	local n4 = 0
	local v350 = v343 and (math.abs(p62.Position.Y - v343) > 0.35 and "takeoff" or "cruise") or nil
	local Magnitude = (v344.Position - p62.Position).Magnitude
	local v352 = os.clock() + math.max(Magnitude / v345, 0.08) * 3 + 8
	local v353 = false
	local v354 = false

	while not t18.cancelled and (not p65 or not p65()) and p62.Parent and not (v352 <= os.clock()) do
		local v355 = math.max(math.min(RunService.Heartbeat:Wait(), 0.15), 0.0041666666666666666)
		local v356 = math.clamp(v126(), t7.MIN_SPEED, t7.MAX_SPEED)

		v153(Parent, v356 * t7.HEADROOM)

		local v357 = v149()[t7.INTEGRITY_KEY]
		local State = type(v357) == "table" and v357.State or nil

		if v207(State, p63, p62) then
			local Position = p62.Position
			local v360 = v344.Position - Position
			local Magnitude2 = v360.Magnitude
			local vector32 = Vector3.new(v360.X, 0, v360.Z)

			if v343 and v350 == "takeoff" and math.abs(Position.Y - v343) <= 0.35 then
				v350 = "cruise"
			end

			local v363 = (v343 and v350 == "takeoff" and Vector3.new(Position.X, v343, Position.Z) or v344.Position) - Position
			local Magnitude3 = v363.Magnitude
			local Magnitude4 = v343 and vector32.Magnitude or Magnitude2

			if v348 and v348 + 2 < Magnitude4 then
				n4 = os.clock() + 0.5
			end

			v348 = Magnitude4

			local v366 = (os.clock() < n4 and math.max(t7.MIN_SPEED, v356 * 0.45) or v356) * v355

			if p67 and not v354 and Magnitude2 <= t17.EarlyCarryDistance then
				v354 = true
				task.spawn(p67)
			end

			local vector33 = Vector3.new(p62.CFrame.LookVector.X, 0, p62.CFrame.LookVector.Z)
			local Unit = vector32.Magnitude > 0.001 and vector32.Unit or vector33.Magnitude > 0.001 and vector33.Unit or Vector3.new(0, 0, -1)

			if (not v343 or v350 == "cruise") and Magnitude2 <= math.max(v366, 0.05) then
				if Magnitude2 > 0.5 then
					now = nil
				end

				v130(v344.Position)
				p62.CFrame = lookAt(v344.Position, v344.Position + Unit)
				p62.AssemblyLinearVelocity = Vector3.zero
				p62.AssemblyAngularVelocity = Vector3.zero
				v130(v344.Position)
				v212(p63, p62, v356, Vector3.zero)
				now = now or os.clock()

				if os.clock() - now >= 0.4 then
					v353 = true

					break
				end
			else
				now = nil

				if Magnitude3 <= 0.001 then
					p62.AssemblyLinearVelocity = Vector3.zero
					p62.AssemblyAngularVelocity = Vector3.zero
					v130(Position)
				else
					local v369 = Position + v363.Unit * math.min(v366, Magnitude3)
					local assemblyLinearVelocity = (v369 - Position) / v355

					v130(v369)
					p62.CFrame = lookAt(v369, v369 + Unit)
					p62.AssemblyLinearVelocity = assemblyLinearVelocity
					v130(v369)

					if not v212(p63, p62, v356, assemblyLinearVelocity) then
						v208(p63, p62, v356)
						v212(p63, p62, v356, assemblyLinearVelocity)
					end
				end
			end
		else
			v348 = nil
			now = nil
			p62.AssemblyLinearVelocity = Vector3.zero
			p62.AssemblyAngularVelocity = Vector3.zero
			v130(p62.Position)

			if v206(State, p63, p62) then
				v183(State, v356 * t7.HEADROOM, Vector3.zero)
			else
				v208(p63, p62, v356)
			end
		end
	end

	if p63.Parent and AutoRotate ~= nil then
		p63.AutoRotate = AutoRotate
	end

	p62.AssemblyLinearVelocity = Vector3.zero
	p62.AssemblyAngularVelocity = Vector3.zero

	if v353 and p66 then
		v139(p62, v344)
	else
		v137()
	end

	return v353 and not t18.cancelled
end

getgenv().ZeroinConfig = zeroinConfig

local u371

local function v372(p69)
	if not p69 or p69 == u371 then
		return
	end

	u371 = p69

	for _, child in ipairs(p69:GetChildren()) do
		if child.Name == "PlayerTrap" then
			pcall(child.Destroy, child)
		end
	end

	v44(p69.ChildAdded:Connect(function(child)
		if child.Name == "PlayerTrap" then
			pcall(child.Destroy, child)
		end
	end))
end

v372(workspace:FindFirstChild("__DEBRIS"))
v44(workspace.ChildAdded:Connect(function(child)
	if child.Name == "__DEBRIS" then
		v372(child)
	end
end))

if type(genv.__ZeroinDecomBoostCleanup) == "function" then
	pcall(genv.__ZeroinDecomBoostCleanup)
end

local t19 = {}
local u376 = false

genv.__ZeroinDecomBoostCleanup = function()
	for _, v in ipairs(t19) do
		pcall(function()
			v:Disconnect()
		end)
	end

	table.clear(t19)
	u376 = false
end

local function v379()
	local ClientRenderedAssets = workspace:FindFirstChild("ClientRenderedAssets")

	if not ClientRenderedAssets then
		return
	end

	for _, child in ipairs(ClientRenderedAssets:GetChildren()) do
		pcall(function()
			child:Destroy()
		end)
	end
end
local function v383(p70)
	if not p70 then
		return false
	end

	local v384 = tostring(LocalPlayer.UserId)
	local v385 = tostring(p70.Name)
	local match = v385:match("^(%d+)_") or v385:match("^(%d+):")

	if match and match == v384 then
		return true
	end

	if p70:GetAttribute("OwnerUserId") == LocalPlayer.UserId then
		return true
	end

	return false
end
local function v387()
	for _, child in ipairs(workspace:GetChildren()) do
		if child.Name == "PlacedEggRenders" then
			for _, child2 in ipairs(child:GetChildren()) do
				pcall(function()
					if not v383(child2) then
						if not child2:FindFirstChildOfClass("ProximityPrompt") then
							child2:Destroy()
						end
					end
				end)
			end
		end
	end
end
local function v392()
	local __DEBRIS = workspace:FindFirstChild("__DEBRIS")

	if not __DEBRIS then
		return
	end

	for _, child in ipairs(__DEBRIS:GetChildren()) do
		if child.Name == "PlayerTrap" then
			pcall(function()
				child:Destroy()
			end)
		end
	end
end
local function v396(descendant)
	pcall(function()
		if descendant:IsA("BasePart") then
			descendant.Material = Enum.Material.SmoothPlastic
			descendant.CastShadow = false
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant.Texture = ""
			descendant.Transparency = 1
		elseif descendant:IsA("Sound") then
			descendant.PlayOnRemove = false
			descendant:Stop()
		elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") or descendant:IsA("Sparkles") or descendant:IsA("Fire") or descendant:IsA("Smoke") or descendant:IsA("PostEffect") then
			descendant.Enabled = false
		end
	end)
end
local function v397()
	if u376 then
		return
	end

	u376 = true
	table.insert(t19, workspace.DescendantAdded:Connect(v396))
	table.insert(t19, workspace.ChildAdded:Connect(function(child)
		if child.Name == "ClientRenderedAssets" then
			v379()
			table.insert(t19, child.ChildAdded:Connect(function(child2)
				pcall(function()
					child2:Destroy()
				end)
			end))
		elseif child.Name == "PlacedEggRenders" then
			v387()
			table.insert(t19, child.ChildAdded:Connect(function(child2)
				pcall(function()
					if not v383(child2) and not child2:FindFirstChildOfClass("ProximityPrompt") then
						child2:Destroy()
					end
				end)
			end))
		elseif child.Name == "__DEBRIS" then
			table.insert(t19, child.ChildAdded:Connect(function(child2)
				if child2.Name == "PlayerTrap" then
					pcall(function()
						child2:Destroy()
					end)
				end
			end))
		end
	end))

	local ClientRenderedAssets = workspace:FindFirstChild("ClientRenderedAssets")

	if ClientRenderedAssets then
		table.insert(t19, ClientRenderedAssets.ChildAdded:Connect(function(child)
			pcall(function()
				child:Destroy()
			end)
		end))
	end

	for _, child in ipairs(workspace:GetChildren()) do
		if child.Name == "PlacedEggRenders" then
			table.insert(t19, child.ChildAdded:Connect(function(child2)
				pcall(function()
					if not v383(child2) and not child2:FindFirstChildOfClass("ProximityPrompt") then
						child2:Destroy()
					end
				end)
			end))
		end
	end
end
local function v401()
	if type(genv.__ZeroinSetCapFps) == "function" then
		genv.__ZeroinSetCapFps(240)
	end

	local Lighting = game:GetService("Lighting")

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
		settings().Physics.PhysicsEnvironmentalThrottle = Enum.EnviromentalPhysicsThrottle.Always
		Lighting.Technology = Enum.Technology.Compatibility
		Lighting.GlobalShadows = false
		Lighting.FogEnd = 9e9
		Lighting.Brightness = 2
		Lighting.Ambient = Color3.new(1, 1, 1)
		Lighting.OutdoorAmbient = Color3.new(1, 1, 1)
	end)

	for _, descendant in ipairs(game:GetDescendants()) do
		if descendant:IsA("BasePart") then
			pcall(function()
				descendant.Material = Enum.Material.SmoothPlastic
				descendant.CastShadow = false
			end)
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			pcall(function()
				descendant.Texture = ""
				descendant.Transparency = 1
			end)
		else
			v396(descendant)
		end
	end

	local Terrain = workspace:FindFirstChildOfClass("Terrain")

	if Terrain then
		pcall(function()
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
			Terrain.Decoration = false
		end)
	end

	pcall(function()
		local SettingsCmds = require(ReplicatedStorage.Shared.SettingsCmds)

		SettingsCmds.Write("HideOtherPets", true)
		SettingsCmds.Write("SFX", false)
		SettingsCmds.Write("Music", false)
		SettingsCmds.Write("DisableVideos", true)
	end)
	v379()
	v387()
	v392()
	v397()
end
local function v407(p71)
	if not p71 or not p71:IsA("Model") then
		return
	end

	local match = p71.Name:match("^(%d+)_")
	local v409 = match

	v409 = v409 and tonumber(match)

	if not v409 or v409 == LocalPlayer.UserId then
		return
	end

	for _, descendant in ipairs(p71:GetDescendants()) do
		if descendant:IsA("BasePart") then
			descendant.Transparency = 1
			descendant.CanCollide = false
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			descendant.Transparency = 1
		elseif descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") or descendant:IsA("Beam") then
			descendant.Enabled = false
		elseif descendant:IsA("BillboardGui") or descendant:IsA("SurfaceGui") then
			descendant.Enabled = false
		end
	end
end
local function v412()
	if zeroinConfig._fpsEggsReady then
		return true
	end

	local u413 = false
	local ok, result = pcall(function()
		local v416 = require(game:GetService("ReplicatedStorage").Shared.Eggs.PlacedEggRenderer).GetRenderFolder()

		if not v416 then
			return
		end

		local children = v416:GetChildren()

		for _, child in ipairs(children) do
			v407(child)
		end

		v416.ChildAdded:Connect(function(child)
			task.defer(v407, child)
		end)
		u413 = true
	end)

	if not ok then
		warn("[FPSBoost] Gagal hide egg pemain lain:", result)

		return false
	end

	return u413
end
local function v420(p72)
	if not p72 then
		return
	end

	pcall(function()
		p72:Destroy()
	end)
end
local function v421()
	if zeroinConfig._fpsPetsReady then
		return true
	end

	local SettingsCmds
	local ok, result = pcall(function()
		SettingsCmds = require(game:GetService("ReplicatedStorage").Shared.SettingsCmds)
		SettingsCmds.Write("HideOtherPets", true)
	end)
	local v425 = false

	if ok and SettingsCmds then
		local ok2, result2 = pcall(SettingsCmds.Allows, "HideOtherPets")

		v425 = ok2 and result2 == true
	end

	if ok and v425 then
		local u428 = false
		local ok2, result2 = pcall(function()
			local ClientRenderedAssets = workspace:FindFirstChild("ClientRenderedAssets") or workspace:WaitForChild("ClientRenderedAssets", 10)

			if not ClientRenderedAssets then
				return
			end

			local children = ClientRenderedAssets:GetChildren()

			for _, child in ipairs(children) do
				v420(child)
			end

			ClientRenderedAssets.ChildAdded:Connect(function(child)
				task.defer(v420, child)
			end)
			u428 = true
		end)

		if not ok2 then
			warn("[FPSBoost] Gagal hide pet (manual):", result2)

			return false
		end

		return u428
	end

	warn("[FPSBoost] Gagal set HideOtherPets bawaan game:", result or "setting belum aktif")

	return false
end
local function v435()
	if type(genv.__ZeroinSetCapFps) == "function" then
		pcall(genv.__ZeroinSetCapFps, 240)
	end

	pcall(function()
		settings().Rendering.QualityLevel = Enum.QualityLevel.Level01
	end)
	pcall(function()
		UserSettings():GetService("UserGameSettings").SavedQualityLevel = Enum.SavedQualitySetting.QualityLevel1
	end)
	pcall(function()
		require(game:GetService("ReplicatedStorage").Client.LightingsController):SetModifier("FPSBoost", function(p73)
			local v436 = table.clone(p73)

			v436.Bloom = nil
			v436.ColorCorrection = nil
			v436.SunRays = nil
			v436.DepthOfField = nil
			v436.Blur = nil
			v436.Clouds = nil
			v436.Atmosphere = nil
			v436.ShadowSoftness = 1

			return v436
		end, 100, 0)
	end)
	pcall(function()
		local Lighting = game:GetService("Lighting")

		Lighting.GlobalShadows = false
		Lighting.Technology = Enum.Technology.Compatibility
		Lighting.FogEnd = 9e9
		Lighting.Brightness = 2
	end)
	pcall(function()
		local Terrain = workspace:FindFirstChildOfClass("Terrain")

		if Terrain then
			Terrain.WaterWaveSize = 0
			Terrain.WaterWaveSpeed = 0
			Terrain.WaterReflectance = 0
			Terrain.WaterTransparency = 1
			Terrain.Decoration = false
		end
	end)
	pcall(function()
		local __DEBRIS = workspace:FindFirstChild("__DEBRIS")

		if __DEBRIS then
			for _, child in ipairs(__DEBRIS:GetChildren()) do
				if child.Name == "PlayerTrap" then
					pcall(function()
						child:Destroy()
					end)
				end
			end
		end
	end)
end

local color3 = Color3.fromRGB(120, 120, 120)

local function v443(p74)
	if not p74 or not p74:IsA("BasePart") then
		return
	end

	pcall(function()
		p74.Material = Enum.Material.SmoothPlastic
		p74.Color = color3
		p74.CastShadow = false
	end)

	for _, child in ipairs(p74:GetChildren()) do
		if child:IsA("Texture") or child:IsA("Decal") then
			pcall(function()
				child:Destroy()
			end)
		end
	end
end
local function v446(p75)
	pcall(function()
		if p75:IsA("ParticleEmitter") then
			p75.Enabled = false
			p75.Rate = 0
			pcall(function()
				p75:Clear()
			end)
		elseif p75:IsA("Trail") or p75:IsA("Beam") or p75:IsA("Smoke") or p75:IsA("Fire") or p75:IsA("Sparkles") or p75:IsA("PostEffect") or p75:IsA("Light") or p75:IsA("Highlight") or p75:IsA("Clouds") then
			p75.Enabled = false
		elseif p75:IsA("Atmosphere") then
			p75.Density = 0
			p75.Haze = 0
			p75.Glare = 0
		elseif p75:IsA("Explosion") then
			p75.Visible = false
		end
	end)
end
local function v447()
	for _, descendant in ipairs(workspace:GetDescendants()) do
		if descendant:IsA("BasePart") then
			v443(descendant)
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			pcall(function()
				descendant:Destroy()
			end)
		else
			v446(descendant)
		end
	end

	local ipairs_ = ipairs
	local Lighting = game:GetService("Lighting")

	for _, descendant in ipairs_(Lighting:GetDescendants()) do
		v446(descendant)
	end

	v44(workspace.DescendantAdded:Connect(function(descendant)
		if descendant:IsA("BasePart") then
			task.defer(v443, descendant)
		elseif descendant:IsA("Decal") or descendant:IsA("Texture") then
			pcall(function()
				descendant:Destroy()
			end)
		else
			task.defer(v446, descendant)
		end
	end))

	return true
end
local function v454()
	if zeroinConfig._fpsAreasReady then
		return true
	end

	local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
	local Areas = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
	local GuardAreas = Areas and Areas:FindFirstChild("GuardAreas")
	local Build = __OBJECTS and __OBJECTS:FindFirstChild("Build")

	if not GuardAreas or not Build then
		return false
	end

	for _, child in ipairs(GuardAreas:GetChildren()) do
		local RequiredSpeedSign = child:FindFirstChild("RequiredSpeedSign")

		if RequiredSpeedSign then
			pcall(function()
				RequiredSpeedSign:Destroy()
			end)
		end
	end

	local MainMap = Build:FindFirstChild("MainMap")
	local Bases = MainMap and MainMap:FindFirstChild("Bases")

	local function v464(p76)
		if Bases and p76:IsDescendantOf(Bases) then
			local v465 = p76.Size.Y <= 5

			return v465 and not string.find(string.upper(p76.Name), "WALL", 1, true)
		end

		local Parent = p76

		while Parent do
			if Parent == Build then
				break
			end

			if string.find(string.upper(Parent.Name), "BOTTOM", 1, true) then
				return true
			end

			Parent = Parent.Parent
		end

		return false
	end
	local function v467(p77)
		if not p77:IsA("BasePart") then
			return
		end

		if v464(p77) then
			v443(p77)
		else
			pcall(function()
				p77:Destroy()
			end)
		end
	end

	local connection4 = Build.DescendantAdded:Connect(function(descendant)
		task.defer(v467, descendant)
	end)
	local n5 = 0
	local fpsAreaDeleted = 0

	for _, descendant in ipairs(Build:GetDescendants()) do
		local v473 = descendant.Parent ~= nil

		v467(descendant)

		if v473 and descendant.Parent == nil then
			fpsAreaDeleted += 1
		end

		n5 += 1

		if n5 >= 250 then
			n5 = 0
			RunService.Heartbeat:Wait()
		end
	end

	zeroinConfig._fpsAreaListener = connection4
	zeroinConfig._fpsAreaDeleted = fpsAreaDeleted
	zeroinConfig._fpsAreasReady = true

	return true
end
local function v474()
	if zeroinConfig._fpsPlotsReady then
		return true
	end

	local u475 = false
	local ok, result = pcall(function()
		local PlotState2 = require(game:GetService("ReplicatedStorage").Client.PlotState)

		if PlotState2.GetMySlot() == nil then
			warn("[FPSBoost] Slot plot kita belum ke-resolve, skip delete plot dulu (biar aman).")

			return
		end

		local function v479(p78)
			local v480 = PlotState2.GetMySlot()

			return v480 ~= nil and p78.Name == tostring(v480)
		end

		local Plots = PlotState2.GetPlotsFolder() or workspace:WaitForChild("Plots", 10)

		if not Plots then
			warn("[FPSBoost] workspace.Plots gak ketemu sama sekali.")

			return
		end

		local children = Plots:GetChildren()
		local n6 = 0

		for _, child in ipairs(children) do
			if not v479(child) and pcall(function()
				child:Destroy()
			end) then
				n6 += 1
			end
		end

		Plots.ChildAdded:Connect(function(child)
			task.defer(function()
				if child.Parent then
					if not v479(child) then
						pcall(function()
							child:Destroy()
						end)
					end
				end
			end)
		end)
		u475 = true
	end)

	if not ok then
		warn("[FPSBoost] Gagal delete plot pemain lain:", result)

		return false
	end

	return u475
end
local function v486()
	if zeroinConfig._fpsTreadmillsReady then
		return true
	end

	local u487 = false
	local ok, result = pcall(function()
		local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
		local PlotState2 = require(ReplicatedStorage2.Client.PlotState)
		local RuntimeInstanceRegistry = require(ReplicatedStorage2.Client.Modules.RuntimeInstanceRegistry)
		local __ClientTreadmillRenders = workspace:FindFirstChild("__ClientTreadmillRenders") or workspace:WaitForChild("__ClientTreadmillRenders", 10)

		if not __ClientTreadmillRenders then
			return
		end

		local function v494()
			local v495 = PlotState2.GetMySlot()

			if v495 == nil then
				return nil
			end

			local ok, result = pcall(RuntimeInstanceRegistry.Get, "TreadmillPlotRender", tostring(v495))

			if ok then
				return result
			end

			return nil
		end
		local function v498(p79)
			local v499 = v494()

			if v499 then
				if p79 == v499 then
					return true
				end
			end

			local ok, result = pcall(function()
				return p79:GetPivot().Position
			end)

			if not ok then
				return true
			end

			local ok2, result2 = pcall(PlotState2.IsWorldPositionWithinLocalPlotBounds, result)

			return ok2 and result2
		end

		local children = __ClientTreadmillRenders:GetChildren()
		local n7 = 0

		for _, child in ipairs(children) do
			if child:IsA("Model") and not v498(child) and pcall(function()
				child:Destroy()
			end) then
				n7 += 1
			end
		end

		__ClientTreadmillRenders.ChildAdded:Connect(function(child)
			task.defer(function()
				if child.Parent then
					if child:IsA("Model") and not v498(child) then
						pcall(function()
							child:Destroy()
						end)
					end
				end
			end)
		end)
		u487 = true
	end)

	if not ok then
		warn("[FPSBoost] Gagal delete treadmill pemain lain:", result)

		return false
	end

	return u487
end
local function v508()
	if zeroinConfig._fpsBoostApplying then
		return
	end

	zeroinConfig._fpsBoostApplying = true

	local ok, result = pcall(function()
		if type(genv.__ZeroinSetCapFps) == "function" then
			pcall(genv.__ZeroinSetCapFps, 240)
		end

		v447()
		v435()
		zeroinConfig._fpsPlotsReady = v474() == true
		zeroinConfig._fpsTreadmillsReady = v486() == true
		zeroinConfig._fpsAreasReady = v454() == true
		zeroinConfig._fpsPetsReady = v421() == true
		zeroinConfig._fpsEggsReady = v412() == true
	end)

	zeroinConfig._fpsBoostApplying = nil

	if not ok then
		warn("[FPSBoost] Gagal menerapkan FPS Boost:", result)
	end
end

local v511 = v305:Window({
	Title = "Zeroin",
	Footer = "Steal An Egg",
	Version = "3.0.0",
	Discord = "https://discord.gg/CvVW5DBZKR",
	Color = Color3.fromRGB(0, 205, 122),
	Color2 = Color3.fromRGB(1, 18, 11),
	["Tab Width"] = 130,
	Image = "79481584966698",
	WindowIMG = "124404129684886",
	LogoHUB = "124404129684886",
	NotificationIcon = "124404129684886"
})
local v512 = v511

local function v513(p80, p81, p82)
	local u514 = true

	pcall(function()
		local filterDescendantsInstances = { p82 }
		local raycastParams = RaycastParams.new()

		raycastParams.FilterType = Enum.RaycastFilterType.Exclude

		local v517 = p80

		for i = 1, 8 do
			raycastParams.FilterDescendantsInstances = filterDescendantsInstances

			local v519 = p81 - v517

			if not (v519.Magnitude < 1) then
				local hit = workspace:Raycast(v517, v519, raycastParams)

				if hit then
					if hit.Instance.CanCollide then
						u514 = false

						break
					end

					table.insert(filterDescendantsInstances, hit.Instance)
					v517 = hit.Position + v519.Unit * 0.1

					continue
				end
			end

			break
		end
	end)

	return u514
end

local t20 = {}

local function v522()
	local t21 = {}

	t21.__index = t21

	local t22 = {
		auto_place = true,
		auto_fuse = true,
		auto_mutate = true,
		equip_best = true
	}
	local t23 = {
		auto_dr_scramble = 120,
		auto_steal = 100,
		auto_the_rift = 95,
		auto_hatch = 80,
		auto_place = 70,
		auto_mutate = 60,
		auto_fuse = 50,
		equip_best = 40,
		rewards = 20
	}

	local function v526(p83)
		local t24 = {}

		for k, v in pairs(p83) do
			t24[k] = v
		end

		return t24
	end

	t21.new = function()
		local obj = setmetatable({}, t21)

		obj.destroyed = false
		obj.active = nil
		obj.background = nil
		obj.reservations = {}
		obj.protections = {}
		obj.categoryProtections = {}
		obj.listeners = {}
		obj.backgroundListeners = {}
		obj.serial = 0

		return obj
	end
	t21._snapshot = function(p84)
		local active = p84.active

		return {
			busy = active ~= nil,
			operation = active and active.owner or nil,
			priority = active and active.priority or 0,
			reservedCount = active and #active.uids or 0,
			reservations = v526(p84.reservations)
		}
	end
	t21._emit = function(p85)
		local v532 = p85:_snapshot()

		for k in pairs(p85.listeners) do
			local ok, result = pcall(k, v532)

			if not ok then
				warn("[StealAnEgg] Coordinator listener failed:", result)
			end
		end
	end
	t21._emitBackground = function(p86)
		local background = p86.background
		local t25 = {
			busy = background ~= nil,
			operation = background and background.owner or nil
		}

		for k in pairs(p86.backgroundListeners) do
			local ok, result = pcall(k, t25)

			if not ok then
				warn("[StealAnEgg] Background coordinator listener failed:", result)
			end
		end
	end
	t21.subscribe = function(p87, p88)
		p87.listeners[p88] = true
		pcall(p88, p87:_snapshot())

		return function()
			p87.listeners[p88] = nil
		end
	end
	t21.subscribeBackground = function(p89, p90)
		p89.backgroundListeners[p90] = true

		local pcall_ = pcall
		local v542 = p90

		pcall_(v542, {
			busy = p89.background ~= nil,
			operation = p89.background and p89.background.owner or nil
		})

		return function()
			p89.backgroundListeners[p90] = nil
		end
	end
	t21.getSnapshot = function(p91)
		return p91:_snapshot()
	end
	t21.isBackgroundBusy = function(p92)
		return p92.background ~= nil
	end
	t21.isReserved = function(p93, p94, p95)
		local v543 = p93.reservations[p94]

		if v543 ~= nil and v543 ~= p95 then
			return true
		end

		local v544 = p93.protections[p94]

		if v544 == nil or v544 == p95 then
			return false
		end

		if v544 == "auto_the_rift" and (p95 == "auto_place" or p95 == "auto_hatch") then
			return false
		end

		return true
	end
	t21.isCategoryProtected = function(p96, p97, p98)
		local v545 = p96.categoryProtections[p97]

		if v545 == nil or v545 == p98 then
			return false
		end

		if v545 == "auto_the_rift" and (p98 == "auto_place" or p98 == "auto_hatch") then
			return false
		end

		return true
	end
	t21.setProtectedCategories = function(p99, p100, p101)
		if type(p100) ~= "string" or p100 == "" then
			return false
		end

		local t26 = {}
		local ipairs_ = ipairs
		local v548 = type(p101) == "table" and p101 or {}

		for _, v in ipairs_(v548) do
			if type(v) == "string" and v ~= "" then
				t26[v] = true
			end
		end

		local v551 = false

		for k, categoryProtection in pairs(p99.categoryProtections) do
			if not (categoryProtection ~= p100 or t26[k]) then
				p99.categoryProtections[k] = nil
				v551 = true
			end
		end

		for k in pairs(t26) do
			if p99.categoryProtections[k] ~= p100 then
				p99.categoryProtections[k] = p100
				v551 = true
			end
		end

		if v551 then
			p99:_emit()
		end

		return true
	end
	t21.setProtected = function(p102, p103, p104)
		if type(p103) ~= "string" or p103 == "" then
			return false
		end

		local t27 = {}
		local ipairs_ = ipairs
		local v557 = type(p104) == "table" and p104 or {}

		for _, v in ipairs_(v557) do
			if type(v) == "string" and v ~= "" then
				t27[v] = true
			end
		end

		local v560 = false

		for k, protection in pairs(p102.protections) do
			if protection == p103 and not t27[k] then
				p102.protections[k] = nil
				v560 = true
			end
		end

		for k in pairs(t27) do
			if p102.protections[k] ~= p103 then
				p102.protections[k] = p103
				v560 = true
			end
		end

		if v560 then
			p102:_emit()
		end

		return true
	end
	t21.clearProtected = function(p105, p106)
		for k, protection in pairs(p105.protections) do
			if p106 == nil or protection == p106 then
				p105.protections[k] = nil
			end
		end

		for k, categoryProtection in pairs(p105.categoryProtections) do
			if p106 == nil or categoryProtection == p106 then
				p105.categoryProtections[k] = nil
			end
		end

		p105:_emit()
	end
	t21.tryAcquire = function(p107, p108, p109, p110)
		if p107.destroyed then
			return nil, "Coordinator destroyed"
		end

		if type(p108) ~= "string" or p108 == "" then
			return nil, "Invalid operation owner"
		end

		if p107.active then
			return nil, "Busy: " .. p107.active.owner
		end

		if p107.background and t22[p108] then
			return nil, "Busy: background " .. p107.background.owner
		end

		local t28 = {}
		local t29 = {}
		local ipairs_ = ipairs
		local v571 = type(p109) == "table" and p109 or {}

		for _, v in ipairs_(v571) do
			if type(v) ~= "string" or v == "" or t29[v] then
				continue
			end

			if p107:isReserved(v, p108) then
				return nil, "UID reserved by " .. tostring(p107.reservations[v])
			end

			t29[v] = true
			table.insert(t28, v)
		end

		p107.serial += 1

		local active = {
			id = p107.serial,
			lane = "foreground",
			owner = p108,
			priority = tonumber(p110) or t23[p108] or 0,
			uids = t28,
			released = false
		}

		p107.active = active

		for _, v in ipairs(t28) do
			p107.reservations[v] = p108
		end

		p107:_emit()

		return active
	end
	t21.tryAcquireBackground = function(p111, p112, p113)
		if p111.destroyed then
			return nil, "Coordinator destroyed"
		end

		if type(p112) ~= "string" or p112 == "" then
			return nil, "Invalid operation owner"
		end

		if p111.background then
			return nil, "Background busy: " .. p111.background.owner
		end

		if p111.active and t22[p111.active.owner] then
			return nil, "Foreground tool busy: " .. p111.active.owner
		end

		local t30 = {}
		local t31 = {}
		local ipairs_ = ipairs
		local v580 = type(p113) == "table" and p113 or {}

		for _, v in ipairs_(v580) do
			if type(v) ~= "string" then
				continue
			end

			if v ~= "" then
				if t31[v] then
					continue
				end

				if p111:isReserved(v, p112) then
					return nil, "UID reserved by " .. tostring(p111.reservations[v])
				end

				t31[v] = true
				table.insert(t30, v)
			end
		end

		p111.serial += 1

		local background = {
			id = p111.serial,
			lane = "background",
			owner = p112,
			priority = 0,
			uids = t30,
			released = false
		}

		p111.background = background

		for _, v in ipairs(t30) do
			p111.reservations[v] = p112
		end

		p111:_emitBackground()

		return background
	end
	t21.release = function(p114, p115)
		if type(p115) == "table" then
			if not p115.released then
				p115.released = true

				local ipairs_ = ipairs
				local uids = p115.uids or {}

				for _, uid in ipairs_(uids) do
					if p114.reservations[uid] == p115.owner then
						p114.reservations[uid] = nil
					end
				end

				local v590 = p114.active == p115

				if v590 then
					p114.active = nil
				elseif p114.background == p115 then
					p114.background = nil
					p114:_emitBackground()
				end

				if v590 then
					p114:_emit()
				end

				return true
			end
		end

		return false
	end
	t21.forceRelease = function(p116, p117)
		local active = p116.active

		if active and (p117 == nil or active.owner == p117) then
			return p116:release(active)
		end

		return false
	end
	t21.destroy = function(p118)
		if p118.destroyed then
			return
		end

		p118.destroyed = true

		if p118.active then
			p118:release(p118.active)
		end

		if p118.background then
			p118:release(p118.background)
		end

		table.clear(p118.reservations)
		table.clear(p118.protections)
		table.clear(p118.categoryProtections)
		table.clear(p118.listeners)
		table.clear(p118.backgroundListeners)
	end

	return t21
end

local v592 = v522()

local function v593()
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local Areas = require(ReplicatedStorage2.Data.Areas)
	local Assets = require(ReplicatedStorage2.Data.Assets)
	local Guards = require(ReplicatedStorage2.Data.Guards)
	local Mutations = require(ReplicatedStorage2.Shared.Modules.Mutations)

	local function v599(p119)
		local t32 = {}
		local t33 = {}

		for _, v in ipairs(p119) do
			if type(v) == "string" and v ~= "" and not t32[v] then
				t32[v] = true
				table.insert(t33, v)
			end
		end

		table.sort(t33)

		return t33
	end

	return {
		getRarities = function()
			local t34 = {}

			for k in pairs(Assets.ByRarity) do
				table.insert(t34, k)
			end

			table.sort(t34, function(p120, p121)
				local key = Assets.ByRarity[p120] and next(Assets.ByRarity[p120])
				local key2 = Assets.ByRarity[p121] and next(Assets.ByRarity[p121])
				local v608 = key and Assets.Directory[key]
				local v609 = key2 and Assets.Directory[key2]

				return (v608 and v608.Rarity and v608.Rarity.RarityNumber or 0) > (v609 and v609.Rarity and v609.Rarity.RarityNumber or 0)
			end)

			return t34
		end,
		getNames = function()
			local t35 = {}

			for _, v in pairs(Assets.Directory) do
				table.insert(t35, v.DisplayName or v._id)
			end

			return v599(t35)
		end,
		getAreas = function()
			local t36 = {}

			for k, v in pairs(Areas.Directory) do
				if type(k) == "string" and type(v) == "table" and type(v.DropTable) == "table" then
					table.insert(t36, k)
				end
			end

			table.sort(t36, function(p122, p123)
				local v616 = Guards.Directory[p122]
				local v617 = Guards.Directory[p123]
				local WalkSpeed = v616 and v616.WalkSpeed or math.huge
				local WalkSpeed2 = v617 and v617.WalkSpeed or math.huge

				if WalkSpeed == WalkSpeed2 then
					return p122 < p123
				end

				return WalkSpeed < WalkSpeed2
			end)

			return t36
		end,
		getMutations = function()
			local t37 = {}
			local v621 = Mutations.Ids()
			local pairs_ = pairs
			local v623 = type(v621) == "table" and v621 or {}

			for k in pairs_(v623) do
				if type(k) == "string" and k ~= Mutations.NO_MUTATION then
					local ok, result = pcall(Mutations.LabelOf, k)

					table.insert(t37, ok and type(result) == "string" and result ~= "" and result or k)
				end
			end

			return v599(t37)
		end,
		resolveMutationId = function(p124)
			if type(p124) ~= "string" then
				return nil
			end

			if Mutations.IdSet[p124] then
				return p124
			end

			for k in pairs(Mutations.Ids()) do
				if k ~= Mutations.NO_MUTATION then
					if Mutations.LabelOf(k) == p124 then
						return k
					end
				end
			end

			return nil
		end,
		resolve = function(p125)
			local v628 = p125 and Assets.Directory[p125.AssetCategory]
			local Rarity = v628 and v628.Rarity

			return {
				name = v628 and (v628.DisplayName or v628._id) or p125 and p125.AssetCategory or "Unknown",
				category = p125 and p125.AssetCategory or "Unknown",
				rarity = Rarity and (Rarity.DisplayName or Rarity._id) or "Unknown",
				rarityRank = Rarity and Rarity.RarityNumber or 0,
				rarityColor = Rarity and Rarity.Color or nil
			}
		end
	}
end

local v630 = v593()

local function v631()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local RunService2 = game:GetService("RunService")
	local LocalPlayer2 = Players2.LocalPlayer
	local EggState2 = require(ReplicatedStorage2.Client.EggState)
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local EggWorld = Remotes.EggWorld
	local AreaEggs = require(ReplicatedStorage2.Shared.Types.AreaEggs)
	local AreaEggSlotIdentity = require(ReplicatedStorage2.Shared.Util.AreaEggSlotIdentity)
	local AreaEggResetWall2 = require(ReplicatedStorage2.Client.AreaEggResetWall)
	local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
	local ToolGameplayGuard = require(ReplicatedStorage2.Client.ToolGameplayGuard)
	local Client = require(ReplicatedStorage2.Shared.Modules.BatController.Client)
	local t38 = {
		Divine = true,
		Eternal = true,
		Secret = true
	}
	local t39 = {
		"LastObservedSample",
		"LastSample",
		"LastGoodSample",
		"LastGameplayTrustedSample",
		"LastValidatedSample",
		"LastValidatedGroundedSample",
		"LastConfirmedGroundSample",
		"CandidateGroundedSample"
	}
	local vector32 = Vector3.new(545, 71, -365)
	local t40 = {
		Script = true,
		LocalScript = true,
		BillboardGui = true,
		Sound = true
	}
	local t41 = {}

	t41.__index = t41

	local Stats = game:GetService("Stats")

	local function v651(p126, p127, p128)
		local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart then
			pcall(function()
				HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
			end)
		end

		if not p128 then
			local n8 = 0

			pcall(function()
				n8 = Stats.Network.ServerStats.Ping:GetValue()
			end)
			task.wait(math.max(0.12, n8 * 1.5 / 1000))
		end

		local t42 = {
			Uid = p126
		}

		if p127 ~= nil then
			t42.FirstAreaSlotKey = p127
		end

		local response, v656 = EggWorld.AskFieldEggCarry:InvokeServer(t42)
		local v657 = response == true
		local v658 = typeof(v656) == "string" and v656 or nil

		return v657, v658
	end
	local function v659(p129, p130, p131)
		local connection4 = p129:Connect(p130)

		table.insert(p131, connection4)

		return connection4
	end
	local function v661(p132)
		for _, v in ipairs(p132) do
			pcall(v.Disconnect, v)
		end

		table.clear(p132)
	end
	local function v664(p133, p134)
		local ipairs_ = ipairs
		local v666 = p133 or {}

		for _, v in ipairs_(v666) do
			if v == p134 then
				return true
			end
		end

		return false
	end

	local v669

	local function v670(p135, p136)
		if type(p135) == "function" then
			if type(debug) == "table" and type(debug.getconstants) == "function" then
				local ok, result = pcall(debug.getconstants, p135)

				if not ok or type(result) ~= "table" then
					return false
				end

				local t43 = {}

				for _, v in ipairs(result) do
					if type(v) == "string" then
						t43[v] = true
					end
				end

				for _, v in ipairs(p136) do
					if not t43[v] then
						return false
					end
				end

				return true
			end
		end

		return false
	end
	local function v678(p137)
		if type(p137) ~= "function" or type(debug) ~= "table" or type(debug.info) ~= "function" then
			return ""
		end

		local ok, result = pcall(debug.info, p137, "s")

		return ok and tostring(result) or ""
	end
	local function v681(p138)
		local HumanoidRootPart = p138 and p138:FindFirstChild("HumanoidRootPart")

		if HumanoidRootPart then
			HumanoidRootPart:SetAttribute("KillPartIgnore", true)
		end
	end
	local function v683(p139)
		if p139._healthPinner then
			pcall(p139._healthPinner.Disconnect, p139._healthPinner)
			p139._healthPinner = nil
		end

		if p139._healthChangedConnection then
			pcall(p139._healthChangedConnection.Disconnect, p139._healthChangedConnection)
			p139._healthChangedConnection = nil
		end
	end
	local function v684(p140, p141)
		v683(p140)

		local Humanoid = p141 and p141:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = p141 and p141:FindFirstChild("HumanoidRootPart")

		if not Humanoid then
			return false
		end

		local MaxHealth = Humanoid.MaxHealth > 0 and Humanoid.MaxHealth or 100
		local u688 = false

		local function v689()
			if u688 or p140.destroyed or LocalPlayer2.Character ~= p141 or Humanoid.Parent ~= p141 then
				return
			end

			u688 = true
			pcall(function()
				Humanoid.BreakJointsOnDeath = false
				Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, false)

				if Humanoid.Health <= 0 then
					Humanoid.Health = MaxHealth
				end

				if Humanoid:GetState() == Enum.HumanoidStateType.Dead then
					Humanoid:ChangeState(Enum.HumanoidStateType.Running)
				end

				if HumanoidRootPart and HumanoidRootPart.Parent == p141 and HumanoidRootPart.Anchored then
					HumanoidRootPart.Anchored = false
				end
			end)
			u688 = false
		end

		v689()
		p140._healthChangedConnection = Humanoid.HealthChanged:Connect(function(health)
			if health < MaxHealth then
				v689()
			end
		end)
		p140._healthPinner = RunService2.RenderStepped:Connect(v689)

		return true
	end

	t41.acquireHealthProtection = function(p142, p143)
		if type(p143) ~= "string" or p143 == "" or p142.destroyed then
			return false
		end

		p142.healthProtectionOwners[p143] = true

		local Character = LocalPlayer2.Character

		return Character ~= nil and v684(p142, Character) or false
	end
	t41.releaseHealthProtection = function(p144, p145)
		if type(p145) == "string" then
			p144.healthProtectionOwners[p145] = nil
		end

		if next(p144.healthProtectionOwners) == nil then
			v683(p144)
		end
	end

	local function v691(p146)
		local Humanoid = p146 and p146:FindFirstChildOfClass("Humanoid")

		if not Humanoid then
			return
		end

		pcall(function()
			if Humanoid.Health <= 0 then
				Humanoid.Health = math.max(Humanoid.MaxHealth, 1)
			end

			Humanoid:SetStateEnabled(Enum.HumanoidStateType.Dead, true)
			Humanoid.BreakJointsOnDeath = true
			Humanoid.RequiresNeck = true
		end)
	end
	local function v693()
		local genv2 = getgenv and getgenv()

		return genv2 or _G
	end
	local function v695()
		local v696 = v693()
		local __FyyStealAnEggMovementSpoof = v696.__FyyStealAnEggMovementSpoof

		if type(__FyyStealAnEggMovementSpoof) ~= "table" or __FyyStealAnEggMovementSpoof.Version ~= 436 then
			if type(__FyyStealAnEggMovementSpoof) == "table" then
				__FyyStealAnEggMovementSpoof.Enabled = false
			end

			__FyyStealAnEggMovementSpoof = {
				Version = 436,
				Installed = false,
				Enabled = false,
				Mode = "StateBaseline",
				Humanoid = nil,
				RootPart = nil,
				WalkSpeed = 800
			}
			v696.__FyyStealAnEggMovementSpoof = __FyyStealAnEggMovementSpoof
		end

		return __FyyStealAnEggMovementSpoof
	end
	local function v698(p147, p148)
		local v699 = v695()

		if not v699 then
			return false
		end

		local Humanoid = p147 and p147:FindFirstChildOfClass("Humanoid")
		local HumanoidRootPart = p147 and p147:FindFirstChild("HumanoidRootPart")

		v699.Humanoid = Humanoid
		v699.RootPart = HumanoidRootPart
		v699.WalkSpeed = math.clamp(tonumber(p148) or 800, 200, 1620)
		v699.Enabled = false

		return Humanoid ~= nil and HumanoidRootPart ~= nil
	end
	local function v702()
		local __FyyStealAnEggMovementSpoof = v693().__FyyStealAnEggMovementSpoof

		if type(__FyyStealAnEggMovementSpoof) == "table" then
			__FyyStealAnEggMovementSpoof.Enabled = false
			__FyyStealAnEggMovementSpoof.Humanoid = nil
			__FyyStealAnEggMovementSpoof.RootPart = nil
		end
	end
	local function v704(p149, p150, p151)
		local u705

		if type(getcallbackvalue) == "function" and type(debug) == "table" and type(debug.getupvalue) == "function" then
			local Signal = ReplicatedStorage2:FindFirstChild("Packages") and ReplicatedStorage2.Packages:FindFirstChild("Signal")

			if Signal then
				local ok, result = pcall(require, Signal)

				if ok and type(result) == "table" and type(result.Invoked) == "function" then
					local ok2, result2 = pcall(result.Invoked, "ClientCharacter: GetDebugSnapshot")

					if ok2 and result2 then
						local ok3, result3 = pcall(getcallbackvalue, result2, "OnInvoke")

						if ok3 and type(result3) == "function" then
							local ok4, result4 = pcall(debug.getinfo, result3)

							if ok4 then
								local function v715(p152, p153, p154)
									if u705 or type(p152) ~= "table" or p153 > 3 or p154[p152] then
										return
									end

									p154[p152] = true

									if rawget(p152, "Player") == p149 and rawget(p152, "Character") == p149.Character and rawget(p152, "Humanoid") == p150 and rawget(p152, "RootPart") == p151 and type(rawget(p152, "SampleHistory")) == "table" and type(rawget(p152, "Evidence")) == "table" then
										u705 = p152

										return
									end

									local n9 = 0

									for _, v in pairs(p152) do
										n9 += 1

										if n9 > 128 then
											break
										end

										if type(v) == "table" then
											v715(v, p153 + 1, p154)
										end
									end
								end

								local n10 = 1
								local nups = result4.nups or 0

								for i = n10, nups do
									local ok5, result5 = pcall(debug.getupvalue, result3, i)

									if ok5 then
										if type(result5) ~= "table" then
											continue
										end

										v715(result5, 0, {})

										if not u705 then
											continue
										end
									else
										continue
									end

									break
								end
							end
						end
					end
				end
			end
		end

		if not u705 and type(getgc) == "function" then
			local ok, result = pcall(getgc, true)

			if ok and type(result) == "table" then
				for _, v in ipairs(result) do
					if type(v) == "table" and rawget(v, "Player") == p149 and rawget(v, "Character") == p149.Character and rawget(v, "Humanoid") == p150 and rawget(v, "RootPart") == p151 and type(rawget(v, "SampleHistory")) == "table" and type(rawget(v, "Evidence")) == "table" then
						u705 = v

						break
					end
				end
			end
		end

		return u705
	end
	local function v728(p155, p156, p157)
		if type(p155) ~= "table" then
			return false
		end

		local value = rawget(p155, "RootPart")
		local CFrame_2 = value and value.Parent and value.CFrame or nil
		local Position = CFrame_2 and CFrame_2.Position or nil
		local vector33 = typeof(p157) == "Vector3" and p157 or Vector3.zero

		local function v733(p158)
			if type(p158) == "table" then
				rawset(p158, "WalkSpeed", p156)

				if CFrame_2 then
					rawset(p158, "CFrame", CFrame_2)
					rawset(p158, "Position", Position)
					rawset(p158, "LinearVelocity", vector33)
					rawset(p158, "AngularVelocity", Vector3.zero)
				end
			end
		end

		for _, v in ipairs(t39) do
			v733(rawget(p155, v))
		end

		local pairs_ = pairs
		local v737 = rawget(p155, "SampleHistory") or {}

		for _, v in pairs_(v737) do
			v733(v)
		end

		local pairs_2 = pairs
		local v741 = rawget(p155, "SafeGroundCheckpoints") or {}

		for _, v in pairs_2(v741) do
			v733(v)
		end

		local value2 = rawget(p155, "Evidence")

		if type(value2) == "table" then
			value2.Speed = 0
			value2.Teleport = 0
			value2.Flight = 0
		end

		local value3 = rawget(p155, "ImpulseContext")

		if type(value3) == "table" then
			local maxHorizontalSpeed = math.max(tonumber(value3.MaxHorizontalSpeed) or 0, p156)
			local v747 = math.max((tonumber(value3.ExpiresAt) or 0) - (tonumber(value3.StartedAt) or 0), 0.05)

			value3.MaxHorizontalSpeed = maxHorizontalSpeed

			if Position then
				value3.OriginPosition = Position
			end

			value3.MaxHorizontalDistance = math.max(tonumber(value3.MaxHorizontalDistance) or 0, maxHorizontalSpeed * v747 + 48)
			v733(value3.PreMovementSafeSample)
		end

		if rawget(p155, "CorrectionContext") == nil then
			rawset(p155, "FirstSuspiciousAt", nil)

			if rawget(p155, "ThreatLevel") == "Observing" then
				rawset(p155, "ThreatLevel", "Trusted")
			end
		end

		return true
	end
	local function v748()
		local v749 = v693()
		local __FyyStealAnEggIntegritySpoof = v749.__FyyStealAnEggIntegritySpoof

		if type(__FyyStealAnEggIntegritySpoof) ~= "table" then
			__FyyStealAnEggIntegritySpoof = {}
			v749.__FyyStealAnEggIntegritySpoof = __FyyStealAnEggIntegritySpoof
		end

		return __FyyStealAnEggIntegritySpoof
	end
	local function v751(p159, p160, p161)
		return type(p159) == "table" and rawget(p159, "Player") == LocalPlayer2 and rawget(p159, "Character") == LocalPlayer2.Character and rawget(p159, "Humanoid") == p160 and rawget(p159, "RootPart") == p161
	end
	local function v752(p162, p163, p164)
		return v751(p162, p163, p164)
	end
	local function v753(p165, p166, p167)
		local v754 = v748()
		local State = v754.State

		if not v751(State, p165, p166) then
			local now = os.clock()

			if now < (v754.NextSearchAt or 0) then
				return false
			end

			v754.NextSearchAt = now + 0.2
			State = v704(LocalPlayer2, p165, p166)
		end

		if not State then
			return false
		end

		if not v752(State, p165, p166) then
			v754.Enabled = false
			v754.Humanoid = p165
			v754.RootPart = p166
			v754.State = State

			return false
		end

		v754.NextSearchAt = 0
		v754.Enabled = true
		v754.Humanoid = p165
		v754.RootPart = p166
		v754.State = State
		v754.WalkSpeed = math.clamp(p167 * 1.35, 200, 1620)
		v754.TravelVelocity = Vector3.zero
		v728(State, v754.WalkSpeed, v754.TravelVelocity)

		return true
	end
	local function v757(p168, p169, p170, p171)
		local __FyyStealAnEggIntegritySpoof = v693().__FyyStealAnEggIntegritySpoof

		if type(__FyyStealAnEggIntegritySpoof) ~= "table" or not __FyyStealAnEggIntegritySpoof.Enabled or __FyyStealAnEggIntegritySpoof.Humanoid ~= p168 or __FyyStealAnEggIntegritySpoof.RootPart ~= p169 or not v752(__FyyStealAnEggIntegritySpoof.State, p168, p169) then
			return false
		end

		__FyyStealAnEggIntegritySpoof.WalkSpeed = math.clamp(p170 * 1.35, 200, 1620)

		if typeof(p171) == "Vector3" then
			__FyyStealAnEggIntegritySpoof.TravelVelocity = p171
		elseif typeof(__FyyStealAnEggIntegritySpoof.TravelVelocity) ~= "Vector3" then
			__FyyStealAnEggIntegritySpoof.TravelVelocity = Vector3.zero
		end

		return v728(__FyyStealAnEggIntegritySpoof.State, __FyyStealAnEggIntegritySpoof.WalkSpeed, __FyyStealAnEggIntegritySpoof.TravelVelocity)
	end
	local function v759(p172)
		local __FyyStealAnEggIntegritySpoof = v693().__FyyStealAnEggIntegritySpoof

		if type(__FyyStealAnEggIntegritySpoof) ~= "table" then
			return
		end

		if p172 == nil or __FyyStealAnEggIntegritySpoof.Humanoid == p172 then
			__FyyStealAnEggIntegritySpoof.Enabled = false
			__FyyStealAnEggIntegritySpoof.Humanoid = nil
			__FyyStealAnEggIntegritySpoof.RootPart = nil
			__FyyStealAnEggIntegritySpoof.State = nil
			__FyyStealAnEggIntegritySpoof.TravelVelocity = nil
			__FyyStealAnEggIntegritySpoof.NextSearchAt = 0
		end
	end

	t41.new = function(p173, p174, p175)
		local obj = setmetatable({}, t41)

		obj.catalog = p173
		obj.isPremium = p175 == true
		obj.preEventReadyAt = os.clock() + 2
		obj.coordinator = p174
		obj.operationToken = nil
		obj.connections = {}
		obj.healthProtectionOwners = {}
		obj.listeners = {}
		obj.records = {}
		obj.enabled = false
		obj.userStealEnabled = false
		obj.riftObjectiveEnabled = false
		obj.riftRequiredCategories = {}
		obj.running = false
		obj.safeStarting = false
		obj.movementRetryPending = false
		obj.destroyed = false
		obj.resetBlocked = AreaEggResetWall2.IsSealed()
		obj.gateOpenAt = obj.resetBlocked and math.huge or os.clock()
		obj.activeTween = nil
		obj.activeTarget = nil
		obj.claimPresentationNode = nil
		obj.claimPresentationOriginal = nil
		obj.claimPresentationSuppression = nil
		obj.carry = {
			active = false,
			uid = nil,
			generation = 0
		}
		obj.manualCarry = {
			active = false,
			uid = nil,
			generation = 0
		}
		obj.carryWorker = nil
		obj.tweenRecoveryUid = nil
		obj.planGeneration = 0
		obj.treadmillDecoy = nil
		obj.treadmillDecoyCamera = nil
		obj.treadmillDecoyCameraConnection = nil
		obj.treadmillDecoyCharacterConnection = nil
		obj.treadmillPopupConnection = nil
		obj.treadmillDecoyRealTransparency = nil
		obj.hoverPadOwnerId = string.format("%s:%0.6f", tostring(obj), os.clock())
		obj.zigzagWalls = obj:_snapshotZigzagWalls()
		obj.instantPhase = nil
		obj.primerUid = nil
		obj.lastAbandonedPrimerUid = nil
		obj.hasDepositedThisSession = false
		obj.targetUid = nil
		obj.resetSnapshotPending = false
		obj.lastAreaState = type(obj.catalog.getLastAreaState) == "function" and obj.catalog.getLastAreaState() or nil
		obj.panelTargetUid = nil
		obj.panelActiveUid = nil
		obj.intentionalGiftUid = nil
		obj.giftDropUids = {}
		obj.continueFromForestGift = false
		obj.playerHuntToken = nil
		obj.playerHuntCarrier = nil
		obj.playerStealBatAuraInstalled = false
		obj.hitTimer = nil
		obj.guardHitBoostInstalled = false
		obj.startupSettled = false
		obj.drScrambleRuntime = nil
		obj.drScrambleObjectiveEnabled = false
		obj.drScrambleRouteActive = false
		obj.drScrambleNeedsSafeReturn = false
		obj.captureTheEggRuntime = nil
		obj.stats = {
			status = obj.resetBlocked and "Reset wall closed" or "Ready",
			available = 0,
			matching = 0,
			lastTarget = "None",
			lastResult = "Idle"
		}
		obj.config = {
			stealMode = "Tween",
			speed = 800,
			stealZigzag = false,
			dropAtFirstArea = false,
			stealFromPlayers = false,
			minValuePerSec = 0,
			rarityEnabled = false,
			rarities = {},
			nameEnabled = false,
			names = {},
			areaEnabled = false,
			areas = {}
		}
		task.delay(3, function()
			if not obj.destroyed and not obj.startupSettled then
				obj:markStartupSettled()
			end
		end)

		if LocalPlayer2.Character then
			v681(LocalPlayer2.Character)
		end

		obj:_replaceSnapshot(EggState2.ReadFieldEggs())
		v659(EggState2.FieldRefreshed, function(p176)
			obj:_replaceSnapshot(p176)
		end, obj.connections)
		v659(EggState2.FieldShifted, function(p177)
			obj.records[p177.Uid] = p177

			if p177.State == AreaEggs.States.GuardCarried and obj.running and obj.activeTarget and obj.activeTarget.Uid == p177.Uid and not obj:isPrimerEgg(p177.Uid) and not obj:isIntentionalGiftDrop(p177.Uid) then
				obj.dropRecoveryUid = p177.Uid
			end

			obj:_refreshCounts()
		end, obj.connections)
		v659(EggState2.FieldGone, function(p178)
			obj.records[p178] = nil

			if obj.panelTargetUid == p178 then
				obj.panelTargetUid = nil
			end

			if obj.playerHuntToken and obj.activeTarget and obj.activeTarget.Uid == p178 then
				obj:_refreshCounts()

				return
			end

			if obj.activeTarget and obj.activeTarget.Uid == p178 then
				if obj:_isDropRecoveryPending(p178) then
					obj:_refreshCounts()

					return
				end

				if obj.carry.active and obj.carry.uid == p178 then
					obj:_refreshCounts()

					return
				end

				obj.carryAttemptToken = nil
				obj:_clearArrivalHold(p178)

				if obj.activeTween and obj.activeTween.Cancel then
					pcall(obj.activeTween.Cancel, obj.activeTween)
				end

				local activeTarget = obj.activeTarget

				task.delay(0.65, function()
					if obj.destroyed or not obj.enabled then
						return
					end

					if obj.carry.active and obj.carry.uid == p178 then
						return
					end

					if obj:_isDropRecoveryPending(p178) then
						return
					end

					if obj.activeTarget == activeTarget and activeTarget.Uid == p178 then
						obj:_finish("Target removed — continuing")
					end
				end)
			end

			obj:_refreshCounts()
		end, obj.connections)
		v659(EggState2.ResetCountdown, function()
			obj.resetSnapshotPending = true
			obj.planGeneration += 1
			obj.panelTargetUid = nil
			obj.panelActiveUid = nil
			obj.intentionalGiftUid = nil
			table.clear(obj.giftDropUids)
			obj.continueFromForestGift = false
			obj:_closeGate("Egg reset countdown")
		end, obj.connections)
		v659(EggState2.ResetFade, function()
			obj.resetSnapshotPending = true
			obj.planGeneration += 1
			obj:_closeGate("Egg reset teleport")
		end, obj.connections)
		v659(AreaEggResetWall2.Changed, function(p179)
			if p179 then
				obj.resetSnapshotPending = true
				obj.planGeneration += 1
				obj:_closeGate("Reset wall closed")
			else
				obj.resetBlocked = false
				obj.gateOpenAt = os.clock()
				obj.preEventReadyAt = os.clock() + 2
				obj:_setStatus(obj.enabled and "Refreshing new rotation" or "Ready")
				obj:_replaceSnapshot(EggState2.ReadFieldEggs())
			end
		end, obj.connections)
		v659(LocalPlayer2.CharacterRemoving, function()
			if obj.drScrambleObjectiveEnabled then
				obj.drScrambleNeedsSafeReturn = true
			end

			obj:releaseDrScrambleRoute(true)

			local manualCarry = obj.manualCarry

			manualCarry.generation += 1
			obj.manualCarry.active = false
			obj.manualCarry.uid = nil
			obj:_cleanupInstantSteal()
			obj:_hideTreadmillDecoy()
			obj.panelTargetUid = nil
			obj.panelActiveUid = nil

			local carry = obj.carry

			carry.generation += 1
			obj:_invalidateCarryWorker()
			obj.carry.active = false
			obj.carry.uid = nil
			obj.intentionalGiftUid = nil
			obj.continueFromForestGift = false
			obj.safeStarting = false
			obj.planGeneration += 1
			obj:_cancelTween("Character resetting")
			obj:_stopMovementProtection()
		end, obj.connections)
		v659(RunService2.Heartbeat, function()
			if obj.destroyed then
				return
			end

			local Character = LocalPlayer2.Character
			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				return
			end

			local AssemblyLinearVelocity = HumanoidRootPart.AssemblyLinearVelocity

			if Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude > 400 or math.abs(AssemblyLinearVelocity.Y) > 400 then
				HumanoidRootPart.AssemblyLinearVelocity = Vector3.new(math.clamp(AssemblyLinearVelocity.X, -100, 100), math.clamp(AssemblyLinearVelocity.Y, -100, 100), math.clamp(AssemblyLinearVelocity.Z, -100, 100))
			end
		end, obj.connections)
		v659(LocalPlayer2.CharacterAdded, function(p180)
			obj:_hideTreadmillDecoy()
			v681(p180)

			if next(obj.healthProtectionOwners) ~= nil then
				v684(obj, p180)
			end

			task.delay(0.25, function()
				if not obj.destroyed and obj.enabled then
					obj:_startMovementProtection()
				end
			end)
			task.delay(1, function()
				if not obj.destroyed and obj.enabled and obj:_wallOpen() then
					obj:_schedule()
				end
			end)
		end, obj.connections)
		obj:_installClaimPresentationFilter()
		v659(EggState2.CarryChanged, function(p181)
			local v768 = p181.IsCarrying and obj.running and obj.activeTarget and p181.Uid == obj.activeTarget.Uid

			if p181.IsCarrying then
				if not v768 and type(p181.Uid) == "string" and p181.Uid ~= "" then
					obj.manualCarry.active = true
					obj.manualCarry.uid = p181.Uid

					local manualCarry = obj.manualCarry

					manualCarry.generation += 1
				end
			elseif obj.manualCarry.active and (p181.Uid == nil or p181.Uid == obj.manualCarry.uid) then
				obj.manualCarry.active = false
				obj.manualCarry.uid = nil

				local manualCarry = obj.manualCarry

				manualCarry.generation += 1
			end

			if p181.IsCarrying then
				if obj.running and obj.activeTarget and p181.Uid == obj.activeTarget.Uid then
					if obj.carry.active and obj.carry.uid == p181.Uid then
						return
					end

					if obj.instantPhase == "priming" and p181.Uid == obj.primerUid then
						obj.carry.active = true
						obj.carry.uid = p181.Uid
						obj:_clearArrivalHold(p181.Uid)
						obj:_enterBaitWait()

						return
					end

					obj.dropRecoveryUid = nil
					obj.guardReturnWait = nil

					local carry = obj.carry

					carry.generation += 1
					obj:_invalidateCarryWorker()
					obj:_clearArrivalHold(p181.Uid)
					obj.claimPresentationSuppression = {
						assetCategory = obj.activeTarget.AssetCategory,
						expiresAt = os.clock() + 8
					}
					obj.carry.active = true
					obj.carry.uid = p181.Uid
					obj.carryStartTime = os.clock()
					obj.carryStartPos = obj.activeTarget and obj.activeTarget.BottomCFrame and obj.activeTarget.BottomCFrame.Position or LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") and LocalPlayer2.Character.HumanoidRootPart.Position

					if obj.tweenRecoveryUid == p181.Uid then
						obj.tweenRecoveryUid = nil
					end

					obj.stats.lastResult = "Carry confirmed"
					obj:_notify()
					obj.carryAttemptToken = nil

					if obj.activeTween and obj.activeTween.Cancel then
						pcall(obj.activeTween.Cancel, obj.activeTween)
					end

					task.defer(function()
						if not obj.destroyed then
							if obj.enabled and obj.carry.uid == p181.Uid and obj:_hasConfirmedCarry(p181.Uid) then
								local v772 = v693()

								if v772 and v772.__ZeroinGodMode then
									pcall(function()
										v772.__ZeroinGodMode:stopDefend()
									end)
								end

								obj:_returnToSafe()
							end
						end
					end)
				end

				return
			end

			if p181.Uid ~= nil then
				if p181.Uid == obj.lastAbandonedPrimerUid and p181.Uid ~= obj.primerUid then
					return
				end

				local uid = obj.carry.uid or obj.activeTarget and obj.activeTarget.Uid

				if uid ~= nil and p181.Uid ~= uid and p181.Uid ~= obj.intentionalGiftUid then
					return
				end
			elseif not obj.carry.active then
				return
			end

			local Uid = p181.Uid or obj.carry.uid

			Uid = Uid or obj.activeTarget and obj.activeTarget.Uid

			if obj.intentionalGiftUid ~= nil and Uid == obj.intentionalGiftUid then
				local intentionalGiftUid = obj.intentionalGiftUid

				obj.intentionalGiftUid = nil
				obj.giftDropUids[intentionalGiftUid] = true

				local carry = obj.carry

				carry.generation += 1
				obj:_invalidateCarryWorker()
				obj:_clearArrivalHold(intentionalGiftUid)

				if obj.activeTween and obj.activeTween.Cancel then
					pcall(obj.activeTween.Cancel, obj.activeTween)
				end

				obj.carry.active = false
				obj.carry.uid = nil
				obj.continueFromForestGift = true
				obj:_finish("Egg dropped at Forest")

				return
			end

			if not obj.carry.active and obj:_isDropRecoveryPending(Uid) then
				return
			end

			local active = obj.carry.active

			if active and not obj:isPrimerEgg(Uid) and not obj:isIntentionalGiftDrop(Uid) then
				obj.dropRecoveryUid = Uid

				local v778 = v693()

				if v778 and v778.__ZeroinGodMode then
					pcall(function()
						v778.__ZeroinGodMode:startDefend(Uid)
					end)
				end
			end

			local carry = obj.carry

			carry.generation += 1

			local generation = obj.carry.generation

			obj:_invalidateCarryWorker()

			if obj.activeTween and obj.activeTween.Cancel then
				pcall(obj.activeTween.Cancel, obj.activeTween)
			end

			obj.carry.active = false
			obj.carry.uid = nil

			if obj.instantPhase == "priming" and (p181.Uid == obj.primerUid or Uid == obj.primerUid) then
				obj:_startPrimerTargetHunt()

				return
			end

			if not active then
				return
			end

			if not obj.running or not obj.activeTarget then
				return
			end

			local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart then
				if obj:_isInSafeArea(HumanoidRootPart) then
					obj:_finish("Safe return complete")

					return
				end
			end

			task.delay(0.03, function()
				if obj.destroyed or not obj.enabled or obj.carry.active or obj.carry.generation ~= generation then
					return
				end

				local HumanoidRootPart2 = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

				if HumanoidRootPart2 and obj:_isInSafeArea(HumanoidRootPart2) then
					obj:_finish("Safe return complete")

					return
				end

				obj:_reStealDroppedEgg(Uid)
			end)
		end, obj.connections)
		v659(LocalPlayer2:GetAttributeChangedSignal("RagdollEndTime"), function()
			local attribute = LocalPlayer2:GetAttribute("RagdollEndTime") or 0

			if obj.instantPhase == "priming" and workspace:GetServerTimeNow() < attribute then
				obj:_startPrimerTargetHunt()
			end
		end, obj.connections)

		return obj
	end
	t41._installClaimPresentationFilter = function(p182)
		if p182.claimPresentationNode then
			return true
		end

		if type(EggState2.FieldClaimed.GetConnections) ~= "function" then
			return false
		end

		for _, v in ipairs(EggState2.FieldClaimed:GetConnections()) do
			local claimPresentationOriginal = type(v) == "table" and rawget(v, "_fn") or nil

			if v678(claimPresentationOriginal):find("PlayerScripts.Game.AreaEggs", 1, true) and v670(claimPresentationOriginal, {
				"Bottom",
				"Message",
				"Color",
				"Time"
			}) then
				p182.claimPresentationNode = v
				p182.claimPresentationOriginal = claimPresentationOriginal

				local function claimPresentationWrapper(p183)
					local claimPresentationSuppression = p182.claimPresentationSuppression

					if claimPresentationSuppression and claimPresentationSuppression.expiresAt < os.clock() then
						p182.claimPresentationSuppression = nil
						claimPresentationSuppression = nil
					end

					if not p182.destroyed and p182.enabled and claimPresentationSuppression and type(p183) == "table" and p183.AssetCategory == claimPresentationSuppression.assetCategory then
						p182.claimPresentationSuppression = nil

						return
					end

					return claimPresentationOriginal(p183)
				end

				p182.claimPresentationWrapper = claimPresentationWrapper
				v._fn = claimPresentationWrapper

				return true
			end
		end

		return false
	end
	t41._restoreClaimPresentationFilter = function(p184)
		local claimPresentationNode = p184.claimPresentationNode
		local claimPresentationOriginal = p184.claimPresentationOriginal

		if type(claimPresentationNode) == "table" then
			if type(claimPresentationOriginal) == "function" and rawget(claimPresentationNode, "_fn") == p184.claimPresentationWrapper then
				claimPresentationNode._fn = claimPresentationOriginal
			end
		end

		p184.claimPresentationNode = nil
		p184.claimPresentationOriginal = nil
		p184.claimPresentationWrapper = nil
		p184.claimPresentationSuppression = nil
	end
	t41._setStatus = function(p185, p186)
		if p185.stats.status == p186 then
			return
		end

		p185.stats.status = p186
		p185:_notify()
	end
	t41._notify = function(p187)
		local v791 = p187:getSnapshot()

		for k in pairs(p187.listeners) do
			local ok, result = pcall(k, v791)

			if not ok then
				warn("[StealAnEgg] UI listener failed:", result)
			end
		end
	end
	t41.onChanged = function(p188, p189)
		p188.listeners[p189] = true

		local ok, result = pcall(p189, p188:getSnapshot())

		if not ok then
			warn("[StealAnEgg] UI listener failed:", result)
		end

		return function()
			p188.listeners[p189] = nil
		end
	end
	t41.getSnapshot = function(p190)
		return {
			status = p190.stats.status,
			available = p190.stats.available,
			matching = p190.stats.matching,
			lastTarget = p190.stats.lastTarget,
			lastResult = p190.stats.lastResult,
			lastAreaLabel = p190.lastAreaState and p190.lastAreaState.label or "Unknown",
			lastAreaId = p190.lastAreaState and p190.lastAreaState.areaId or nil,
			lastAreaVariant = p190.lastAreaState and p190.lastAreaState.variantId or nil,
			lastAreaPeriod = p190.lastAreaState and p190.lastAreaState.period or nil,
			wallClosed = p190.resetBlocked or AreaEggResetWall2.IsSealed() or os.clock() < p190.gateOpenAt,
			enabled = p190.enabled,
			running = p190.running
		}
	end
	t41._replaceSnapshot = function(p191, p192)
		table.clear(p191.records)

		local Records = p192 and (p192.Records or p192) or {}

		for k, Record in pairs(Records) do
			if type(Record) == "table" and type(Record.Uid) == "string" then
				p191.records[Record.Uid] = Record
			elseif type(k) == "string" and type(Record) == "table" then
				p191.records[k] = Record
			end
		end

		p191.lastAreaState = type(p191.catalog.getLastAreaState) == "function" and p191.catalog.getLastAreaState() or nil

		if p191.resetSnapshotPending and not p191.resetBlocked and not AreaEggResetWall2.IsSealed() then
			p191.resetSnapshotPending = false
			p191.gateOpenAt = os.clock()
			p191:_setStatus(p191.enabled and "Searching" or "Ready")
		end

		p191:_refreshCounts()

		if not p191.resetSnapshotPending then
			p191:_schedule()
		end
	end
	t41.isIntentionalGiftDrop = function(p193, p194)
		return type(p194) == "string" and p194 ~= "" and (p194 == p193.intentionalGiftUid or p193.giftDropUids[p194] == true)
	end
	t41._isRiftObjective = function(p195, p196)
		return p195.riftObjectiveEnabled and type(p196) == "table" and not p195:isIntentionalGiftDrop(p196.Uid) and p195.riftRequiredCategories[p196.AssetCategory] == true
	end
	t41._matchesNormalFilter = function(p197, p198)
		if p197:isIntentionalGiftDrop(p198 and p198.Uid) then
			return false
		end

		local v800 = p197.catalog.resolve(p198)
		local config = p197.config

		if config.rarityEnabled and not (#config.rarities ~= 0 and v664(config.rarities, v800.rarity)) then
			return false
		end

		local v802

		if not config.nameEnabled then
			if config.areaEnabled and not (#config.areas ~= 0 and v664(config.areas, p198.AreaId)) then
				return false
			end

			local minValuePerSec = config.minValuePerSec or 0

			if minValuePerSec > 0 then
				v802 = v669(p198)

				if not v802 or v802 < config.minValuePerSec then
					return false
				end
			end

			return true
		end

		if #config.names == 0 or not v664(config.names, v800.name) and not v664(config.names, v800.category) then
			return false
		end

		if config.areaEnabled and not (#config.areas ~= 0 and v664(config.areas, p198.AreaId)) then
			return false
		end

		if (config.minValuePerSec or 0) > 0 then
			v802 = v669(p198)

			if not v802 or v802 < config.minValuePerSec then
				return false
			end
		end

		return true
	end
	t41._matches = function(p199, p200)
		if p200.State ~= AreaEggs.States.Slot and p200.State ~= AreaEggs.States.Dropped then
			return false
		end

		if p199.riftObjectiveEnabled and p199:_isRiftObjective(p200) then
			return true
		end

		if p199.userStealEnabled and p199:_matchesNormalFilter(p200) then
			return true
		end

		return false
	end
	t41._isForeignCarryCandidate = function(p201, p202)
		local stealFromPlayers = p201.isPremium and p201.config.stealFromPlayers

		return stealFromPlayers and p201.userStealEnabled and type(p202) == "table" and p202.State == AreaEggs.States.Carried and type(p202.CarrierUserId) == "number" and p202.CarrierUserId ~= LocalPlayer2.UserId and not p201:isIntentionalGiftDrop(p202.Uid) and p201:_matchesNormalFilter(p202)
	end
	t41._resolveForeignCarrier = function(p203, p204, p205)
		if not p203:_isForeignCarryCandidate(p204) then
			return nil
		end

		local playerByUserId = Players2:GetPlayerByUserId(p204.CarrierUserId)
		local Character = playerByUserId and playerByUserId.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not playerByUserId or not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
			return nil
		end

		if playerByUserId:GetAttribute("InBossArena") == true then
			return nil
		end

		local v809 = tonumber(playerByUserId:GetAttribute("RagdollEndTime")) or 0

		if workspace:GetServerTimeNow() < v809 then
			return nil
		end

		if p205 or ToolGameplayGuard.IsInsideArena(playerByUserId) and not ToolGameplayGuard.IsInsideSafeZone(playerByUserId) then
			return playerByUserId, HumanoidRootPart, Humanoid
		end

		return nil
	end
	t41.isPrimerEgg = function(p206, p207)
		if type(p207) == "string" then
			if p207 ~= "" then
				return p207 == p206.primerUid or p207 == p206.lastAbandonedPrimerUid
			end
		end

		return false
	end
	t41.hasMatchingUserEggs = function(p208)
		if p208.enabled then
			if p208.userStealEnabled and not p208.destroyed then
				if not p208.drScrambleRouteActive and (p208.running or p208.activeTarget ~= nil or p208.tweenRecoveryUid ~= nil) then
					return true
				end

				for _, record in pairs(p208.records) do
					if record.State ~= AreaEggs.States.Slot and record.State ~= AreaEggs.States.Dropped then
						if p208:_isForeignCarryCandidate(record) then
							return true
						end

						continue
					end

					if p208:_matchesNormalFilter(record) then
						return true
					end
				end

				return false
			end
		end

		return false
	end
	t41._hasActiveUserTargetFilter = function(p209)
		local config = p209.config
		local v813 = config.rarityEnabled == true or config.nameEnabled == true or config.areaEnabled == true

		if not v813 then
			v813 = (config.minValuePerSec or 0) > 0
		end

		return v813
	end
	t41.hasDrPriorityEggsAuthoritative = function(p210, p211)
		if p210.destroyed or not p210.userStealEnabled or not p210:_hasActiveUserTargetFilter() then
			return false
		end

		if p211 ~= true and not p210.drScrambleRouteActive and (p210.running or p210.activeTarget ~= nil or p210.tweenRecoveryUid ~= nil or p210.carry.active) then
			return true
		end

		local ok, result = pcall(EggState2.ReadFieldEggs)
		local Records = ok and type(result) == "table" and (type(result.Records) == "table" and result.Records or result) or p210.records

		for _, Record in pairs(Records) do
			if type(Record) ~= "table" then
				continue
			end

			if Record.State ~= AreaEggs.States.Slot and Record.State ~= AreaEggs.States.Dropped then
				continue
			end

			if p210:_matchesNormalFilter(Record) then
				return true
			end
		end

		return false
	end
	t41.hasMatchingUserEggsAuthoritative = function(p212)
		if p212.enabled then
			if p212.userStealEnabled and not p212.destroyed then
				if not p212.drScrambleRouteActive and (p212.running or p212.activeTarget ~= nil or p212.tweenRecoveryUid ~= nil) then
					return true
				end

				local ok, result = pcall(EggState2.ReadFieldEggs)

				if not ok or type(result) ~= "table" then
					return p212:hasMatchingUserEggs()
				end

				local Records = type(result.Records) == "table" and result.Records or result

				for _, Record in pairs(Records) do
					if type(Record) ~= "table" then
						continue
					end

					if (Record.State == AreaEggs.States.Slot or Record.State == AreaEggs.States.Dropped) and p212:_matchesNormalFilter(Record) then
						return true
					end

					if p212:_isForeignCarryCandidate(Record) then
						return true
					end
				end

				return p212:hasMatchingUserEggs()
			end
		end

		return false
	end
	t41._refreshCounts = function(p213)
		local available = 0
		local matching = 0

		for _, record in pairs(p213.records) do
			if record.State == AreaEggs.States.Slot then
				available += 1

				if p213:_matches(record) then
					matching += 1
				end
			elseif p213:_isForeignCarryCandidate(record) then
				matching += 1
			end
		end

		p213.stats.available = available
		p213.stats.matching = matching
		p213:_notify()
	end
	t41._chooseTarget = function(p214)
		local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		local panelTargetUid = p214.panelTargetUid

		if type(panelTargetUid) == "string" and panelTargetUid ~= "" then
			local v830 = EggState2.ReadFieldEgg(panelTargetUid) or p214.records[panelTargetUid]

			if not (type(v830) ~= "table" or v830.State ~= AreaEggs.States.Slot and v830.State ~= AreaEggs.States.Dropped or p214:isIntentionalGiftDrop(panelTargetUid)) then
				p214.panelTargetUid = nil
				p214.panelActiveUid = panelTargetUid

				return v830
			end

			p214.panelTargetUid = nil

			if not p214.userStealEnabled and not p214.riftObjectiveEnabled and p214.panelActiveUid == nil then
				task.defer(function()
					if not p214.destroyed then
						p214:_reconcileRunningState()
					end
				end)
			end
		end

		if p214.userStealEnabled and p214.config.stealFromPlayers then
			local v831
			local v832
			local v833

			for _, record in pairs(p214.records) do
				if p214:_isForeignCarryCandidate(record) then
					local playerByUserId = Players2:GetPlayerByUserId(record.CarrierUserId)
					local HumanoidRootPart2 = playerByUserId and playerByUserId.Character and playerByUserId.Character:FindFirstChild("HumanoidRootPart")
					local rarityRank = p214.catalog.resolve(record).rarityRank or 0
					local Magnitude = HumanoidRootPart2 and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude or math.huge

					if not v831 or v832 < rarityRank or rarityRank == v832 and Magnitude < v833 then
						v831 = record
						v832 = rarityRank
						v833 = Magnitude
					end
				end
			end

			if v831 then
				return v831
			end
		end

		if p214.userStealEnabled then
			local v840
			local v841
			local v842

			for _, record in pairs(p214.records) do
				if (record.State == AreaEggs.States.Slot or record.State == AreaEggs.States.Dropped) and p214:_matchesNormalFilter(record) then
					local v845 = p214.catalog.resolve(record)

					if t38[v845.rarity] then
						local Magnitude = (record.BottomCFrame.Position - HumanoidRootPart.Position).Magnitude
						local rarityRank = v845.rarityRank or 0

						if not v840 or v841 < rarityRank or rarityRank == v841 and Magnitude < v842 then
							v840 = record
							v841 = rarityRank
							v842 = Magnitude
						end
					end
				end
			end

			if v840 then
				return v840
			end
		end

		if p214.riftObjectiveEnabled then
			local v848
			local v849

			for _, record in pairs(p214.records) do
				if (record.State == AreaEggs.States.Slot or record.State == AreaEggs.States.Dropped) and p214:_isRiftObjective(record) then
					local Magnitude = (record.BottomCFrame.Position - HumanoidRootPart.Position).Magnitude

					if not v848 or Magnitude < v849 then
						v848 = record
						v849 = Magnitude
					end
				end
			end

			if v848 then
				return v848
			end
		end

		if p214.userStealEnabled then
			local v853
			local v854
			local v855

			for _, record in pairs(p214.records) do
				if (record.State == AreaEggs.States.Slot or record.State == AreaEggs.States.Dropped) and p214:_matchesNormalFilter(record) then
					local Magnitude = (record.BottomCFrame.Position - HumanoidRootPart.Position).Magnitude
					local rarityRank = p214.catalog.resolve(record).rarityRank or 0

					if not v853 or v854 < rarityRank or rarityRank == v854 and Magnitude < v855 then
						v853 = record
						v854 = rarityRank
						v855 = Magnitude
					end
				end
			end

			if v853 then
				return v853
			end
		end

		return nil
	end
	t41.setTreadmillManager = function(p215, p216)
		p215.treadmillManager = p216
	end
	t41.setRiftRuntime = function(p217, p218)
		p217.riftRuntime = p218
	end
	t41.setDrScrambleRuntime = function(p219, p220)
		p219.drScrambleRuntime = p220
	end
	t41.setDrScrambleObjective = function(p221, p222)
		p221.drScrambleObjectiveEnabled = p222 == true

		if not p221.drScrambleObjectiveEnabled then
			p221.drScrambleNeedsSafeReturn = false
			p221:releaseDrScrambleRoute()
		end

		p221:_reconcileRunningState()
	end
	t41.releaseDrScrambleRoute = function(p223, p224)
		if not (p223.drScrambleRouteActive or p223.operationToken and p223.operationToken.owner == "auto_dr_scramble") then
			return false
		end

		local drScrambleRuntime = p223.drScrambleRuntime

		p223.drScrambleRouteActive = false
		p223.safeStarting = false
		p223.running = false
		p223.activeTarget = nil

		if drScrambleRuntime and type(drScrambleRuntime.releaseEventLock) == "function" then
			drScrambleRuntime:releaseEventLock()
		end

		p223:_cancelTween("Dr. Scramble route released")

		if p224 ~= true and not p223.destroyed and p223.enabled then
			p223:_scheduleMovementRetry()
		end

		return true
	end
	t41._finishDrScrambleTravel = function(p225, p226, p227, p228)
		p225.safeStarting = false
		p225.running = false

		if not p225.drScrambleRouteActive then
			return
		end

		if p226 and p227 and p227:lockAfterSharedTravel(p228) == true then
			p225:_setStatus("Locked to event robot")

			return
		end

		p225:releaseDrScrambleRoute()
	end
	t41._finishDrScrambleSafeReturn = function(p229, p230)
		if not p229.drScrambleRouteActive then
			return
		end

		p229.drScrambleRouteActive = false
		p229.safeStarting = false
		p229.running = false
		p229.activeTarget = nil
		p229:_releaseOperation()

		if p230 then
			p229.drScrambleNeedsSafeReturn = false
		end

		p229:_setStatus(p230 and "Safe zone ready for event" or "Retrying event safe zone")

		if not p229.destroyed and p229.enabled then
			p229:_scheduleMovementRetry()
		end
	end
	t41._returnToSafeForDrScramble = function(p231, p232)
		if p231.drScrambleRouteActive or not p232 then
			return false
		end

		local v861 = p231:_resolveSafeCFrame(p232)

		if not v861 then
			return false
		end

		local autoDrScramble, v863 = p231.coordinator:tryAcquire("auto_dr_scramble", {})

		if autoDrScramble then
			p231.operationToken = autoDrScramble
			p231.drScrambleRouteActive = true
			p231.safeStarting = true
			p231.running = true
			p231.activeTarget = nil
			p231:_setStatus("Returning to safe zone for event")
			p231:_tweenRoot(v861, function()
				p231:_finishDrScrambleSafeReturn(true)
			end, nil, {
				flightProfile = true,
				abort = function()
					return not p231.drScrambleObjectiveEnabled or not p231:_wallOpen()
				end,
				onDone = function(p233)
					if not p233 then
						p231:_finishDrScrambleSafeReturn(false)
					end
				end
			})

			return true
		end

		p231:_setStatus("Dr. Scramble safe zone waiting · " .. tostring(v863 or "busy"))
		p231:_scheduleMovementRetry()

		return false
	end
	t41._startDrScrambleRoute = function(p234, p235)
		if p234.drScrambleRouteActive or type(p235) ~= "table" or typeof(p235.destination) ~= "CFrame" then
			return false
		end

		local autoDrScramble, v865 = p234.coordinator:tryAcquire("auto_dr_scramble", {})

		if not autoDrScramble then
			p234:_setStatus("Dr. Scramble waiting · " .. tostring(v865 or "busy"))
			p234:_scheduleMovementRetry()

			return false
		end

		p234.operationToken = autoDrScramble
		p234.drScrambleRouteActive = true
		p234.safeStarting = true
		p234.running = true
		p234.activeTarget = nil
		p234:_setStatus("Traveling to event robot")

		local drScrambleRuntime = p234.drScrambleRuntime
		local v867 = drScrambleRuntime and drScrambleRuntime:getGeneration() or 0

		p234:_tweenRoot(p235.destination, function()
			p234:_finishDrScrambleTravel(true, drScrambleRuntime, v867)
		end, nil, {
			groundedProfile = true,
			dynamicDestination = function()
				local v868 = drScrambleRuntime and drScrambleRuntime:getEventRoute()

				return v868 and v868.destination or nil
			end,
			projectGroundPosition = function(p236)
				return drScrambleRuntime and drScrambleRuntime:projectGroundPosition(p236) or nil
			end,
			abort = function()
				return not p234.drScrambleObjectiveEnabled or not p234:_wallOpen() or p234:hasMatchingUserEggsAuthoritative()
			end,
			onDone = function(p237)
				if not p237 then
					p234:_finishDrScrambleTravel(false, drScrambleRuntime, v867)
				end
			end
		})

		return true
	end
	t41.setCaptureTheEggRuntime = function(p238, p239)
		p238.captureTheEggRuntime = p239
	end
	t41.setRiftObjective = function(p240, p241, p242)
		local riftObjectiveEnabled = p241 == true
		local riftRequiredCategories = {}
		local ipairs_ = ipairs
		local v872 = type(p242) == "table"

		v872 = v872 and p242 or {}

		for _, v in ipairs_(v872) do
			if type(v) == "string" and v ~= "" then
				riftRequiredCategories[v] = true
			end
		end

		p240.riftObjectiveEnabled = riftObjectiveEnabled
		p240.riftRequiredCategories = riftRequiredCategories
		p240:_reconcileRunningState()
	end
	t41.getStealMode = function(p243)
		return p243.config.stealMode or "Tween"
	end
	t41.setStealMode = function(p244, p245)
		local stealMode = p245 == "Instant" and "Instant" or "Tween"

		if p244.config.stealMode ~= stealMode then
			p244.config.stealMode = stealMode

			if p244.enabled then
				if p244.carry.active then
					p244.stats.lastResult = "Mode set to " .. stealMode .. " (finishing carry)"
					p244:_notify()

					return stealMode
				end

				p244.planGeneration += 1
				p244.safeStarting = false
				p244:_cancelTween("Mode changed")
				task.delay(0.1, function()
					if not p244.destroyed and p244.enabled and not p244.running then
						p244:_schedule()
					end
				end)
			end
		end

		return stealMode
	end
	t41._setInstantAnchored = function(p246, p247)
		pcall(function()
			local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

			if HumanoidRootPart and HumanoidRootPart.Anchored ~= p247 then
				HumanoidRootPart.Anchored = p247
			end
		end)
	end
	t41._kbCancelTimer = function(p248)
		local hitTimer = p248.hitTimer

		p248.hitTimer = nil
		p248.baitWaitToken = nil
		p248.waitingGuardHit = false

		if hitTimer and hitTimer ~= coroutine.running() then
			pcall(task.cancel, hitTimer)
		end

		if p248.baitHitConnections then
			v661(p248.baitHitConnections)
			p248.baitHitConnections = nil
		end

		if p248.antiGuard then
			p248.antiGuard:setPrimerHitWindow(false)
		end
	end

	local _selectClosestTarget

	t41._installPlayerStealBatAura = function(p249)
		if p249.playerStealBatAuraInstalled then
			return true
		end

		if type(Client) == "table" then
			if type(Client._selectClosestTarget) == "function" then
				_selectClosestTarget = _selectClosestTarget or Client._selectClosestTarget

				local v879 = p249

				Client._selectClosestTarget = function(p250)
					local playerHuntCarrier = v879.playerHuntToken and v879.playerHuntCarrier

					playerHuntCarrier = playerHuntCarrier or nil

					if playerHuntCarrier and playerHuntCarrier.Parent == Players2 then
						local Character = LocalPlayer2.Character
						local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
						local HumanoidRootPart2 = playerHuntCarrier.Character and playerHuntCarrier.Character:FindFirstChild("HumanoidRootPart")

						if HumanoidRootPart and HumanoidRootPart2 and (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude <= 500 then
							local v884 = true

							if type(p250._isTargetEligible) == "function" then
								local ok, result = pcall(p250._isTargetEligible, p250, playerHuntCarrier, HumanoidRootPart, 500)

								v884 = ok and result == true
							end

							if v884 then
								return playerHuntCarrier
							end
						end
					end

					return _selectClosestTarget(p250)
				end
				p249.playerStealBatAuraInstalled = true

				return true
			end
		end

		return false
	end
	t41._removePlayerStealBatAura = function(p251)
		if not p251.playerStealBatAuraInstalled then
			return
		end

		if type(Client) == "table" and _selectClosestTarget then
			Client._selectClosestTarget = _selectClosestTarget
		end

		p251.playerStealBatAuraInstalled = false
	end
	t41._cleanupInstantSteal = function(p252)
		p252.instantPhase = nil
		p252.primerUid = nil
		p252.targetUid = nil
		p252.playerHuntToken = nil
		p252.playerHuntCarrier = nil
		p252:_removePlayerStealBatAura()
		p252:_kbCancelTimer()
		p252:_setInstantAnchored(false)
		p252:_hideTreadmillDecoy()
	end
	t41._triggerInstantForestHit = function(p253, p254)
		if p253.destroyed or not p253.enabled or not p253.waitingGuardHit or p253.baitWaitToken ~= p254 or p253.instantPhase ~= "priming" then
			return
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Forest = p253:_findAreaGuardRoot("Forest")

		if not HumanoidRootPart or not Forest then
			return
		end

		local primerUid = p253.primerUid

		if not primerUid then
			return
		end

		HumanoidRootPart.CFrame = cFrameNew(Forest.Position + Vector3.new(0, 0.8, 0))
		HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
		HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

		local Collider = Forest.Parent and Forest.Parent:FindFirstChild("Collider") or Forest
		local firetouchinterest_ = v693().firetouchinterest or firetouchinterest

		if Collider:IsA("BasePart") and type(firetouchinterest_) == "function" then
			pcall(function()
				firetouchinterest_(HumanoidRootPart, Collider, 0)
				firetouchinterest_(HumanoidRootPart, Collider, 1)
			end)
		end

		if p253.baitWaitToken ~= p254 or not p253.waitingGuardHit then
			return
		end

		local ForestStrike = Remotes.GuardPatrol and Remotes.GuardPatrol.ForestStrike

		if ForestStrike then
			pcall(function()
				ForestStrike:FireServer({
					EggUid = primerUid,
					GuardCFrame = Forest.CFrame
				})
			end)
		end
	end
	t41._choosePrimerEgg = function(p255, p256)
		local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
		local Areas = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
		local GuardAreas = Areas and Areas:FindFirstChild("GuardAreas")
		local Forest = GuardAreas and GuardAreas:FindFirstChild("Forest") or Areas and Areas:FindFirstChild("Forest")
		local Guard = Forest and (Forest:FindFirstChild("Guard") or Forest:FindFirstChild("ForestGuardAuthored"))
		local HumanoidRootPart = Guard and Guard:FindFirstChild("HumanoidRootPart")
		local Position = HumanoidRootPart and HumanoidRootPart.Position
		local v901
		local v902

		for _, record in pairs(p255.records) do
			if (record.State == AreaEggs.States.Slot or record.State == AreaEggs.States.Dropped) and record.AreaId == "Forest" and record.Uid ~= p256 then
				local v905 = -(Position and (record.BottomCFrame.Position - Position).Magnitude or LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart") and (record.BottomCFrame.Position - LocalPlayer2.Character.HumanoidRootPart.Position).Magnitude or math.huge) - (p255.catalog.resolve(record).rarityRank or 0) * 100

				if not v901 or v902 < v905 then
					v901 = record
					v902 = v905
				end
			end
		end

		return v901
	end
	t41._enterBaitWait = function(p257)
		if not p257.baitWaitToken and not p257.destroyed then
			if p257.enabled and p257.instantPhase == "priming" and p257.primerUid then
				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

				if not HumanoidRootPart or not Humanoid then
					p257:_finish("Character unavailable")

					return
				end

				p257.carryAttemptToken = nil

				if p257.activeTween then
					pcall(p257.activeTween.Cancel, p257.activeTween)
				end

				p257:_clearArrivalHold()
				p257:_stopHoverPad()
				p257:_setInstantAnchored(false)

				local baitWaitToken = {}
				local primerUid = p257.primerUid

				p257.baitWaitToken = baitWaitToken
				p257.waitingGuardHit = true
				p257:_setStatus("Waiting for guard hit")
				p257.baitHitConnections = {}

				local u911 = false

				local function v912()
					if p257.baitWaitToken == baitWaitToken and p257.waitingGuardHit then
						u911 = true
					end
				end

				v659(Humanoid.StateChanged, function(p258, p259)
					if p259 == Enum.HumanoidStateType.Ragdoll or p259 == Enum.HumanoidStateType.FallingDown or p259 == Enum.HumanoidStateType.PlatformStanding then
						v912()
					end
				end, p257.baitHitConnections)
				v659(Humanoid:GetPropertyChangedSignal("PlatformStand"), function()
					if Humanoid.PlatformStand then
						v912()
					end
				end, p257.baitHitConnections)

				local Packages = ReplicatedStorage2:FindFirstChild("Packages")
				local Networking = Packages and Packages:FindFirstChild("Networking")
				local RERigSyncRefresh = Networking and Networking:FindFirstChild("RE/RigSync/Refresh")

				if RERigSyncRefresh then
					pcall(function()
						v659(RERigSyncRefresh.OnClientEvent, v912, p257.baitHitConnections)
					end)
				end

				if p257.antiGuard then
					p257.antiGuard:setPrimerHitWindow(true)
				end

				p257.hitTimer = task.defer(function()
					local v916 = os.clock() + 1.2
					local n11 = 0
					local exitTo

					while true do
						if p257.baitWaitToken ~= baitWaitToken or not p257.waitingGuardHit or p257.destroyed or not p257.enabled or p257.instantPhase ~= "priming" then
							exitTo = 1

							break
						end

						if LocalPlayer2.Character ~= Character or not HumanoidRootPart.Parent or not Humanoid.Parent then
							exitTo = 2

							break
						end

						local state = Humanoid:GetState()

						if not u911 and not Humanoid.PlatformStand and not Humanoid.Sit and state ~= Enum.HumanoidStateType.Ragdoll and state ~= Enum.HumanoidStateType.FallingDown and not (HumanoidRootPart.AssemblyLinearVelocity.Magnitude > 18) then
							local now = os.clock()

							if not (v916 <= now) then
								if n11 <= now then
									n11 = now + 0.06
									p257:_triggerInstantForestHit(baitWaitToken)
								end

								RunService2.Heartbeat:Wait()

								continue
							end

							exitTo = 1

							break
						end

						break
					end

					if exitTo ~= 1 then
						if exitTo == 2 then
							p257:_kbCancelTimer()
							p257:_finish("Forest bait interrupted")

							return
						end

						p257:_startPrimerTargetHunt()

						return
					end

					if p257.baitWaitToken ~= baitWaitToken then
						return
					end

					p257:_kbCancelTimer()
					p257.lastAbandonedPrimerUid = primerUid
					p257.instantPhase = nil
					p257.primerUid = nil
					p257.targetUid = nil
					p257.carry.active = false
					p257.carry.uid = nil

					if LocalPlayer2.Character == Character and HumanoidRootPart.Parent and Humanoid.Parent then
						p257:_teleportRoot(HumanoidRootPart, Humanoid, p257:_resolveSafeCFrame(HumanoidRootPart))
					end

					p257:_finish("Forest guard hit timed out")
				end)

				return
			end
		end
	end
	t41._findPlayerStealBat = function()
		local Character = LocalPlayer2.Character
		local Backpack = LocalPlayer2:FindFirstChildOfClass("Backpack")

		local function v923(p260)
			local ipairs_ = ipairs
			local children = p260 and p260:GetChildren() or {}

			for _, child in ipairs_(children) do
				if child:IsA("Tool") and child:GetAttribute("IsBat") == true then
					return child
				end
			end

			return nil
		end

		return v923(Character) or v923(Backpack)
	end
	t41._ensurePlayerStealBat = function(p261, p262)
		local v928 = os.clock() + 2.5
		local n12 = 0

		while not p261.destroyed and p261.enabled and p261.playerHuntToken == p262 and os.clock() < v928 do
			local Character = LocalPlayer2.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

			if not Character or not Humanoid or Humanoid.Health <= 0 then
				return nil
			end

			local v932 = p261:_findPlayerStealBat()

			if v932 then
				if v932.Parent ~= Character then
					pcall(Humanoid.EquipTool, Humanoid, v932)
				end

				if v932.Parent == Character then
					task.wait(0.08)

					if v932.Parent == Character then
						return v932
					end
				end
			end

			local now = os.clock()

			if n12 <= now then
				n12 = now + 0.45
				p261:_setStatus("Requesting Field Bat")
				pcall(function()
					Remotes.Codex.AskWearFieldBat:InvokeServer()
				end)
			end

			task.wait(0.05)
		end

		return nil
	end
	t41._activatePlayerStealBat = function(p263, p264, p265)
		if p264 and p265 then
			local Character = LocalPlayer2.Character
			local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

			if Character and Humanoid and not (Humanoid.Health <= 0 or p265.Parent ~= Character) then
				return pcall(p265.Activate, p265)
			end

			return false
		end

		return false
	end
	t41._startPlayerCarryHunt = function(p266, p267)
		local Uid = p267 and p267.Uid

		if type(Uid) ~= "string" or Uid == "" or p266.playerHuntToken then
			p266:_finish("Player target unavailable")

			return
		end

		local playerHuntToken = {}

		p266.playerHuntToken = playerHuntToken
		p266.instantPhase = "player_hunt"
		p266.activeTarget = p267
		p266.safeStarting = false
		p266.running = true
		p266:_hideTreadmillDecoy()
		task.spawn(function()
			p266:_setStatus("Equipping Field Bat")

			local v938 = p266:_ensurePlayerStealBat(playerHuntToken)

			if not v938 then
				if p266.playerHuntToken == playerHuntToken then
					p266.playerHuntToken = nil
					p266:_finish("Failed to equip Field Bat")
				end

				return
			end

			local function v939(p268)
				local v940 = EggState2.ReadFieldEgg(Uid) or p266.records[Uid]

				if v940 and v940.State == AreaEggs.States.Carried then
					local v941, v942 = p266:_resolveForeignCarrier(v940, p268)

					return v941, v942, v940
				end

				return nil
			end

			local v943, v944 = v939(false)

			if not v943 or not v944 then
				p266.playerHuntToken = nil
				p266:_finish("Player steal target lost")

				return
			end

			p266.playerHuntCarrier = v943

			if not p266:_installPlayerStealBatAura() then
				p266.playerHuntToken = nil
				p266.playerHuntCarrier = nil
				p266:_finish("Bat Aura unavailable")

				return
			end

			local vector33 = Vector3.zero
			local now = os.clock()

			local function v947()
				local _, v949 = v939(true)

				if not v949 then
					return nil
				end

				local now2 = os.clock()
				local v951 = math.clamp(now2 - now, 0, 0.1)

				now = now2

				local AssemblyLinearVelocity = v949.AssemblyLinearVelocity

				vector33 = vector33:Lerp(Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z), 1 - math.exp(-12 * v951))

				local n13 = 0

				pcall(function()
					n13 = LocalPlayer2:GetNetworkPing()
				end)

				local v954 = vector33 * math.clamp(n13 + 0.18, 0.18, 0.35)

				if v954.Magnitude > 0.1 then
					v954 = v954.Unit * 0.1
				end

				local CFrame_2 = v949.CFrame

				return lookAt(CFrame_2:PointToWorldSpace(Vector3.new(0, 0, 0)) + v954, v949.Position + v954)
			end

			local v956 = v947()

			if not v956 then
				p266.playerHuntToken = nil
				p266:_finish("Player steal target lost")

				return
			end

			p266:_setStatus("Following egg carrier")
			p266:_tweenRoot(v956, nil, nil, {
				silent = true,
				continuous = true,
				dynamicDestination = v947,
				abort = function()
					return p266.playerHuntToken ~= playerHuntToken or not p266.config.stealFromPlayers or not p266:_wallOpen()
				end
			})

			local n14 = 0
			local n15 = 0
			local v959
			local v960 = os.clock() + 15
			local exitTo
			local v962

			while true do
				if p266.destroyed or not p266.enabled or p266.playerHuntToken ~= playerHuntToken then
					exitTo = 1

					break
				end

				local now2 = os.clock()

				if v960 <= now2 then
					exitTo = 1

					break
				end

				v962 = EggState2.ReadFieldEgg(Uid)
				v962 = v962 or p266.records[Uid]

				if not v962 then
					v959 = v959 or now2

					if not (now2 - v959 >= 0.45) then
						task.wait(0.03)

						continue
					end

					exitTo = 1

					break
				end

				v959 = nil

				if v962.State ~= AreaEggs.States.Dropped and v962.State ~= AreaEggs.States.Slot then
					if v962.State ~= AreaEggs.States.Carried or not p266:_matchesNormalFilter(v962) then
						exitTo = 1

						break
					end

					local v964 = now2 >= n15

					if v964 then
						n15 = now2 + 0.2
					end

					local v965, v966 = p266:_resolveForeignCarrier(v962, not v964)

					if not v965 or not v966 then
						exitTo = 1

						break
					end

					p266.playerHuntCarrier = v965

					local Character = LocalPlayer2.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
					local v969, _setStatus, v971

					if HumanoidRootPart and v938.Parent == Character then
						if n14 <= now2 then
							n14 = now2 + 0.62
							v969 = p266
							_setStatus = p266._setStatus
							v971 = (HumanoidRootPart.Position - v966.Position).Magnitude <= 13 and "Striking egg carrier" or "Closing on egg carrier"
							_setStatus(v969, v971)
							p266:_activatePlayerStealBat(v965, v938)
						end

						task.wait(0.05)

						continue
					end

					v938 = p266:_ensurePlayerStealBat(playerHuntToken)

					if not v938 then
						exitTo = 1

						break
					end

					if n14 <= now2 then
						n14 = now2 + 0.62
						v969 = p266
						_setStatus = p266._setStatus
						v971 = (HumanoidRootPart.Position - v966.Position).Magnitude <= 13 and "Striking egg carrier" or "Closing on egg carrier"
						_setStatus(v969, v971)
						p266:_activatePlayerStealBat(v965, v938)
					end

					task.wait(0.05)

					continue
				end

				break
			end

			if exitTo == 1 then
				if p266.playerHuntToken == playerHuntToken then
					p266.playerHuntToken = nil
					p266.playerHuntCarrier = nil
					p266:_removePlayerStealBatAura()

					if p266.activeTween and p266.activeTween.Cancel then
						pcall(p266.activeTween.Cancel, p266.activeTween)
					end

					p266:_finish("Player steal target lost")
				end

				return
			end

			p266.playerHuntToken = nil
			p266.playerHuntCarrier = nil
			p266:_removePlayerStealBatAura()

			if p266.activeTween and p266.activeTween.Cancel then
				pcall(p266.activeTween.Cancel, p266.activeTween)
			end

			p266.instantPhase = "hunting"
			p266.activeTarget = v962

			local carry = p266.carry

			carry.generation += 1
			p266:_invalidateCarryWorker()
			p266:_reStealDroppedEgg(Uid)
		end)
	end
	t41._startPrimerTargetHunt = function(p269)
		if p269.instantPhase ~= "priming" then
			return
		end

		p269:_kbCancelTimer()
		p269:_setInstantAnchored(false)
		p269.instantPhase = "hunting"
		p269:_clearArrivalHold()
		p269.lastAbandonedPrimerUid = p269.primerUid
		p269.primerUid = nil

		local carry = p269.carry

		carry.generation += 1
		p269:_invalidateCarryWorker()
		p269.carry.active = false
		p269.carry.uid = nil

		local targetUid = p269.targetUid

		p269.targetUid = nil

		if not targetUid then
			p269:_finish("No target egg")

			return
		end

		local v975 = EggState2.ReadFieldEgg(targetUid) or p269.records[targetUid]

		if v975 and v975.State == AreaEggs.States.Carried and p269.isPremium and p269.config.stealFromPlayers then
			p269:_startPlayerCarryHunt(v975)

			return
		end

		if not v975 or v975.State ~= AreaEggs.States.Slot and v975.State ~= AreaEggs.States.Dropped then
			p269:_finish("Target egg no longer available")

			return
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			p269:_finish("Character unavailable")

			return
		end

		p269.activeTarget = v975

		local v979 = p269:_resolveEggDestination(v975, HumanoidRootPart, Humanoid)

		if not v979 then
			p269:_finish("Target destination unavailable")

			return
		end

		if p269.config.stealMode ~= "Instant" then
			p269:_setStatus("Traveling to target")
			p269:_tweenRoot(v979, function()
				if p269.instantPhase == "hunting" and p269.activeTarget and p269.activeTarget.Uid == v975.Uid then
					p269:_requestCarry(v975, true)
				end
			end, nil, {
				arrivalHoldSeconds = 0,
				holdAfterArrival = true,
				holdUid = v975.Uid,
				flightProfile = true,
				carryTarget = v975
			})

			return
		end

		p269:_setStatus("Teleporting to target")

		if not p269:_teleportRoot(HumanoidRootPart, Humanoid, v979) then
			p269:_finish("Teleport target failed")

			return
		end

		p269:_hideTreadmillDecoy()
		p269:_setArrivalHold(v979, v975.Uid)
		p269:_setStatus("Securing target egg")
		p269:_requestCarry(v975, true)
	end
	t41._wallOpen = function(p270)
		if not p270.resetBlocked and not AreaEggResetWall2.IsSealed() then
			if not (os.clock() < p270.gateOpenAt) then
				local Areas = workspace:FindFirstChild("__OBJECTS") and workspace.__OBJECTS:FindFirstChild("Areas")
				local WallStartCollision = Areas and Areas:FindFirstChild("WallStartCollision")

				if WallStartCollision and WallStartCollision:IsA("BasePart") and WallStartCollision.CanCollide then
					return false
				end

				return true
			end
		end

		return false
	end
	t41.isResetWallOpen = function(p271)
		return not p271.destroyed and p271:_wallOpen()
	end
	t41._closeGate = function(p272, p273)
		p272.resetBlocked = true

		if p272.drScrambleRuntime and type(p272.drScrambleRuntime.releaseEventLock) == "function" then
			p272.drScrambleRuntime:releaseEventLock()
		end

		p272:releaseDrScrambleRoute()
		p272.gateOpenAt = math.huge
		p272.continueFromForestGift = false

		if not p272.activeTween or not p272.activeTween.sharedTravel then
			p272:_cancelTween(p273)
		end

		p272:_setStatus(p273)
	end
	t41._releaseOperation = function(p274)
		local operationToken = p274.operationToken

		p274.operationToken = nil

		if operationToken and p274.coordinator then
			p274.coordinator:release(operationToken)
		end
	end
	t41._acquireOperation = function(p275)
		if p275.operationToken or not p275.coordinator then
			return true
		end

		local autoSteal, v984 = p275.coordinator:tryAcquire("auto_steal", {})

		if not autoSteal then
			return false, v984
		end

		p275.operationToken = autoSteal

		return true
	end
	t41._cancelTween = function(p276, p277, p278)
		if p277 ~= "Re-stealing dropped egg" then
			p276.dropRecoveryUid = nil
			p276.guardReturnWait = nil
		end

		p276:_cleanupInstantSteal()
		p276.safeStarting = false
		p276.carryAttemptToken = nil
		p276:_clearArrivalHold()

		if p276.activeTween then
			pcall(p276.activeTween.Cancel, p276.activeTween)
			p276.activeTween = nil
		end

		if not p276.activeTween and not p276.arrivalHold then
			p276:_stopHoverPad()
		end

		if p276.running then
			p276.running = false
			p276.activeTarget = nil
			p276.stats.lastResult = p277
			p276:_notify()
		end

		if not p278 then
			p276:_releaseOperation()
		end
	end
	t41._resolveForestBounds = function()
		local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
		local Areas = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
		local GuardAreas = Areas and Areas:FindFirstChild("GuardAreas")
		local Forest = GuardAreas and GuardAreas:FindFirstChild("Forest")
		local Bounds = Forest and Forest:FindFirstChild("Bounds")

		return Bounds and Bounds:IsA("BasePart") and Bounds or nil
	end
	t41._isInsideForest = function(p279, p280)
		local v990 = p279:_resolveForestBounds()

		if p280 and v990 then
			local v991 = v990.CFrame:PointToObjectSpace(p280.Position)
			local v992 = v990.Size * 0.5

			return math.abs(v991.X) <= v992.X and math.abs(v991.Z) <= v992.Z and v991.Y >= -6 and v991.Y <= 12
		end

		return false
	end
	t41._resolveForestDropCFrame = function(p281, p282)
		if not p282 then
			return nil
		end

		local v993 = p281:_resolveForestBounds()

		if not v993 then
			return nil
		end

		local v994 = v993.CFrame:PointToWorldSpace(Vector3.new(0, 4, 0))

		return cFrameNew(v994) * p282.CFrame.Rotation
	end
	t41._resolveSafeCFrame = function(p283, p284)
		if p284 then
			return cFrameNew(vector32) * p284.CFrame.Rotation
		end

		return nil
	end

	local function v995(p285)
		local v996 = p285.Size.X * 0.5
		local v997 = p285.Size.Z * 0.5
		local huge = math.huge
		local v999 = -math.huge
		local huge2 = math.huge
		local v1001 = -math.huge

		for _, v in ipairs({
			Vector3.new(v996, 0, v997),
			Vector3.new(v996, 0, -v997),
			Vector3.new(-v996, 0, v997),
			Vector3.new(-v996, 0, -v997)
		}) do
			local v1004 = p285.CFrame:PointToWorldSpace(v)

			huge = math.min(huge, v1004.X)
			v999 = math.max(v999, v1004.X)
			huge2 = math.min(huge2, v1004.Z)
			v1001 = math.max(v1001, v1004.Z)
		end

		return huge, v999, huge2, v1001
	end

	t41._snapshotZigzagWalls = function()
		local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
		local Build = __OBJECTS and __OBJECTS:FindFirstChild("Build")
		local t44 = {}

		if not Build then
			return t44
		end

		local function v1008(p286)
			local v1009 = string.upper(p286.Name)

			if v1009 == "SIDE_WALLS" then
				return "high"
			end

			if v1009 == "SIDE_WALLS2" then
				return "low"
			end

			local Parent = p286

			while Parent and Parent ~= Build do
				local v1011 = string.upper(Parent.Name)

				if string.find(v1011, "WALL LEFT", 1, true) then
					return "low"
				end

				if string.find(v1011, "WALL RIGHT", 1, true) then
					return "high"
				end

				Parent = Parent.Parent
			end

			return nil
		end

		for _, descendant in ipairs(Build:GetDescendants()) do
			if descendant:IsA("BasePart") and descendant.CanCollide then
				local v1014 = v1008(descendant)

				if v1014 then
					local v1015, v1016, v1017, v1018 = v995(descendant)

					if v1016 - v1015 >= 100 then
						table.insert(t44, {
							side = v1014,
							minX = v1015,
							maxX = v1016,
							innerZ = v1014 == "low" and v1018 or v1017
						})
					end
				end
			end
		end

		return t44
	end
	t41._resolveZigzagBounds = function(p287, p288)
		local v1019 = -math.huge
		local huge = math.huge
		local v1021 = false
		local v1022 = false
		local ipairs_ = ipairs
		local zigzagWalls = p287.zigzagWalls

		zigzagWalls = zigzagWalls or {}

		for _, zigzagWall in ipairs_(zigzagWalls) do
			if zigzagWall.minX <= p288 and p288 <= zigzagWall.maxX then
				if zigzagWall.side == "low" and zigzagWall.innerZ < vector32.Z then
					v1019 = math.max(v1019, zigzagWall.innerZ)
					v1021 = true
				elseif zigzagWall.side == "high" and vector32.Z < zigzagWall.innerZ then
					huge = math.min(huge, zigzagWall.innerZ)
					v1022 = true
				end
			end
		end

		if not v1021 or not v1022 then
			return nil
		end

		local v1027 = v1019 + 18
		local v1028 = huge - 18

		if v1028 - v1027 < 48 then
			return nil
		end

		return v1027, v1028
	end
	t41._buildSafeZigzagWaypoints = function(p289, p290, p291)
		if p289.config.stealZigzag and p290 then
			if typeof(p291) == "CFrame" then
				local v1029 = p291.Position.X - p290.Position.X
				local v1030 = math.abs(v1029)

				if v1030 <= 30 then
					return {}
				end

				local v1031 = p289:_resolveRouteCruiseY(p290, p291)

				if not v1031 then
					return {}
				end

				local v1032 = math.max(1, math.floor(v1030 / 220))
				local t45 = {}
				local v1034 = p290.Position.Z <= vector32.Z

				for i = 1, v1032 do
					local v1036 = p290.Position.X + v1029 * (i / (v1032 + 1))
					local v1037, v1038 = p289:_resolveZigzagBounds(v1036)

					if not v1037 then
						return {}
					end

					table.insert(t45, cFrameNew(v1036, v1031, v1034 and v1038 or v1037))
					v1034 = not v1034
				end

				return t45
			end
		end

		return {}
	end

	local function v1039(p292)
		if typeof(p292) == "Instance" and p292:IsA("Trail") then
			pcall(p292.Destroy, p292)
		end
	end
	local function v1040(p293)
		if typeof(p293) == "Instance" and (p293.Name == "SpeedGainPopup" or p293.Name == "PlusOne") then
			pcall(p293.Destroy, p293)
		end
	end

	t41._showTreadmillDecoy = function(p294)
		if p294.treadmillDecoy and p294.treadmillDecoy.Parent then
			return true
		end

		p294:_hideTreadmillDecoy()

		local Character = LocalPlayer2.Character

		if not Character then
			return false
		end

		local Archivable = Character.Archivable

		Character.Archivable = true

		local ok, treadmillDecoy = pcall(Character.Clone, Character)

		Character.Archivable = Archivable

		if not ok or not treadmillDecoy or typeof(treadmillDecoy) ~= "Instance" then
			return false
		end

		treadmillDecoy.Name = "__FyyTreadmillDecoy"

		for _, descendant in ipairs(treadmillDecoy:GetDescendants()) do
			if t40[descendant.ClassName] or descendant:IsA("Trail") then
				pcall(descendant.Destroy, descendant)
			elseif descendant:IsA("BasePart") then
				descendant.LocalTransparencyModifier = 0
				descendant.Anchored = true
				descendant.CanCollide = false
				descendant.CanQuery = false
				descendant.CanTouch = false
			end
		end

		local HumanoidRootPart = treadmillDecoy:FindFirstChild("HumanoidRootPart")
		local Humanoid = treadmillDecoy:FindFirstChildOfClass("Humanoid")

		if HumanoidRootPart then
			if Humanoid then
				pcall(function()
					Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None
					Humanoid.HealthDisplayType = Enum.HumanoidHealthDisplayType.AlwaysOff
				end)
				treadmillDecoy.Parent = workspace
				treadmillDecoy:PivotTo(cFrameNew(vector32))
				p294.treadmillDecoy = treadmillDecoy

				local PlayerGui = LocalPlayer2:FindFirstChildOfClass("PlayerGui")

				if PlayerGui then
					for _, descendant in ipairs(PlayerGui:GetDescendants()) do
						if descendant.Name == "SpeedGainPopup" or descendant.Name == "PlusOne" then
							v1040(descendant)
						end
					end

					p294.treadmillPopupConnection = PlayerGui.DescendantAdded:Connect(function(descendant)
						if p294.treadmillDecoy == treadmillDecoy then
							v1040(descendant)
						end
					end)
				end

				local treadmillDecoyRealTransparency = setmetatable({}, {
					__mode = "k"
				})

				local function v1053(p295)
					if not p295 or not p295:IsA("BasePart") or not p295:IsDescendantOf(Character) then
						return
					end

					if treadmillDecoyRealTransparency[p295] == nil then
						treadmillDecoyRealTransparency[p295] = p295.LocalTransparencyModifier
					end

					p295.LocalTransparencyModifier = 1
				end

				for _, descendant in ipairs(Character:GetDescendants()) do
					v1053(descendant)
					v1039(descendant)
				end

				p294.treadmillDecoyRealTransparency = treadmillDecoyRealTransparency
				p294.treadmillDecoyCharacterConnection = Character.DescendantAdded:Connect(function(descendant)
					if p294.treadmillDecoy == treadmillDecoy then
						pcall(v1053, descendant)
						v1039(descendant)
					end
				end)

				local CurrentCamera = workspace.CurrentCamera

				if CurrentCamera then
					p294.treadmillDecoyCamera = CurrentCamera.CameraSubject
					CurrentCamera.CameraSubject = Humanoid
				end

				p294.treadmillDecoyCameraConnection = RunService2.RenderStepped:Connect(function()
					if p294.treadmillDecoy ~= treadmillDecoy or not treadmillDecoy.Parent or not Humanoid.Parent then
						return
					end

					for k in pairs(treadmillDecoyRealTransparency) do
						if k.Parent and k.LocalTransparencyModifier ~= 1 then
							k.LocalTransparencyModifier = 1
						end
					end

					local CurrentCamera2 = workspace.CurrentCamera

					if CurrentCamera2 and CurrentCamera2.CameraSubject ~= Humanoid then
						CurrentCamera2.CameraSubject = Humanoid
					end
				end)

				return true
			end
		end

		treadmillDecoy:Destroy()

		return false
	end
	t41._hideTreadmillDecoy = function(p296)
		if p296.treadmillDecoyCameraConnection then
			pcall(p296.treadmillDecoyCameraConnection.Disconnect, p296.treadmillDecoyCameraConnection)
			p296.treadmillDecoyCameraConnection = nil
		end

		if p296.treadmillDecoyCharacterConnection then
			pcall(p296.treadmillDecoyCharacterConnection.Disconnect, p296.treadmillDecoyCharacterConnection)
			p296.treadmillDecoyCharacterConnection = nil
		end

		if p296.treadmillPopupConnection then
			pcall(p296.treadmillPopupConnection.Disconnect, p296.treadmillPopupConnection)
			p296.treadmillPopupConnection = nil
		end

		local pairs_ = pairs
		local treadmillDecoyRealTransparency = p296.treadmillDecoyRealTransparency or {}

		for k, v in pairs_(treadmillDecoyRealTransparency) do
			if typeof(k) == "Instance" and k.Parent then
				pcall(function()
					k.LocalTransparencyModifier = v
				end)
			end
		end

		p296.treadmillDecoyRealTransparency = nil

		local Character = LocalPlayer2.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local CurrentCamera = workspace.CurrentCamera

		if CurrentCamera then
			pcall(function()
				CurrentCamera.CameraSubject = Humanoid or p296.treadmillDecoyCamera
			end)
		end

		p296.treadmillDecoyCamera = nil

		if p296.treadmillDecoy then
			pcall(p296.treadmillDecoy.Destroy, p296.treadmillDecoy)
		end

		p296.treadmillDecoy = nil
	end
	t41._restoreTreadmillVisualAtSafe = function(p297)
		if not p297.treadmillDecoy then
			p297:_hideTreadmillDecoy()

			return true
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local v1069 = p297:_resolveSafeCFrame(HumanoidRootPart)

		if not HumanoidRootPart or not Humanoid or not v1069 then
			p297:_hideTreadmillDecoy()

			return false
		end

		local v1070 = os.clock() + 2
		local v1071
		local n16 = 0

		while not p297.destroyed and os.clock() < v1070 do
			local now = os.clock()

			if p297:_isInSafeArea(HumanoidRootPart) then
				v1071 = v1071 or now

				if now - v1071 >= 0.35 then
					p297:_hideTreadmillDecoy()

					return true
				end
			else
				v1071 = nil

				if n16 <= now then
					n16 = now + 0.1
					p297:_teleportRoot(HumanoidRootPart, Humanoid, v1069)
				end
			end

			task.wait(0.03)
		end

		p297:_hideTreadmillDecoy()

		return false
	end
	t41._findAreaGuardRoot = function(p298, p299)
		if type(p299) == "string" then
			if p299 ~= "" then
				local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
				local Areas = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
				local GuardAreas = Areas and Areas:FindFirstChild("GuardAreas")
				local v1077 = GuardAreas and GuardAreas:FindFirstChild(p299) or Areas and Areas:FindFirstChild(p299)

				if not v1077 then
					return nil
				end

				local Guard = v1077:FindFirstChild("Guard") or v1077:FindFirstChild(p299 .. "GuardAuthored") or v1077:FindFirstChild("ForestGuardAuthored") or v1077:FindFirstChildWhichIsA("Model")

				return Guard and (Guard:FindFirstChild("HumanoidRootPart") or Guard:FindFirstChild("Collider") or Guard:IsA("Model") and Guard.PrimaryPart or Guard:FindFirstChildWhichIsA("BasePart"))
			end
		end

		return nil
	end
	t41._resolveEggDestination = function(p300, p301, p302, p303)
		if type(p301) ~= "table" or typeof(p301.BottomCFrame) ~= "CFrame" then
			return nil
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = p302 or Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = p303 or Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			return nil
		end

		local v1082 = p301.BottomCFrame.Position + Vector3.new(0, p300:_feetOffset(HumanoidRootPart, Humanoid) + 0.15, 0)
		local v1083 = p300:_findAreaGuardRoot(p301.AreaId)

		if v1083 then
			local Position = v1083.Position
			local vector33 = Vector3.new(Position.X - v1082.X, 0, Position.Z - v1082.Z)

			if vector33.Magnitude > 0.2 then
				return lookAt(v1082, v1082 + vector33.Unit)
			end
		end

		return cFrameNew(v1082)
	end
	t41._resolveRouteCruiseY = function(p304, p305, p306)
		if p305 and typeof(p306) == "CFrame" then
			return math.max(p305.Position.Y, p306.Position.Y + 50, vector32.Y + 50)
		end

		return nil
	end
	t41._resolveElevatedDestination = function(p307, p308, p309)
		local v1086 = p307:_resolveRouteCruiseY(p308, p309)

		if v1086 then
			return cFrameNew(p309.Position.X, v1086, p309.Position.Z) * p309.Rotation
		end

		return nil
	end
	t41._teleportRoot = function(p310, p311, p312, p313)
		if p311 and p312 then
			if typeof(p313) == "CFrame" then
				if not pcall(function()
					p311.AssemblyLinearVelocity = Vector3.zero
					p311.AssemblyAngularVelocity = Vector3.zero
					p311.CFrame = p313
					p311.AssemblyLinearVelocity = Vector3.zero
					p311.AssemblyAngularVelocity = Vector3.zero
				end) then
					return false
				end

				local v1087 = math.clamp(p310.config.speed or 800, 200, 1200)

				v698(LocalPlayer2.Character, v1087 * 1.35)

				if not v757(p312, p311, v1087, Vector3.zero) then
					v753(p312, p311, v1087)
					v757(p312, p311, v1087, Vector3.zero)
				end

				return true
			end
		end

		return false
	end
	t41._isInSafeArea = function(p314, p315)
		if not p315 then
			return false
		end

		local v1088 = p315.Position - vector32

		return Vector2.new(v1088.X, v1088.Z).Magnitude <= 30 and math.abs(v1088.Y) <= 18
	end
	t41._isInField = function(p316, p317)
		local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
		local Areas = __OBJECTS and __OBJECTS:FindFirstChild("Areas")
		local WallStartCollision = Areas and Areas:FindFirstChild("WallStartCollision")

		if WallStartCollision and WallStartCollision:IsA("BasePart") then
			return p317.Position.X >= WallStartCollision.Position.X + 3
		end

		return true
	end
	t41._invalidateCarryWorker = function(p318)
		p318.carryWorker = nil
	end
	t41._claimCarryWorker = function(p319, p320, p321)
		local generation = p319.carry.generation
		local carryWorker = p319.carryWorker

		if carryWorker and carryWorker.generation == generation then
			return nil
		end

		local carryWorker2 = {
			kind = p320,
			uid = p321,
			generation = generation,
			token = {}
		}

		p319.carryWorker = carryWorker2

		return carryWorker2
	end
	t41._isCarryWorkerCurrent = function(p322, p323)
		return type(p323) == "table" and p322.carryWorker == p323 and p322.carry.generation == p323.generation and not p322.destroyed and p322.enabled
	end
	t41._releaseCarryWorker = function(p324, p325)
		if p324.carryWorker == p325 then
			p324.carryWorker = nil
		end
	end
	t41.ownsCarryRecovery = function(p326, p327)
		if not p326.destroyed then
			if p326.enabled then
				if p326.carry.uid == p327 then
					return true
				end

				return p326.running and p326.activeTarget ~= nil and (p327 == nil or p326.activeTarget.Uid == p327)
			end
		end

		return false
	end
	t41.requestCarryRecovery = function(p328, p329)
		if not p328.destroyed then
			if p328.enabled and type(p329) == "string" and p329 ~= "" then
				if p328:isPrimerEgg(p329) or p328:isIntentionalGiftDrop(p329) then
					return false
				end

				if p328:_isDropRecoveryPending(p329) and (p328.guardReturnWait or p328.carryWorker or p328.carryAttemptToken) then
					return true
				end

				if p328.tweenRecoveryUid == p329 then
					p328:_scheduleMovementRetry()

					return true
				end

				if p328.carry.active and p328.carry.uid == p329 then
					return true
				end

				local v1095 = EggState2.ReadFieldEgg(p329) or p328.records[p329]

				if type(v1095) ~= "table" or v1095.State ~= AreaEggs.States.Dropped and v1095.State ~= AreaEggs.States.Slot and v1095.State ~= AreaEggs.States.GuardCarried then
					return false
				end

				local carryWorker = p328.carryWorker

				if carryWorker and carryWorker.kind == "re-steal" and carryWorker.uid == p329 or p328.activeTween and p328.activeTarget and p328.activeTarget.Uid == p329 or p328.carryAttemptToken and p328.activeTarget and p328.activeTarget.Uid == p329 then
					return true
				end

				p328.dropRecoveryUid = p329

				local carry = p328.carry

				carry.generation += 1
				p328:_invalidateCarryWorker()
				p328.carryAttemptToken = nil
				p328.running = true
				p328.activeTarget = v1095
				task.defer(function()
					if not p328.destroyed then
						if p328.enabled and not p328.carry.active then
							p328:_reStealDroppedEgg(p329)
						end
					end
				end)

				return true
			end
		end

		return false
	end
	t41._hasConfirmedCarry = function(p330, p331)
		if not p330.carry.active then
			return false
		end

		if p331 == nil or p330.carry.uid == nil then
			return true
		end

		return p330.carry.uid == p331
	end
	t41._recordShowsForeignCarry = function(p332, p333)
		if type(p333) ~= "string" or p333 == "" then
			return false
		end

		local v1098 = EggState2.ReadFieldEgg(p333) or p332.records[p333]

		return type(v1098) == "table" and v1098.State == AreaEggs.States.Carried and v1098.CarrierUserId ~= nil and v1098.CarrierUserId ~= LocalPlayer2.UserId
	end
	t41._resolveMovementSpeed = function(p334, p335)
		if p335.Parent and not (p335.Health <= 0) then
			return math.clamp(p334.config.speed, 200, 1200)
		end

		return nil
	end
	t41._feetOffset = function(p336, p337, p338)
		if p338.RigType == Enum.HumanoidRigType.R15 then
			return p337.Size.Y * 0.5 + math.max(p338.HipHeight, 0.5)
		end

		return p337.Size.Y * 0.5 + 2
	end
	t41._syncHoverPad = function(p339, p340)
		local hoverPad = p339.hoverPad

		if hoverPad then
			if hoverPad.Parent and hoverPad:GetAttribute("FyyStealRuntimeOwner") == p339.hoverPadOwnerId then
				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

				if not HumanoidRootPart or not Humanoid then
					return false
				end

				local Position = typeof(p340) == "Vector3" and p340 or HumanoidRootPart.Position

				hoverPad.CFrame = cFrameNew(Position.X, Position.Y - p339:_feetOffset(HumanoidRootPart, Humanoid) - 0.5 - 0.05, Position.Z)

				return true
			end
		end

		return false
	end
	t41._setArrivalHold = function(p341, p342, p343)
		if typeof(p342) ~= "CFrame" then
			return
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

		if not Character or not HumanoidRootPart then
			return
		end

		p341.arrivalHold = {
			Character = Character,
			RootPart = HumanoidRootPart,
			CFrame = p342,
			Uid = p343
		}
	end
	t41._clearArrivalHold = function(p344, p345)
		local arrivalHold = p344.arrivalHold

		if arrivalHold then
			if p345 == nil or arrivalHold.Uid == nil or arrivalHold.Uid == p345 then
				p344.arrivalHold = nil
			end
		else
			p344.arrivalHold = nil

			return
		end
	end
	t41._enforceArrivalHold = function(p346)
		local arrivalHold = p346.arrivalHold

		if type(arrivalHold) ~= "table" or typeof(arrivalHold.CFrame) ~= "CFrame" then
			return false
		end

		if LocalPlayer2.Character ~= arrivalHold.Character or not arrivalHold.RootPart or not arrivalHold.RootPart.Parent then
			p346.arrivalHold = nil

			return false
		end

		p346:_startHoverPad()
		pcall(function()
			arrivalHold.RootPart.AssemblyLinearVelocity = Vector3.zero
			arrivalHold.RootPart.AssemblyAngularVelocity = Vector3.zero
			p346:_syncHoverPad(arrivalHold.CFrame.Position)
			arrivalHold.RootPart.CFrame = arrivalHold.CFrame
		end)
		p346:_syncHoverPad(arrivalHold.CFrame.Position)

		return true
	end
	t41._purgeOrphanHoverPads = function(p347)
		for _, child in ipairs(workspace:GetChildren()) do
			if child.Name == "__FyyHoverPad" and child ~= p347.hoverPad then
				pcall(child.Destroy, child)
			end
		end
	end
	t41._startHoverPad = function(p348)
		local hoverPad = p348.hoverPad

		if not hoverPad or not hoverPad.Parent or hoverPad:GetAttribute("FyyStealRuntimeOwner") ~= p348.hoverPadOwnerId then
			p348:_purgeOrphanHoverPads()

			if hoverPad and hoverPad.Parent then
				pcall(hoverPad.Destroy, hoverPad)
			end

			local Part = Instance.new("Part")

			Part.Name = "__FyyHoverPad"
			Part:SetAttribute("FyyStealRuntimeOwner", p348.hoverPadOwnerId)
			Part.Anchored = true
			Part.CanCollide = true
			Part.CanQuery = true
			Part.CanTouch = false
			Part.CastShadow = false
			Part.Transparency = 1
			Part.Material = Enum.Material.SmoothPlastic
			Part.Size = Vector3.new(8, 1, 8)
			p348.hoverPad = Part
			Part.Parent = workspace
		end

		p348:_syncHoverPad()

		if not p348.hoverPadConnection then
			p348.hoverPadConnection = RunService2.PreSimulation:Connect(function()
				if not p348:_syncHoverPad() then
					p348:_startHoverPad()
				end
			end)
		end

		if not p348.hoverPadPostConnection then
			p348.hoverPadPostConnection = RunService2.PostSimulation:Connect(function()
				if p348.activeTween then
					p348:_syncHoverPad()

					return
				elseif p348.arrivalHold then
					p348:_syncHoverPad()
				end
			end)
		end
	end
	t41._stopHoverPad = function(p349)
		if p349.hoverPadConnection then
			pcall(p349.hoverPadConnection.Disconnect, p349.hoverPadConnection)
			p349.hoverPadConnection = nil
		end

		if p349.hoverPadPostConnection then
			pcall(p349.hoverPadPostConnection.Disconnect, p349.hoverPadPostConnection)
			p349.hoverPadPostConnection = nil
		end

		if p349.hoverPad then
			pcall(p349.hoverPad.Destroy, p349.hoverPad)
			p349.hoverPad = nil
		end

		p349:_purgeOrphanHoverPads()
	end
	t41._startMovementProtection = function(p350)
		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not Character or not HumanoidRootPart or not Humanoid then
			return false
		end

		local v1115 = math.clamp(p350.config.speed or 800, 200, 1200)

		p350.protectionCharacter = Character
		p350.protectionHumanoid = Humanoid
		p350.protectionRoot = HumanoidRootPart
		v698(Character, v1115 * 1.35)
		v753(Humanoid, HumanoidRootPart, v1115)

		if not p350.integritySpoofConnection then
			p350.integritySpoofConnection = RunService2.PreSimulation:Connect(function()
				local Character2 = LocalPlayer2.Character
				local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")
				local Humanoid2 = Character2 and Character2:FindFirstChildOfClass("Humanoid")

				if not Character2 or not HumanoidRootPart2 or not Humanoid2 then
					return
				end

				local v1119 = math.clamp(p350.config.speed or 800, 200, 1200)

				p350.protectionCharacter = Character2
				p350.protectionHumanoid = Humanoid2
				p350.protectionRoot = HumanoidRootPart2
				v698(Character2, v1119 * 1.35)

				if not v757(Humanoid2, HumanoidRootPart2, v1119) then
					v753(Humanoid2, HumanoidRootPart2, v1119)
				end

				p350:_enforceArrivalHold()
			end)
		end

		if not p350.arrivalHoldConnection then
			p350.arrivalHoldConnection = RunService2.Heartbeat:Connect(function()
				p350:_enforceArrivalHold()
			end)
		end

		return true
	end
	t41._stopMovementProtection = function(p351)
		if p351.integritySpoofConnection then
			pcall(p351.integritySpoofConnection.Disconnect, p351.integritySpoofConnection)
			p351.integritySpoofConnection = nil
		end

		if p351.arrivalHoldConnection then
			pcall(p351.arrivalHoldConnection.Disconnect, p351.arrivalHoldConnection)
			p351.arrivalHoldConnection = nil
		end

		p351:_clearArrivalHold()
		p351:_stopHoverPad()
		v702()
		v759(p351.protectionHumanoid)
		p351.protectionCharacter = nil
		p351.protectionHumanoid = nil
		p351.protectionRoot = nil
	end
	t41.travelAndWait = function(p352, p353, p354)
		local v1120 = p354 or {}

		if not p352.destroyed then
			if not p352.travelBusy then
				if p352.activeTween and not p352.activeTween.sharedTravel and not p352.running then
					pcall(p352.activeTween.Cancel, p352.activeTween)
				end

				if p352.activeTween then
					return false
				end

				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

				if not HumanoidRootPart then
					return false
				end

				p352.travelBusy = true

				local u1123
				local now = os.clock()
				local v1125 = now
				local Magnitude = (p353.Position - HumanoidRootPart.Position).Magnitude
				local v1127 = now + Magnitude / math.max(tonumber(v1120.speed) or p352.config.speed or 800, 200) + 6

				p352:_tweenRoot(p353, nil, v1120.speed, {
					silent = true,
					sharedTravel = true,
					keepHoverPad = v1120.keepHoverPad == true,
					arrivalHoldSeconds = v1120.arrivalHoldSeconds,
					abort = function()
						return p352.destroyed or v1120.abort ~= nil and v1120.abort()
					end,
					onDone = function(p355)
						u1123 = p355 == true
					end
				})

				while u1123 == nil do
					local now2 = os.clock()
					local HumanoidRootPart2 = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")
					local Magnitude2 = HumanoidRootPart2 and (p353.Position - HumanoidRootPart2.Position).Magnitude or math.huge

					if Magnitude2 < Magnitude - 0.5 then
						Magnitude = Magnitude2
						v1125 = now2
					end

					if p352.destroyed or v1120.abort ~= nil and v1120.abort() or now2 - v1125 >= 1.5 or v1127 <= now2 then
						if p352.activeTween and p352.activeTween.Cancel then
							pcall(p352.activeTween.Cancel)
						end

						u1123 = false

						break
					else
						task.wait(0.05)
					end
				end

				p352.travelBusy = false

				return u1123
			end
		end

		return false
	end

	local function v1131(p356, p357)
		local u1132
		local u1133 = false
		local u1134 = false
		local u1135 = false

		return {
			setMoving = function(p358, p359)
				if u1134 then
					return
				end

				if not p359 then
					if u1132 and u1135 then
						pcall(u1132.Stop, u1132, 0.12)
					end

					u1135 = false

					return
				end

				if not u1133 then
					u1133 = true

					local ok, result = pcall(function()
						local Animate = p356:FindFirstChild("Animate")
						local Animator = p357:FindFirstChildOfClass("Animator")

						if not Animate or not Animator then
							return
						end

						local v1140

						for _, v in ipairs({
							"run",
							"walk"
						}) do
							local v1143 = Animate:FindFirstChild(v)
							local descendants = v1143 and v1143:GetDescendants() or {}

							if v1143 then
								table.insert(descendants, 1, v1143)
							end

							for _, descendant in ipairs(descendants) do
								if descendant:IsA("Animation") and descendant.AnimationId ~= "" then
									v1140 = descendant

									break
								end
							end

							if v1140 then
								break
							end
						end

						if not v1140 then
							return
						end

						u1132 = Animator:LoadAnimation(v1140)
						u1132.Looped = true
						u1132.Priority = Enum.AnimationPriority.Movement
					end)

					if not ok then
						warn("[SAE] Travel run animation unavailable: " .. tostring(result))
					end
				end

				if u1132 and not u1135 then
					u1135 = pcall(u1132.Play, u1132, 0.12, 1, 3)
				end
			end,
			destroy = function()
				if u1134 then
					return
				end

				u1134 = true

				if u1132 then
					pcall(u1132.Stop, u1132, 0)
					pcall(u1132.Destroy, u1132)
					u1132 = nil
				end

				u1135 = false
			end
		}
	end

	t41._tweenRoot = function(p360, p361, p362, p363, p364)
		p360:_clearArrivalHold()

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local v1150 = p364 or {}

		if not HumanoidRootPart or not Humanoid then
			p360.safeStarting = false

			if v1150.silent then
				if v1150.onDone then
					pcall(v1150.onDone, false)
				end

				return
			end

			p360:_finish("Character unavailable")

			return
		end

		local v1151 = p363 or p360:_resolveMovementSpeed(Humanoid)

		if not v1151 then
			p360.safeStarting = false

			if v1150.silent then
				if v1150.onDone then
					pcall(v1150.onDone, false)
				end

				return
			end

			p360:_finish("Movement unavailable")

			return
		end

		local v1152 = math.clamp(v1151, 200, 1200)

		p360:_startMovementProtection()
		pcall(v681, Character)

		local CurrentCamera = workspace.CurrentCamera

		if CurrentCamera and CurrentCamera.CameraSubject ~= Humanoid then
			pcall(function()
				CurrentCamera.CameraSubject = Humanoid
			end)
		end

		local AutoRotate = Humanoid.AutoRotate

		Humanoid.AutoRotate = false

		local v1155 = p361
		local v1156 = v1150.flightProfile == true and p360:_resolveRouteCruiseY(HumanoidRootPart, p361) or nil

		if v1156 then
			p361 = cFrameNew(p361.Position.X, v1156, p361.Position.Z) * p361.Rotation
		end

		local v1157 = type(v1150.pathWaypoints) == "table" and table.clone(v1150.pathWaypoints) or nil
		local n17 = 1
		local activeTween = {
			sharedTravel = v1150.sharedTravel == true,
			routeCruiseY = v1156,
			travelPhase = v1156 and "takeoff" or nil
		}

		p360.activeTween = activeTween

		if v1150.groundedProfile then
			p360:_stopHoverPad()
		else
			p360:_startHoverPad()
		end

		local v1160 = v1131(Character, Humanoid)
		local u1161 = false
		local connection4
		local now
		local v1164 = math.max(tonumber(v1150.arrivalHoldSeconds) or 0.4, 0)
		local u1165
		local n18 = 0
		local CFrame_2
		local u1168
		local travelPhase
		local n19 = 0
		local n20 = 0
		local Position
		local n21 = 0.016666666666666666

		local function v1174()
			CFrame_2 = nil
			u1168 = nil
			travelPhase = nil
			n19 = 0
			n20 = 0
			Position = nil
		end
		local function v1175(p365)
			if u1161 then
				return
			end

			u1161 = true
			now = nil
			v1160:destroy()

			if Humanoid.Parent ~= nil then
				Humanoid.AutoRotate = AutoRotate
			end

			if p365 and v1150.holdAfterArrival then
				local v1176 = p361

				if LocalPlayer2.Character == Character and HumanoidRootPart.Parent then
					v1176 = cFrameNew(v1176.Position) * HumanoidRootPart.CFrame.Rotation
				end

				p360:_setArrivalHold(v1176, v1150.holdUid)
			end

			if v1150.onDone then
				pcall(v1150.onDone, p365 == true)
			end

			if connection4 then
				connection4:Disconnect()
				connection4 = nil
			end

			if p360.activeTween == activeTween then
				p360.activeTween = nil
			end

			if not p360.arrivalHold and not v1150.keepHoverPad then
				p360:_stopHoverPad()
			end

			if not p360.enabled then
				p360:_stopMovementProtection()
			end

			pcall(function()
				if LocalPlayer2.Character == Character and HumanoidRootPart.Parent then
					HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
				end
			end)

			if p365 and LocalPlayer2.Character == Character and Humanoid.Parent ~= nil and p362 then
				p362()
			end
		end

		activeTween.Cancel = function()
			v1175(false)
		end
		connection4 = RunService2.Heartbeat:Connect(function(dt)
			if v1150.abort and v1150.abort() then
				v1175(false)

				return
			end

			if not p360.destroyed and p360.activeTween == activeTween and LocalPlayer2.Character == Character and HumanoidRootPart.Parent and Humanoid.Parent then
				if not pcall(function()
					if v1150.dynamicDestination then
						local ok, result = pcall(v1150.dynamicDestination)

						if not ok or typeof(result) ~= "CFrame" then
							v1175(false)

							return
						end

						p361 = result
					end

					if p360.activeTween ~= activeTween then
						return
					end

					local v1179 = math.clamp(p363 or p360.config.speed or v1152, 200, 1200)

					v698(Character, v1179 * 1.35)

					local __FyyStealAnEggIntegritySpoof = v693().__FyyStealAnEggIntegritySpoof
					local State = type(__FyyStealAnEggIntegritySpoof) == "table" and __FyyStealAnEggIntegritySpoof.State or nil

					if not v752(State, Humanoid, HumanoidRootPart) then
						v1160:setMoving(false)
						u1165 = nil
						now = nil
						v1174()
						HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
						HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

						if not v1150.groundedProfile then
							p360:_syncHoverPad(HumanoidRootPart.Position)
						end

						if v751(State, Humanoid, HumanoidRootPart) then
							v728(State, v1179 * 1.35, Vector3.zero)
						else
							v753(Humanoid, HumanoidRootPart, v1179)
						end

						return
					end

					local Position2 = HumanoidRootPart.Position

					n21 += (math.max(dt, 0.001) - n21) * 0.1

					local v1183 = math.max(0, math.min(dt, 0.05, 2 * n21))
					local v1184 = os.clock() < n18 and math.max(200, v1179 * 0.45) or v1179
					local v1185 = v1184 * v1183

					if v1150.groundedProfile and v1150.projectGroundPosition then
						local v1186 = v1150.projectGroundPosition(p361.Position)

						if typeof(v1186) ~= "Vector3" then
							v1175(false)

							return
						end

						p361 = cFrameNew(v1186) * p361.Rotation
					end

					local v1187 = p361.Position - Position2
					local Magnitude = v1187.Magnitude
					local vector33 = Vector3.new(v1187.X, 0, v1187.Z)
					local Magnitude2 = vector33.Magnitude
					local Position3 = p361.Position

					if activeTween.routeCruiseY then
						if activeTween.travelPhase == "takeoff" and activeTween.routeCruiseY - Position2.Y <= math.max(v1185, 1.5) then
							activeTween.travelPhase = "cruise"
						end

						if activeTween.travelPhase == "takeoff" then
							Position3 = Vector3.new(Position2.X, activeTween.routeCruiseY, Position2.Z)
						else
							Position3 = p361.Position
						end
					end

					local Magnitude3 = (Position3 - Position2).Magnitude
					local routeCruiseY = activeTween.routeCruiseY and Magnitude2 or Magnitude

					if u1165 and u1165 + 2 < routeCruiseY then
						n18 = os.clock() + 0.5
					end

					u1165 = routeCruiseY

					local v1194 = vector33
					local vector34 = Vector3.new(HumanoidRootPart.CFrame.LookVector.X, 0, HumanoidRootPart.CFrame.LookVector.Z)
					local Unit = v1194.Magnitude > 0.001 and v1194.Unit or vector34.Magnitude > 0.001 and vector34.Unit or Vector3.new(0, 0, -1)
					local cFrame = lookAt(Position3, Position3 + Unit)
					local v1198 = Position and (Position2 - Position).Magnitude > 2

					if not CFrame_2 or travelPhase ~= activeTween.travelPhase or v1198 or (u1168.Position - Position3).Magnitude > 0.05 then
						CFrame_2 = HumanoidRootPart.CFrame
						u1168 = cFrame
						travelPhase = activeTween.travelPhase
						n19 = (u1168.Position - CFrame_2.Position).Magnitude
						n20 = 0

						if v1198 then
							now = nil
							n18 = os.clock() + 0.5
						end
					end

					local v1199 = math.min(v1184 * 0.22, n19 * 0.35)
					local n22 = 1

					if v1199 > 0 then
						local v1201 = v1157 and n17 <= #v1157
						local v1202 = activeTween.travelPhase == "landing"

						n22 = math.clamp(math.min((v1150.dynamicDestination or v1157 or v1202) and 1 or n20 / v1199, (v1201 or v1202) and 1 or (n19 - n20) / v1199), 0, 1)
					end

					local v1203 = v1184 * (0.18 + 0.82000000000000006 * math.sin(n22 * 3.1415926535897931 / 2)) * v1183

					if v1150.carryTarget and not activeTween.__earlyCarrySpam and Magnitude <= 30 then
						activeTween.__earlyCarrySpam = true

						local carryTarget = v1150.carryTarget
						local Uid = carryTarget.Uid
						local v1206 = AreaEggSlotIdentity.LooksLikeFirstAreaUid(Uid) and AreaEggSlotIdentity.SlotKey(carryTarget.AreaId, carryTarget.NestId) or nil

						task.spawn(function()
							while not p360.destroyed and p360.enabled and not (p360.activeTween ~= activeTween or p360:_hasConfirmedCarry(Uid)) do
								pcall(v651, Uid, v1206, true)
								task.wait(0.03)
							end
						end)
					end

					local v1207 = not activeTween.routeCruiseY or activeTween.travelPhase == "cruise"
					local v1208 = Magnitude

					if not v1207 or not (v1208 <= math.max(v1203, 0.05)) then
						now = nil

						if not (Magnitude3 <= 0.001) then
							if not v1150.groundedProfile and (not p360.hoverPad or not p360.hoverPad.Parent) then
								p360:_startHoverPad()
							end

							n20 = math.min(n19, n20 + v1203)

							local Position4 = CFrame_2:Lerp(u1168, n19 > 0.001 and n20 / n19 or 1).Position

							if v1150.groundedProfile and v1150.projectGroundPosition then
								local v1210 = v1150.projectGroundPosition(Position4)

								if typeof(v1210) ~= "Vector3" then
									v1175(false)

									return
								end

								Position4 = v1210
							else
								p360:_syncHoverPad(Position4)
							end

							HumanoidRootPart.CFrame = lookAt(Position4, Position4 + Unit)
							v1160:setMoving((Position4 - Position2).Magnitude > 0.001)
							Position = HumanoidRootPart.Position
							HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
							HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

							if not v1150.groundedProfile then
								p360:_syncHoverPad(Position4)
							end

							if not v757(Humanoid, HumanoidRootPart, v1179, Vector3.zero) then
								v753(Humanoid, HumanoidRootPart, v1179)
								v757(Humanoid, HumanoidRootPart, v1179, Vector3.zero)
							end

							return
						end

						v1160:setMoving(false)
						HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
						HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

						if not v1150.groundedProfile then
							p360:_syncHoverPad(Position2)
						end

						return
					end

					local Position4 = p361.Position

					if not v1150.groundedProfile then
						p360:_syncHoverPad(Position4)
					end

					HumanoidRootPart.CFrame = lookAt(Position4, Position4 + Unit)
					Position = HumanoidRootPart.Position
					HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero

					if not v1150.groundedProfile then
						p360:_syncHoverPad(Position4)
					end

					v757(Humanoid, HumanoidRootPart, v1179, Vector3.zero)

					local v1212 = v1157 and v1157[n17]

					if typeof(v1212) == "CFrame" then
						n17 += 1
						p361 = v1212
						activeTween.routeCruiseY = nil
						activeTween.travelPhase = nil
						u1165 = nil
						now = nil
						v1174()
						v1160:setMoving(true)

						return
					end

					if activeTween.routeCruiseY then
						p361 = v1155
						activeTween.routeCruiseY = nil
						activeTween.travelPhase = "landing"
						v1174()
						now = nil
						u1165 = nil

						return
					end

					v1160:setMoving(false)

					if v1208 > 0.5 then
						now = nil
					end

					if v1150.continuous then
						now = nil

						return
					end

					now = now or os.clock()

					if v1164 <= os.clock() - now then
						v1175(true)
					end
				end) then
					v1175(false)
				end

				return
			end

			v1175(false)
		end)
	end
	t41._isDropRecoveryPending = function(p366, p367)
		local v1213 = p367 ~= nil and p366.dropRecoveryUid == p367 and p366.running and p366.enabled and not p366.destroyed

		return v1213 and p366.activeTarget ~= nil and p366.activeTarget.Uid == p367
	end
	t41._waitForGuardReturn = function(p368, p369, p370)
		local Character = LocalPlayer2.Character
		local guardReturnWait = p368.guardReturnWait

		if not guardReturnWait or guardReturnWait.uid ~= p369 then
			guardReturnWait = {
				uid = p369,
				deadline = os.clock() + 15,
				character = Character
			}
			p368.guardReturnWait = guardReturnWait
		end

		p368.dropRecoveryUid = p369
		p368:_clearArrivalHold(p369)

		if p368.activeTween then
			pcall(p368.activeTween.Cancel, p368.activeTween)
		end

		local function v1216(p371, p372)
			if p368.guardReturnWait == guardReturnWait then
				p368.guardReturnWait = nil
			end

			return p371, p372
		end

		while p370() and p368.guardReturnWait == guardReturnWait do
			if LocalPlayer2.Character ~= guardReturnWait.character or not Character or not Character:FindFirstChild("HumanoidRootPart") then
				return v1216(nil, "Character unavailable")
			end

			if not p368:_wallOpen() then
				return v1216(nil, "Wall closed during guard return")
			end

			if p368:isPrimerEgg(p369) or p368:isIntentionalGiftDrop(p369) then
				return v1216(nil, "Egg excluded from recovery")
			end

			local v1217 = EggState2.ReadFieldEgg(p369) or p368.records[p369]

			if v1217 then
				if v1217.State == AreaEggs.States.Claimed then
					return v1216(nil, "Egg already claimed")
				end

				if v1217.State == AreaEggs.States.Carried and v1217.CarrierUserId and v1217.CarrierUserId ~= LocalPlayer2.UserId then
					return v1216(nil, "Egg carried by another player")
				end

				if v1217.State == AreaEggs.States.GuardCarried then
					guardReturnWait.guardSeen = true
				elseif not (v1217.State ~= AreaEggs.States.Slot and (v1217.State ~= AreaEggs.States.Dropped or guardReturnWait.guardSeen)) then
					return v1216(v1217)
				end
			end

			if not (guardReturnWait.deadline <= os.clock()) then
				p368:_setStatus("Waiting for guard to return egg")
				task.wait(0.03)

				continue
			end

			return v1216(nil, "Guard return timed out")
		end

		return v1216(nil, "Recovery cancelled")
	end
	t41._reStealDroppedEgg = function(p373, p374)
		if type(p374) == "string" and p374 ~= "" then
			if not p373:isPrimerEgg(p374) and not p373:isIntentionalGiftDrop(p374) then
				if p373.tweenRecoveryUid == p374 then
					p373.running = false
					p373.activeTarget = nil
					p373:_releaseOperation()
					p373:_scheduleMovementRetry()

					return
				end

				local v1218 = p373:_claimCarryWorker("re-steal", p374)

				if not v1218 then
					return
				end

				local v1219 = v693()

				if v1219 and v1219.__ZeroinGodMode then
					pcall(function()
						v1219.__ZeroinGodMode:startDefend(p374)
					end)
				end

				p373.dropRecoveryUid = p374
				p373:_setStatus("Re-stealing dropped egg")

				local v1220, v1221 = p373:_waitForGuardReturn(p374, function()
					return p373:_isCarryWorkerCurrent(v1218) and p373:_isDropRecoveryPending(p374)
				end)

				if not p373:_isCarryWorkerCurrent(v1218) then
					return
				end

				if not p373:_isDropRecoveryPending(p374) then
					p373:_releaseCarryWorker(v1218)

					return
				end

				if not v1220 or not p373:_wallOpen() then
					p373:_releaseCarryWorker(v1218)
					p373:_finish(v1221 or "Egg lost — retrying")

					return
				end

				p373:_cancelTween("Re-stealing dropped egg", true)

				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

				if HumanoidRootPart then
					HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
					HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
				end

				local v1225 = p373:_resolveEggDestination(v1220, HumanoidRootPart, Humanoid)

				if not v1225 then
					p373:_releaseCarryWorker(v1218)
					p373:_finish("Character unavailable")

					return
				end

				p373.running = true
				p373.activeTarget = v1220
				p373:_setStatus("Teleporting to dropped egg")

				if not p373:_teleportRoot(HumanoidRootPart, Humanoid, v1225) then
					p373:_releaseCarryWorker(v1218)
					p373:_finish("Dropped egg teleport failed")

					return
				end

				p373:_setArrivalHold(v1225, v1220.Uid)
				p373:_setStatus("Re-stealing egg")

				if p373:_isCarryWorkerCurrent(v1218) then
					p373:_requestCarry(v1220, true)
				end

				return
			end
		end

		p373:_finish("Egg lost — retrying")
	end
	t41._recoverCarryConfirmationTimeout = function(p375, p376, p377, p378)
		if not p375.destroyed and p375.enabled then
			if p375.carryAttemptToken == p376 and not p375:_hasConfirmedCarry(p377) then
				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				local v1228 = HumanoidRootPart and p375:_resolveSafeCFrame(HumanoidRootPart)
				local v1229 = v1228 and p375:_resolveElevatedDestination(HumanoidRootPart, v1228) or nil

				p375.tweenRecoveryUid = p377
				p375.dropRecoveryUid = nil
				p375.guardReturnWait = nil

				local carry = p375.carry

				carry.generation += 1
				p375:_invalidateCarryWorker()
				p375.carryAttemptToken = nil
				p375:_clearArrivalHold(p377)

				if p375.activeTween and p375.activeTween.Cancel then
					pcall(p375.activeTween.Cancel, p375.activeTween)
				end

				p375.activeTween = nil
				p375:_stopMovementProtection()
				p375.running = false
				p375.activeTarget = nil
				p375.stats.lastResult = p378 and "Carry timeout: " .. p378 or "Carry confirmation timeout"

				if HumanoidRootPart and v1229 then
					pcall(function()
						HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
						HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
						HumanoidRootPart.CFrame = v1229
						HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
						HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
					end)
					p375:_setStatus(p375.stats.lastResult .. " — teleported safe")
				else
					p375:_setStatus(p375.stats.lastResult .. " — safe area unavailable")
				end

				if p375.enabled then
					p375:_startMovementProtection()
				end

				p375:_releaseOperation()
				task.delay(0.35, function()
					if not p375.destroyed and p375.enabled and p375.carryAttemptToken == nil then
						p375:_schedule()
					end
				end)

				return true
			end
		end

		return false
	end
	t41._requestCarry = function(p379, p380, p381)
		if not p379:_wallOpen() then
			p379:_finish("Wall closed before carry")

			return
		end

		local Uid = p380.Uid
		local carryAttemptToken = {}
		local u1233
		local u1234

		p379.carryAttemptToken = carryAttemptToken
		p379.stats.lastResult = "Carry requested"
		p379:_setStatus("Securing egg")

		local Character = LocalPlayer2.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if Humanoid then
			pcall(Humanoid.UnequipTools, Humanoid)
		end

		if p379.coordinator then
			if p379.coordinator:isBackgroundBusy() then
				local v1237 = os.clock() + 0.08

				while p379.coordinator:isBackgroundBusy() and not p379.destroyed and p379.enabled and p379.carryAttemptToken == carryAttemptToken and os.clock() < v1237 do
					task.wait(0.02)
				end

				if Humanoid and Humanoid.Parent then
					pcall(Humanoid.UnequipTools, Humanoid)
				end
			end
		end

		task.spawn(function()
			while not p379.destroyed and p379.enabled and p379.running and p379.carryAttemptToken == carryAttemptToken and p379.activeTarget and p379.activeTarget.Uid == Uid do
				if p379:_hasConfirmedCarry(Uid) then
					p379:_clearArrivalHold(Uid)
					p379.carryAttemptToken = nil

					if p379.activeTween then
						pcall(p379.activeTween.Cancel, p379.activeTween)
						p379.activeTween = nil
					end

					if p379.instantPhase ~= "priming" or Uid ~= p379.primerUid then
						p379.stats.lastResult = "Carry confirmed"
						p379:_setStatus("Carry confirmed")
						task.defer(function()
							if not p379.destroyed and p379.enabled and p379:_hasConfirmedCarry(Uid) then
								p379:_returnToSafe()
							end
						end)

						return
					end

					p379.carry.active = true
					p379.carry.uid = Uid
					p379.stats.lastResult = "Primer secured"
					p379:_enterBaitWait()

					return
				end

				if not p379:_wallOpen() then
					p379:_finish("Wall closed before carry")

					return
				end

				local v1238 = EggState2.ReadFieldEgg(Uid) or p379.records[Uid]

				if not p379:isPrimerEgg(Uid) and not p379:isIntentionalGiftDrop(Uid) then
					local v1239, v1240, v1241, v1242, _finish, v1244

					if v1238 and v1238.State == AreaEggs.States.GuardCarried then
						v1239, v1240 = p379:_waitForGuardReturn(Uid, function()
							return not p379.destroyed and p379.enabled and p379.running and p379.carryAttemptToken == carryAttemptToken
						end)
						v1238 = v1239
						v1241 = v1240

						if p379.carryAttemptToken ~= carryAttemptToken or p379.destroyed or not p379.enabled then
							return
						end

						if not v1238 then
							v1242 = p379
							_finish = p379._finish
							v1244 = v1241 or "Guard return failed"
							_finish(v1242, v1244)

							return
						end

						p379.activeTarget = v1238
						u1233 = nil
						u1234 = nil
					elseif not v1238 and p379:_isDropRecoveryPending(Uid) then
						v1239, v1240 = p379:_waitForGuardReturn(Uid, function()
							return not p379.destroyed and p379.enabled and p379.running and p379.carryAttemptToken == carryAttemptToken
						end)
						v1238 = v1239
						v1241 = v1240

						if p379.carryAttemptToken ~= carryAttemptToken or p379.destroyed or not p379.enabled then
							return
						end

						if not v1238 then
							v1242 = p379
							_finish = p379._finish
							v1244 = v1241 or "Guard return failed"
							_finish(v1242, v1244)

							return
						end

						p379.activeTarget = v1238
						u1233 = nil
						u1234 = nil
					end
				end

				if u1233 then
					if u1233 <= os.clock() then
						p379:_recoverCarryConfirmationTimeout(carryAttemptToken, Uid, u1234)

						return
					end
				end

				if not v1238 then
					p379:_finish("Target unavailable")

					return
				end

				if v1238.State ~= AreaEggs.States.Carried then
					if v1238.State ~= AreaEggs.States.Slot and v1238.State ~= AreaEggs.States.Dropped then
						p379:_finish("Target changed")

						return
					end

					local Character2 = LocalPlayer2.Character
					local HumanoidRootPart = Character2 and Character2:FindFirstChild("HumanoidRootPart")

					if not HumanoidRootPart then
						p379:_finish("Character unavailable")

						return
					end

					local Humanoid2 = Character2 and Character2:FindFirstChildOfClass("Humanoid")

					if not Humanoid2 then
						p379:_finish("Character unavailable")

						return
					end

					local v1248 = p379:_resolveEggDestination(v1238, HumanoidRootPart, Humanoid2)
					local v1249 = v1248

					if not v1249 then
						p379:_finish("Character unavailable")

						return
					end

					if (HumanoidRootPart.Position - v1249.Position).Magnitude > 10 then
						if not p381 then
							p379:_setStatus("Re-approaching egg")

							local u1250 = false
							local v1251 = p379
							local _tweenRoot = p379._tweenRoot
							local v1253 = v1248

							local function v1254()
								u1250 = true

								if not (p379.carryAttemptToken ~= carryAttemptToken or p379:_hasConfirmedCarry(Uid)) then
									p379:_setStatus("Securing egg")
								end
							end

							_tweenRoot(v1251, v1253, v1254, nil, {
								holdAfterArrival = true,
								holdUid = Uid,
								flightProfile = not (p379.instantPhase == "priming" and Uid == p379.primerUid)
							})

							while not p379.destroyed and p379.enabled and p379.carryAttemptToken == carryAttemptToken and not p379:_hasConfirmedCarry(Uid) and not u1250 do
								task.wait(0.25)
							end

							continue
						end

						p379:_setStatus("Teleporting back to dropped egg")

						if not p379:_teleportRoot(HumanoidRootPart, Humanoid2, v1249) then
							p379:_finish("Dropped egg teleport failed")

							return
						end

						p379:_setArrivalHold(v1249, Uid)
						p379:_setStatus("Re-stealing egg")
					end

					local v1255 = AreaEggSlotIdentity.LooksLikeFirstAreaUid(v1238.Uid) and AreaEggSlotIdentity.SlotKey(v1238.AreaId, v1238.NestId) or nil
					local v1256 = (tonumber(LocalPlayer2:GetAttribute("RagdollEndTime")) or 0) - workspace:GetServerTimeNow()
					local v1257 = p381 and p379.config.stealMode == "Instant" and p379.instantPhase == "hunting"

					if Humanoid2.Parent and not v1257 then
						pcall(function()
							Humanoid2.PlatformStand = false
							Humanoid2.Sit = false

							local state = Humanoid2:GetState()

							if state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.PlatformStanding then
								Humanoid2:ChangeState(Enum.HumanoidStateType.Running)
							end
						end)
					end

					if not v1257 and v1256 > 0 then
						p379:_setStatus(string.format("Hit recovery (%.1fs)", v1256))

						if Remotes and Remotes.Limpness and Remotes.Limpness.WriteLimpness then
							pcall(function()
								Remotes.Limpness.WriteLimpness:FireServer(false)
							end)
						end

						if v1256 > 0.05 then
							task.wait(math.clamp(v1256 - 0.03, 0.02, 0.12))
						end
					end

					if p379.destroyed or not p379.enabled or p379.carryAttemptToken ~= carryAttemptToken or p379.carry.active or p379:_hasConfirmedCarry(Uid) or LocalPlayer2.Character ~= Character2 then
						return
					end

					local ok, result, result2 = pcall(v651, v1238.Uid, v1255, true)

					if p379.destroyed or not p379.enabled or p379.carryAttemptToken ~= carryAttemptToken or p379.carry.active then
						return
					end

					if p379:_hasConfirmedCarry(Uid) then
						return
					end

					u1233 = u1233 or os.clock() + 5

					if ok and result then
						u1234 = nil
						p379.stats.lastResult = "Carry accepted; awaiting confirmation"
						p379:_setStatus("Waiting for carry confirmation")
					else
						local v1262 = ok and result2 or "Request failed"

						if type(v1262) ~= "string" or v1262 == "" then
							v1262 = "Server rejected carry"
						end

						local carryRejected = v1262:sub(1, 100)

						if u1234 ~= carryRejected then
							u1234 = carryRejected
							p379.stats.lastResult = "Carry rejected: " .. carryRejected
							p379:_setStatus(p379.stats.lastResult)
						end
					end

					task.wait(0.05)

					continue
				end

				if v1238.CarrierUserId ~= LocalPlayer2.UserId then
					p379:_finish("Egg carried by another player")

					return
				end

				p379:_setStatus("Confirming carry state")
				task.wait(0.25)
			end
		end)
	end
	t41._dropCarriedEggAtFirstArea = function(p382)
		local uid = p382.carry.uid

		if type(uid) ~= "string" or uid == "" or p382:isPrimerEgg(uid) then
			return false
		end

		local v1265 = p382:_claimCarryWorker("gift-drop", uid)

		if not v1265 then
			return false
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
		local v1269 = p382:_resolveForestDropCFrame(HumanoidRootPart)

		if not HumanoidRootPart or not Humanoid or not v1269 then
			p382:_releaseCarryWorker(v1265)
			p382:_finish("Forest drop destination unavailable")

			return false
		end

		if not p382:_wallOpen() then
			p382:_releaseCarryWorker(v1265)
			p382:_finish("Forest drop interrupted by reset")

			return false
		end

		p382.running = true
		p382:_setStatus("Delivering egg to Forest")
		p382:_tweenRoot(v1269, function()
			if not p382:_isCarryWorkerCurrent(v1265) then
				return
			end

			if p382.destroyed or not p382.enabled or not p382.carry.active or p382.carry.uid ~= uid then
				p382:_releaseCarryWorker(v1265)

				return
			end

			p382.intentionalGiftUid = uid
			p382:_setStatus("Dropping egg at Forest")
			task.spawn(function()
				local v1270 = os.clock() + 2

				while p382:_isCarryWorkerCurrent(v1265) and not p382.destroyed and p382.enabled and p382.intentionalGiftUid == uid and p382.carry.active and p382.carry.uid == uid and os.clock() < v1270 do
					local ok, result = pcall(function()
						return EggWorld.AskFieldEggDrop:InvokeServer({
							Reason = "PlayerRequest"
						})
					end)

					if not ok then
						break
					end

					if result == true then
						task.wait(0.03)
					else
						task.wait(0.08)
					end
				end

				if p382.intentionalGiftUid == uid and p382.carry.active and p382.carry.uid == uid then
					p382.intentionalGiftUid = nil
					p382:_releaseCarryWorker(v1265)
					p382:_finish("Forest drop not confirmed")
				elseif p382:_isCarryWorkerCurrent(v1265) then
					p382:_releaseCarryWorker(v1265)
				end
			end)
		end, nil, {
			flightProfile = true,
			arrivalHoldSeconds = 0
		})

		return true
	end
	t41._returnToSafe = function(p383)
		p383:_hideTreadmillDecoy()

		local uid = p383.carry.uid

		if p383:isPrimerEgg(uid) then
			return
		end

		if p383.config.dropAtFirstArea then
			p383:_dropCarriedEggAtFirstArea()

			return
		end

		local v1274 = p383:_claimCarryWorker("return", uid)

		if not v1274 then
			return
		end

		p383:_clearArrivalHold(uid)

		if not p383:_wallOpen() then
			p383:_releaseCarryWorker(v1274)
			p383:_finish("Reset interrupted carry")

			return
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			p383:_releaseCarryWorker(v1274)
			p383:_finish("Character unavailable")

			return
		end

		if not p383:_hasConfirmedCarry(uid) or p383:_recordShowsForeignCarry(uid) then
			p383:_releaseCarryWorker(v1274)
			p383:_finish("Carry not confirmed — retrying")

			return
		end

		if p383:_isInSafeArea(HumanoidRootPart) then
			p383:_finalizeReturn(v1274)

			return
		end

		local v1277 = p383:_resolveSafeCFrame(HumanoidRootPart)

		if not v1277 then
			p383:_releaseCarryWorker(v1274)
			p383:_finish("Safe destination unavailable")

			return
		end

		local v1278 = p383:_buildSafeZigzagWaypoints(HumanoidRootPart, v1277)
		local v1279 = v1278[1]

		if not v1279 then
			p383:_setStatus("Returning to safe area")
			p383:_tweenRoot(v1277, function()
				if p383:_isCarryWorkerCurrent(v1274) then
					p383:_finalizeReturn(v1274)
				end
			end, nil, {
				flightProfile = true,
				arrivalHoldSeconds = 0
			})

			return
		end

		local t46 = {}

		for i = 2, #v1278 do
			table.insert(t46, v1278[i])
		end

		table.insert(t46, v1277)
		p383:_setStatus(string.format("Zigzag return · %d turns", #v1278))
		p383:_tweenRoot(v1279, function()
			if p383:_isCarryWorkerCurrent(v1274) then
				p383:_finalizeReturn(v1274)
			end
		end, nil, {
			pathWaypoints = t46,
			flightProfile = true,
			arrivalHoldSeconds = 0
		})
	end
	t41._finalizeReturn = function(p384, p385)
		if not p384:_isCarryWorkerCurrent(p385) then
			return
		end

		if not p384.carry.active then
			p384.hasDepositedThisSession = true
			p384:_releaseCarryWorker(p385)
			p384:_finish("Safe return complete")

			return
		end

		p384:_setStatus("Validating safe arrival")

		local now = os.clock()
		local v1283 = os.clock() + 6

		while p384:_isCarryWorkerCurrent(p385) and p384.carry.active and os.clock() < v1283 do
			local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

			if not HumanoidRootPart then
				p384:_releaseCarryWorker(p385)
				p384:_finish("Character unavailable")

				return
			end

			if not p384:_isInSafeArea(HumanoidRootPart) then
				p384:_setStatus("Rollback detected — returning again")
				p384:_releaseCarryWorker(p385)
				task.defer(function()
					if not p384.destroyed and p384.enabled and p384.carry.active then
						p384:_returnToSafe()
					end
				end)

				return
			end

			if os.clock() - now >= 0.35 then
				p384:_setStatus("Waiting for deposit")
			end

			task.wait(0.08)
		end

		if not p384:_isCarryWorkerCurrent(p385) then
			return
		end

		if not p384.carry.active then
			p384:_releaseCarryWorker(p385)
			p384:_finish("Safe return complete")

			return
		end

		p384:_setStatus("Deposit pending — validating again")
		task.defer(function()
			if p384:_isCarryWorkerCurrent(p385) and p384.carry.active then
				p384:_finalizeReturn(p385)
			end
		end)
	end
	t41._finish = function(p386, p387)
		p386:_invalidateCarryWorker()
		p386.planGeneration += 1

		if p386.panelActiveUid ~= nil then
			p386.panelActiveUid = nil
		end

		local v1285 = p386:hasDrPriorityEggsAuthoritative(true)
		local v1286 = p386.riftRuntime and type(p386.riftRuntime.isPlacePending) == "function" and p386.riftRuntime:isPlacePending()
		local v1287 = not v1285 and p386.drScrambleRuntime and type(p386.drScrambleRuntime.isEventWindowActive) == "function" and p386.drScrambleRuntime:isEventWindowActive()
		local v1288 = p386.captureTheEggRuntime and type(p386.captureTheEggRuntime.isEngaged) == "function" and p386.captureTheEggRuntime:isEngaged()
		local v1289 = p386.enabled and not v1286 and not v1287 and not v1288

		p386:_cancelTween(p387, v1289)

		local v1290 = p386
		local _setStatus = p386._setStatus
		local v1292 = v1289 and "Searching"

		_setStatus(v1290, v1292 or v1287 and "Yielding to Dr. Scramble" or v1286 and "Yielding to Rift place" or "Idle")

		if p386.enabled then
			task.delay(0.1, function()
				if p386.destroyed then
					p386:_releaseOperation()

					return
				end

				if not (p386.userStealEnabled or p386.riftObjectiveEnabled or p386.drScrambleObjectiveEnabled or p386.panelTargetUid ~= nil or p386.panelActiveUid ~= nil) then
					p386:_reconcileRunningState()

					return
				end

				p386:_schedule()
			end)
		end
	end
	t41._scheduleMovementRetry = function(p388)
		if not p388.movementRetryPending and not p388.destroyed then
			if p388.enabled then
				p388.movementRetryPending = true
				task.delay(0.2, function()
					p388.movementRetryPending = false

					if not p388.destroyed and p388.enabled then
						p388:_schedule()
					end
				end)

				return
			end
		end
	end
	t41._schedule = function(p389)
		if p389.destroyed or not p389.enabled or p389.running or p389.safeStarting or p389.resetSnapshotPending then
			return
		end

		if not p389.startupSettled then
			p389:_setStatus("Waiting for filters")

			return
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			p389:_releaseOperation()
			p389:_setStatus("Character unavailable")

			return
		end

		p389:_startMovementProtection()

		if p389.carry.active and p389.carry.uid ~= nil then
			if p389:isPrimerEgg(p389.carry.uid) then
				return
			end

			p389:_returnToSafe()

			return
		end

		if not p389:_wallOpen() then
			p389:_releaseOperation()
			p389:_setStatus("Waiting for reset wall")

			return
		end

		if p389.riftRuntime and type(p389.riftRuntime.isTradeReady) == "function" then
			if p389.riftRuntime:isTradeReady() then
				p389:_releaseOperation()
				p389:_setStatus("Yielding to Rift trade")
				task.delay(0.5, function()
					if not p389.destroyed and p389.enabled then
						p389:_schedule()
					end
				end)

				return
			end
		end

		if p389.riftRuntime and type(p389.riftRuntime.isPlacePending) == "function" then
			if p389.riftRuntime:isPlacePending() then
				p389:_releaseOperation()
				p389:_setStatus("Yielding to Rift place")
				task.delay(0.5, function()
					if not p389.destroyed and p389.enabled then
						p389:_schedule()
					end
				end)

				return
			end
		end

		if p389.captureTheEggRuntime and type(p389.captureTheEggRuntime.isEngaged) == "function" then
			if p389.captureTheEggRuntime:isEngaged() then
				p389:_releaseOperation()
				p389:_setStatus("Yielding to Capture The Egg")
				task.delay(0.5, function()
					if not p389.destroyed and p389.enabled then
						p389:_schedule()
					end
				end)

				return
			end
		end

		local tweenRecoveryUid = p389.tweenRecoveryUid
		local v1297 = tweenRecoveryUid and (EggState2.ReadFieldEgg(tweenRecoveryUid) or p389.records[tweenRecoveryUid]) or nil

		if tweenRecoveryUid and (type(v1297) ~= "table" or v1297.State ~= AreaEggs.States.Slot and v1297.State ~= AreaEggs.States.Dropped) then
			p389.tweenRecoveryUid = nil
			tweenRecoveryUid = nil
			v1297 = nil
		end

		if not v1297 and p389.drScrambleObjectiveEnabled and p389.drScrambleRuntime then
			if p389.drScrambleRuntime:isEventWindowActive() and not p389:hasDrPriorityEggsAuthoritative() then
				if p389.drScrambleNeedsSafeReturn then
					if not p389:_isInSafeArea(HumanoidRootPart) then
						p389:_returnToSafeForDrScramble(HumanoidRootPart)

						return
					end

					p389.drScrambleNeedsSafeReturn = false
				end

				local v1298 = p389.drScrambleRuntime:getEventRoute()

				if v1298 then
					p389:_startDrScrambleRoute(v1298)
				else
					p389:_releaseOperation()
					p389:_setStatus("Waiting for event robot replication")
					p389:_scheduleMovementRetry()
				end

				return
			end
		end

		v1297 = v1297 or p389:_chooseTarget()

		if not v1297 then
			p389:_releaseOperation()

			local treadmillManager = p389.treadmillManager and p389.treadmillManager:isEngaged()

			if not treadmillManager and p389:_isInField(HumanoidRootPart) and not p389:_isInSafeArea(HumanoidRootPart) then
				local v1300 = p389:_resolveSafeCFrame(HumanoidRootPart)

				if v1300 and not p389.safeStarting then
					p389.safeStarting = true
					p389.running = true
					p389:_setStatus("Returning to safe area")
					p389:_tweenRoot(v1300, function()
						p389.safeStarting = false
						p389.running = false
						task.delay(0.2, function()
							if not p389.destroyed and p389.enabled then
								p389:_schedule()
							end
						end)
					end, nil, {
						flightProfile = true,
						arrivalHoldSeconds = 0
					})

					return
				end
			end

			p389:_setStatus(treadmillManager and "Training on treadmill" or "No matching eggs")

			return
		end

		local planGeneration = p389.planGeneration
		local v1302, v1303 = p389:_acquireOperation()

		if not v1302 then
			p389:_setStatus("Waiting · " .. tostring(v1303 or "another operation"))
			task.delay(0.5, function()
				if not p389.destroyed and p389.enabled and p389.planGeneration == planGeneration then
					p389:_schedule()
				end
			end)

			return
		end

		p389.safeStarting = true
		p389.running = true
		p389.activeTarget = v1297

		if v1297 and v1297.AssetCategory then
			if v1297.AreaId and type(t10) == "table" then
				t10[v1297.AssetCategory] = v1297.AreaId
			end

			local v1304 = v693()

			if v1304 then
				v1304.__ZeroinLastStolenEgg = {
					AssetCategory = v1297.AssetCategory,
					AssetScale = v1297.AssetScale,
					AreaId = v1297.AreaId,
					Mutations = v1297.Mutations,
					BaseMutation = v1297.BaseMutation,
					Timestamp = os.clock()
				}
			end
		end

		local v1305 = p389.catalog.resolve(v1297)

		p389.stats.lastTarget = string.format("%s · %s · %s", v1305.rarity, v1305.name, v1297.AreaId)

		if tweenRecoveryUid then
			p389.safeStarting = false
			p389.stats.lastResult = "Recovering with tween"

			local v1306 = p389:_resolveEggDestination(v1297, HumanoidRootPart, Humanoid)

			if not v1306 then
				p389.tweenRecoveryUid = nil
				p389:_finish("Recovery destination unavailable")

				return
			end

			p389:_setStatus("Returning to egg")
			p389:_tweenRoot(v1306, function()
				if p389.tweenRecoveryUid == v1297.Uid then
					p389:_requestCarry(v1297, false)
				end
			end, nil, {
				holdAfterArrival = true,
				holdUid = v1297.Uid,
				flightProfile = true,
				carryTarget = v1297
			})

			return
		end

		local dropAtFirstArea = p389.continueFromForestGift and p389.config.dropAtFirstArea and p389:_wallOpen() and p389:_isInsideForest(HumanoidRootPart)

		p389.continueFromForestGift = false

		if not dropAtFirstArea and p389:_isInField(HumanoidRootPart) and not p389:_isInSafeArea(HumanoidRootPart) then
			local v1308 = p389:_resolveSafeCFrame(HumanoidRootPart)

			if v1308 then
				p389.safeStarting = true
				p389.running = true
				p389:_setStatus("Repositioning to safe area")
				p389:_tweenRoot(v1308, function()
					p389.safeStarting = false
					p389.running = false
					task.delay(0.15, function()
						if not p389.destroyed and p389.enabled and p389.planGeneration == planGeneration then
							p389:_schedule()
						end
					end)
				end, nil, {
					flightProfile = true
				})

				return
			end
		end

		p389.safeStarting = false

		local v1309 = p389:_choosePrimerEgg(v1297.Uid)

		if not v1309 then
			p389.running = false
			p389.activeTarget = nil
			p389:_releaseOperation()
			p389:_setStatus("Waiting for Forest primer")
			task.delay(0.25, function()
				if not p389.destroyed and p389.enabled and p389.planGeneration == planGeneration then
					p389:_schedule()
				end
			end)

			return
		end

		p389.instantPhase = "priming"
		p389.primerUid = v1309.Uid
		p389.targetUid = v1297.Uid
		p389.activeTarget = v1309

		if p389.config.stealMode == "Instant" then
			p389:_showTreadmillDecoy()
		end

		local v1310 = p389.hasDepositedThisSession == true

		if p389.config.stealMode == "Instant" then
			v1310 = true
		end

		local v1311 = p389:_resolveEggDestination(v1309, HumanoidRootPart, Humanoid)

		if not v1311 then
			p389:_finish("Primer destination unavailable")

			return
		end

		if v1310 then
			p389.stats.lastResult = p389.config.stealMode .. " priming (teleport)"
			p389:_setStatus("Teleporting to Forest primer")

			if not p389:_teleportRoot(HumanoidRootPart, Humanoid, v1311) then
				p389:_finish("Teleport primer failed")

				return
			end

			p389:_setArrivalHold(v1311, v1309.Uid)
			p389:_requestCarry(v1309, true)
		else
			p389.stats.lastResult = p389.config.stealMode .. " priming (tween)"
			p389:_setStatus("Traveling to Forest primer")
			p389:_tweenRoot(v1311, function()
				p389:_requestCarry(v1309, false)
			end, nil, {
				holdAfterArrival = true,
				holdUid = v1309.Uid,
				flightProfile = false,
				carryTarget = v1309
			})
		end
	end
	t41._reconcileRunningState = function(p390)
		local enabled = p390.userStealEnabled == true or p390.riftObjectiveEnabled == true or p390.drScrambleObjectiveEnabled == true or p390.panelTargetUid ~= nil or p390.panelActiveUid ~= nil

		if p390.enabled == enabled then
			if p390.enabled then
				p390:_refreshCounts()
				p390:_schedule()
			end

			return
		end

		p390.enabled = enabled

		if p390.enabled then
			p390.healthProtectionOwners.auto_steal = true

			if LocalPlayer2.Character then
				v681(LocalPlayer2.Character)
				v684(p390, LocalPlayer2.Character)
			end

			p390:_startMovementProtection()
			p390:_setStatus("Searching")
			p390:_schedule()
		else
			p390.hasDepositedThisSession = false
			p390.panelTargetUid = nil
			p390.panelActiveUid = nil
			p390.planGeneration += 1

			local carry = p390.carry

			carry.generation += 1
			p390:_cleanupInstantSteal()
			p390:_invalidateCarryWorker()
			p390.carry.active = false
			p390.carry.uid = nil
			p390.intentionalGiftUid = nil
			table.clear(p390.giftDropUids)
			p390.continueFromForestGift = false
			p390.tweenRecoveryUid = nil
			p390.claimPresentationSuppression = nil
			p390.safeStarting = false
			p390.movementRetryPending = false
			p390:_cancelTween("Disabled")
			p390:_restoreTreadmillVisualAtSafe()
			p390:_releaseOperation()
			p390:_stopMovementProtection()
			p390:releaseHealthProtection("auto_steal")
			p390.activeTarget = nil
			p390.running = false
			p390:_setStatus("Idle")
		end

		p390:_refreshCounts()
	end
	t41.markStartupSettled = function(p391)
		if p391.startupSettled then
			return
		end

		p391.startupSettled = true
		p391:_refreshCounts()

		if p391.enabled and not p391.running and not p391.destroyed then
			p391:_schedule()
		end
	end
	t41.requestPanelSteal = function(p392, p393)
		if not p392.isPremium then
			return false, "PREMIUM_REQUIRED"
		end

		if p392.destroyed or type(p393) ~= "string" or p393 == "" then
			return false, "Invalid egg UID"
		end

		local v1314 = EggState2.ReadFieldEgg(p393) or p392.records[p393]

		if type(v1314) ~= "table" then
			return false, "Egg no longer exists"
		end

		if v1314.State ~= AreaEggs.States.Slot and v1314.State ~= AreaEggs.States.Dropped then
			return false, "Egg is no longer available"
		end

		if p392:isIntentionalGiftDrop(p393) then
			return false, "Gift egg is blacklisted"
		end

		p392.panelTargetUid = p393
		p392.stats.lastResult = "Egg Panel target queued"
		p392:_reconcileRunningState()

		return true
	end
	t41._sanitizePremiumToggleState = function(p394)
		if p394.isPremium then
			return false
		end

		local v1315 = p394.config.stealFromPlayers == true

		p394.config.stealFromPlayers = false

		return v1315
	end
	t41.setPremium = function(p395, p396)
		local isPremium = p396 == true

		if p395.isPremium == isPremium then
			if not isPremium then
				p395:_sanitizePremiumToggleState()
			end

			return p395.isPremium
		end

		p395.isPremium = isPremium

		if not isPremium then
			local v1317 = p395.playerHuntToken ~= nil

			p395:_sanitizePremiumToggleState()
			p395.playerHuntToken = nil
			p395.playerHuntCarrier = nil
			p395:_removePlayerStealBatAura()

			if v1317 then
				p395.planGeneration += 1
				p395:_cancelTween("Premium access changed")
			end
		end

		p395:_refreshCounts()
		p395:_schedule()

		return p395.isPremium
	end
	t41.setEnabled = function(p397, p398)
		p397:_sanitizePremiumToggleState()
		p397.userStealEnabled = p398 == true

		if p397.userStealEnabled then
			local manualCarry = p397.manualCarry

			manualCarry.generation += 1
			p397.manualCarry.active = false
			p397.manualCarry.uid = nil
		end

		p397:_reconcileRunningState()
	end
	t41.setDropAtFirstArea = function(p399, p400)
		p399.config.dropAtFirstArea = p400 == true

		if not p399.config.dropAtFirstArea then
			p399.continueFromForestGift = false
		end

		return p399.config.dropAtFirstArea
	end
	t41.setStealFromPlayers = function(p401, p402)
		if not (p402 ~= true or p401.isPremium) then
			p401.config.stealFromPlayers = false

			return false, "PREMIUM_REQUIRED"
		end

		p401.config.stealFromPlayers = p402 == true

		if not p401.config.stealFromPlayers then
			p401.playerHuntToken = nil
			p401.playerHuntCarrier = nil
			p401:_removePlayerStealBatAura()

			if p401.activeTween and p401.instantPhase == "player_hunt" then
				p401.planGeneration += 1
				p401:_cancelTween("Player steal disabled")
			end
		end

		p401:_refreshCounts()
		p401:_schedule()

		return p401.config.stealFromPlayers
	end
	v669 = function(p403)
		if type(p403) ~= "table" then
			return nil
		end

		local Category = p403.Category or p403.AssetCategory
		local v1320 = tonumber(p403.Scale or p403.AssetScale)

		if type(Category) ~= "string" or not v1320 or v1320 <= 0 then
			return nil
		end

		local ok, result = pcall(AssetEarnings.MutationOnlyRatePerSecond, {
			Category = Category,
			Scale = v1320,
			Mutations = type(p403.Mutations) == "table" and table.clone(p403.Mutations) or {},
			BaseMutation = type(p403.BaseMutation) == "string" and p403.BaseMutation or nil
		})

		return ok and type(result) == "number" and result or nil
	end
	t41.setMinValuePerSec = function(p404, p405)
		p404.config.minValuePerSec = math.max(tonumber(p405) or 0, 0)
		p404:_refreshCounts()
		p404:_schedule()
	end
	t41.setSpeed = function(p406, p407)
		local v1323 = math.clamp(math.floor((tonumber(p407) or 80) + 0.5), 20, 120)

		p406.config.speed = v1323 * 10

		if p406.enabled or p406.activeTween then
			p406:_startMovementProtection()
		end

		return v1323
	end
	t41.getDefaultSpeed = function()
		return 80
	end
	t41.setStealZigzag = function(p408, p409)
		p408.config.stealZigzag = p409 == true

		return p408.config.stealZigzag
	end
	t41.setFilterEnabled = function(p410, p411, p412)
		p410.config[p411 .. "Enabled"] = p412 == true
		p410:_refreshCounts()
		p410:_schedule()
	end
	t41.setFilter = function(p413, p414, p415)
		local config = p413.config

		config[p414] = type(p415) == "table" and table.clone(p415) or {}
		p413:_refreshCounts()
		p413:_schedule()
	end
	t41.destroy = function(p416)
		if p416.destroyed then
			return
		end

		p416.destroyed = true
		p416.enabled = false
		p416:releaseDrScrambleRoute(true)
		p416:_hideTreadmillDecoy()
		p416.panelTargetUid = nil
		p416.panelActiveUid = nil
		p416.planGeneration += 1

		local carry = p416.carry

		carry.generation += 1
		p416:_invalidateCarryWorker()
		p416.carry.active = false
		p416.carry.uid = nil
		p416.intentionalGiftUid = nil
		table.clear(p416.giftDropUids)
		p416.continueFromForestGift = false
		p416.playerHuntToken = nil
		p416.playerHuntCarrier = nil
		p416:_removePlayerStealBatAura()
		p416.tweenRecoveryUid = nil
		p416.safeStarting = false
		p416:_cancelTween("Destroyed")
		p416:_cleanupInstantSteal()
		p416:_releaseOperation()
		p416:_stopMovementProtection()
		table.clear(p416.healthProtectionOwners)

		if p416._healthPinner then
			pcall(p416._healthPinner.Disconnect, p416._healthPinner)
			p416._healthPinner = nil
		end

		if p416._healthChangedConnection then
			pcall(p416._healthChangedConnection.Disconnect, p416._healthChangedConnection)
			p416._healthChangedConnection = nil
		end

		p416:_restoreClaimPresentationFilter()
		v691(LocalPlayer2.Character)
		v661(p416.connections)
		table.clear(p416.listeners)
		table.clear(p416.records)
	end
	t41.hasPendingPreEventSteal = function(p417)
		if not p417.enabled or not p417.userStealEnabled or p417.destroyed then
			return false
		end

		if not p417.startupSettled then
			return true
		end

		if not p417:_wallOpen() then
			return true
		end

		if os.clock() < (p417.preEventReadyAt or 0) then
			return true
		end

		if not p417.running and not p417.safeStarting and p417.activeTarget == nil and p417.tweenRecoveryUid == nil and p417.playerHuntToken == nil and p417.operationToken == nil and (not p417.carry or not p417.carry.active) then
			return p417:hasMatchingUserEggsAuthoritative()
		end

		return true
	end
	t41.setAntiGuard = function(p418, p419)
		p418.antiGuard = p419
	end

	return t41
end

local v1326 = v631()

local function v1327()
	local Players2 = game:GetService("Players")
	local RunService2 = game:GetService("RunService")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local LocalPlayer2 = Players2.LocalPlayer
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local EggState2 = require(ReplicatedStorage2.Client.EggState)
	local Ragdoll = require(ReplicatedStorage2.Shared.Modules.Ragdoll)
	local RagdollJoints = require(ReplicatedStorage2.Shared.Modules.RagdollJoints)
	local EggWorld = Remotes.EggWorld
	local t47 = {}

	t47.__index = t47

	local function v1338(p420)
		if p420 then
			pcall(p420.Disconnect, p420)
		end
	end

	t47.new = function(p421)
		local obj = setmetatable({}, t47)

		obj.eggRuntime = p421
		obj.enabled = true
		obj.destroyed = false
		obj.connections = {}
		obj.originalRagdoll = {}
		obj.originalHumanoidStates = setmetatable({}, {
			__mode = "k"
		})
		obj.stats = {
			blockedHits = 0,
			blockedDrops = 0,
			recarriedEggs = 0
		}
		obj.lastHeldEggUid = nil
		obj.lastHeldSlotKey = nil
		obj._installed = false
		obj._stickyToken = 0
		obj._nextBodyRecoveryAt = 0
		obj._nextJointSweepAt = 0
		obj._forestStrikeOldFire = nil

		return obj
	end
	t47._liveBody = function()
		local Character = LocalPlayer2.Character

		return Character, Character and Character:FindFirstChildOfClass("Humanoid"), Character and Character:FindFirstChild("HumanoidRootPart")
	end
	t47._recoverBody = function(p422, p423)
		if p422.enabled then
			if not p422.destroyed then
				local v1341, v1342, v1343 = p422:_liveBody()

				if not v1341 or not v1342 or not v1343 then
					return
				end

				local now = os.clock()

				if not p423 and now < p422._nextBodyRecoveryAt then
					return
				end

				p422._nextBodyRecoveryAt = now + 0.03

				if not p422.originalHumanoidStates[v1342] then
					p422.originalHumanoidStates[v1342] = {
						Dead = v1342:GetStateEnabled(Enum.HumanoidStateType.Dead),
						Physics = v1342:GetStateEnabled(Enum.HumanoidStateType.Physics),
						FallingDown = v1342:GetStateEnabled(Enum.HumanoidStateType.FallingDown),
						Ragdoll = v1342:GetStateEnabled(Enum.HumanoidStateType.Ragdoll),
						BreakJointsOnDeath = v1342.BreakJointsOnDeath,
						RequiresNeck = v1342.RequiresNeck
					}
				end

				local state = v1342:GetState()
				local v1346 = state == Enum.HumanoidStateType.Physics or state == Enum.HumanoidStateType.FallingDown or state == Enum.HumanoidStateType.Ragdoll or state == Enum.HumanoidStateType.PlatformStanding or state == Enum.HumanoidStateType.Seated

				pcall(function()
					v1342.BreakJointsOnDeath = false
					v1342.RequiresNeck = false
					v1342:SetStateEnabled(Enum.HumanoidStateType.Dead, false)
					v1342:SetStateEnabled(Enum.HumanoidStateType.Physics, false)
					v1342:SetStateEnabled(Enum.HumanoidStateType.FallingDown, false)
					v1342:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, false)
					v1342.PlatformStand = false
					v1342.Sit = false

					local state2 = v1342:GetState()

					if state2 == Enum.HumanoidStateType.Physics or state2 == Enum.HumanoidStateType.FallingDown or state2 == Enum.HumanoidStateType.Ragdoll or state2 == Enum.HumanoidStateType.PlatformStanding or state2 == Enum.HumanoidStateType.Seated then
						v1342:ChangeState(Enum.HumanoidStateType.GettingUp)
						v1342:ChangeState(Enum.HumanoidStateType.Running)
					end
				end)

				for _, descendant in ipairs(v1341:GetDescendants()) do
					if descendant:IsA("Motor6D") then
						if not descendant.Enabled then
							descendant.Enabled = true
						end
					elseif descendant:IsA("BallSocketConstraint") or descendant:IsA("HingeConstraint") then
						if descendant.Name:find("Ragdoll", 1, true) or descendant:GetAttribute("RagdollConstraint") then
							pcall(descendant.Destroy, descendant)
						end
					end
				end

				local AssemblyLinearVelocity = v1343.AssemblyLinearVelocity
				local Magnitude = Vector3.new(AssemblyLinearVelocity.X, 0, AssemblyLinearVelocity.Z).Magnitude

				if v1346 or Magnitude > 340 or math.abs(AssemblyLinearVelocity.Y) > 240 then
					v1343.AssemblyLinearVelocity = Vector3.zero
					v1343.AssemblyAngularVelocity = Vector3.zero
					p422.stats.blockedHits += 1
				end

				return
			end
		end
	end
	t47._watchCharacter = function(p424, p425)
		if not p425 then
			return
		end

		local connection4 = p425.DescendantAdded:Connect(function(descendant)
			if not p424.enabled or p424.destroyed then
				return
			end

			if not descendant:IsA("BallSocketConstraint") and not descendant:IsA("HingeConstraint") then
				if descendant:IsA("Motor6D") and not descendant.Enabled then
					descendant.Enabled = true
				end
			elseif descendant.Name:find("Ragdoll", 1, true) or descendant:GetAttribute("RagdollConstraint") then
				pcall(descendant.Destroy, descendant)
				p424:_recoverBody(true)
			end
		end)

		table.insert(p424.connections, connection4)
	end
	t47._installRagdollHooks = function(p426)
		if p426._installed then
			return
		end

		p426._installed = true

		local ForestStrike = Remotes.GuardPatrol and Remotes.GuardPatrol.ForestStrike

		if ForestStrike and type(hookfunction) == "function" then
			local u1354

			local function v1355(p427, ...)
				if p427 ~= ForestStrike or not p426.enabled or p426.destroyed then
					return u1354(p427, ...)
				end

				if p426.eggRuntime and p426.eggRuntime.instantPhase == "priming" or p426.primerHitWindow then
					return u1354(p427, ...)
				end

				p426.stats.blockedHits += 1
				p426:_recoverBody(true)

				if genv.__ZeroinGodMode then
					genv.__ZeroinGodMode:startDefend()
				end
			end

			pcall(function()
				u1354 = hookfunction(ForestStrike.FireServer, type(newcclosure) == "function" and newcclosure(v1355) or v1355)
				p426._forestStrikeOldFire = u1354
			end)
		end

		for _, v in ipairs({
			"ApplyClientRagdoll",
			"Ragdoll",
			"TimedRagdoll",
			"TimedRagdollAsync"
		}) do
			if type(Ragdoll[v]) == "function" then
				p426.originalRagdoll[v] = Ragdoll[v]
				Ragdoll[v] = function(...)
					if not p426.enabled or p426.destroyed then
						return p426.originalRagdoll[v](...)
					end

					p426.stats.blockedHits += 1
					p426:_recoverBody(true)
				end
			end
		end

		if type(Ragdoll.IsRagdolled) == "function" then
			p426.originalRagdoll.IsRagdolled = Ragdoll.IsRagdolled
			Ragdoll.IsRagdolled = function(p428)
				if p426.enabled and p428 == LocalPlayer2.Character then
					return false
				end

				return p426.originalRagdoll.IsRagdolled(p428)
			end
		end
	end
	t47._restoreLocalState = function(p429)
		for k, originalHumanoidState in pairs(p429.originalHumanoidStates) do
			if k.Parent then
				pcall(function()
					k:SetStateEnabled(Enum.HumanoidStateType.Dead, originalHumanoidState.Dead)
					k:SetStateEnabled(Enum.HumanoidStateType.Physics, originalHumanoidState.Physics)
					k:SetStateEnabled(Enum.HumanoidStateType.FallingDown, originalHumanoidState.FallingDown)
					k:SetStateEnabled(Enum.HumanoidStateType.Ragdoll, originalHumanoidState.Ragdoll)
					k.BreakJointsOnDeath = originalHumanoidState.BreakJointsOnDeath
					k.RequiresNeck = originalHumanoidState.RequiresNeck
				end)
			end
		end

		p429.originalHumanoidStates = setmetatable({}, {
			__mode = "k"
		})
		pcall(RagdollJoints.Release, LocalPlayer2.Character)
	end
	t47._slotKey = function(p430, p431)
		if type(p431) == "table" and type(p431.AreaId) == "string" and type(p431.NestId) == "string" then
			return string.format("%s:%s", p431.AreaId, p431.NestId)
		end

		return nil
	end
	t47._requestCarry = function(p432, p433, p434)
		local t48 = {
			Uid = p433
		}

		if p434 ~= nil then
			t48.FirstAreaSlotKey = p434
		end

		return EggWorld.AskFieldEggCarry:InvokeServer(t48)
	end
	t47._startSticky = function(p435, p436, p437)
		if type(p436) == "string" then
			if p436 ~= "" then
				p435._stickyToken += 1

				local _stickyToken = p435._stickyToken

				p435.stats.recarriedEggs += 1
				task.spawn(function()
					local v1362 = os.clock() + 5

					while not p435.destroyed and p435.enabled and _stickyToken == p435._stickyToken and os.clock() < v1362 do
						local v1363 = EggState2.ReadFieldEgg(p436)

						if v1363 and v1363.State == "Carried" and v1363.CarrierUserId == LocalPlayer2.UserId then
							p435.lastHeldEggUid = p436
							p435.lastHeldSlotKey = p437 or p435:_slotKey(v1363)

							return
						end

						if v1363 and (v1363.State == "Dropped" or v1363.State == "Slot") then
							if p435.eggRuntime then
								if p435.eggRuntime:requestCarryRecovery(p436) then
									return
								end
							end

							local _, _, v1366 = p435:_liveBody()

							if v1366 and v1363.BottomCFrame and (v1366.Position - v1363.BottomCFrame.Position).Magnitude <= 10 then
								pcall(p435._requestCarry, p435, p436, p437 or p435:_slotKey(v1363))
							end
						end

						task.wait(0.05)
					end
				end)

				return
			end
		end
	end
	t47._bindSignals = function(p438)
		table.insert(p438.connections, EggState2.CarryChanged:Connect(function(p439)
			if not p438.enabled then
				return
			end

			if p439.IsCarrying and type(p439.Uid) == "string" then
				p438._stickyToken += 1
				p438.lastHeldEggUid = p439.Uid

				local v1367 = EggState2.ReadFieldEgg(p439.Uid)

				p438.lastHeldSlotKey = p438:_slotKey(v1367)

				return
			end

			local Uid = p439.Uid or p438.lastHeldEggUid
			local lastHeldSlotKey = p438.lastHeldSlotKey

			if Uid then
				p438.stats.blockedDrops += 1
				p438:_startSticky(Uid, lastHeldSlotKey)

				if genv.__ZeroinGodMode then
					genv.__ZeroinGodMode:startDefend(Uid)
				end
			end
		end))
		table.insert(p438.connections, LocalPlayer2.CharacterAdded:Connect(function(character)
			p438:_watchCharacter(character)
			task.defer(function()
				p438:_recoverBody(true)
			end)
		end))

		if LocalPlayer2.Character then
			p438:_watchCharacter(LocalPlayer2.Character)
		end

		table.insert(p438.connections, RunService2.Stepped:Connect(function()
			p438:_recoverBody()
		end))
	end
	t47.setEnabled = function(p440, p441)
		local enabled = p441 == true

		if p440.enabled == enabled then
			return
		end

		p440.enabled = enabled

		if p440.enabled then
			p440:_recoverBody()
		else
			p440._stickyToken += 1
			p440:_restoreLocalState()
		end
	end
	t47.install = function(p442)
		if p442.destroyed then
			return false
		end

		getgenv().__ZeroinAntiGuard = p442
		p442:_installRagdollHooks()
		p442:_bindSignals()
		p442:_recoverBody()

		return true
	end
	t47.destroy = function(p443)
		if p443.destroyed then
			return
		end

		p443.enabled = false
		p443:_restoreLocalState()
		p443.destroyed = true
		p443._stickyToken += 1

		for _, connection4 in ipairs(p443.connections) do
			v1338(connection4)
		end

		table.clear(p443.connections)

		for k, v in pairs(p443.originalRagdoll) do
			if type(v) == "function" then
				Ragdoll[k] = v
			end
		end

		local ForestStrike = Remotes.GuardPatrol and Remotes.GuardPatrol.ForestStrike

		if ForestStrike and p443._forestStrikeOldFire and type(hookfunction) == "function" then
			pcall(hookfunction, ForestStrike.FireServer, p443._forestStrikeOldFire)
		end

		p443._forestStrikeOldFire = nil
		p443.eggRuntime = nil

		if getgenv().__ZeroinAntiGuard == p443 then
			getgenv().__ZeroinAntiGuard = nil
		end
	end
	t47.setPrimerHitWindow = function(p444, p445)
		p444.primerHitWindow = p445 == true
	end
	t47.getStats = function(p446)
		return p446.stats
	end

	return t47
end

local v1376 = v1327()

local function v1377()
	local Players2 = game:GetService("Players")
	local RunService2 = game:GetService("RunService")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local LocalPlayer2 = Players2.LocalPlayer
	local ToolGameplayGuard = require(ReplicatedStorage2.Client.ToolGameplayGuard)
	local t49 = {}

	t49.__index = t49
	t49.new = function(p447)
		local obj = setmetatable({}, t49)

		obj.eggRuntime = p447
		obj.enabled = zeroinConfig.GodMode == nil and true or zeroinConfig.GodMode == true
		obj.active = false
		obj.activeDroppedUid = nil
		obj.swingSequence = 0
		obj.lastSwingAt = 0
		obj.defendThread = nil
		obj.connections = {}
		obj.targetRange = 13
		obj.defenseBat = nil
		obj:_bindSignals()

		return obj
	end
	t49._isBat = function(p448, p449)
		if not p449 or not p449:IsA("Tool") then
			return false
		end

		if p449:GetAttribute("IsBat") == true or p449:GetAttribute("GearName") == "Bat" then
			return true
		end

		local v1385 = string.lower(p449.Name)

		return string.find(v1385, "bat", 1, true) ~= nil or string.find(v1385, "slap", 1, true) ~= nil
	end
	t49._findBat = function(p450)
		local Character = LocalPlayer2.Character
		local Backpack = LocalPlayer2:FindFirstChildOfClass("Backpack")

		if Character then
			for _, child in ipairs(Character:GetChildren()) do
				if p450:_isBat(child) then
					return child, true
				end
			end
		end

		if Backpack then
			for _, child in ipairs(Backpack:GetChildren()) do
				if p450:_isBat(child) then
					return child, false
				end
			end
		end

		pcall(function()
			local Networking = ReplicatedStorage2:FindFirstChild("Packages") and ReplicatedStorage2.Packages:FindFirstChild("Networking")
			local RFCodexAskWearFieldBat = Networking and Networking:FindFirstChild("RF/Codex/AskWearFieldBat")

			if RFCodexAskWearFieldBat then
				RFCodexAskWearFieldBat:InvokeServer()
			end
		end)

		return nil, false
	end
	t49._equipBat = function(p451)
		local Character = LocalPlayer2.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not Humanoid or Humanoid.Health <= 0 then
			return nil
		end

		local v1396, v1397 = p451:_findBat()

		if not v1396 then
			return nil
		end

		if v1397 and v1396.Parent == Character then
			return v1396
		end

		pcall(Humanoid.EquipTool, Humanoid, v1396)

		local v1398 = os.clock() + 0.35

		while true do
			if not (os.clock() < v1398) then
				return v1396.Parent == Character and v1396 or nil
			end

			if v1396.Parent ~= Character then
				task.wait(0.05)

				continue
			end

			break
		end

		return v1396
	end
	t49._getNearbyEnemies = function(p452)
		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or not ToolGameplayGuard.IsInsideArena(LocalPlayer2) or ToolGameplayGuard.IsInsideSafeZone(LocalPlayer2) then
			return {}
		end

		local t50 = {}

		for _, player in ipairs(Players2:GetPlayers()) do
			if player ~= LocalPlayer2 and player.Character then
				local HumanoidRootPart2 = player.Character:FindFirstChild("HumanoidRootPart")
				local Humanoid2 = player.Character:FindFirstChildOfClass("Humanoid")

				if HumanoidRootPart2 and Humanoid2 and Humanoid2.Health > 0 and ToolGameplayGuard.IsInsideArena(player) and not ToolGameplayGuard.IsInsideSafeZone(player) then
					local Magnitude = (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude

					if Magnitude <= p452.targetRange then
						table.insert(t50, {
							player = player,
							root = HumanoidRootPart2,
							humanoid = Humanoid2,
							distance = Magnitude
						})
					end
				end
			end
		end

		table.sort(t50, function(p453, p454)
			return p453.distance < p454.distance
		end)

		return t50
	end

	local s2 = "_swing"

	local function v1409(p455, p456, p457)
		if p456 then
			if p456.Parent == LocalPlayer2.Character then
				if not p457 or not p457.Parent then
					return false
				end

				local playerFromCharacter = Players2:GetPlayerFromCharacter(p457.Parent)

				if not playerFromCharacter or playerFromCharacter == LocalPlayer2 then
					return false
				end

				local Character = LocalPlayer2.Character
				local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
				local HumanoidRootPart2 = playerFromCharacter.Character and playerFromCharacter.Character:FindFirstChild("HumanoidRootPart")
				local Humanoid2 = playerFromCharacter.Character and playerFromCharacter.Character:FindFirstChildOfClass("Humanoid")

				if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 or not HumanoidRootPart2 or not Humanoid2 or Humanoid2.Health <= 0 or p455.targetRange < (HumanoidRootPart2.Position - HumanoidRootPart.Position).Magnitude then
					return false
				end

				if not ToolGameplayGuard.IsInsideArena(LocalPlayer2) or ToolGameplayGuard.IsInsideSafeZone(LocalPlayer2) or not ToolGameplayGuard.IsInsideArena(playerFromCharacter) or ToolGameplayGuard.IsInsideSafeZone(playerFromCharacter) then
					return false
				end

				local serverTimeNow = workspace:GetServerTimeNow()

				if not (serverTimeNow - p455.lastSwingAt < 0.75 or p456:GetAttribute("CooldownActive") == true) then
					if not (serverTimeNow < (tonumber(p456:GetAttribute("CooldownEndTime")) or 0)) then
						if not (serverTimeNow < (tonumber(LocalPlayer2:GetAttribute("RagdollEndTime")) or 0)) then
							if not (serverTimeNow < (tonumber(playerFromCharacter:GetAttribute("RagdollEndTime")) or 0)) then
								local ok, result = pcall(function()
									local BatSwing = require(ReplicatedStorage2.Shared.Remotes).BatSwing

									if BatSwing then
										if BatSwing.Trigger then
											p455.swingSequence += 1

											local v1420 = string.format("%d:%d:%d", LocalPlayer2.UserId, p455.swingSequence, math.floor(serverTimeNow * 1000))

											BatSwing.Trigger:FireServer(playerFromCharacter, v1420)

											return true
										end
									end

									return false
								end)

								if ok and result then
									p455.lastSwingAt = serverTimeNow
								end

								return ok and result == true
							end
						end
					end
				end

				return false
			end
		end

		return false
	end

	t49[s2] = v1409
	t49.startDefend = function(p458, p459)
		if not p458.enabled then
			return
		end

		if zeroinConfig.IsFusing then
			return
		end

		if p458.eggRuntime and p458.eggRuntime.instantPhase == "priming" then
			return
		end

		if #p458:_getNearbyEnemies() == 0 then
			return
		end

		p458.active = true
		p458.activeDroppedUid = p459 or p458.activeDroppedUid

		if p458.defendThread then
			return
		end

		p458.defendThread = task.spawn(function()
			while p458.active and p458.enabled and not zeroinConfig.IsFusing and not zeroinConfig.IsScrambleFarming do
				if (not p458.eggRuntime or p458.eggRuntime.instantPhase ~= "priming" and p458.eggRuntime.playerHuntToken == nil) and (not p458.eggRuntime or not p458.eggRuntime.carry or not p458.eggRuntime.carry.active) then
					local v1421 = p458:_getNearbyEnemies()

					if #v1421 ~= 0 then
						if #v1421 > 0 then
							local Tool = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChildOfClass("Tool")
							local v1423 = p458:_equipBat()

							if v1423 then
								if v1423 ~= Tool then
									p458.defenseBat = v1423
								end

								local v1424 = p458:_getNearbyEnemies()

								for _, v in ipairs(v1424) do
									if not v.root then
										continue
									end

									if v.root.Parent then
										if not p458:_swing(v1423, v.root) then
											continue
										end
									else
										continue
									end

									break
								end
							end
						end

						task.wait(0.1)

						continue
					end
				end

				break
			end

			p458.active = false
			p458.defendThread = nil

			local defenseBat = p458.defenseBat

			p458.defenseBat = nil

			local Backpack = LocalPlayer2:FindFirstChildOfClass("Backpack")

			if defenseBat then
				if defenseBat.Parent == LocalPlayer2.Character and Backpack then
					defenseBat.Parent = Backpack
				end
			end
		end)
	end
	t49.stopDefend = function(p460)
		p460.active = false
		p460.activeDroppedUid = nil
	end
	t49.setEnabled = function(p461, p462)
		p461.enabled = p462 == true

		if not p461.enabled then
			p461:stopDefend()
		end
	end
	t49._bindSignals = function(p463)
		local n23 = 0

		local function v1430(dt)
			n23 += dt

			if n23 < 0.2 then
				return
			end

			n23 = 0

			if not p463.enabled or p463.defendThread then
				return
			end

			local eggRuntime = p463.eggRuntime

			if zeroinConfig.IsFusing or zeroinConfig.IsScrambleFarming or eggRuntime and (eggRuntime.instantPhase == "priming" or eggRuntime.playerHuntToken ~= nil or eggRuntime.carry and eggRuntime.carry.active) then
				return
			end

			if #p463:_getNearbyEnemies() > 0 then
				p463:startDefend()
			end
		end

		table.insert(p463.connections, RunService2.Heartbeat:Connect(v1430))
		pcall(function()
			table.insert(p463.connections, require(ReplicatedStorage2.Client.EggState).CarryChanged:Connect(function(p464)
				if p464.IsCarrying then
					p463:stopDefend()
				elseif p463.enabled then
					p463:startDefend(p464.Uid)
				end
			end))
		end)
		pcall(function()
			local Remotes = require(ReplicatedStorage2.Shared.Remotes)
			local ForestStrike = Remotes.GuardPatrol and Remotes.GuardPatrol.ForestStrike

			if ForestStrike then
				table.insert(p463.connections, ForestStrike.OnClientEvent:Connect(function()
					if p463.enabled then
						p463:startDefend()
					end
				end))
			end
		end)
	end
	t49.destroy = function(p465)
		p465:stopDefend()

		for _, connection4 in ipairs(p465.connections) do
			pcall(connection4.Disconnect, connection4)
		end

		table.clear(p465.connections)
	end

	return t49
end

local v1436 = v1377()

local function v1437()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local LocalPlayer2 = Players2.LocalPlayer
	local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
	local AssetItems = require(ReplicatedStorage2.Shared.Util.AssetItems)
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local Save = require(ReplicatedStorage2.Shared.Save)
	local Rift = Remotes.Rift
	local t51 = {
		["Riftborn Egg"] = "Verdant",
		["Riftbeasts Egg"] = "Umbral",
		["Shattered Rift Egg"] = "Radiant"
	}
	local t52 = {
		"Riftborn Egg",
		"Riftbeasts Egg",
		"Shattered Rift Egg"
	}
	local t53 = {}

	t53.__index = t53

	local function v1449(p466, p467)
		local pcall_ = pcall
		local LiveRatePerSecond = AssetEarnings.LiveRatePerSecond
		local ok, result = pcall_(LiveRatePerSecond, {
			Category = p466.Category,
			Scale = math.max(tonumber(p466.Scale) or 1, 0.01),
			Mutations = type(p466.Mutations) == "table" and p466.Mutations or {}
		}, p467 and p467.Gamepasses, p467 and p467.Products)

		return ok and type(result) == "number" and result or math.huge
	end

	t53.new = function(p468, p469, p470, p471)
		local obj = setmetatable({}, t53)

		obj.coordinator = p468
		obj.eggRuntime = p469
		obj.eggLifecycle = p470
		obj.travel = p471
		obj.destroyed = false
		obj.enabled = false
		obj.running = false
		obj.generation = 0
		obj.listeners = {}
		obj.resources = {}
		obj.state = nil
		obj.protectedUids = {}
		obj.tradeReady = false
		obj.targetPrize = nil
		obj.stats = {
			status = "Disabled",
			banner = "Unknown",
			ready = 0,
			total = 3,
			missing = "None",
			rotation = 0,
			targetPrize = "None"
		}

		local v1455 = Save.WatchFields({
			"Inventory",
			"EggInventory",
			"Rift",
			"EquippedAssets"
		}, function()
			obj:_schedule()
		end)

		if v1455 then
			table.insert(obj.resources, v1455)
		end

		if Rift.BannerRotated then
			table.insert(obj.resources, Rift.BannerRotated.OnClientEvent:Connect(function()
				obj.state = nil
				obj:_schedule()
			end))
		end

		return obj
	end
	t53._snapshot = function(p472)
		return {
			enabled = p472.enabled,
			running = p472.running,
			status = p472.stats.status,
			banner = p472.stats.banner,
			ready = p472.stats.ready,
			total = p472.stats.total,
			missing = p472.stats.missing,
			rotation = p472.stats.rotation,
			targetPrize = p472.stats.targetPrize
		}
	end
	t53._emit = function(p473)
		local v1456 = p473:_snapshot()

		for k in pairs(p473.listeners) do
			pcall(k, v1456)
		end
	end
	t53.onChanged = function(p474, p475)
		p474.listeners[p475] = true
		pcall(p475, p474:_snapshot())

		return function()
			p474.listeners[p475] = nil
		end
	end
	t53._setStatus = function(p476, p477)
		p476.stats.status = p477
		p476:_emit()
	end
	t53._askState = function(p478)
		local ok, state = pcall(function()
			return Rift.AskState:InvokeServer()
		end)

		if not ok or type(state) ~= "table" then
			return nil, tostring(state or "State unavailable")
		end

		p478.state = state
		p478.stats.banner = tostring(state.BannerDisplayName or state.BannerId or "Unknown")
		p478.stats.rotation = math.max(tonumber(state.SecondsUntilRotation) or 0, 0)

		return state
	end
	t53._petEntries = function()
		local v1460 = Save.Get()
		local Inventory = v1460 and v1460.Inventory or {}
		local t54 = {}
		local ipairs_ = ipairs
		local EquippedAssets = v1460 and v1460.EquippedAssets or {}

		for _, EquippedAsset in ipairs_(EquippedAssets) do
			t54[EquippedAsset] = true
		end

		local t55 = {}

		pcall(function()
			for k in pairs(require(ReplicatedStorage2.Client.AssetRoster).ReadOwnerPen(LocalPlayer2.UserId)) do
				t55[k] = true
			end
		end)

		local t56 = {}

		for k, v in pairs(Inventory) do
			if type(k) == "string" and type(v) == "table" then
				local ok, result = pcall(AssetItems.Decode, v)

				if ok and type(result) == "table" then
					t56[#t56 + 1] = {
						uid = k,
						item = result,
						category = result.Category,
						favorite = result.IsFavorite == true,
						equipped = t54[k] == true,
						placed = t55[k] == true,
						inFuse = result.InFuse == true,
						rate = v1449(result, v1460)
					}
				end
			end
		end

		return t56
	end
	t53._selectPets = function(p479, p480)
		local t57 = {}

		for _, v in ipairs(p479:_petEntries()) do
			if not v.favorite and not v.equipped and not v.placed and not v.inFuse then
				t57[v.category] = t57[v.category] or {}
				table.insert(t57[v.category], v)
			end
		end

		for _, v in pairs(t57) do
			table.sort(v, function(p481, p482)
				if p481.rate == p482.rate then
					return p481.uid < p482.uid
				end

				return p481.rate < p482.rate
			end)
		end

		local t58 = {}
		local t59 = {}
		local t60 = {}

		for i, v in ipairs(p480) do
			local v1484
			local ipairs_ = ipairs
			local v1486 = t57[v] or {}

			for _, v2 in ipairs_(v1486) do
				if not t58[v2.uid] then
					v1484 = v2

					break
				end
			end

			if v1484 then
				t58[v1484.uid] = true
				t59[i] = v1484
			else
				t60[#t60 + 1] = v
			end
		end

		return t59, t60
	end
	t53.getPrizeOptions = function()
		return table.clone(t52)
	end
	t53.getTargetPrize = function(p483)
		return p483.targetPrize
	end
	t53.setTargetPrize = function(p484, p485)
		local v1489

		if type(p485) == "string" and t51[p485] then
			v1489 = p485
		end

		if p484.targetPrize ~= v1489 then
			p484.targetPrize = v1489
			p484.stats.targetPrize = v1489 or "None"
			p484.generation += 1

			if p484.enabled then
				p484:_schedule()
			else
				p484:_emit()
			end
		end
	end
	t53.isTradeReady = function(p486)
		return not p486.destroyed and p486.enabled and p486.tradeReady == true
	end
	t53.isPlacePending = function(p487)
		if p487.destroyed or not p487.enabled then
			return false
		end

		local state = p487.state
		local Requirements = state and state.Requirements

		if type(Requirements) ~= "table" or #Requirements == 0 then
			return false
		end

		local v1492 = Save.Get()
		local EggInventory = v1492 and v1492.EggInventory

		if type(EggInventory) ~= "table" then
			return false
		end

		local t61 = {}

		for _, Requirement in ipairs(Requirements) do
			t61[Requirement] = true
		end

		local n24 = 0
		local n25 = 0

		for _, v in pairs(EggInventory) do
			if type(v) == "table" and type(v.AssetCategory) == "string" then
				if v.Placement ~= nil then
					n24 += 1
				elseif t61[v.AssetCategory] then
					n25 += 1
				end
			end
		end

		if n25 == 0 then
			return false
		end

		local n26 = 0

		pcall(function()
			n26 = require(ReplicatedStorage2.Data.Bases).GetAssetEquipCapacity(v1492 and v1492.BaseUpgradeLevel or 0)
		end)

		return n24 < n26
	end
	t53._unhatchedCountByCategory = function()
		local t62 = {}
		local v1503 = Save.Get()
		local pairs_ = pairs
		local EggInventory = v1503 and v1503.EggInventory or {}

		for k, v in pairs_(EggInventory) do
			if type(k) == "string" and type(v) == "table" and type(v.AssetCategory) == "string" then
				t62[v.AssetCategory] = (t62[v.AssetCategory] or 0) + 1
			end
		end

		return t62
	end
	t53._objectiveCategories = function(p488, p489, p490)
		local t63 = {}
		local t64 = {}
		local v1510 = p488:_unhatchedCountByCategory()

		for i, v in ipairs(p489) do
			if not p490[i] then
				local v1513 = v1510[v] or 0

				if v1513 > 0 then
					v1510[v] = v1513 - 1
				elseif not t64[v] then
					t64[v] = true
					t63[#t63 + 1] = v
				end
			end
		end

		return t63
	end
	t53._protectedObjectiveUids = function(p491, p492, p493)
		local t65 = {}

		for _, v in pairs(p493) do
			t65[#t65 + 1] = v.uid
		end

		local t66 = {}

		for i, v in ipairs(p492) do
			if not p493[i] then
				t66[v] = (t66[v] or 0) + 1
			end
		end

		local v1520 = Save.Get()
		local pairs_ = pairs
		local EggInventory = v1520 and v1520.EggInventory or {}

		for k, v in pairs_(EggInventory) do
			if type(k) == "string" and type(v) == "table" then
				if (t66[v.AssetCategory] or 0) > 0 then
					t65[#t65 + 1] = k

					local AssetCategory = v.AssetCategory

					t66[AssetCategory] -= 1
				end
			end
		end

		return t65
	end
	t53._travelToMachine = function(p494, p495)
		local __OBJECTS = workspace:FindFirstChild("__OBJECTS")
		local Machines = __OBJECTS and __OBJECTS:FindFirstChild("Machines")
		local RiftMachine = Machines and Machines:FindFirstChild("RiftMachine")
		local Machine = RiftMachine and RiftMachine:FindFirstChild("Machine")

		if not Machine or not Machine:IsA("BasePart") then
			return false, "Rift machine unavailable"
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			return false, "Character unavailable"
		end

		local v1533 = Machine.CFrame * cFrameNew(0, Machine.Size.Y * 0.5 + (HumanoidRootPart.Size.Y * 0.5 + (Humanoid.RigType == Enum.HumanoidRigType.R15 and math.max(Humanoid.HipHeight, 0.5) or 2)) + 0.05, 4)

		if (HumanoidRootPart.Position - v1533.Position).Magnitude <= 7 then
			return true
		end

		if p494.travel then
			return p494.travel:travelAndWait(v1533, {
				abort = function()
					return p494.destroyed or not p494.enabled or p495 ~= p494.generation
				end
			}), "Travel interrupted"
		end

		return false, "Travel unavailable"
	end
	t53._finishPendingReward = function(p496, p497)
		p496:_setStatus("Finishing Rift reward")
		task.wait(0.8)

		if p496.destroyed or not p496.enabled or p497 ~= p496.generation then
			return false
		end

		local ok, result = pcall(function()
			return Rift.AskFinishReveal:InvokeServer()
		end)

		return ok and result ~= false
	end
	t53._trade = function(p498, p499, p500, p501)
		if p498.eggRuntime then
			if type(p498.eggRuntime.hasPendingPreEventSteal) == "function" then
				if p498.eggRuntime:hasPendingPreEventSteal() then
					return false, "Waiting for priority egg delivery"
				end
			end
		end

		local t67 = {}

		for i = 1, #p499 do
			local v1538 = p500[i]

			if not v1538 then
				return false, "Requirements incomplete"
			end

			t67[#t67 + 1] = v1538.uid
		end

		local autoTheRift, v1540 = p498.coordinator:tryAcquire("auto_the_rift", t67)

		if not autoTheRift then
			return false, v1540
		end

		local function v1541()
			p498.coordinator:release(autoTheRift)
		end

		local v1542, v1543 = p498:_travelToMachine(p501)

		if not v1542 then
			v1541()

			return false, v1543
		end

		local v1544, v1545 = p498:_askState()

		if not v1544 then
			v1541()

			return false, v1545
		end

		for i, v in ipairs(p499) do
			if v1544.Requirements[i] ~= v then
				v1541()

				return false, "Requirements rotated"
			end
		end

		local v1548 = Save.Get()

		for i, v in ipairs(t67) do
			local ok, result = pcall(AssetItems.Decode, v1548 and v1548.Inventory and v1548.Inventory[v])

			if not ok then
				v1541()

				return false, "Protected pet changed"
			end

			if type(result) ~= "table" or result.Category ~= p499[i] or result.IsFavorite == true or result.InFuse == true then
				v1541()

				return false, "Protected pet changed"
			end
		end

		p498:_setStatus("Trading Rift pets")

		local ok, result, result2 = pcall(function()
			return Rift.AskTradeIn:InvokeServer(t67)
		end)

		if not ok or result ~= true then
			v1541()

			return false, tostring(result2 or result or "Trade rejected")
		end

		local v1556 = os.clock() + 8

		while not p498.destroyed and p498.enabled and p501 == p498.generation and os.clock() < v1556 do
			local v1557 = Save.Get()
			local v1558 = true

			for _, v in ipairs(t67) do
				if v1557 and v1557.Inventory and v1557.Inventory[v] ~= nil then
					v1558 = false

					break
				end
			end

			if not v1558 then
				task.wait(0.1)

				continue
			end

			break
		end

		local v1561 = Save.Get()

		for _, v in ipairs(t67) do
			if v1561 and v1561.Inventory and v1561.Inventory[v] ~= nil then
				v1541()

				return false, "Trade confirmation timed out"
			end
		end

		v1541()
		p498:_finishPendingReward(p501)

		return true
	end
	t53._isCategoryOnField = function(p502, p503)
		if not p502.eggRuntime or not p502.eggRuntime.records then
			return false
		end

		for _, record in pairs(p502.eggRuntime.records) do
			local v1566 = record.State == 1 or record.State == 2

			if (v1566 or record.State == "Slot" or record.State == "Dropped") and record.AssetCategory == p503 then
				return true
			end
		end

		return false
	end
	t53._run = function(p504, p505)
		if p504.running then
			return
		end

		p504.running = true

		while not p504.destroyed and p504.enabled do
			if p505 ~= p504.generation then
				break
			end

			local v1567, v1568 = p504:_askState()

			if not v1567 then
				p504:_setStatus("Rift state: " .. tostring(v1568))
				task.wait(1)
			elseif v1567.Unlocked == false then
				p504:_setStatus("The Rift is locked")
				task.wait(2)
			elseif v1567.PendingReward then
				p504:_finishPendingReward(p505)
				task.wait(0.5)
			else
				local targetPrize = p504.targetPrize and t51[p504.targetPrize] or nil
				local RequirementsBannerId = v1567.RequirementsBannerId or v1567.BannerId

				if targetPrize and RequirementsBannerId and RequirementsBannerId ~= targetPrize then
					p504.tradeReady = false
					p504.eggRuntime:setRiftObjective(false, {})
					p504.eggLifecycle:setRiftObjective(false, {})
					p504.coordinator:clearProtected("auto_the_rift")
					p504.protectedUids = {}
					p504:_setStatus(string.format("Waiting for %s (Current: %s)", p504.targetPrize, p504.stats.banner))
					p504:_emit()
					task.wait(1)
				else
					local Requirements = type(v1567.Requirements) == "table" and v1567.Requirements

					Requirements = Requirements or {}
					p504.stats.total = #Requirements

					if #Requirements < 3 then
						p504:_setStatus("Waiting for Rift requirements")
						task.wait(1)
					else
						local v1572, v1573 = p504:_selectPets(Requirements)

						p504.stats.ready = #Requirements - #v1573
						p504.stats.missing = #v1573 > 0 and table.concat(v1573, ", ") or "None"

						local v1574 = p504:_objectiveCategories(Requirements, v1572)
						local v1575 = p504:_protectedObjectiveUids(Requirements, v1572)

						p504.protectedUids = v1575
						p504.coordinator:setProtected("auto_the_rift", v1575)
						p504.coordinator:setProtectedCategories("auto_the_rift", Requirements)

						local tradeReady = #v1573 == 0

						p504.tradeReady = tradeReady
						p504.eggRuntime:setRiftObjective(not tradeReady and #v1574 > 0, v1574)
						p504.eggLifecycle:setRiftObjective(not tradeReady, Requirements)

						if tradeReady then
							p504.eggRuntime:setRiftObjective(false, {})

							local v1577, v1578 = p504:_trade(Requirements, v1572, p505)

							p504.tradeReady = false
							p504:_setStatus(v1577 and "Rift trade complete" or "Rift trade: " .. tostring(v1578))
						elseif #v1574 > 0 then
							local v1579 = v1574[1]

							if p504:_isCategoryOnField(v1579) then
								p504:_setStatus("Stealing: " .. tostring(v1579) .. " egg")
							else
								p504:_setStatus("Waiting for " .. tostring(v1579) .. " to spawn")
							end
						else
							p504:_setStatus("Waiting for eggs to hatch")
						end

						p504:_emit()
						task.wait(0.5)
					end
				end
			end
		end

		p504.running = false
	end
	t53._schedule = function(p506)
		if p506.destroyed or not p506.enabled or p506.running then
			return
		end

		local generation = p506.generation

		task.defer(function()
			local ok, result = pcall(p506._run, p506, generation)

			if not ok and not p506.destroyed and p506.enabled then
				if generation == p506.generation then
					p506.running = false
					p506:_setStatus("Rift error: " .. tostring(result))
					task.delay(2, function()
						if not p506.destroyed and p506.enabled and generation == p506.generation then
							p506:_schedule()
						end
					end)
				end
			end
		end)
	end
	t53.setEnabled = function(p507, p508)
		p507.enabled = p508 == true
		p507.generation += 1

		if p507.enabled then
			p507:_setStatus("Reading Rift requirements")
			p507:_schedule()
		else
			p507.tradeReady = false
			p507.eggRuntime:setRiftObjective(false, {})
			p507.eggLifecycle:setRiftObjective(false, {})
			p507.coordinator:clearProtected("auto_the_rift")
			p507.protectedUids = {}
			p507:_setStatus("Disabled")
		end
	end
	t53.destroy = function(p509)
		if p509.destroyed then
			return
		end

		p509.destroyed = true
		p509.enabled = false
		p509.tradeReady = false
		p509.generation += 1
		p509.eggRuntime:setRiftObjective(false, {})
		p509.eggLifecycle:setRiftObjective(false, {})
		p509.coordinator:clearProtected("auto_the_rift")

		for _, resource in ipairs(p509.resources) do
			pcall(function()
				if typeof(resource) == "RBXScriptConnection" then
					resource:Disconnect()
				elseif type(resource) == "function" then
					resource()
				elseif type(resource) == "table" and type(resource.Disconnect) == "function" then
					resource:Disconnect()
				end
			end)
		end

		table.clear(p509.resources)
		table.clear(p509.listeners)
	end

	return t53
end

local v1585 = v1437()

local function v1586()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local RunService2 = game:GetService("RunService")
	local Workspace2 = game:GetService("Workspace")
	local LocalPlayer2 = Players2.LocalPlayer
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local Scramble = Remotes.Scramble
	local EggWorld = Remotes.EggWorld
	local ScrambleMotion = require(ReplicatedStorage2.Shared.Util.ScrambleMotion)
	local Save = require(ReplicatedStorage2.Shared.Save)
	local Gears = require(ReplicatedStorage2.Data.Gears)
	local t68 = {
		ScrapDrone = "Scrap Drone",
		ReactorDrone = "Reactor Drone",
		AugmentedDrone = "Augmented Drone"
	}
	local t69 = {
		Scrambled = "MutationConsumable",
		["Experiment #001"] = "LimitedTimeExperimentPet",
		["Nibbles #013"] = "Nibbles013",
		["2x Cash Booster"] = "CashBooster",
		["1.25x Speed"] = "SpeedBoost",
		["2x Treadmill Booster"] = "TreadmillBooster"
	}
	local t70 = {}

	t70.__index = t70

	local getgc_ = getgc
	local debug_ = debug

	local function v1603(p510)
		return p510
	end

	local v1604 = v1603(function()
		if type(getgc_) == "function" then
			if type(debug_) == "table" and type(debug.info) == "function" then
				if type(debug.getupvalues) == "function" then
					local u1605
					local t71 = {}
					local t72 = {}
					local n27 = 0

					local function v1609(p511, p512)
						if not (type(p511) ~= "table" or t72[p511]) then
							if not (p512 > 4) and not (n27 >= 1200) then
								t72[p511] = true
								n27 += 1

								if rawget(p511, "EventId") == "DrScrambleOutbreak" and type(rawget(p511, "Shop")) == "table" then
									u1605 = p511
								end

								if type(rawget(p511, "Upserts")) == "table" then
									t71[#t71 + 1] = p511

									return
								end

								if rawget(p511, "Id") ~= nil and typeof(rawget(p511, "CFrame")) == "CFrame" and tonumber(rawget(p511, "Health")) then
									t71[#t71 + 1] = {
										Upserts = { p511 }
									}

									return
								end

								for _, v in pairs(p511) do
									if type(v) == "table" then
										v1609(v, p512 + 1)
									end
								end

								return
							end
						end
					end

					local ok, result = pcall(getgc_, true)

					if not ok or type(result) ~= "table" then
						return nil, {}
					end

					for _, v in ipairs(result) do
						if type(v) == "function" then
							local ok2, result2 = pcall(debug.info, v, "s")

							if (ok2 and type(result2) == "string" and result2:lower() or ""):find("scrambleclient", 1, true) then
								local ok3, result3 = pcall(debug.getupvalues, v)

								if ok3 and type(result3) == "table" then
									for _, v2 in pairs(result3) do
										v1609(v2, 0)
									end
								end
							end
						end

						if u1605 and #t71 > 0 then
							break
						end
					end

					return u1605, t71
				end
			end
		end

		return nil, {}
	end)

	t70.new = function(p513)
		local obj = setmetatable({}, t70)

		obj.eggRuntime = p513
		obj.enabled = false
		obj.destroyed = false
		obj.generation = 0
		obj.droneCache = {}
		obj.context = nil
		obj.nextBootstrapAt = 0
		obj.cachedRoute = nil
		obj.lastVisualScanAt = 0
		obj.nextPriorityEggCheckAt = 0
		obj.priorityEggsCached = false
		obj.lockConnection = nil
		obj.lockHumanoid = nil
		obj.lockAutoRotate = nil
		obj.locked = false
		obj.lockedTargetKey = nil
		obj.stickyTargetKey = nil
		obj.batGearIds = {}
		obj.batIndex = 1
		obj.lastBatRefreshAt = 0
		obj.lastBatSwapAt = 0
		obj.worker = nil
		obj.stats = {
			status = "Off"
		}
		obj.autoBuy = false
		obj.shopItems = {}
		obj.shopAmount = 1
		obj.shopInterval = 15
		obj.nextShopCycleAt = 0
		obj.shopStatus = "Off"
		obj.shopPurchases = {}
		obj.lastShopRequestAt = 0
		obj.lastShopSignature = nil
		obj.connections = {}

		if Scramble and Scramble.State then
			table.insert(obj.connections, Scramble.State.OnClientEvent:Connect(function(p514)
				if type(p514) == "table" and p514.EventId == "DrScrambleOutbreak" then
					obj.context = p514

					if type(p514.Drones) == "table" then
						obj:_applyDronePacket(p514.Drones)
					end
				end

				if obj.enabled and obj.eggRuntime and type(obj.eggRuntime._schedule) == "function" then
					task.defer(function()
						obj.eggRuntime:_schedule()
					end)
				end
			end))
		end

		if Scramble and Scramble.Drones then
			table.insert(obj.connections, Scramble.Drones.OnClientEvent:Connect(function(...)
				for i = 1, select("#", ...) do
					obj:_applyDronePacket(select(i, ...))
				end

				if obj.enabled and obj.eggRuntime and type(obj.eggRuntime._schedule) == "function" then
					task.defer(function()
						obj.eggRuntime:_schedule()
					end)
				end
			end))
		end

		obj:_refreshBatGearIds(true)
		obj:_ensureWorker()

		return obj
	end
	t70._setStatus = function(p515, p516)
		p515.stats.status = p516
		genv.__ZeroinScrambleStatus = p515:getSnapshot()
	end
	t70._snapshot = function(p517)
		return p517:_resolveClientContext()
	end
	t70._bootstrapClientState = function(p518, p519)
		if p519 ~= true and os.clock() < p518.nextBootstrapAt then
			return
		end

		p518.nextBootstrapAt = os.clock() + 30

		local v1624, v1625 = v1604()

		if type(v1624) == "table" then
			p518.context = v1624
		end

		local ipairs_ = ipairs
		local v1627 = type(v1625) == "table" and v1625 or {}

		for _, v in ipairs_(v1627) do
			p518:_applyDronePacket(v)
		end
	end
	t70._resolveClientContext = function(p520)
		if type(p520.context) == "table" and type(p520.context.Shop) == "table" then
			return p520.context
		end

		p520:_bootstrapClientState(false)

		return p520.context
	end
	t70._refreshBatGearIds = function(p521, p522)
		if p522 ~= true and os.clock() - p521.lastBatRefreshAt < 2 then
			return
		end

		p521.lastBatRefreshAt = os.clock()

		local GearInventory = (Save.Get() or {}).GearInventory or {}
		local batGearIds = {}

		for k, v in pairs(GearInventory) do
			local Directory = Gears.Directory and Gears.Directory[k] or Gears[k]

			if tostring(k):lower():find("bat", 1, true) ~= nil or type(Directory) == "table" and Directory.ToolController == "Slap" then
				if (tonumber(v) or 0) > 0 then
					batGearIds[#batGearIds + 1] = k
				end
			end
		end

		table.sort(batGearIds)
		p521.batGearIds = batGearIds

		if p521.batIndex > #batGearIds then
			p521.batIndex = 1
		end
	end
	t70._equippedBat = function(p523)
		local Character = LocalPlayer2.Character

		if not Character then
			return nil
		end

		for _, child in ipairs(Character:GetChildren()) do
			if child:IsA("Tool") then
				local attribute = child:GetAttribute("GearName")
				local Directory = attribute and (Gears.Directory and Gears.Directory[attribute] or Gears[attribute])

				if not table.find(p523.batGearIds, attribute) then
					continue
				end

				if not Directory then
					continue
				end

				if Directory.ToolController == "Slap" then
					return child
				end
			end
		end

		return nil
	end
	t70._rotateBatIfNeeded = function(p524)
		p524:_refreshBatGearIds(false)

		local v1640 = #p524.batGearIds

		if v1640 == 0 then
			return
		end

		local v1641 = p524:_equippedBat()

		if not v1641 then
			if os.clock() - p524.lastBatSwapAt >= 0.12 and EggWorld and EggWorld.AskWearTool then
				p524.lastBatSwapAt = os.clock()
				pcall(EggWorld.AskWearTool.InvokeServer, EggWorld.AskWearTool, p524.batGearIds[p524.batIndex] or p524.batGearIds[1])
			end

			return
		end

		if v1640 == 1 then
			return
		end

		local serverTimeNow = Workspace2:GetServerTimeNow()
		local v1643 = v1641:GetAttribute("CooldownActive") == true

		if not v1643 then
			v1643 = (tonumber(v1641:GetAttribute("CooldownEndTime")) or 0) > serverTimeNow
		end

		if not v1643 or os.clock() - p524.lastBatSwapAt < 0.12 then
			return
		end

		p524.lastBatSwapAt = os.clock()
		p524.batIndex = p524.batIndex % v1640 + 1

		if EggWorld and EggWorld.AskWearTool then
			pcall(EggWorld.AskWearTool.InvokeServer, EggWorld.AskWearTool, p524.batGearIds[p524.batIndex])
		end
	end
	t70._ensureBatEquipped = function(p525, p526)
		p525:_refreshBatGearIds(true)

		if #p525.batGearIds == 0 then
			return false
		end

		if p525:_equippedBat() then
			return true
		end

		if not EggWorld or not EggWorld.AskWearTool then
			return false
		end

		pcall(EggWorld.AskWearTool.InvokeServer, EggWorld.AskWearTool, p525.batGearIds[p525.batIndex] or p525.batGearIds[1])

		local v1644 = os.clock() + math.max(tonumber(p526) or 0.75, 0)

		repeat
			if p525:_equippedBat() then
				return true
			end

			task.wait(0.05)
		until p525.destroyed or not p525.enabled or v1644 <= os.clock()

		return false
	end
	t70._eventWindowActive = function(p527, p528)
		local serverTimeNow = Workspace2:GetServerTimeNow()
		local v1646 = Workspace2:GetAttribute("ScrambleOutbreakActive") == true
		local v1647 = tonumber(Workspace2:GetAttribute("ScrambleOutbreakEndsAt")) or 0
		local v1648 = tonumber(Workspace2:GetAttribute("ScrambleActiveDrones")) or 0

		if v1646 and (v1647 <= 0 or serverTimeNow < v1647) then
			return true
		end

		if v1648 > 0 and (v1647 <= 0 or serverTimeNow < v1647) then
			return true
		end

		local v1649 = p528 or p527:_resolveClientContext()

		if type(v1649) ~= "table" or v1649.Ready ~= true or v1649.Enabled ~= true or v1649.WorldReady ~= true then
			return false
		end

		if tonumber(v1649.EventEndsAt) and v1649.EventEndsAt <= serverTimeNow then
			return false
		end

		return type(v1649.Window) == "table" and v1649.Window.Active == true
	end
	t70._hasPriorityEggs = function(p529, p530)
		if p530 == true or p529.nextPriorityEggCheckAt <= os.clock() then
			p529.nextPriorityEggCheckAt = os.clock() + 0.4
			p529.priorityEggsCached = p529.eggRuntime and type(p529.eggRuntime.hasDrPriorityEggsAuthoritative) == "function" and p529.eggRuntime:hasDrPriorityEggsAuthoritative() == true or false
		end

		return p529.priorityEggsCached
	end
	t70._applyDronePacket = function(p531, p532)
		if type(p532) ~= "table" then
			return
		end

		local v1650 = type(p532.Upserts) == "table" and p532 or type(p532[1]) == "table" and p532[1] or nil

		if not v1650 or type(v1650.Upserts) ~= "table" then
			return
		end

		for _, upsert in pairs(v1650.Upserts) do
			if type(upsert) == "table" then
				local Id = upsert.Id or upsert.id

				if Id ~= nil then
					p531.droneCache[tostring(Id)] = upsert
				end
			end
		end

		local pairs_ = pairs
		local Removed = type(v1650.Removed) == "table" and v1650.Removed or {}

		for _, v in pairs_(Removed) do
			p531.droneCache[tostring(type(v) == "table" and (v.Id or v.id) or v)] = nil
		end

		p531.cachedRoute = nil
	end

	local function v1658(p533)
		if type(p533) == "table" then
			return tonumber(p533.Health or p533.health or p533.HP or p533.Hp or p533.hp), tonumber(p533.MaxHealth or p533.maxHealth or p533.MaxHP or p533.maxHp)
		end

		return nil, nil
	end
	local function v1659(p534)
		local Attributes = type(p534) == "table" and p534.Attributes or nil
		local v1661 = type(p534) == "table"

		if v1661 then
			v1661 = p534.ScrambleTier or p534.Tier or p534.DroneTier
			v1661 = v1661 or type(Attributes) == "table" and (Attributes.ScrambleTier or Attributes.Tier)
		end

		return v1661 or nil
	end
	local function v1662(p535)
		local v1663 = tonumber(p535.maxHealth) or tonumber(p535.health) or 0

		if v1663 >= 10 then
			return 1
		end

		if v1663 >= 5 then
			return 2
		end

		return 3
	end
	local function v1664(p536)
		local Id = p536.Id or p536.id or p536.Uid or p536.uid or p536.DroneId or p536.droneId

		return Id ~= nil and "state:" .. tostring(Id) or "state-table:" .. tostring(p536)
	end

	t70._candidateFromState = function(p537, p538)
		if type(p538) ~= "table" then
			return nil
		end

		local v1666, v1667 = v1658(p538)

		if not v1666 or v1666 <= 0 then
			return nil
		end

		local CFrame_2 = typeof(p538.CFrame) == "CFrame" and p538.CFrame or typeof(p538.Position) == "Vector3" and cFrameNew(p538.Position)
		local Size = typeof(p538.Size) == "Vector3" and p538.Size or nil

		if not CFrame_2 then
			local ok, result = pcall(ScrambleMotion.Read, p538)

			if ok and type(result) == "table" then
				CFrame_2 = typeof(result.CFrame) == "CFrame" and result.CFrame or typeof(result.Position) == "Vector3" and cFrameNew(result.Position)

				local Size2 = typeof(result.Size) == "Vector3" and result.Size

				Size = Size2 or Size
			end
		end

		if not CFrame_2 or CFrame_2.Position.Y < 0 then
			return nil
		end

		return {
			key = v1664(p538),
			cframe = CFrame_2,
			radius = Size and math.max(Size.X, Size.Z) * 0.5 or 2,
			health = v1666,
			maxHealth = v1667,
			tier = v1659(p538),
			source = p538
		}
	end
	t70._visualCandidates = function(p539)
		local t73 = {}

		if os.clock() - p539.lastVisualScanAt < 1 then
			return t73
		end

		p539.lastVisualScanAt = os.clock()

		local ScrambleLocalVisuals = Workspace2:FindFirstChild("ScrambleLocalVisuals")

		if not ScrambleLocalVisuals then
			return t73
		end

		for _, child in ipairs(ScrambleLocalVisuals:GetChildren()) do
			local Hitbox = child:IsA("BasePart") and child.Name == "Hitbox" and child or child:IsA("Model") and child:FindFirstChild("Hitbox", true)
			local v1678 = Hitbox and tonumber(Hitbox:GetAttribute("Health"))

			if Hitbox and Hitbox:IsA("BasePart") and v1678 and v1678 > 0 and Hitbox.Position.Y >= 0 then
				t73[#t73 + 1] = {
					key = "visual:" .. tostring(child:GetAttribute("Id") or child:GetAttribute("DroneId") or child.Name),
					cframe = Hitbox.CFrame,
					radius = math.max(Hitbox.Size.X, Hitbox.Size.Z) * 0.5,
					health = v1678,
					maxHealth = tonumber(Hitbox:GetAttribute("MaxHealth")) or tonumber(Hitbox:GetAttribute("MaxHP")),
					tier = Hitbox:GetAttribute("ScrambleTier") or child:GetAttribute("ScrambleTier"),
					instance = Hitbox
				}
			end
		end

		return t73
	end
	t70.projectGroundPosition = function(p540, p541)
		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not Character or not Humanoid or not HumanoidRootPart then
			return nil
		end

		local filterDescendantsInstances = { Character }

		for _, player in ipairs(Players2:GetPlayers()) do
			if player.Character and player.Character ~= Character then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = player.Character
			end
		end

		for _, v in ipairs({
			"ScrambleLocalVisuals",
			"__ClientTreadmillRenders"
		}) do
			local v1687 = Workspace2:FindFirstChild(v)

			if v1687 then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = v1687
			end
		end

		for _, child in ipairs(Workspace2:GetChildren()) do
			if child:IsA("BasePart") and child.Name == "__FyyHoverPad" then
				filterDescendantsInstances[#filterDescendantsInstances + 1] = child
			end
		end

		local raycastParams = RaycastParams.new()

		raycastParams.FilterType = Enum.RaycastFilterType.Exclude
		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		raycastParams.IgnoreWater = false

		local vector32 = Vector3.new(p541.X, math.max(p541.Y, HumanoidRootPart.Position.Y) + 64, p541.Z)
		local vector33 = Vector3.new(0, -256, 0)
		local hit

		for i = 1, 12 do
			hit = Workspace2:Raycast(vector32, vector33, raycastParams)

			if not hit then
				break
			end

			local Model = hit.Instance:FindFirstAncestorOfClass("Model")

			if not (Model and Model:FindFirstChildOfClass("Humanoid") ~= nil) and (hit.Instance:IsA("Terrain") or hit.Instance:IsA("BasePart") and hit.Instance.CanCollide) then
				break
			end

			filterDescendantsInstances[#filterDescendantsInstances + 1] = hit.Instance
			raycastParams.FilterDescendantsInstances = filterDescendantsInstances
			hit = nil
		end

		if hit then
			return (Vector3.new(p541.X, hit.Position.Y + (HumanoidRootPart.Size.Y * 0.5 + (Humanoid.RigType == Enum.HumanoidRigType.R15 and math.max(Humanoid.HipHeight, 0.5) or 2)) + 0.05, p541.Z))
		end

		return nil
	end
	t70._groundedDestination = function(p542, p543, p544)
		local v1696 = p542:projectGroundPosition(p543)

		if not v1696 then
			return nil
		end

		local vector32 = Vector3.new(p544.X, v1696.Y, p544.Z)

		if (vector32 - v1696).Magnitude <= 0.001 then
			return cFrameNew(v1696)
		end

		return lookAt(v1696, vector32)
	end
	t70._routeForKey = function(p545, p546, p547)
		if type(p546) ~= "string" then
			return nil
		end

		local cachedRoute

		if p546:sub(1, 6) == "state:" then
			cachedRoute = p545:_candidateFromState(p545.droneCache[p546:sub(7)])
		elseif p545.cachedRoute and p545.cachedRoute.key == p546 then
			cachedRoute = p545.cachedRoute

			if cachedRoute.instance and cachedRoute.instance.Parent then
				cachedRoute.cframe = cachedRoute.instance.CFrame
				cachedRoute.health = tonumber(cachedRoute.instance:GetAttribute("Health")) or cachedRoute.health
			end
		end

		if not cachedRoute or cachedRoute.health <= 0 then
			return nil
		end

		local Position = cachedRoute.cframe.Position
		local vector32 = Vector3.new(p547.Position.X - Position.X, 0, p547.Position.Z - Position.Z)

		cachedRoute.destination = p545:_groundedDestination(Position + (vector32.Magnitude > 0.001 and vector32.Unit or Vector3.new(0, 0, 1)) * (cachedRoute.radius + 0.7), Position, p547)

		if cachedRoute.destination then
			return cachedRoute
		end

		return nil
	end
	t70._nearestRoute = function(p548, p549)
		local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		if not p549 and p548.stickyTargetKey then
			local v1702 = p548:_routeForKey(p548.stickyTargetKey, HumanoidRootPart)

			if v1702 then
				p548.cachedRoute = v1702

				return v1702
			end

			p548.stickyTargetKey = nil
		end

		if not p549 and p548.cachedRoute then
			local v1703 = p548:_routeForKey(p548.cachedRoute.key, HumanoidRootPart)

			if v1703 then
				return v1703
			end
		end

		local t74 = {}

		for _, v in pairs(p548.droneCache) do
			local v1707 = p548:_candidateFromState(v)

			if v1707 then
				t74[#t74 + 1] = v1707
			end
		end

		if #t74 == 0 then
			for _, v in ipairs(p548:_visualCandidates()) do
				t74[#t74 + 1] = v
			end
		end

		local v1710
		local v1711
		local v1712

		for _, v in ipairs(t74) do
			local v1715 = v1662(v)
			local Magnitude = (HumanoidRootPart.Position - v.cframe.Position).Magnitude

			if v1712 and not (v1715 < v1712) then
				if v1715 ~= v1712 then
					continue
				end

				if not (Magnitude < v1711) then
					continue
				end
			end

			v1710 = v
			v1711 = Magnitude
			v1712 = v1715
		end

		if not v1710 then
			p548.cachedRoute = nil

			return nil
		end

		p548.stickyTargetKey = v1710.key
		p548.cachedRoute = v1710

		return p548:_routeForKey(v1710.key, HumanoidRootPart)
	end
	t70.isEventWindowActive = function(p550)
		return not p550.destroyed and p550.enabled and p550:_eventWindowActive()
	end
	t70.isEngaged = function(p551)
		return p551:isEventWindowActive() and p551:_nearestRoute() ~= nil
	end
	t70.getEventRoute = function(p552)
		if not p552.destroyed and p552.enabled and not p552:_hasPriorityEggs() and p552:_eventWindowActive() then
			return p552:_nearestRoute()
		end

		return nil
	end
	t70._releaseLock = function(p553)
		local locked = p553.locked or p553.lockConnection ~= nil or p553.lockHumanoid ~= nil

		if p553.lockConnection then
			pcall(p553.lockConnection.Disconnect, p553.lockConnection)
			p553.lockConnection = nil
		end

		local lockHumanoid = p553.lockHumanoid or locked and LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChildOfClass("Humanoid")

		if lockHumanoid and lockHumanoid.Parent and locked then
			local lockAutoRotate = p553.lockAutoRotate

			if lockAutoRotate == nil then
				lockAutoRotate = true
			end

			pcall(function()
				lockHumanoid.AutoRotate = lockAutoRotate
			end)
		end

		p553.lockHumanoid = nil
		p553.lockAutoRotate = nil
		p553.locked = false
		p553.lockedTargetKey = nil
		zeroinConfig.IsScrambleFarming = false

		if p553.eggRuntime and type(p553.eggRuntime._stopHoverPad) == "function" then
			p553.eggRuntime:_stopHoverPad()
		end
	end
	t70.releaseEventLock = function(p554)
		p554:_releaseLock()
	end
	t70.getGeneration = function(p555)
		return p555.generation
	end
	t70.lockAfterSharedTravel = function(p556, p557)
		if not p556.destroyed then
			if p556.enabled and p557 == p556.generation and not p556:_hasPriorityEggs() then
				p556:_releaseLock()

				local v1720 = p556:_nearestRoute()

				if not v1720 then
					return false
				end

				if not p556:_ensureBatEquipped(0.75) then
					p556.stats.status = "Waiting for Slap tool"

					return false
				end

				local Character = LocalPlayer2.Character
				local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

				if not Humanoid or Humanoid.Health <= 0 then
					return false
				end

				p556.lockHumanoid = Humanoid
				p556.lockAutoRotate = Humanoid.AutoRotate
				p556.locked = true
				p556.lockedTargetKey = v1720.key
				zeroinConfig.IsScrambleFarming = true
				p556.stats.status = string.format("Locked to %s · 0.7 stud", tostring(t68[v1720.tier] or v1720.tier or "drone"))
				p556.lockConnection = RunService2.PreSimulation:Connect(function()
					if not p556.destroyed and p556.enabled and p557 == p556.generation and p556:_eventWindowActive() then
						if p556.eggRuntime:isResetWallOpen() then
							if p556:_hasPriorityEggs() then
								p556:_releaseLock()

								if p556.eggRuntime and type(p556.eggRuntime.releaseDrScrambleRoute) == "function" then
									p556.eggRuntime:releaseDrScrambleRoute()
								end

								return
							end

							local v1723 = p556:_nearestRoute()

							if not v1723 or v1723.key ~= p556.lockedTargetKey then
								p556:_releaseLock()

								if p556.eggRuntime and type(p556.eggRuntime.releaseDrScrambleRoute) == "function" then
									p556.eggRuntime:releaseDrScrambleRoute()
								end

								return
							end

							local Character2 = LocalPlayer2.Character
							local HumanoidRootPart = Character2 and Character2:FindFirstChild("HumanoidRootPart")
							local Humanoid2 = Character2 and Character2:FindFirstChildOfClass("Humanoid")

							if HumanoidRootPart and Humanoid2 and not (Humanoid2.Health <= 0) then
								if p556.lockHumanoid ~= Humanoid2 then
									p556.lockHumanoid = Humanoid2
									p556.lockAutoRotate = Humanoid2.AutoRotate
								end

								p556:_rotateBatIfNeeded()
								HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
								HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
								HumanoidRootPart.CFrame = v1723.destination
								Humanoid2.AutoRotate = false

								return
							end

							p556:_releaseLock()

							if p556.eggRuntime then
								if type(p556.eggRuntime.releaseDrScrambleRoute) == "function" then
									p556.eggRuntime:releaseDrScrambleRoute(true)
								end
							end

							return
						end
					end

					p556:_releaseLock()

					if p556.eggRuntime and type(p556.eggRuntime.releaseDrScrambleRoute) == "function" then
						p556.eggRuntime:releaseDrScrambleRoute()
					end
				end)

				return true
			end
		end

		return false
	end
	t70._purchaseCount = function(p558, p559, p560)
		local State = type(p559) == "table" and p559.State

		State = State or nil

		local ShopPurchases = type(State) == "table" and State.ShopPurchases or nil
		local v1729 = type(ShopPurchases) == "table" and ShopPurchases[p560.Id] or nil

		if type(v1729) == "table" and tostring(v1729.Period) == tostring(p559.ShopPeriod) then
			return math.max(tonumber(v1729.Count) or 0, 0)
		end

		return 0
	end
	t70._selectedShopOffer = function(p561, p562)
		local t75 = {}

		for _, shopItem in ipairs(p561.shopItems) do
			t75[shopItem] = true

			local v1733 = t69[shopItem]

			if v1733 then
				t75[v1733] = true
			end
		end

		local ipairs_ = ipairs
		local Shop = type(p562 and p562.Shop) == "table" and p562.Shop or {}

		for _, v in ipairs_(Shop) do
			if type(v) ~= "table" or not t75[v.Label] and not t75[v.Id] then
				continue
			end

			local v1738 = p561.shopPurchases[v.Id] or 0
			local shopAmount = p561.shopAmount
			local v1740 = p561:_purchaseCount(p562, v)
			local v1741 = tonumber(v.PurchaseLimit)

			if not (v1738 < shopAmount) then
				continue
			end

			if not v1741 then
				return v
			end

			if v1740 + (tonumber(v.Quantity) or 1) <= v1741 then
				return v
			end
		end

		return nil
	end
	t70._shopTick = function(p563)
		local now = os.clock()

		if now < p563.nextShopCycleAt then
			p563.shopStatus = string.format("Next purchase cycle in %ds", math.ceil(p563.nextShopCycleAt - now))

			return
		end

		local v1743 = p563:_snapshot()

		if type(v1743) ~= "table" or v1743.Ready ~= true or v1743.Enabled ~= true or v1743.WorldReady ~= true then
			p563.shopStatus = "Event inactive"

			return
		end

		if tonumber(v1743.EventEndsAt) then
			if v1743.EventEndsAt <= Workspace2:GetServerTimeNow() then
				p563.shopStatus = "Event inactive"

				return
			end
		end

		if type(p563.shopItems) ~= "table" or #p563.shopItems == 0 then
			p563.shopStatus = "No items selected"

			return
		end

		local v1744 = p563:_selectedShopOffer(v1743)

		if not v1744 then
			table.clear(p563.shopPurchases)
			p563.lastShopSignature = nil
			p563.nextShopCycleAt = now + p563.shopInterval
			p563.shopStatus = string.format("Selected offers unavailable or capped | retry in %ds", p563.shopInterval)

			return
		end

		local State = type(v1743.State) == "table" and v1743.State or nil

		if not State then
			p563.shopStatus = "Shop state unavailable"

			return
		end

		if type(v1744.Quote) ~= "string" or v1744.Quote == "" then
			p563.shopStatus = "Offer quote unavailable"

			return
		end

		if not Scramble or not Scramble.Request then
			p563.shopStatus = "Official shop remote unavailable"

			return
		end

		local v1746 = tonumber(State.Samples) or 0

		if v1746 < (tonumber(v1744.Price) or math.huge) then
			p563.nextShopCycleAt = now + p563.shopInterval
			p563.shopStatus = "Not enough Samples for " .. tostring(v1744.Label)

			return
		end

		local v1747 = p563:_purchaseCount(v1743, v1744)
		local concat = table.concat
		local t76 = {}
		local v1750 = tostring(v1743.ShopPeriod)
		local v1751 = tostring(v1744.Id)
		local v1752 = tostring(State.ShopSequence)
		local v1753 = tostring(v1746)
		local v1754 = tostring(v1747)
		local tostring_ = tostring
		local v1756 = p563.shopPurchases[v1744.Id] or 0

		do
			local values = table.pack(v1750, v1751, v1752, v1753, v1754, tostring_(v1756))

			table.move(values, 1, values.n, 1, t76)
		end

		local lastShopSignature = concat(t76, ":")

		if p563.lastShopSignature == lastShopSignature or now - p563.lastShopRequestAt < 1.5 then
			return
		end

		p563.lastShopRequestAt = now
		p563.lastShopSignature = lastShopSignature
		p563.shopStatus = "Buying " .. tostring(v1744.Label)

		local ok, result = pcall(function()
			return Scramble.Request:InvokeServer("Shop", v1744.Id, {
				Quote = v1744.Quote,
				Sequence = math.max(tonumber(State.ShopSequence) or 0, 0)
			})
		end)

		if ok and result ~= false then
			if type(result) == "table" and type(result.Snapshot) == "table" then
				p563.context = result.Snapshot
			end

			p563.shopPurchases[v1744.Id] = (p563.shopPurchases[v1744.Id] or 0) + 1
			p563.shopStatus = "Bought " .. tostring(v1744.Label)
		else
			p563.shopStatus = "Purchase failed: " .. tostring(type(result) == "table" and result.Reason or result)
		end
	end
	t70.setEnabled = function(p564, p565)
		p564.enabled = p565 == true
		p564.generation += 1

		if p564.eggRuntime and type(p564.eggRuntime.setDrScrambleObjective) == "function" then
			p564.eggRuntime:setDrScrambleObjective(p564.enabled)
		end

		if p564.enabled then
			p564:_setStatus("Waiting for event robot")
			p564:_ensureWorker()
		else
			p564.stickyTargetKey = nil
			p564:_releaseLock()
			p564:_setStatus("Off")
		end
	end
	t70.setAutoBuy = function(p566, p567)
		if not (p567 ~= true or p566.autoBuy) then
			table.clear(p566.shopPurchases)
			p566.nextShopCycleAt = 0
		end

		p566.autoBuy = p567 == true
		p566.lastShopRequestAt = 0
		p566.lastShopSignature = nil

		if p566.autoBuy then
			p566.shopStatus = "Monitoring shop"
		else
			p566.shopStatus = "Off"
		end

		p566:_ensureWorker()
	end
	t70.setShopItems = function(p568, p569)
		p568.shopItems = type(p569) == "table" and table.clone(p569) or {}
		table.clear(p568.shopPurchases)
		p568.lastShopSignature = nil
		p568.nextShopCycleAt = 0
	end
	t70.setShopAmount = function(p570, p571)
		p570.shopAmount = math.clamp(math.floor(tonumber(p571) or 1), 1, 100)
		table.clear(p570.shopPurchases)
		p570.lastShopSignature = nil
		p570.nextShopCycleAt = 0

		return p570.shopAmount
	end
	t70.setShopInterval = function(p572, p573)
		p572.shopInterval = math.clamp(tonumber(p573) or 15, 1, 3600)
		p572.lastShopSignature = nil
		p572.nextShopCycleAt = 0

		return p572.shopInterval
	end
	t70.isFightPending = function(p574)
		local enabled = not p574.destroyed and p574.enabled and p574:_eventWindowActive()

		return enabled and p574:_nearestRoute() ~= nil
	end
	t70.isMovementBusy = function(p575)
		return p575.locked or p575.eggRuntime and p575.eggRuntime.drScrambleRouteActive == true
	end
	t70.getSnapshot = function(p576)
		local v1762 = p576:_resolveClientContext()
		local serverTimeNow = Workspace2:GetServerTimeNow()
		local Window = type(v1762) == "table" and v1762.Window or nil
		local v1765 = p576:_eventWindowActive(v1762)
		local v1766 = v1765

		if v1766 then
			v1766 = math.max(tonumber(Workspace2:GetAttribute("ScrambleOutbreakEndsAt")) or 0, type(Window) == "table" and tonumber(Window.EndsAt) or 0)
		end

		v1766 = v1766 or type(Window) == "table" and (tonumber(Window.NextAt) or tonumber(Window.StartsAt)) or 0

		if v1766 <= 0 then
			v1766 = (math.floor(serverTimeNow / 1800) + 1) * 1800
		end

		local v1767 = p576:_nearestRoute()
		local t77 = {
			enabled = p576.enabled,
			active = v1765,
			status = p576.stats.status,
			targetTier = v1767 and (t68[v1767.tier] or v1767.tier) or nil,
			health = v1767 and v1767.health or 0,
			maxHealth = v1767 and v1767.maxHealth or 0
		}

		t77.secondsLeft = math.max(0, v1766 - serverTimeNow)
		t77.shopStatus = p576.shopStatus
		t77.shopAmount = p576.shopAmount
		t77.shopInterval = p576.shopInterval
		t77.samples = tonumber(type(v1762) == "table" and v1762.State and v1762.State.Samples) or 0
		t77.shopItemCount = type(p576.shopItems) == "table" and #p576.shopItems or 0

		return t77
	end
	t70._ensureWorker = function(p577)
		if p577.worker then
			return
		end

		p577.worker = task.spawn(function()
			while not p577.destroyed do
				local v1769 = p577:_resolveClientContext()

				if p577.autoBuy then
					local ok, result = xpcall(p577._shopTick, debug.traceback, p577)

					if not ok then
						warn("[SAE][ScrambleShop] " .. tostring(result))
						p577.shopStatus = "Shop runtime error"
					end
				end

				if p577.enabled then
					p577:_hasPriorityEggs(true)
				end

				if not p577.enabled then
					p577:_releaseLock()
				elseif p577:_hasPriorityEggs() then
					p577:_releaseLock()

					if p577.eggRuntime and type(p577.eggRuntime.releaseDrScrambleRoute) == "function" then
						p577.eggRuntime:releaseDrScrambleRoute()
					end

					p577.stats.status = "Prioritizing filtered egg"
				elseif not p577:_eventWindowActive(v1769) then
					p577:_releaseLock()
					p577.stickyTargetKey = nil

					if p577.eggRuntime then
						if type(p577.eggRuntime.releaseDrScrambleRoute) == "function" then
							p577.eggRuntime:releaseDrScrambleRoute()
						end
					end

					p577.stats.status = "Waiting for outbreak window"
				elseif not p577:_nearestRoute() then
					p577:_releaseLock()
					p577.stats.status = "Waiting for selected drone"
				elseif not p577.locked then
					p577.stats.status = "Ready for Auto Steal route"
				end

				genv.__ZeroinScrambleStatus = p577:getSnapshot()
				task.wait((p577.enabled or p577.autoBuy) and 0.15 or 1)
			end

			p577.worker = nil
		end)
	end
	t70.destroy = function(p578)
		if p578.destroyed then
			return
		end

		p578.destroyed = true
		p578.enabled = false
		p578.autoBuy = false
		p578.generation += 1

		if p578.eggRuntime and type(p578.eggRuntime.setDrScrambleObjective) == "function" then
			p578.eggRuntime:setDrScrambleObjective(false)
		end

		p578:_releaseLock()

		for _, connection4 in ipairs(p578.connections) do
			pcall(connection4.Disconnect, connection4)
		end

		table.clear(p578.connections)

		if p578.worker then
			pcall(task.cancel, p578.worker)
			p578.worker = nil
		end
	end

	return t70
end

local v1774 = v1586()

local function v1775()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local Workspace2 = game:GetService("Workspace")
	local LocalPlayer2 = Players2.LocalPlayer
	local Assets = require(ReplicatedStorage2.Data.Assets)
	local AssetRoster = require(ReplicatedStorage2.Client.AssetRoster)
	local AssetItems = require(ReplicatedStorage2.Shared.Util.AssetItems)
	local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
	local Eggs = require(ReplicatedStorage2.Shared.Types.Eggs)
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local Save = require(ReplicatedStorage2.Shared.Save)
	local Fusery = Remotes.Fusery
	local t78 = {
		"Lowest Rarity",
		"Highest Rarity",
		"Lowest Value",
		"Lightest",
		"Heaviest"
	}
	local t79 = {}

	t79.__index = t79

	local function v1790(p579)
		pcall(function()
			if typeof(p579) == "RBXScriptConnection" then
				p579:Disconnect()
			elseif type(p579) == "function" then
				p579()
			elseif type(p579) == "table" and type(p579.Disconnect) == "function" then
				p579:Disconnect()
			elseif type(p579) == "table" and type(p579.Destroy) == "function" then
				p579:Destroy()
			end
		end)
	end
	local function v1791(p580)
		local n28 = 0
		local pairs_ = pairs
		local v1794 = type(p580) == "table" and p580 or {}

		for _ in pairs_(v1794) do
			n28 += 1
		end

		return n28
	end
	local function v1796(p581)
		local FusionSlots = type(p581) == "table" and type(p581.FusionSlots) == "table" and p581.FusionSlots

		return FusionSlots or {}
	end
	local function v1798(p582)
		return type(p582) == "table" and (type(p582.FusionReward) == "table" or type(p582.FusionEggReward) == "table")
	end
	local function v1799(p583)
		local v1800 = tonumber(type(p583) == "table" and p583.FusionEndsAt)
		local v1801 = tonumber(type(p583) == "table" and p583.FusionDuration) or 0

		return v1798(p583) or type(p583) == "table" and p583.FusionLocked == true or v1800 ~= nil and (v1801 > 0 or v1800 > Workspace2:GetServerTimeNow())
	end
	local function v1802(p584)
		local Packages = ReplicatedStorage2:FindFirstChild("Packages")
		local Networking = Packages and Packages:FindFirstChild("Networking")
		local v1805 = Networking and Networking:FindFirstChild("RF/Fusery/" .. p584)

		if v1805 then
			return v1805
		end

		return Fusery and Fusery[p584] or nil
	end

	t79.getPriorities = function()
		return table.clone(t78)
	end
	t79.new = function(p585, p586, p587, p588)
		local obj = setmetatable({}, t79)

		obj.coordinator = p585
		obj.travel = p586
		obj.treadmillManager = p587
		obj.captureRuntime = p588
		obj.destroyed = false
		obj.running = false
		obj.generation = 0
		obj.listeners = {}
		obj.resources = {}
		obj.retryScheduled = false
		obj.rescheduleRequested = false
		obj.startupRecoveryPending = true
		obj.pendingSinglePass = false
		obj.manualConfirmation = nil
		obj.lastCoordinatorOperation = nil
		obj.config = {
			enabled = false,
			priority = t78[1],
			rarities = { "All" },
			keepPerCategory = 1,
			maxWeightKg = 0
		}
		obj.stats = {
			status = "Disabled",
			lastFused = "None",
			eligibleGroups = nil
		}

		local v1807 = Save.WatchFields({
			"Inventory",
			"EquippedAssets",
			"EggInventory",
			"FusionSlots",
			"FusionLocked",
			"FusionEndsAt",
			"FusionDuration",
			"FusionReward",
			"FusionEggReward"
		}, function()
			obj:_emit()

			if obj.running then
				obj.rescheduleRequested = true
			else
				obj:_schedule()
			end
		end)

		if v1807 then
			table.insert(obj.resources, v1807)
		end

		if p585 then
			if type(p585.subscribe) == "function" then
				table.insert(obj.resources, p585:subscribe(function(p589)
					local operation = p589 and p589.operation or nil
					local lastCoordinatorOperation = obj.lastCoordinatorOperation

					obj.lastCoordinatorOperation = operation

					if operation == "auto_fuse" or lastCoordinatorOperation == "auto_fuse" or operation ~= nil then
						return
					end

					if obj.running then
						obj.rescheduleRequested = true
					else
						obj:_schedule()
					end
				end))
			end
		end

		task.defer(function()
			if obj.destroyed then
				return
			end

			local v1810 = Save.Get()

			if v1799(v1810) then
				obj.running = true
				zeroinConfig.IsFusing = true

				local ok, _, result2 = xpcall(obj._finishPendingFusion, debug.traceback, obj)

				if not ok then
					warn("[SAE][AutoFuse] Startup reward recovery failed")
				elseif result2 then
					obj:_setStatus(result2)
				end

				obj.running = false
				zeroinConfig.IsFusing = false
			end

			obj.startupRecoveryPending = false
			obj:_emit()

			if obj.pendingSinglePass then
				obj.pendingSinglePass = false
				obj:_schedule(true)
			elseif obj.config.enabled then
				obj:_schedule()
			end
		end)

		return obj
	end
	t79._snapshot = function(p590)
		local v1814 = Save.Get()

		return {
			enabled = p590.config.enabled,
			running = p590.running,
			status = p590.stats.status,
			lastFused = p590.stats.lastFused,
			eligibleGroups = p590.stats.eligibleGroups,
			machineCount = #v1796(v1814),
			priority = p590.config.priority,
			keepPerCategory = p590.config.keepPerCategory,
			maxWeightKg = p590.config.maxWeightKg,
			rarities = table.clone(p590.config.rarities)
		}
	end
	t79._emit = function(p591)
		local v1815 = p591:_snapshot()

		genv.__ZeroinFuseStatus = v1815

		for k in pairs(p591.listeners) do
			pcall(k, v1815)
		end
	end
	t79.onChanged = function(p592, p593)
		p592.listeners[p593] = true
		pcall(p593, p592:_snapshot())

		return function()
			p592.listeners[p593] = nil
		end
	end
	t79._setStatus = function(p594, p595)
		p594.stats.status = p595
		p594:_emit()
	end
	t79._waitFor = function(p596, p597, p598, p599)
		local v1817 = os.clock() + p598

		while true do
			if not (os.clock() < v1817) then
				return false
			end

			if p596.destroyed or p597 ~= p596.generation then
				break
			end

			if p599() then
				return true
			end

			task.wait(0.1)
		end

		return false
	end
	t79._placedUids = function()
		local ok, result = pcall(AssetRoster.ReadOwnerPen, LocalPlayer2.UserId)

		if not ok or type(result) ~= "table" then
			return nil
		end

		local t80 = {}

		for k, v in pairs(result) do
			if type(k) == "string" then
				t80[k] = true
			end

			if type(v) == "table" and type(v.UID) == "string" then
				t80[v.UID] = true
			end
		end

		return t80
	end
	t79._decodeInventory = function(p600)
		local v1823 = Save.Get()
		local Inventory = v1823 and v1823.Inventory

		if type(Inventory) ~= "table" then
			return nil, "Pet inventory unavailable"
		end

		local v1825 = p600:_placedUids()

		if not v1825 then
			return nil, "Placed pet status unavailable"
		end

		local t81 = {}
		local ipairs_ = ipairs
		local EquippedAssets = v1823.EquippedAssets or {}

		for _, EquippedAsset in ipairs_(EquippedAssets) do
			t81[EquippedAsset] = true
		end

		local t82 = {}

		for k, v in pairs(Inventory) do
			if type(k) == "string" and type(v) == "table" then
				local ok, result = pcall(AssetItems.Decode, v)

				if ok and type(result) == "table" and type(result.Category) == "string" then
					local v1836 = Assets.Directory[result.Category]
					local Rarity = v1836 and v1836.Rarity
					local ok2, result2 = pcall(AssetItems.WeightKg, result)
					local ok3, result3 = pcall(AssetEarnings.LiveRatePerSecond, {
						Category = result.Category,
						Scale = math.max(tonumber(result.Scale or result.AssetScale) or 1, 0.01),
						Mutations = type(result.Mutations) == "table" and result.Mutations or {}
					}, v1823.Gamepasses, v1823.Products)
					local v1842 = #t82 + 1
					local t83 = {
						uid = k,
						item = result,
						category = result.Category,
						displayName = v1836 and (v1836.DisplayName or v1836._id) or result.Category,
						rarity = Rarity and (Rarity.DisplayName or Rarity._id) or "Unknown",
						rarityId = Rarity and Rarity._id or "Unknown",
						rarityRank = Rarity and Rarity.RarityNumber or 0
					}
					local weightKg = ok2

					if weightKg then
						weightKg = math.max(tonumber(result2) or 0, 0)
					end

					t83.weightKg = weightKg or 0
					t83.weightKnown = ok2 and tonumber(result2) ~= nil
					t83.ratePerSecond = ok3 and type(result3) == "number" and math.max(result3, 0) or math.huge
					t83.favorite = result.IsFavorite == true
					t83.equipped = t81[k] == true
					t83.placed = v1825[k] == true
					t83.inFuse = result.InFuse == true
					t83.canFuse = v1836 ~= nil and v1836.CannotFuse ~= true
					t82[v1842] = t83
				end
			end
		end

		return t82
	end
	t79._rarityMatches = function(p601, p602)
		if table.find(p601.config.rarities, "All") then
			return true
		end

		return table.find(p601.config.rarities, p602.rarity) ~= nil or table.find(p601.config.rarities, p602.rarityId) ~= nil
	end
	t79._selectGroup = function(p603)
		local v1845 = Save.Get()

		if #v1796(v1845) > 0 then
			return nil, "Fuse machine already contains pets"
		end

		if Eggs.MAX_INVENTORY <= v1791(v1845 and v1845.EggInventory) then
			return nil, "Egg inventory is full"
		end

		local v1846, v1847 = p603:_decodeInventory()

		if not v1846 then
			return nil, v1847
		end

		local t84 = {}

		for _, v in ipairs(v1846) do
			if v.canFuse and not v.favorite and not v.inFuse and not v.equipped and not v.placed and p603:_rarityMatches(v) and (p603.config.priority ~= "Lightest" and p603.config.priority ~= "Heaviest" or v.weightKnown) and (p603.config.maxWeightKg <= 0 or v.weightKnown and v.weightKg <= p603.config.maxWeightKg) and not p603.coordinator:isCategoryProtected(v.category, "auto_fuse") and not p603.coordinator:isReserved(v.uid, "auto_fuse") then
				t84[v.category] = t84[v.category] or {}
				table.insert(t84[v.category], v)
			end
		end

		local t85 = {}
		local eligibleGroups = 0
		local v1853 = false
		local keepPerCategory = p603.config.keepPerCategory

		for k, v in pairs(t84) do
			if #v >= 3 and #v - keepPerCategory < 3 then
				v1853 = true
			end

			if #v - keepPerCategory >= 3 then
				eligibleGroups += math.floor((#v - keepPerCategory) / 3)
				table.sort(v, function(p604, p605)
					if p603.config.priority == "Heaviest" then
						return p604.weightKg > p605.weightKg
					end

					if p603.config.priority == "Lowest Value" and p604.ratePerSecond ~= p605.ratePerSecond then
						return p604.ratePerSecond < p605.ratePerSecond
					end

					if p604.weightKg == p605.weightKg then
						return p604.uid < p605.uid
					end

					return p604.weightKg < p605.weightKg
				end)
				t85[#t85 + 1] = {
					category = k,
					displayName = v[1].displayName,
					entries = {
						v[1],
						v[2],
						v[3]
					},
					rarityRank = v[1].rarityRank,
					weight = v[1].weightKg + v[2].weightKg + v[3].weightKg,
					ratePerSecond = v[1].ratePerSecond + v[2].ratePerSecond + v[3].ratePerSecond
				}
			end
		end

		p603.stats.eligibleGroups = eligibleGroups

		if #t85 == 0 then
			if v1853 then
				return nil, string.format("Need %d eligible copies of one pet (3 to fuse + %d kept)", keepPerCategory + 3, keepPerCategory)
			end

			return nil, "No pet type has 3 eligible copies"
		end

		table.sort(t85, function(p606, p607)
			if p603.config.priority == "Highest Rarity" and p606.rarityRank ~= p607.rarityRank then
				return p606.rarityRank > p607.rarityRank
			end

			if p603.config.priority == "Lowest Rarity" and p606.rarityRank ~= p607.rarityRank then
				return p606.rarityRank < p607.rarityRank
			end

			if p603.config.priority == "Lowest Value" and p606.ratePerSecond ~= p607.ratePerSecond then
				return p606.ratePerSecond < p607.ratePerSecond
			end

			if p603.config.priority == "Heaviest" and p606.weight ~= p607.weight then
				return p606.weight > p607.weight
			end

			if p603.config.priority ~= "Lightest" or p606.weight == p607.weight then
				return p606.category < p607.category
			end

			return p606.weight < p607.weight
		end)

		return t85[1]
	end
	t79._validateGroup = function(p608, p609)
		local v1857 = Save.Get()

		if #v1796(v1857) > 0 then
			return false, "Fuse machine already contains pets"
		end

		if Eggs.MAX_INVENTORY <= v1791(v1857 and v1857.EggInventory) then
			return false, "Egg inventory is full"
		end

		local v1858, v1859 = p608:_decodeInventory()

		if not v1858 then
			return false, v1859
		end

		local t86 = {}
		local n29 = 0

		for _, v in ipairs(v1858) do
			t86[v.uid] = v

			if v.category == p609.category and v.canFuse and not v.favorite and not v.inFuse and not v.equipped and not v.placed and p608:_rarityMatches(v) and (p608.config.priority ~= "Lightest" and p608.config.priority ~= "Heaviest" or v.weightKnown) then
				if not (p608.config.maxWeightKg <= 0) then
					if not v.weightKnown then
						continue
					end

					if not (v.weightKg <= p608.config.maxWeightKg) then
						continue
					end
				end

				if not p608.coordinator:isCategoryProtected(v.category, "auto_fuse") then
					if not p608.coordinator:isReserved(v.uid, "auto_fuse") then
						n29 += 1
					end
				end
			end
		end

		if n29 - p608.config.keepPerCategory < 3 then
			return false, "Keep Copies prevents selected group"
		end

		for _, entry in ipairs(p609.entries) do
			local v1866 = t86[entry.uid]

			if not v1866 or v1866.category ~= p609.category or not v1866.canFuse or v1866.favorite or v1866.inFuse or v1866.equipped or v1866.placed or not p608:_rarityMatches(v1866) or (p608.config.priority == "Lightest" or p608.config.priority == "Heaviest") and not v1866.weightKnown or p608.config.maxWeightKg > 0 and (not v1866.weightKnown or p608.config.maxWeightKg < v1866.weightKg) then
				return false, "Selected pets changed before fuse"
			end

			if p608.coordinator:isCategoryProtected(v1866.category, "auto_fuse") then
				return false, "Selected pets changed before fuse"
			end

			if p608.coordinator:isReserved(v1866.uid, "auto_fuse") then
				return false, "Selected pets changed before fuse"
			end
		end

		return true
	end
	t79._waitForTreadmill = function(p610)
		if not p610.treadmillManager then
			return true
		end

		if type(p610.treadmillManager._syncActiveTreadmillSnapshot) == "function" then
			p610.treadmillManager:_syncActiveTreadmillSnapshot()
		end

		if not p610.treadmillManager:isEngaged() then
			return true
		end

		if type(p610.treadmillManager._cancelIdle) == "function" then
			p610.treadmillManager:_cancelIdle(true)
		end

		local v1867 = os.clock() + 5

		while p610.treadmillManager:isEngaged() and os.clock() < v1867 do
			if type(p610.treadmillManager._requestUnequip) == "function" then
				p610.treadmillManager:_requestUnequip()
			end

			task.wait(0.1)
		end

		return not p610.treadmillManager:isEngaged()
	end
	t79._shouldAbort = function(p611, p612, p613)
		if p611.destroyed or p612 ~= p611.generation or not p613 and not p611.config.enabled then
			return true
		end

		if p611.captureRuntime and type(p611.captureRuntime.isEngaged) == "function" then
			if p611.captureRuntime:isEngaged() then
				return true
			end
		end

		if p611.travel and type(p611.travel.hasPendingPreEventSteal) == "function" then
			if p611.travel:hasPendingPreEventSteal() then
				return true
			end
		end

		local __ZeroinScrambleRuntime = genv.__ZeroinScrambleRuntime

		if __ZeroinScrambleRuntime and type(__ZeroinScrambleRuntime.isFightPending) == "function" and __ZeroinScrambleRuntime:isFightPending() then
			return true
		end

		local __ZeroinRiftRuntime = genv.__ZeroinRiftRuntime

		return __ZeroinRiftRuntime and type(__ZeroinRiftRuntime.isTradeReady) == "function" and __ZeroinRiftRuntime:isTradeReady() or false
	end
	t79._travelToMachine = function(p614, p615, p616)
		local __OBJECTS = Workspace2:FindFirstChild("__OBJECTS")
		local Machines = __OBJECTS and __OBJECTS:FindFirstChild("Machines")
		local FuseMachine = Machines and Machines:FindFirstChild("FuseMachine")
		local Machine = FuseMachine and FuseMachine:FindFirstChild("Machine")

		if not Machine or not Machine:IsA("BasePart") then
			return false, "Fuse machine unavailable"
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid or Humanoid.Health <= 0 then
			return false, "Character unavailable"
		end

		local Attachment = Machine:FindFirstChildOfClass("Attachment")
		local WorldPosition = Attachment and Attachment.WorldPosition or Machine.Position
		local v1879 = WorldPosition - Machine.Position
		local vector32 = Vector3.new(v1879.X, 0, v1879.Z)
		local Unit = vector32.Magnitude > 0.1 and vector32.Unit or -Machine.CFrame.LookVector
		local v1882 = HumanoidRootPart.Size.Y * 0.5
		local v1883 = Humanoid.RigType == Enum.HumanoidRigType.R15 and math.max(Humanoid.HipHeight, 0.5)
		local v1884 = Vector3.new(WorldPosition.X, Machine.Position.Y - Machine.Size.Y * 0.5 + (v1882 + (v1883 or 2)), WorldPosition.Z) + Unit * 4
		local cFrame = lookAt(v1884, Vector3.new(WorldPosition.X, v1884.Y, WorldPosition.Z))

		if (HumanoidRootPart.Position - cFrame.Position).Magnitude <= 7 then
			return true
		end

		if not p614.travel then
			return false, "Shared travel unavailable"
		end

		if p614.travel:travelAndWait(cFrame, {
			abort = function()
				return p614:_shouldAbort(p615, p616)
			end
		}) then
			return true
		end

		return false, "Travel to fuse machine interrupted"
	end
	t79._rollback = function(p617, p618)
		local EjectPet = v1802("EjectPet")

		if not EjectPet then
			return
		end

		for _, v in ipairs(p618) do
			pcall(EjectPet.InvokeServer, EjectPet, v.uid)
		end
	end
	t79._clearStuckMachine = function(p619, p620)
		local v1889 = Save.Get()
		local t87 = {}

		for _, v in ipairs(v1796(v1889)) do
			if type(v) == "string" and v ~= "" then
				t87[v] = true
			end
		end

		local ipairs_ = ipairs
		local v1894 = p619:_decodeInventory() or {}

		for _, v in ipairs_(v1894) do
			if v.inFuse then
				t87[v.uid] = true
			end
		end

		if not next(t87) then
			return true
		end

		p619:_setStatus("Clearing unfinished fuse")

		local EjectPet = v1802("EjectPet")

		if not EjectPet then
			return false, "EjectPet remote unavailable"
		end

		for k in pairs(t87) do
			pcall(EjectPet.InvokeServer, EjectPet, k)
		end

		if p619:_waitFor(p620, 8, function()
			return #v1796(Save.Get()) == 0
		end) then
			return true
		end

		return false, "Fuse machine cleanup timed out"
	end
	t79._finishPendingFusion = function(p621)
		local v1899 = Save.Get()
		local v1900 = tonumber(v1899 and v1899.FusionEndsAt)

		if not v1799(v1899) then
			return false, nil
		end

		local v1901 = v1798(v1899)

		if not v1901 then
			p621:_setStatus("Waiting for existing fuse")

			local v1902 = tonumber(v1899 and v1899.FusionDuration) or 0
			local v1903 = v1900 and math.max(30, v1900 - Workspace2:GetServerTimeNow() + 8) or math.max(30, v1902 + 8)
			local v1904 = os.clock() + v1903

			while not p621.destroyed and os.clock() < v1904 do
				local v1905 = Save.Get()

				if v1798(v1905) then
					v1901 = true

					break
				end

				local v1906 = tonumber(v1905 and v1905.FusionEndsAt)

				if v1906 ~= nil and v1905.FusionLocked ~= true and v1906 <= Workspace2:GetServerTimeNow() then
					v1901 = true

					break
				end

				task.wait(0.1)
			end
		end

		if not v1901 then
			return true, "Existing fuse reward timed out"
		end

		local v1907, v1908 = p621:_finishReveal()

		if not v1907 then
			return true, "Finish reveal failed: " .. tostring(v1908)
		end

		p621:_setStatus("Recovered previous fuse reward")

		return true, nil
	end
	t79._finishReveal = function()
		local FinishReveal = v1802("FinishReveal")

		if not FinishReveal then
			return false, "FinishReveal remote unavailable"
		end

		local ok, result, result2 = pcall(FinishReveal.InvokeServer, FinishReveal)

		if ok and result ~= false then
			return true
		end

		return false, tostring(result2 or result or "Unknown")
	end
	t79._run = function(p622, p623, p624)
		if p622.running or p622.destroyed then
			return
		end

		p622.running = true
		zeroinConfig.IsFusing = true

		local v1913 = false

		while not p622.destroyed and p623 == p622.generation and (p622.config.enabled or p624) do
			local v1914, v1915 = p622:_finishPendingFusion()

			if v1915 then
				p622:_setStatus(v1915)
				v1913 = true

				break
			end

			if v1914 then
				if not p624 then
					task.wait(0.5)

					continue
				end
			else
				local ok2 = not (not not p622.captureRuntime and type(p622.captureRuntime.isEngaged) == "function")

				if not ok2 then
					ok2 = not p622.captureRuntime:isEngaged()
				end

				if not ok2 then
					p622:_setStatus("Waiting for Capture The Egg")
					v1913 = true

					break
				end

				local ok = not (not not p622.travel and type(p622.travel.hasPendingPreEventSteal) == "function")

				if not ok then
					ok = not p622.travel:hasPendingPreEventSteal()
				end

				if not ok then
					p622:_setStatus("Waiting for Auto Steal")
					v1913 = true

					break
				end

				local manualCarry = p622.travel and p622.travel.manualCarry

				if manualCarry and manualCarry.active then
					p622:_setStatus("Waiting for carried egg")
					v1913 = true

					break
				end

				local v1919, v1920 = p622:_clearStuckMachine(p623)

				if not v1919 then
					p622:_setStatus(v1920 or "Fuse cleanup failed")
					v1913 = true

					break
				end

				local v1921, v1922 = p622:_selectGroup()

				if not v1921 then
					p622:_setStatus(v1922 or "No eligible fuse group")
					v1913 = v1922 == "Pet inventory unavailable" or v1922 == "Placed pet status unavailable"

					break
				end

				local t88 = {}

				for _, entry in ipairs(v1921.entries) do
					t88[#t88 + 1] = entry.uid
				end

				local autoFuse, v1927 = p622.coordinator:tryAcquire("auto_fuse", t88)

				if not autoFuse then
					p622:_setStatus(v1927 or "Waiting for another automation")
					v1913 = true

					break
				end

				local u1928 = false

				local function v1929()
					if u1928 then
						return
					end

					u1928 = true
					p622.coordinator:release(autoFuse)
				end

				if not p622:_waitForTreadmill() then
					v1929()
					p622:_setStatus("Treadmill did not release")
					v1913 = true

					break
				end

				p622:_setStatus("Moving to Fuse Machine")

				local v1930, v1931 = p622:_travelToMachine(p623, p624)

				if not v1930 then
					v1929()
					p622:_setStatus(v1931 or "Fuse travel failed")
					v1913 = true

					break
				end

				local v1932, v1933 = p622:_validateGroup(v1921)

				if not v1932 then
					v1929()
					p622:_setStatus(v1933)

					break
				end

				pcall(function()
					local ConfirmBriefing = v1802("ConfirmBriefing")

					if ConfirmBriefing then
						ConfirmBriefing:InvokeServer()
					end
				end)

				local LoadPet = v1802("LoadPet")

				if not LoadPet then
					v1929()
					p622:_setStatus("LoadPet remote unavailable")

					break
				end

				local t89 = {}
				local fuseFailed

				for i, entry in ipairs(v1921.entries) do
					if p622:_shouldAbort(p623, p624) then
						fuseFailed = "Cancelled"

						break
					end

					if p622.coordinator:isCategoryProtected(v1921.category, "auto_fuse") then
						fuseFailed = "Pet category became protected"

						break
					end

					p622:_setStatus(string.format("Loading %s (%d/3)", v1921.displayName, i))

					local ok3, result, result2 = pcall(LoadPet.InvokeServer, LoadPet, entry.uid)

					if ok3 and result ~= false then
						t89[#t89 + 1] = entry
						task.wait(0.15)
					else
						fuseFailed = tostring(result2 or result or "Insert rejected")

						break
					end
				end

				if fuseFailed then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("Fuse failed: " .. fuseFailed)

					break
				end

				local BeginFuse = v1802("BeginFuse")

				if not BeginFuse then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("BeginFuse remote unavailable")

					break
				end

				if p622:_shouldAbort(p623, p624) then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("Fuse cancelled")

					break
				end

				if p622.coordinator:isCategoryProtected(v1921.category, "auto_fuse") then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("Fuse cancelled: pet category protected")

					break
				end

				local v1944 = Save.Get()

				if Eggs.MAX_INVENTORY <= v1791(v1944 and v1944.EggInventory) then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("Fuse cancelled: egg inventory is full")

					break
				end

				p622:_setStatus("Fusing " .. v1921.displayName)

				local ok3, result, result2, result3 = pcall(BeginFuse.InvokeServer, BeginFuse)

				if not ok3 or result == false then
					p622:_rollback(t89)
					v1929()
					p622:_setStatus("Fuse failed: " .. tostring(result2 or result or "Unknown"))

					break
				end

				v1929()

				local v1949 = Save.Get()
				local v1950 = tonumber(v1949 and v1949.FusionEndsAt)
				local v1951 = tonumber(v1949 and v1949.FusionDuration) or 0
				local n30 = 30
				local v1953

				if v1950 then
					v1953 = math.max(n30, v1950 - Workspace2:GetServerTimeNow() + 8)
				elseif v1951 > 0 then
					v1953 = math.max(n30, v1951 + 8)
				else
					v1953 = 5
				end

				p622:_setStatus("Waiting for fuse reward")

				local v1954 = os.clock() + v1953
				local v1955 = false

				while not p622.destroyed and os.clock() < v1954 do
					local v1956 = Save.Get()

					if v1798(v1956) then
						v1955 = true

						break
					end

					local v1957 = tonumber(v1956 and v1956.FusionEndsAt)

					if v1957 ~= nil and v1956.FusionLocked ~= true and v1957 <= Workspace2:GetServerTimeNow() then
						v1955 = true

						break
					end

					task.wait(0.1)
				end

				if not v1955 then
					p622:_setStatus("Fuse reward timed out")
					v1913 = true

					break
				end

				local v1958, v1959 = p622:_finishReveal()

				if not v1958 then
					p622:_setStatus("Finish reveal failed: " .. tostring(v1959))
					v1913 = true

					break
				end

				local stats = p622.stats
				local lastFused = type(result3) == "table"

				if lastFused then
					lastFused = tostring(result3.AssetCategory or v1921.displayName)
				end

				stats.lastFused = lastFused or v1921.displayName
				p622:_setStatus("Fused " .. p622.stats.lastFused)

				if p624 then
					break
				end

				task.wait(0.5)

				continue
			end

			break
		end

		p622.running = false
		zeroinConfig.IsFusing = false
		p622:_emit()

		if (v1913 or p622.rescheduleRequested or p624) and p622.config.enabled and not p622.destroyed then
			p622.rescheduleRequested = false
			p622:_scheduleRetry()
		end
	end
	t79._scheduleRetry = function(p625)
		if p625.retryScheduled or p625.destroyed or not p625.config.enabled then
			return
		end

		p625.retryScheduled = true

		local generation = p625.generation

		task.delay(1, function()
			p625.retryScheduled = false

			if not p625.destroyed and p625.config.enabled and generation == p625.generation then
				p625:_schedule()
			end
		end)
	end
	t79._schedule = function(p626, p627)
		if not p626.startupRecoveryPending then
			if not p626.destroyed and not p626.running and (p626.config.enabled or p627) then
				local generation = p626.generation

				task.defer(function()
					local ok, result = xpcall(p626._run, debug.traceback, p626, generation, p627 == true)

					if not ok then
						p626.running = false
						zeroinConfig.IsFusing = false
						p626.coordinator:forceRelease("auto_fuse")
						p626:_setStatus("Fuse runtime error")
						warn("[SAE][AutoFuse] " .. tostring(result))
						p626:_scheduleRetry()
					end
				end)

				return
			end

			return
		end

		p626.rescheduleRequested = p626.config.enabled or p627 == true
		p626.pendingSinglePass = p626.pendingSinglePass or p627 == true
	end
	t79.setEnabled = function(p628, p629)
		p628.config.enabled = p629 == true
		p628.generation += 1
		zeroinConfig.AutoFuse = p628.config.enabled

		if p628.config.enabled then
			if p628.running then
				p628.rescheduleRequested = true
			end

			p628:_setStatus("Scanning pets")
			p628:_schedule()
		else
			p628.rescheduleRequested = false
			zeroinConfig.IsFusing = p628.running
			p628:_setStatus("Disabled")
		end
	end
	t79.setPriority = function(p630, p631)
		if table.find(t78, p631) then
			p630.config.priority = p631
		end

		zeroinConfig.AutoFusePriority = p630.config.priority
		p630.manualConfirmation = nil
		p630.generation += 1
		p630:_emit()

		if p630.running then
			p630.rescheduleRequested = true
		else
			p630:_schedule()
		end

		return p630.config.priority
	end
	t79.setRarities = function(p632, p633)
		local t90 = {}
		local ipairs_ = ipairs
		local v1968 = type(p633) == "table" and p633 or { p633 }

		for _, v in ipairs_(v1968) do
			if type(v) == "string" and v ~= "" and not table.find(t90, v) then
				t90[#t90 + 1] = v
			end
		end

		p632.config.rarities = table.find(t90, "All") and { "All" } or #t90 > 0 and t90 or { "All" }
		zeroinConfig.AutoFuseRarities = table.clone(p632.config.rarities)
		p632.manualConfirmation = nil
		p632.generation += 1
		p632:_emit()

		if p632.running then
			p632.rescheduleRequested = true
		else
			p632:_schedule()
		end

		return table.clone(p632.config.rarities)
	end
	t79.setKeepPerCategory = function(p634, p635)
		local config = p634.config
		local max = math.max
		local n31 = 0
		local floor = math.floor

		config.keepPerCategory = max(n31, floor(tonumber(p635) or 1))
		zeroinConfig.AutoFuseKeepPerPet = p634.config.keepPerCategory
		p634.manualConfirmation = nil
		p634.generation += 1
		p634:_emit()

		if p634.running then
			p634.rescheduleRequested = true
		else
			p634:_schedule()
		end

		return p634.config.keepPerCategory
	end
	t79.setMaxWeightKg = function(p636, p637)
		p636.config.maxWeightKg = math.max(tonumber(p637) or 0, 0)
		zeroinConfig.AutoFuseMaxWeightKg = p636.config.maxWeightKg
		p636.manualConfirmation = nil
		p636.generation += 1
		p636:_emit()

		if p636.running then
			p636.rescheduleRequested = true
		else
			p636:_schedule()
		end

		return p636.config.maxWeightKg
	end
	t79.fuseOnce = function(p638)
		if p638.destroyed or p638.running then
			return false, "Auto Fuse is busy"
		end

		p638.generation += 1
		p638:_setStatus("Manual fuse requested")
		p638:_schedule(true)

		return true
	end
	t79.requestFuseOnce = function(p639)
		if p639.destroyed or p639.running then
			return false, "Auto Fuse is busy"
		end

		local v1975, v1976 = p639:_selectGroup()

		if not v1975 then
			p639.manualConfirmation = nil
			p639:_setStatus(v1976 or "No eligible fuse group")

			return false, p639.stats.status
		end

		local t91 = { v1975.category }

		for _, entry in ipairs(v1975.entries) do
			t91[#t91 + 1] = entry.uid
		end

		local v1980 = table.concat(t91, ":")
		local manualConfirmation = p639.manualConfirmation

		if manualConfirmation and not (manualConfirmation.signature ~= v1980 or manualConfirmation.expiresAt < os.clock()) then
			p639.manualConfirmation = nil

			return p639:fuseOnce()
		end

		p639.manualConfirmation = {
			signature = v1980,
			expiresAt = os.clock() + 8
		}
		p639:_setStatus("Ready: " .. v1975.displayName .. " x3 - press again to confirm")

		return false, "Press again within 8 seconds to confirm"
	end
	t79.preview = function(p640)
		local v1982, v1983 = p640:_selectGroup()

		p640:_emit()

		if v1982 then
			return {
				category = v1982.category,
				displayName = v1982.displayName,
				uids = {
					v1982.entries[1].uid,
					v1982.entries[2].uid,
					v1982.entries[3].uid
				}
			}, nil
		end

		return nil, v1983
	end
	t79.getSnapshot = function(p641)
		return p641:_snapshot()
	end
	t79.destroy = function(p642)
		if p642.destroyed then
			return
		end

		p642.destroyed = true
		p642.config.enabled = false
		p642.generation += 1
		zeroinConfig.IsFusing = false
		p642.coordinator:forceRelease("auto_fuse")

		for _, resource in ipairs(p642.resources) do
			v1790(resource)
		end

		table.clear(p642.resources)
		table.clear(p642.listeners)
	end

	return t79
end

local v1986 = v1775()

local function v1987()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local Workspace2 = game:GetService("Workspace")
	local LocalPlayer2 = Players2.LocalPlayer
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local Save = require(ReplicatedStorage2.Shared.Save)
	local Assets = require(ReplicatedStorage2.Data.Assets)
	local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
	local BossMastery = Remotes.BossMastery
	local t92 = {
		"Boss",
		"Scrambled"
	}
	local t93 = {}

	t93.__index = t93

	local function v1999(p643)
		pcall(function()
			if typeof(p643) == "RBXScriptConnection" then
				p643:Disconnect()
			elseif type(p643) == "function" then
				p643()
			elseif type(p643) == "table" and type(p643.Disconnect) == "function" then
				p643:Disconnect()
			end
		end)
	end

	t93.new = function(p644, p645, p646, p647)
		local obj = setmetatable({}, t93)

		obj.coordinator = p644
		obj.travel = p645
		obj.treadmillManager = p646
		obj.captureRuntime = p647
		obj.destroyed = false
		obj.running = false
		obj.generation = 0
		obj.listeners = {}
		obj.resources = {}
		obj.manualConfirmation = nil
		obj.successHoldUntil = 0
		obj.config = {
			enabled = false,
			mutationType = "Boss",
			rarities = {
				"Secret",
				"Eternal",
				"Divine",
				"Cosmic",
				"Mythic"
			},
			names = {},
			minValuePerSec = 0
		}
		obj.stats = {
			status = "Disabled",
			consumables = 0,
			eligible = 0,
			target = nil,
			lastMutated = "None"
		}

		local v2001 = Save.WatchFields({
			"EggInventory",
			"BossMastery",
			"Gamepasses",
			"Products"
		}, function()
			obj:_emit()
			obj:_schedule()
		end)

		if v2001 then
			obj.resources[#obj.resources + 1] = v2001
		end

		return obj
	end
	t93.getMutationTypes = function()
		return table.clone(t92)
	end
	t93._snapshot = function(p648)
		return {
			enabled = p648.config.enabled,
			running = p648.running,
			status = p648.stats.status,
			consumables = p648.stats.consumables,
			eligible = p648.stats.eligible,
			target = p648.stats.target,
			lastMutated = p648.stats.lastMutated,
			mutationType = p648.config.mutationType,
			rarities = table.clone(p648.config.rarities),
			names = table.clone(p648.config.names),
			minValuePerSec = p648.config.minValuePerSec,
			placedNames = p648:getPlacedEggNames()
		}
	end
	t93._emit = function(p649)
		local v2002 = p649:_snapshot()

		genv.__ZeroinAutoMutateStatus = v2002

		for k in pairs(p649.listeners) do
			pcall(k, v2002)
		end
	end
	t93.onChanged = function(p650, p651)
		p650.listeners[p651] = true
		pcall(p651, p650:_snapshot())

		return function()
			p650.listeners[p651] = nil
		end
	end
	t93._setStatus = function(p652, p653)
		p652.stats.status = p653
		p652:_emit()
	end
	t93._toolMutationType = function(p654, p655)
		return p655 and (p655:GetAttribute("MutationId") or p655:GetAttribute("MutationTemplate")) or nil
	end
	t93._isConsumable = function(p656, p657)
		if not p657 or not p657:IsA("Tool") then
			return false
		end

		if p657:GetAttribute("ItemType") ~= "MutationConsumable" then
			if not p657.Name:find("Mutation Consumable", 1, true) then
				return false
			end
		end

		local v2004 = p656:_toolMutationType(p657)

		if p656.config.mutationType == "Scrambled" then
			return v2004 == "Scrambled"
		end

		return v2004 == nil or v2004 == "" or v2004 == "Boss"
	end
	t93._findConsumable = function(p658)
		for _, v in pairs({
			character = LocalPlayer2.Character,
			backpack = LocalPlayer2:FindFirstChildOfClass("Backpack")
		}) do
			local ipairs_ = ipairs
			local children = v and v:GetChildren() or {}

			for _, child in ipairs_(children) do
				if p658:_isConsumable(child) then
					return child, v == LocalPlayer2.Character
				end
			end
		end

		return nil, false
	end
	t93.getConsumableCount = function(p659)
		if p659.config.mutationType ~= "Scrambled" then
			local v2011 = Save.Get()

			return math.max(tonumber(v2011 and v2011.BossMastery and v2011.BossMastery.MutationConsumables) or 0, 0)
		end

		local n32 = 0

		for _, v in pairs({
			character = LocalPlayer2.Character,
			backpack = LocalPlayer2:FindFirstChildOfClass("Backpack")
		}) do
			local ipairs_ = ipairs
			local children = v and v:GetChildren() or {}

			for _, child in ipairs_(children) do
				if p659:_isConsumable(child) then
					n32 += math.max(tonumber(child:GetAttribute("Uses")) or 1, 0)
				end
			end
		end

		return n32
	end
	t93._ensureEquipped = function(p660)
		local v2019, v2020 = p660:_findConsumable()

		if v2020 then
			return v2019 ~= nil
		end

		local Character = LocalPlayer2.Character
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not v2019 or not Humanoid then
			return false
		end

		pcall(Humanoid.EquipTool, Humanoid, v2019)

		local v2023 = os.clock() + 0.5

		while true do
			if not (os.clock() < v2023) then
				return false
			end

			if v2019.Parent ~= Character or not p660:_isConsumable(v2019) then
				task.wait(0.05)

				continue
			end

			break
		end

		return true
	end
	t93.getPlacedEggNames = function()
		local t94 = {}
		local t95 = {}
		local v2026 = Save.Get()
		local pairs_ = pairs
		local EggInventory = v2026 and v2026.EggInventory or {}

		for _, v in pairs_(EggInventory) do
			if type(v) == "table" and v.Placement ~= nil and type(v.AssetCategory) == "string" then
				local v2031 = Assets.Directory[v.AssetCategory]
				local DisplayName = v2031 and (v2031.DisplayName or v2031._id) or v.AssetCategory

				if not t95[DisplayName] then
					t95[DisplayName] = true
					t94[#t94 + 1] = DisplayName
				end
			end
		end

		table.sort(t94)

		return t94
	end
	t93._rate = function(p661, p662, p663)
		local pcall_ = pcall
		local LiveRatePerSecond = AssetEarnings.LiveRatePerSecond
		local t96 = {
			Category = p662.AssetCategory
		}

		t96.Scale = math.max(tonumber(p662.AssetScale or p662.Scale) or 1, 0.01)
		t96.Mutations = type(p662.Mutations) == "table" and p662.Mutations or {}
		t96.BaseMutation = p662.BaseMutation

		local ok, result = pcall_(LiveRatePerSecond, t96, p663 and p663.Gamepasses, p663 and p663.Products)

		return ok and type(result) == "number" and math.max(result, 0) or nil
	end
	t93._eligibleTargets = function(p664)
		local v2038 = Save.Get()
		local t97 = {}
		local pairs_ = pairs
		local EggInventory = v2038 and v2038.EggInventory or {}

		for k, v in pairs_(EggInventory) do
			if type(k) == "string" and type(v) == "table" and v.Placement ~= nil and type(v.AssetCategory) == "string" then
				local v2044 = Assets.Directory[v.AssetCategory]
				local DisplayName = v2044 and v2044.Rarity and (v2044.Rarity.DisplayName or v2044.Rarity._id) or "Unknown"
				local DisplayName2 = v2044 and (v2044.DisplayName or v2044._id) or v.AssetCategory
				local v2047 = p664:_rate(v, v2038)
				local v2048 = table.find(p664.config.rarities, "All") ~= nil or table.find(p664.config.rarities, DisplayName) ~= nil
				local v2049 = #p664.config.names == 0 or table.find(p664.config.names, DisplayName2) ~= nil
				local v2050 = v2047 ~= nil and v2047 >= p664.config.minValuePerSec
				local v2051 = table.find(type(v.Mutations) == "table" and v.Mutations or {}, p664.config.mutationType) ~= nil or v.BaseMutation == p664.config.mutationType

				if v2048 and v2049 and v2050 and not v2051 then
					if not p664.coordinator:isReserved(k, "auto_mutate") then
						t97[#t97 + 1] = {
							uid = k,
							egg = v,
							category = v.AssetCategory,
							name = DisplayName2,
							rarity = DisplayName,
							rate = v2047
						}
					end
				end
			end
		end

		table.sort(t97, function(p665, p666)
			if p665.rate == p666.rate then
				return p665.uid < p666.uid
			end

			return p665.rate > p666.rate
		end)
		p664.stats.eligible = #t97
		p664.stats.target = t97[1] and t97[1].name or nil

		return t97
	end
	t93._noTargetReason = function(p667)
		local v2052 = Save.Get()
		local t98 = {}
		local t99 = {}
		local t100 = {}
		local pairs_ = pairs
		local EggInventory = v2052 and v2052.EggInventory or {}

		for _, v in pairs_(EggInventory) do
			if type(v) == "table" and v.Placement ~= nil and type(v.AssetCategory) == "string" then
				local v2060 = Assets.Directory[v.AssetCategory]
				local DisplayName = v2060 and (v2060.DisplayName or v2060._id) or v.AssetCategory

				t98[DisplayName] = true

				if #p667.config.names == 0 or table.find(p667.config.names, DisplayName) then
					t99[DisplayName] = true

					if table.find(type(v.Mutations) == "table" and v.Mutations or {}, p667.config.mutationType) or v.BaseMutation == p667.config.mutationType then
						t100[DisplayName] = true
					end
				end
			end
		end

		if #p667.config.names > 0 then
			local t101 = {}
			local t102 = {}

			for _, name in ipairs(p667.config.names) do
				if not t98[name] then
					t101[#t101 + 1] = name
				elseif t100[name] then
					t102[#t102 + 1] = name
				end
			end

			if #t102 == #p667.config.names then
				return table.concat(t102, ", ") .. " already has " .. p667.config.mutationType .. " mutation"
			end

			if #t101 == #p667.config.names then
				return "Selected egg is no longer placed"
			end
		end

		if next(t99) and next(t100) then
			return "Matching placed eggs already have " .. p667.config.mutationType .. " mutation"
		end

		if p667.config.minValuePerSec > 0 then
			return "No placed egg meets the minimum value"
		end

		return "No placed egg matches the rarity or name filters"
	end
	t93._findModel = function(p668, p669)
		local PlacedEggRenders = Workspace2:FindFirstChild("PlacedEggRenders")

		if not PlacedEggRenders then
			return nil
		end

		local v2067 = PlacedEggRenders:FindFirstChild(string.format("%d_%s", LocalPlayer2.UserId, p669))

		if v2067 and v2067:IsA("Model") then
			return v2067
		end

		for _, child in ipairs(PlacedEggRenders:GetChildren()) do
			if child:IsA("Model") then
				if child.Name:find(p669, 1, true) then
					return child
				end
			end
		end

		return nil
	end
	t93._projectGround = function(p670, p671)
		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			return nil
		end

		local raycastParams = RaycastParams.new()

		raycastParams.FilterType = Enum.RaycastFilterType.Exclude

		local filterDescendantsInstances = { Character }
		local PlacedEggRenders = Workspace2:FindFirstChild("PlacedEggRenders")

		if PlacedEggRenders then
			filterDescendantsInstances[#filterDescendantsInstances + 1] = PlacedEggRenders
		end

		raycastParams.FilterDescendantsInstances = filterDescendantsInstances
		raycastParams.IgnoreWater = false

		local hit = Workspace2:Raycast(Vector3.new(p671.X, math.max(p671.Y, HumanoidRootPart.Position.Y) + 40, p671.Z), Vector3.new(0, -160, 0), raycastParams)

		if hit then
			return Vector3.new(p671.X, hit.Position.Y + (HumanoidRootPart.Size.Y * 0.5 + (Humanoid.RigType == Enum.HumanoidRigType.R15 and math.max(Humanoid.HipHeight, 0.5) or 2)) + 0.05, p671.Z)
		end

		return nil
	end
	t93._destination = function(p672, p673)
		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")

		if not HumanoidRootPart then
			return nil
		end

		local Position = p673:GetPivot().Position
		local vector32 = Vector3.new(HumanoidRootPart.Position.X - Position.X, 0, HumanoidRootPart.Position.Z - Position.Z)
		local v2081 = p672:_projectGround(Position + (vector32.Magnitude > 0.001 and vector32.Unit or Vector3.new(0, 0, 1)) * 4.5)

		if v2081 then
			return lookAt(v2081, Vector3.new(Position.X, v2081.Y, Position.Z))
		end

		return nil
	end
	t93._shouldAbort = function(p674, p675, p676)
		if not p674.destroyed and p675 == p674.generation then
			if p676 or p674.config.enabled then
				if p674.captureRuntime and type(p674.captureRuntime.isEngaged) == "function" then
					if p674.captureRuntime:isEngaged() then
						return true
					end
				end

				if p674.travel and type(p674.travel.hasPendingPreEventSteal) == "function" then
					if p674.travel:hasPendingPreEventSteal() then
						return true
					end
				end

				local __ZeroinScrambleRuntime = genv.__ZeroinScrambleRuntime

				if __ZeroinScrambleRuntime and type(__ZeroinScrambleRuntime.isFightPending) == "function" and __ZeroinScrambleRuntime:isFightPending() then
					return true
				end

				local __ZeroinRiftRuntime = genv.__ZeroinRiftRuntime

				return __ZeroinRiftRuntime and type(__ZeroinRiftRuntime.isTradeReady) == "function" and __ZeroinRiftRuntime:isTradeReady() or false
			end
		end

		return true
	end
	t93._applyTarget = function(p677, p678, p679, p680)
		local v2084 = p677:_findModel(p678.uid)

		if not v2084 then
			p677:_setStatus("Waiting for placed egg model")

			return false
		end

		if not p677:_ensureEquipped() then
			p677:_setStatus("Unable to equip " .. p677.config.mutationType .. " consumable")

			return false
		end

		if p677.treadmillManager and type(p677.treadmillManager._syncActiveTreadmillSnapshot) == "function" then
			p677.treadmillManager:_syncActiveTreadmillSnapshot()
		end

		if p677.treadmillManager then
			if p677.treadmillManager:isEngaged() then
				if type(p677.treadmillManager._cancelIdle) == "function" then
					p677.treadmillManager:_cancelIdle(true)
				end

				if type(p677.treadmillManager._requestUnequip) == "function" then
					p677.treadmillManager:_requestUnequip()
				end
			end
		end

		local v2085 = p677:_destination(v2084)
		local HumanoidRootPart = LocalPlayer2.Character and LocalPlayer2.Character:FindFirstChild("HumanoidRootPart")

		if v2085 then
			if HumanoidRootPart then
				if (HumanoidRootPart.Position - v2085.Position).Magnitude > 8 then
					p677:_setStatus("Moving to " .. p678.name)

					if not p677.travel:travelAndWait(v2085, {
						groundedProfile = true,
						projectGroundPosition = function(p681)
							return p677:_projectGround(p681)
						end,
						abort = function()
							return p677:_shouldAbort(p679, p680)
						end
					}) or p677:_shouldAbort(p679, p680) then
						p677:_setStatus("Mutation travel interrupted")

						return false
					end
				end

				local v2087 = Save.Get()
				local EggInventory = v2087 and v2087.EggInventory and v2087.EggInventory[p678.uid]
				local v2089 = p677:_eligibleTargets()
				local v2090 = false

				for _, v in ipairs(v2089) do
					if v.uid == p678.uid then
						v2090 = true

						break
					end
				end

				if not (EggInventory and EggInventory.Placement ~= nil and p677:getConsumableCount() > 0 and v2090) then
					p677:_setStatus("Target changed before mutation")

					return false
				end

				if not BossMastery or not BossMastery.AskUseMutationConsumable then
					p677:_setStatus("Mutation remote unavailable")

					return false
				end

				p677:_setStatus("Applying " .. p677.config.mutationType .. " to " .. p678.name)

				local ok, result = pcall(BossMastery.AskUseMutationConsumable.InvokeServer, BossMastery.AskUseMutationConsumable, p678.uid)

				if not ok or type(result) ~= "table" or not result.Success then
					p677:_setStatus("Server rejected mutation request")

					return false
				end

				if result.Mutated then
					p677.stats.lastMutated = p678.name
					p677.successHoldUntil = os.clock() + 5
					p677:_setStatus("Mutation applied to " .. p678.name)
				else
					p677:_setStatus("Mutation missed; retrying")
				end

				return true
			end
		end

		p677:_setStatus("Placed egg position unavailable")

		return false
	end
	t93._run = function(p682, p683, p684)
		if p682.running or p682.destroyed then
			return
		end

		p682.running = true

		local v2095 = p682:_eligibleTargets()

		p682.stats.consumables = p682:getConsumableCount()

		local v2096 = v2095[1]

		if v2096 or not (os.clock() < p682.successHoldUntil) then
			if not v2096 then
				p682:_setStatus(p682:_noTargetReason())
			elseif p682.stats.consumables <= 0 then
				p682:_setStatus("No " .. p682.config.mutationType .. " consumables left")
			elseif p682:_shouldAbort(p683, p684) then
				if p683 == p682.generation then
					p682:_setStatus("Waiting for another automation")
				end
			else
				local autoMutate, v2098 = p682.coordinator:tryAcquire("auto_mutate", { v2096.uid })

				if autoMutate then
					p682:_applyTarget(v2096, p683, p684)
					p682.coordinator:release(autoMutate)
				else
					p682:_setStatus(v2098 or "Waiting for another automation")
				end
			end
		end

		p682.running = false

		if p683 == p682.generation then
			p682:_emit()
		end

		if p682.config.enabled and not p682.destroyed and not p684 then
			task.delay(0.9, function()
				p682:_schedule()
			end)
		end
	end
	t93._schedule = function(p685, p686)
		if p685.destroyed or p685.running or not p685.config.enabled and not p686 then
			return
		end

		local generation = p685.generation

		task.defer(function()
			local ok, result = xpcall(p685._run, debug.traceback, p685, generation, p686 == true)

			if not ok then
				p685.running = false
				p685.coordinator:forceRelease("auto_mutate")
				p685:_setStatus("Mutation runtime error")
				warn("[SAE][AutoMutate] " .. tostring(result))

				if p685.config.enabled and not p685.destroyed then
					task.delay(0.9, function()
						p685:_schedule()
					end)
				end
			end
		end)
	end
	t93.setEnabled = function(p687, p688)
		p687.config.enabled = p688 == true
		zeroinConfig.AutoMutate = p687.config.enabled
		p687.generation += 1
		p687:_setStatus(p687.config.enabled and "Scanning placed eggs" or "Disabled")

		if p687.config.enabled then
			p687:_schedule()
		else
			p687.coordinator:forceRelease("auto_mutate")
		end
	end
	t93.setMutationType = function(p689, p690)
		if table.find(t92, p690) then
			p689.config.mutationType = p690
		end

		zeroinConfig.AutoMutateType = p689.config.mutationType
		p689.manualConfirmation = nil
		p689.successHoldUntil = 0
		p689.generation += 1
		p689:_emit()
		p689:_schedule()

		return p689.config.mutationType
	end
	t93.setRarities = function(p691, p692)
		local t103 = {}
		local ipairs_ = ipairs
		local v2104 = type(p692) == "table" and p692 or { p692 }

		for _, v in ipairs_(v2104) do
			if type(v) == "string" and v ~= "" and not table.find(t103, v) then
				t103[#t103 + 1] = v
			end
		end

		p691.config.rarities = table.find(t103, "All") and { "All" } or #t103 > 0 and t103 or { "All" }
		zeroinConfig.AutoMutateRarities = table.clone(p691.config.rarities)
		p691.manualConfirmation = nil
		p691.successHoldUntil = 0
		p691.generation += 1
		p691:_emit()
		p691:_schedule()

		return table.clone(p691.config.rarities)
	end
	t93.setNames = function(p693, p694)
		local v2107 = p693:getPlacedEggNames()
		local names = {}
		local ipairs_ = ipairs
		local v2110 = type(p694) == "table" and p694 or { p694 }

		for _, v in ipairs_(v2110) do
			if table.find(v2107, v) and not table.find(names, v) then
				names[#names + 1] = v
			end
		end

		p693.config.names = names
		zeroinConfig.AutoMutateNames = table.clone(names)
		p693.manualConfirmation = nil
		p693.successHoldUntil = 0
		p693.generation += 1
		p693:_emit()
		p693:_schedule()

		return table.clone(names)
	end
	t93.setMinValue = function(p695, p696)
		p695.config.minValuePerSec = math.max(tonumber(p696) or 0, 0)
		zeroinConfig.AutoMutateMinValue = p695.config.minValuePerSec
		p695.manualConfirmation = nil
		p695.successHoldUntil = 0
		p695.generation += 1
		p695:_emit()
		p695:_schedule()

		return p695.config.minValuePerSec
	end
	t93.requestOnce = function(p697)
		if p697.running then
			return false, "Auto Consume Mutation is busy"
		end

		local v2113 = p697:_eligibleTargets()[1]

		if not v2113 then
			p697.manualConfirmation = nil
			p697:_setStatus(p697:_noTargetReason())

			return false
		end

		local v2114 = table.concat({
			p697.config.mutationType,
			v2113.uid
		}, ":")
		local manualConfirmation = p697.manualConfirmation

		if manualConfirmation and not (manualConfirmation.signature ~= v2114 or manualConfirmation.expiresAt < os.clock()) then
			p697.manualConfirmation = nil
			p697.generation += 1
			p697:_schedule(true)

			return true
		end

		p697.manualConfirmation = {
			signature = v2114,
			expiresAt = os.clock() + 8
		}
		p697:_setStatus(string.format("Ready: %s -> %s ($%s/s) - press again", p697.config.mutationType, v2113.name, t20.formatMoneyShort(v2113.rate)))

		return false, "Press again within 8 seconds to confirm"
	end
	t93.getSnapshot = function(p698)
		return p698:_snapshot()
	end
	t93.destroy = function(p699)
		if p699.destroyed then
			return
		end

		p699.destroyed = true
		p699.config.enabled = false
		p699.generation += 1
		p699.coordinator:forceRelease("auto_mutate")

		for _, resource in ipairs(p699.resources) do
			v1999(resource)
		end

		table.clear(p699.resources)
		table.clear(p699.listeners)
	end

	return t93
end

local v2118 = v1987()

local function v2119()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local LocalPlayer2 = Players2.LocalPlayer
	local t104 = {}

	t104.__index = t104

	local vector32 = Vector3.new(8, 1, 8)

	t104.new = function()
		local obj = setmetatable({}, t104)

		obj.enabled = zeroinConfig.AutoCaptureEgg == true
		obj.destroyed = false
		obj.running = false
		obj.worker = nil
		obj.hoverPad = nil
		obj.hoverOrigin = nil
		obj.status = "Off"
		obj.changeCallbacks = {}
		obj.connections = {}
		obj:_bindSignals()

		if obj.enabled then
			obj:setEnabled(true)
		end

		return obj
	end
	t104.onChanged = function(p700, p701)
		if type(p701) == "function" then
			table.insert(p700.changeCallbacks, p701)
		end
	end
	t104._notify = function(p702, p703, p704)
		local t105 = {
			enabled = p702.enabled,
			status = p702.status,
			title = p703 or "Capture The Egg: " .. p702.status,
			content = p704 or "Waiting for event..."
		}

		for _, changeCallback in ipairs(p702.changeCallbacks) do
			pcall(changeCallback, t105)
		end
	end
	t104.isEventActive = function()
		return workspace:GetAttribute("Event_CaptureTheEgg") == true or workspace:GetAttribute("Event_CaptureTheEggGameplay") == true or workspace:GetAttribute("Event_CaptureTheEggUid") ~= nil
	end
	t104.getEventEggUid = function()
		local attribute = workspace:GetAttribute("Event_CaptureTheEggUid")

		if attribute and attribute ~= "" then
			return tostring(attribute)
		end

		local ok, result = pcall(function()
			return require(ReplicatedStorage2.Data.CaptureTheEgg)
		end)

		if ok and result and result.EggUidAttribute then
			local attribute2 = workspace:GetAttribute(result.EggUidAttribute)

			if attribute2 and attribute2 ~= "" then
				return tostring(attribute2)
			end
		end

		return nil
	end
	t104.isCarryingEventEgg = function(p705)
		local ok, result = pcall(function()
			return require(ReplicatedStorage2.Client.EggState)
		end)

		if not ok or not result then
			return false
		end

		local ReadLocalState = result.ReadLocalState and result.ReadLocalState()
		local v2136 = p705:getEventEggUid()

		if ReadLocalState and ReadLocalState.IsCarrying then
			if v2136 and ReadLocalState.Uid == v2136 then
				return true
			end

			if not v2136 then
				return true
			end
		end

		if v2136 then
			local v2137 = result.ReadFieldEgg(v2136)

			if v2137 and v2137.CarrierUserId == LocalPlayer2.UserId then
				return true
			end
		end

		return false
	end
	t104.isEngaged = function(p706)
		return not p706.destroyed and p706.enabled and p706:isEventActive()
	end
	t104._ensureHoverPad = function(p707, p708)
		if p707.hoverPad and p707.hoverPad.Parent then
			p707.hoverPad.CFrame = cFrameNew(p708.X, p708.Y - 3, p708.Z)
		else
			local Part = Instance.new("Part")

			Part.Name = "__CaptureHoverPad"
			Part.Size = vector32
			Part.Anchored = true
			Part.CanCollide = true
			Part.Transparency = 1
			Part.CFrame = cFrameNew(p708.X, p708.Y - 3, p708.Z)
			Part.Parent = workspace
			p707.hoverPad = Part
		end

		return p707.hoverPad
	end
	t104._destroyHoverPad = function(p709)
		if p709.hoverPad then
			pcall(p709.hoverPad.Destroy, p709.hoverPad)
			p709.hoverPad = nil
		end
	end
	t104._startWorker = function(p710)
		if p710.worker then
			return
		end

		p710.running = true
		p710.worker = task.spawn(function()
			while not p710.destroyed and p710.enabled do
				if p710:isEventActive() then
					local Character = LocalPlayer2.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

					if HumanoidRootPart and Humanoid and not (Humanoid.Health <= 0) then
						local v2142 = p710:getEventEggUid()

						if p710:isCarryingEventEgg() then
							if not p710.hoverOrigin then
								p710.hoverOrigin = Vector3.new(HumanoidRootPart.Position.X, math.max(HumanoidRootPart.Position.Y, 71) + 45, HumanoidRootPart.Position.Z)
							end

							local Y = p710.hoverOrigin.Y
							local v2144 = os.clock() * 0.35
							local vector33 = Vector3.new(p710.hoverOrigin.X + math.cos(v2144) * 12, Y, p710.hoverOrigin.Z + math.sin(v2144) * 12)

							p710:_ensureHoverPad(vector33)
							HumanoidRootPart.AssemblyLinearVelocity = Vector3.zero
							HumanoidRootPart.AssemblyAngularVelocity = Vector3.zero
							HumanoidRootPart.CFrame = cFrameNew(vector33)
							p710.status = "Holding Egg (+45 studs)"
							p710:_notify("Holding Event Egg 🏆", string.format("Hovering at safe altitude (+45 studs) · Timer ticking up!"))
							task.wait(0.05)
						else
							p710:_destroyHoverPad()
							p710.hoverOrigin = nil

							local ok, result = pcall(function()
								return require(ReplicatedStorage2.Client.EggState)
							end)
							local v2148 = ok and v2142 and result.ReadFieldEgg(v2142)

							if v2148 and v2148.CarrierUserId and v2148.CarrierUserId ~= LocalPlayer2.UserId then
								local playerByUserId = Players2:GetPlayerByUserId(v2148.CarrierUserId)
								local Character2 = playerByUserId and playerByUserId.Character
								local HumanoidRootPart2 = Character2 and Character2:FindFirstChild("HumanoidRootPart")

								if HumanoidRootPart2 then
									p710.status = "Attacking Carrier"
									p710:_notify("Attacking Carrier ⚔️", string.format("Chasing %s to force drop the egg!", playerByUserId.DisplayName or playerByUserId.Name))

									local v2152 = HumanoidRootPart2.Position - HumanoidRootPart.Position
									local Magnitude = v2152.Magnitude

									if Magnitude > 7 then
										HumanoidRootPart.CFrame = cFrameNew(HumanoidRootPart.Position + v2152.Unit * math.min(Magnitude - 4, 4.25), HumanoidRootPart2.Position)
									else
										HumanoidRootPart.CFrame = cFrameNew(HumanoidRootPart2.Position + Vector3.new(0, 2, 0))

										if genv.__ZeroinGodMode then
											local v2154 = genv.__ZeroinGodMode:_equipBat()

											if v2154 then
												genv.__ZeroinGodMode:_swing(v2154, HumanoidRootPart2)
											end
										end
									end
								else
									p710.status = "Tracking Carrier"
									p710:_notify("Tracking Carrier...", "Carrier is moving or respawning")
								end

								task.wait(0.05)
							else
								p710.status = "Securing Egg"
								p710:_notify("Securing Event Egg ⚡", "Flying to egg to snatch it!")

								local v2155

								if v2148 and v2148.BottomCFrame then
									v2155 = v2148.BottomCFrame.Position + Vector3.new(0, 3, 0)
								else
									local CaptureTheEggSpawn = workspace:FindFirstChild("CaptureTheEggSpawn", true) or workspace:FindFirstChild("AdminAbuseEggSpawn", true)

									if CaptureTheEggSpawn and CaptureTheEggSpawn:IsA("BasePart") then
										v2155 = CaptureTheEggSpawn.Position + Vector3.new(0, 3, 0)
									end
								end

								if v2155 then
									local v2157 = v2155 - HumanoidRootPart.Position
									local Magnitude = v2157.Magnitude

									if Magnitude > 6 then
										HumanoidRootPart.CFrame = cFrameNew(HumanoidRootPart.Position + v2157.Unit * math.min(Magnitude, 4.5))
									else
										HumanoidRootPart.CFrame = cFrameNew(v2155)

										local Remotes = require(ReplicatedStorage2.Shared.Remotes)

										if Remotes and Remotes.EggWorld and Remotes.EggWorld.AskFieldEggCarry then
											pcall(function()
												Remotes.EggWorld.AskFieldEggCarry:InvokeServer({
													Uid = v2142
												})
											end)
										end
									end
								end

								task.wait(0.05)
							end
						end
					else
						p710:_destroyHoverPad()
						task.wait(0.5)
					end
				else
					p710:_destroyHoverPad()
					p710.hoverOrigin = nil
					p710.status = "Waiting for event"
					p710:_notify("Capture The Egg Event", "Waiting for event to begin...")
					task.wait(1)
				end
			end

			p710:_destroyHoverPad()
			p710.running = false
			p710.worker = nil
		end)
	end
	t104.setEnabled = function(p711, p712)
		local enabled = p712 == true

		if p711.enabled == enabled and p711.worker then
			return
		end

		p711.enabled = enabled
		zeroinConfig.AutoCaptureEgg = enabled

		if enabled then
			p711:_startWorker()
		else
			if p711.worker then
				pcall(task.cancel, p711.worker)
				p711.worker = nil
			end

			p711:_destroyHoverPad()
			p711.hoverOrigin = nil
			p711.running = false
			p711.status = "Off"
			p711:_notify("Capture The Egg Event", "Auto Capture is disabled")
		end
	end
	t104._bindSignals = function(p713)
		pcall(function()
			table.insert(p713.connections, workspace:GetAttributeChangedSignal("Event_CaptureTheEgg"):Connect(function()
				if p713.enabled then
					if not p713.destroyed then
						p713:_startWorker()
					end
				end
			end))
			table.insert(p713.connections, workspace:GetAttributeChangedSignal("Event_CaptureTheEggGameplay"):Connect(function()
				if p713.enabled and not p713.destroyed then
					p713:_startWorker()
				end
			end))
			table.insert(p713.connections, workspace:GetAttributeChangedSignal("Event_CaptureTheEggUid"):Connect(function()
				if p713.enabled and not p713.destroyed then
					p713:_startWorker()
				end
			end))
		end)
	end
	t104.destroy = function(p714)
		if p714.destroyed then
			return
		end

		p714.destroyed = true
		p714:setEnabled(false)

		for _, connection4 in ipairs(p714.connections) do
			pcall(connection4.Disconnect, connection4)
		end

		table.clear(p714.connections)
		p714:_destroyHoverPad()
	end

	return t104
end

local v2163 = v2119()

local function v2164()
	local Players2 = game:GetService("Players")
	local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
	local LocalPlayer2 = Players2.LocalPlayer
	local Remotes = require(ReplicatedStorage2.Shared.Remotes)
	local PlotState2 = require(ReplicatedStorage2.Client.PlotState)
	local t106 = {}

	t106.__index = t106
	t106.new = function(p715, p716)
		local obj = setmetatable({}, t106)

		obj.coordinator = p715
		obj.travel = p716
		obj.destroyed = false
		obj.listeners = {}
		obj.resources = {}
		obj.config = {
			disableDuringAutomation = true,
			idleFarm = false
		}
		obj.stats = {
			mode = "Idle",
			boost = "Waiting"
		}
		obj.busy = p715 and p715:getSnapshot().busy == true or false
		obj.idleGeneration = 0
		obj.lastEquipAt = 0
		obj.activeTreadmill = nil
		obj.travelingToTreadmill = false
		obj.treadmillEquipPending = false
		obj.unequipGuardRunning = false
		obj.backgroundYieldRunning = false
		obj.lastBackgroundYieldAt = 0
		obj.treadmillStateRevision = 0
		obj:_listenActiveTreadmill()
		obj:_syncActiveTreadmillSnapshot()
		obj:_listenCoordinator()
		obj:_listenSpeedGain()

		return obj
	end
	t106._snapshot = function(p717)
		return {
			mode = p717.stats.mode,
			boost = p717.stats.boost,
			disableDuringAutomation = p717.config.disableDuringAutomation,
			idleFarm = p717.config.idleFarm
		}
	end
	t106._emit = function(p718)
		local v2172 = p718:_snapshot()

		for _, listener in ipairs(p718.listeners) do
			pcall(listener, v2172)
		end
	end
	t106._setStatus = function(p719, p720, p721)
		if p720 ~= nil then
			p719.stats.mode = p720
		end

		if p721 ~= nil then
			p719.stats.boost = p721
		end

		p719:_emit()
	end
	t106.subscribe = function(p722, p723)
		table.insert(p722.listeners, p723)
		pcall(p723, p722:_snapshot())

		return function()
			local v2175 = table.find(p722.listeners, p723)

			if v2175 then
				table.remove(p722.listeners, v2175)
			end
		end
	end
	t106._requestUnequip = function()
		local ok, result, result2 = pcall(function()
			return Remotes.Treadmill.AskDoff:InvokeServer()
		end)

		if not ok then
			return false, tostring(result)
		end

		if result == false then
			return false, tostring(result2 or "Server rejected")
		end

		return true
	end

	local s3 = "_shouldBlockTreadmill"

	local function v2180(p724)
		local v2181 = not p724.destroyed

		return v2181 and p724.busy and p724.config.disableDuringAutomation
	end

	t106[s3] = v2180
	t106._startUnequipGuard = function(p725)
		if p725.unequipGuardRunning or not p725:_shouldBlockTreadmill() or p725.activeTreadmill == nil then
			return
		end

		p725.unequipGuardRunning = true
		task.spawn(function()
			local n33 = 0.15

			while p725:_shouldBlockTreadmill() do
				if p725.activeTreadmill == nil then
					break
				end

				local v2183, v2184 = p725:_requestUnequip()

				p725:_setStatus("Automation active", v2183 and "Blocked" or "Release retry: " .. tostring(v2184))
				task.wait(n33)
				n33 = math.min(n33 * 2, 0.75)
			end

			p725.unequipGuardRunning = false

			if p725:_shouldBlockTreadmill() and p725.activeTreadmill ~= nil then
				p725:_startUnequipGuard()
			end
		end)
	end
	t106._cancelIdle = function(p726, p727)
		p726.idleGeneration += 1

		local idleGeneration = p726.idleGeneration

		if p727 then
			p726:_requestUnequip()
		end

		task.delay(0.5, function()
			if not p726.destroyed and not p726.busy then
				if p726.config.idleFarm and p726.idleGeneration == idleGeneration then
					p726:_startIdle()
				end
			end
		end)
	end
	t106.setDisableDuringAutomation = function(p728, p729)
		p728.config.disableDuringAutomation = p729 == true

		if p728.busy and p728.config.disableDuringAutomation then
			p728:_cancelIdle(true)
			p728:_startUnequipGuard()
			p728:_setStatus("Automation active", "Blocked")
		elseif not p728.busy and p728.config.idleFarm then
			p728:_startIdle()
		end
	end
	t106.setIdleFarm = function(p730, p731)
		p730.config.idleFarm = p731 == true

		if not p730.config.idleFarm then
			p730:_cancelIdle(true)
			p730:_setStatus(p730.busy and "Automation active" or "Idle", "Disabled")
		elseif not p730.busy then
			p730:_startIdle()
		end
	end
	t106.setCaptureTheEggRuntime = function(p732, p733)
		p732.captureTheEggRuntime = p733
	end
	t106._resolveStandCFrame = function()
		local v2186 = PlotState2.ResolveLocalSlot()
		local v2187 = PlotState2.ResolveFolder()
		local v2188 = v2187 and v2186 and v2187:FindFirstChild(tostring(v2186))
		local TreadmillBottom = v2188 and v2188:FindFirstChild("TreadmillBottom")

		if not TreadmillBottom or not TreadmillBottom:IsA("BasePart") then
			return nil
		end

		local Character = LocalPlayer2.Character
		local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
		local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")

		if not HumanoidRootPart or not Humanoid then
			return nil
		end

		local v2193

		if Humanoid.RigType == Enum.HumanoidRigType.R15 then
			v2193 = HumanoidRootPart.Size.Y * 0.5 + math.max(Humanoid.HipHeight, 0.5)
		else
			v2193 = HumanoidRootPart.Size.Y * 0.5 + 2
		end

		return TreadmillBottom.CFrame * cFrameNew(0, TreadmillBottom.Size.Y * 0.5 + v2193 + 0.05, 0)
	end
	t106.isEngaged = function(p734)
		return p734.activeTreadmill ~= nil or p734.travelingToTreadmill or p734.treadmillEquipPending
	end
	t106.yieldForBackground = function(p735)
		if p735.destroyed then
			return
		end

		p735:_cancelIdle(false)

		if p735.backgroundYieldRunning then
			return
		end

		p735.backgroundYieldRunning = true
		task.spawn(function()
			local n34 = 0.15

			while not p735.destroyed do
				if p735.coordinator and p735.coordinator:isBackgroundBusy() then
					p735.lastBackgroundYieldAt = os.clock()
					p735:_setStatus("Idle", "Yielding to background inventory")
					p735:_requestUnequip()
					task.wait(n34)

					if p735:_syncActiveTreadmillSnapshot() then
						n34 = math.min(n34 * 2, 0.75)

						continue
					end
				end

				break
			end

			p735.backgroundYieldRunning = false

			if not p735.destroyed and not p735:isEngaged() then
				p735:_setStatus("Idle", "Background inventory ready")
			end
		end)
	end
	t106._startIdle = function(p736)
		if p736.destroyed or p736.busy or not p736.config.idleFarm then
			return
		end

		p736.idleGeneration += 1

		local idleGeneration = p736.idleGeneration
		local now = os.clock()

		task.spawn(function()
			local ok, result = xpcall(function()
				while not p736.destroyed and not p736.busy and p736.config.idleFarm and idleGeneration == p736.idleGeneration do
					if p736.captureTheEggRuntime and type(p736.captureTheEggRuntime.isEngaged) == "function" then
						if p736.captureTheEggRuntime:isEngaged() then
							now = os.clock()
							p736:_setStatus("Idle", "Yielding to Capture The Egg")
							task.wait(0.25)

							continue
						end
					end

					if p736.coordinator then
						if p736.coordinator:isBackgroundBusy() then
							now = os.clock()
							p736:_setStatus("Idle", "Waiting for background inventory")
							task.wait(0.25)

							continue
						end
					end

					if p736.eggRuntime and p736.eggRuntime.enabled and not p736.eggRuntime.resetBlocked then
						local v2199 = false

						if p736.eggRuntime.records then
							for _, record in pairs(p736.eggRuntime.records) do
								if p736.eggRuntime:_matches(record) then
									v2199 = true

									break
								end
							end
						end

						if v2199 then
							now = os.clock()
							p736:_setStatus("Idle", "Yielding to Auto Steal")
							task.wait(0.25)

							continue
						end
					end

					if genv.__ZeroinIsAutoSellEggBusy and genv.__ZeroinIsAutoSellEggBusy() then
						now = os.clock()
						p736:_setStatus("Idle", "Waiting for Auto Sell Egg")
						task.wait(0.25)
					else
						local v2202 = 1 - (os.clock() - now)

						if v2202 > 0 then
							p736:_setStatus("Idle", string.format("Starting in %.0fs", math.ceil(v2202)))
							task.wait(math.min(v2202, 0.25))
						else
							local v2203 = p736:_resolveStandCFrame()

							if v2203 then
								p736.travelingToTreadmill = true
								p736:_setStatus("Moving", "Waiting")

								local travel = p736.travel and p736.travel:travelAndWait(v2203, {
									abort = function()
										local destroyed = p736.destroyed or p736.busy

										return destroyed or not p736.config.idleFarm or idleGeneration ~= p736.idleGeneration or p736.coordinator and p736.coordinator:isBackgroundBusy() or genv.__ZeroinIsAutoSellEggBusy and genv.__ZeroinIsAutoSellEggBusy()
									end
								})

								p736.travelingToTreadmill = false

								if not travel then
									if not p736.busy and p736.config.idleFarm then
										p736:_setStatus("Idle", "Travel failed")
										task.wait(1)
									end
								elseif not p736.busy and p736.config.idleFarm and idleGeneration == p736.idleGeneration then
									if p736.coordinator then
										if p736.coordinator:isBackgroundBusy() then
											continue
										end
									end

									if not genv.__ZeroinIsAutoSellEggBusy or not genv.__ZeroinIsAutoSellEggBusy() then
										task.wait(0.35)

										if not p736.busy and p736.config.idleFarm then
											if idleGeneration == p736.idleGeneration then
												if p736.coordinator then
													if p736.coordinator:isBackgroundBusy() then
														continue
													end
												end

												if not genv.__ZeroinIsAutoSellEggBusy or not genv.__ZeroinIsAutoSellEggBusy() then
													p736.treadmillEquipPending = true

													local ok3, result, result2 = pcall(function()
														return Remotes.Treadmill.AskWearStill:InvokeServer()
													end)

													if ok3 and result ~= false then
														p736.lastEquipAt = os.clock()
														p736:_setStatus("Active", "Waiting for gain")
														task.delay(2, function()
															if not p736.destroyed and p736.activeTreadmill == nil then
																p736.treadmillEquipPending = false
															end
														end)
													else
														p736.treadmillEquipPending = false
														p736:_setStatus("Preparing carry", "Activation failed: " .. tostring(result2 or result))
													end

													local v2209 = os.clock() + 8

													while (p736.activeTreadmill ~= nil or os.clock() < v2209) and not p736.destroyed and not p736.busy and p736.config.idleFarm and idleGeneration == p736.idleGeneration do
														local ok2 = not p736.coordinator

														if not ok2 then
															ok2 = not p736.coordinator:isBackgroundBusy()
														end

														if not ok2 then
															break
														end

														local ok = not (not not p736.captureTheEggRuntime and type(p736.captureTheEggRuntime.isEngaged) == "function")

														if not ok then
															ok = not p736.captureTheEggRuntime:isEngaged()
														end

														if not ok then
															p736:_cancelIdle(true)
															p736:_setStatus("Idle", "Yielding to Capture The Egg")

															break
														end

														if not p736.eggRuntime or not p736.eggRuntime.enabled or p736.eggRuntime.resetBlocked then
															if genv.__ZeroinIsAutoSellEggBusy and genv.__ZeroinIsAutoSellEggBusy() then
																p736:_cancelIdle(true)
																p736:_setStatus("Idle", "Yielding to Auto Sell Egg")

																break
															end

															task.wait(0.25)

															continue
														end

														local v2212 = false

														if p736.eggRuntime.records then
															for _, record in pairs(p736.eggRuntime.records) do
																if p736.eggRuntime:_matches(record) then
																	v2212 = true

																	break
																end
															end
														end

														if v2212 then
															p736:_cancelIdle(true)
															p736:_setStatus("Idle", "Yielding to Auto Steal")

															break
														end

														if genv.__ZeroinIsAutoSellEggBusy and genv.__ZeroinIsAutoSellEggBusy() then
															p736:_cancelIdle(true)
															p736:_setStatus("Idle", "Yielding to Auto Sell Egg")

															break
														end

														task.wait(0.25)
													end
												end
											end
										end
									end
								end
							else
								p736:_setStatus("Idle", "Position unavailable")
								task.wait(2)
							end
						end
					end
				end
			end, debug.traceback)

			if not ok then
				warn("[SAE][treadmill] idle error:\n" .. tostring(result))
			end
		end)
	end
	t106._onCoordinator = function(p737, p738)
		local busy = p737.busy

		p737.busy = p738.busy == true

		if p737.busy then
			p737:_cancelIdle(p737.config.disableDuringAutomation)
			p737:_startUnequipGuard()
			p737:_setStatus("Automation active", p737.config.disableDuringAutomation and "Blocked" or "Unchanged")
		elseif busy then
			if p737.config.idleFarm then
				p737:_startIdle()
			else
				p737:_setStatus("Idle", "Disabled")
			end
		end
	end
	t106._listenCoordinator = function(p739)
		if not p739.coordinator then
			return
		end

		table.insert(p739.resources, p739.coordinator:subscribe(function(p740)
			p739:_onCoordinator(p740)
		end))
		table.insert(p739.resources, p739.coordinator:subscribeBackground(function(p741)
			if p741.busy then
				p739:_cancelIdle(false)
				p739:_setStatus("Idle", "Waiting for background inventory")
			elseif not p739.destroyed and not p739.busy and p739.config.idleFarm then
				p739:_startIdle()
			end
		end))
	end
	t106._syncActiveTreadmillSnapshot = function(p742)
		local ok, result, treadmillStateRevision = pcall(function()
			return Remotes.Treadmill.AskRenderSnapshot:InvokeServer()
		end)

		if not ok or type(result) ~= "table" then
			return p742.activeTreadmill ~= nil
		end

		if type(treadmillStateRevision) == "number" and treadmillStateRevision < p742.treadmillStateRevision then
			return p742.activeTreadmill ~= nil
		end

		local v2219 = table.find(result, LocalPlayer2.UserId) ~= nil

		if type(treadmillStateRevision) == "number" then
			p742.treadmillStateRevision = treadmillStateRevision
		end

		p742.activeTreadmill = v2219 and "snapshot" or nil

		if not v2219 then
			p742.treadmillEquipPending = false
		end

		return v2219
	end
	t106._listenActiveTreadmill = function(p743)
		local RenderStateShifted = Remotes.Treadmill.RenderStateShifted

		if RenderStateShifted then
			table.insert(p743.resources, RenderStateShifted.OnClientEvent:Connect(function(p744, p745, p746)
				if p744 ~= LocalPlayer2 or type(p745) ~= "boolean" then
					return
				end

				if type(p746) == "number" and p746 <= p743.treadmillStateRevision then
					return
				end

				p743.treadmillStateRevision = type(p746) == "number" and p746 or p743.treadmillStateRevision + 1
				p743.activeTreadmill = p745 and true or nil
				p743.treadmillEquipPending = false

				if p745 and p743:_shouldBlockTreadmill() then
					p743:_startUnequipGuard()
				elseif not p745 and p743:_shouldBlockTreadmill() then
					p743:_setStatus("Automation active", "Blocked")
				elseif not p745 then
					p743:_setStatus("Idle", p743.config.idleFarm and "Released" or "Disabled")
				elseif not p743.busy then
					p743:_setStatus("Active", "Waiting for gain")
				end
			end))
		end
	end
	t106._listenSpeedGain = function(p747)
		local SpeedGained = Remotes.Treadmill.SpeedGained

		if SpeedGained then
			table.insert(p747.resources, SpeedGained.OnClientEvent:Connect(function(p748, p749)
				if p749 ~= "Treadmill" then
					return
				end

				p747.activeTreadmill = p747.activeTreadmill or true
				p747.treadmillEquipPending = false

				if p747:_shouldBlockTreadmill() then
					p747:_startUnequipGuard()

					return
				end

				p747:_setStatus("Active", "Gain ticking")
			end))
		end
	end
	t106.destroy = function(p750)
		if p750.destroyed then
			return
		end

		p750.destroyed = true
		p750:_cancelIdle(true)

		for _, resource in ipairs(p750.resources) do
			pcall(function()
				if typeof(resource) == "RBXScriptConnection" then
					resource:Disconnect()
				elseif type(resource) == "function" then
					resource()
				elseif type(resource) == "table" and type(resource.Disconnect) == "function" then
					resource:Disconnect()
				end
			end)
		end

		table.clear(p750.resources)
		table.clear(p750.listeners)
	end
	t106.Destroy = t106.destroy

	return t106
end

local v2224 = v2164()
local v2225 = v592.new()

v2225:subscribe(function(p751)
	local operation = p751.operation

	zeroinConfig.IsStealing = operation == "auto_steal"
	zeroinConfig.IsRiftTrading = operation == "auto_the_rift"

	local __ZeroinScrambleRuntime = genv.__ZeroinScrambleRuntime

	zeroinConfig.IsScrambleFarming = operation == "auto_dr_scramble" or __ZeroinScrambleRuntime and __ZeroinScrambleRuntime.locked == true or false
end)

local v2228 = v1326.new(v630, v2225, true)

genv.__ZeroinEggRuntime = v2228

local function v2229()
	local t107 = {}

	t107.__index = t107
	t107.new = function()
		local obj = setmetatable({}, t107)

		obj.destroyed = false

		return obj
	end
	t107.setRiftObjective = function(p752, p753, p754)
		table.clear(zeroinConfig.RiftObjectiveCategories)

		if p753 then
			local ipairs_ = ipairs
			local v2233 = p754 or {}

			for _, v in ipairs_(v2233) do
				zeroinConfig.RiftObjectiveCategories[v] = (zeroinConfig.RiftObjectiveCategories[v] or 0) + 1
			end

			if t20.AutoPlaceLoop then
				task.spawn(t20.AutoPlaceLoop)
			end

			if t20.AutoHatchLoop then
				task.spawn(t20.AutoHatchLoop)
			end
		end
	end
	t107.destroy = function(p755)
		p755.destroyed = true
		table.clear(zeroinConfig.RiftObjectiveCategories)
	end

	return t107
end

local v2236 = v2229().new()
local v2237 = v1585.new(v2225, v2228, v2236, v2228)

v2237:setTargetPrize(zeroinConfig.RiftTargetPrize)

local v2238 = v1774.new(v2228)

v2228:setDrScrambleRuntime(v2238)
genv.__ZeroinRiftRuntime = v2237
genv.__ZeroinScrambleRuntime = v2238
v2238:setEnabled(zeroinConfig.AutoScramble == true)
v2238:setShopItems(zeroinConfig.ScrambleShopItems)
v2238:setShopAmount(zeroinConfig.ScrambleShopAmount)
v2238:setShopInterval(zeroinConfig.ScrambleShopInterval)
v2238:setAutoBuy(zeroinConfig.AutoBuyScrambleShop == true)
v2228:setRiftRuntime(v2237)

local v2239 = v2163.new()

genv.__ZeroinCaptureTheEggRuntime = v2239
v2228:setCaptureTheEggRuntime(v2239)

local v2240 = v2224.new(v2225, v2228)

genv.__ZeroinTreadmillManager = v2240
v2228:setTreadmillManager(v2240)
v2240:setCaptureTheEggRuntime(v2239)

if zeroinConfig.AutoTreadmillIdle then
	v2240:setIdleFarm(true)
end

local v2241 = v1986.new(v2225, v2228, v2240, v2239)

genv.__ZeroinFuseRuntime = v2241
v2241:setPriority(zeroinConfig.AutoFusePriority)
v2241:setRarities(zeroinConfig.AutoFuseRarities)
v2241:setKeepPerCategory(zeroinConfig.AutoFuseKeepPerPet)
v2241:setMaxWeightKg(zeroinConfig.AutoFuseMaxWeightKg)
v2241:setEnabled(zeroinConfig.AutoFuse == true)

local v2242 = v2118.new(v2225, v2228, v2240, v2239)

genv.__ZeroinAutoMutateRuntime = v2242

local v2243 = zeroinConfig.AutoMutate == true

zeroinConfig.AutoMutate = false
v2242:setMutationType(zeroinConfig.AutoMutateType)
v2242:setRarities(zeroinConfig.AutoMutateRarities)
v2242:setNames(zeroinConfig.AutoMutateNames)
v2242:setMinValue(zeroinConfig.AutoMutateMinValue)
v2242:setEnabled(v2243)

local v2244 = v1376.new(v2228)

v2244:install()
v2244:setEnabled(zeroinConfig.AntiGuardKnockback == true)
genv.__ZeroinAntiGuard = v2244
v2228.antiGuard = v2244

local v2245 = v1436.new(v2228)

v2245:setEnabled(zeroinConfig.GodMode == nil and true or zeroinConfig.GodMode == true)
genv.__ZeroinGodMode = v2245
v2228:setStealMode((zeroinConfig.StealMode == "Instant" or zeroinConfig.StealMode == "Semi Teleport") and "Instant" or "Tween")
v2228:setSpeed(zeroinConfig.TweenSpeedMultiplier or 80)
v2228:setStealZigzag(zeroinConfig.StealZigzag == true)

if zeroinConfig.StealMinValue and zeroinConfig.StealMinValue > 0 then
	v2228:setMinValuePerSec(zeroinConfig.StealMinValue)
end

if zeroinConfig.StealAreas and not table.find(zeroinConfig.StealAreas, "None") and #zeroinConfig.StealAreas > 0 then
	local t108 = {}

	for _, stealArea in ipairs(zeroinConfig.StealAreas) do
		if stealArea ~= "None" then
			table.insert(t108, stealArea == "Angels & Demons" and "Light Dark" or stealArea)
		end
	end

	v2228:setFilter("areas", t108)
	v2228:setFilterEnabled("area", #t108 > 0)
end

if zeroinConfig.StealRarities and not table.find(zeroinConfig.StealRarities, "None") and #zeroinConfig.StealRarities > 0 then
	local t109 = {}

	for _, stealRarity in ipairs(zeroinConfig.StealRarities) do
		if stealRarity ~= "None" then
			table.insert(t109, stealRarity)
		end
	end

	v2228:setFilter("rarities", t109)
	v2228:setFilterEnabled("rarity", #t109 > 0)
end

if zeroinConfig.StealNamesFilter and not table.find(zeroinConfig.StealNamesFilter, "None") and #zeroinConfig.StealNamesFilter > 0 then
	local t110 = {}

	for _, v in ipairs(zeroinConfig.StealNamesFilter) do
		if v ~= "None" then
			table.insert(t110, v)
		end
	end

	v2228:setFilter("names", t110)
	v2228:setFilterEnabled("name", #t110 > 0)
end

v2228:markStartupSettled()
v2237:onChanged(function(p756)
	zeroinConfig.AutoRift = p756.enabled == true
	genv.__ZeroinRiftStatus = p756
	table.clear(zeroinConfig.RiftProtectedPetUids)

	local ipairs_ = ipairs
	local protectedUids = v2237.protectedUids or {}

	for _, protectedUid in ipairs_(protectedUids) do
		zeroinConfig.RiftProtectedPetUids[protectedUid] = true
	end
end)

local function v2259(p757)
	zeroinConfig.AutoRift = p757 == true
	v2237:setEnabled(p757)

	if p757 then
		if t20.AutoPlaceLoop then
			task.spawn(t20.AutoPlaceLoop)
		end

		if t20.AutoHatchLoop then
			task.spawn(t20.AutoHatchLoop)
		end
	end
end
local function v2260(p758)
	zeroinConfig.AutoScramble = p758 == true
	v2238:setEnabled(p758)
end
local function v2261(p759)
	zeroinConfig.AutoBuyScrambleShop = p759 == true
	v2238:setAutoBuy(p759)
end

local u2262

local function v2263(p760)
	local v2264 = p760 == true
	local v2265

	if v2228 and type(v2228.setStealFromPlayers) == "function" then
		v2264, v2265 = v2228:setStealFromPlayers(v2264)
	end

	zeroinConfig.StealFromPlayers = v2264 == true

	if not (p760 ~= true or zeroinConfig.StealFromPlayers) then
		task.defer(function()
			if u2262 and u2262.Value == true then
				u2262:Set(false)
			end
		end)
	end

	return zeroinConfig.StealFromPlayers, v2265
end
local function v2266(p761)
	zeroinConfig.DropAtFirstArea = p761 == true

	if v2228 and type(v2228.setDropAtFirstArea) == "function" then
		v2228:setDropAtFirstArea(p761)
	end
end

v2263(zeroinConfig.StealFromPlayers == true)
genv.__ZeroinSetAutoRift = v2259
genv.__ZeroinSetAutoScramble = v2260
genv.__ZeroinSetAutoBuyScrambleShop = v2261
genv.__ZeroinSetStealFromPlayers = v2263
genv.__ZeroinSetDropAtFirstArea = v2266

local function v2267()
	if v2236 then
		v2236:destroy()
	end

	v2237:destroy()
	v2225:forceRelease("auto_the_rift")
	v2225:forceRelease("auto_place")

	if genv.__ZeroinRiftRuntime == v2237 then
		genv.__ZeroinRiftRuntime = nil
	end

	if genv.__ZeroinSetAutoRift == v2259 then
		genv.__ZeroinSetAutoRift = nil
	end

	if genv.__ZeroinRiftCleanup == v2267 then
		genv.__ZeroinRiftCleanup = nil
	end
end

genv.__ZeroinRiftCleanup = v2267
genv.__ZeroinEggRuntimeCleanup = function()
	if v2228 then
		pcall(v2228.destroy, v2228)
	end

	if v2240 then
		pcall(v2240.destroy, v2240)
	end

	if v2239 then
		pcall(v2239.destroy, v2239)
	end

	if genv.__ZeroinEggRuntime == v2228 then
		genv.__ZeroinEggRuntime = nil
	end

	if genv.__ZeroinSetStealFromPlayers == v2263 then
		genv.__ZeroinSetStealFromPlayers = nil
	end

	if genv.__ZeroinSetDropAtFirstArea == v2266 then
		genv.__ZeroinSetDropAtFirstArea = nil
	end

	if genv.__ZeroinTreadmillManager == v2240 then
		genv.__ZeroinTreadmillManager = nil
	end

	if genv.__ZeroinCaptureTheEggRuntime == v2239 then
		genv.__ZeroinCaptureTheEggRuntime = nil
	end
end
genv.__ZeroinAntiGuardCleanup = function()
	if v2244 then
		pcall(v2244.destroy, v2244)
	end

	if v2245 then
		pcall(v2245.destroy, v2245)
	end

	if genv.__ZeroinAntiGuard == v2244 then
		genv.__ZeroinAntiGuard = nil
	end

	if genv.__ZeroinGodMode == v2245 then
		genv.__ZeroinGodMode = nil
	end
end

local function v2268()
	v2238:destroy()
	v2225:forceRelease("auto_dr_scramble")

	if genv.__ZeroinScrambleRuntime == v2238 then
		genv.__ZeroinScrambleRuntime = nil
		genv.__ZeroinSetAutoScramble = nil
		genv.__ZeroinSetAutoBuyScrambleShop = nil
	end

	if genv.__ZeroinScrambleCleanup == v2268 then
		genv.__ZeroinScrambleCleanup = nil
	end
end

genv.__ZeroinScrambleCleanup = v2268

local function v2269()
	v2241:destroy()
	v2225:forceRelease("auto_fuse")

	if genv.__ZeroinFuseRuntime == v2241 then
		genv.__ZeroinFuseRuntime = nil
	end

	genv.__ZeroinFuseStatus = nil

	if genv.__ZeroinFuseCleanup == v2269 then
		genv.__ZeroinFuseCleanup = nil
	end
end

genv.__ZeroinFuseCleanup = v2269

local function v2270()
	v2242:destroy()
	v2225:forceRelease("auto_mutate")

	if genv.__ZeroinAutoMutateRuntime == v2242 then
		genv.__ZeroinAutoMutateRuntime = nil
	end

	genv.__ZeroinAutoMutateStatus = nil

	if genv.__ZeroinAutoMutateCleanup == v2270 then
		genv.__ZeroinAutoMutateCleanup = nil
	end
end

genv.__ZeroinAutoMutateCleanup = v2270

local t111 = {
	Main = function()
		local v2272 = v512:AddTab({
			Name = "Main",
			Icon = "house"
		}):AddSection({
			Title = "Auto Farm",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 2
		})

		v2272:AddToggle({
			Title = "Auto Steal",
			Column = "Left",
			Row = 1,
			Default = zeroinConfig.AutoSteal == true,
			Callback = function(p762)
				zeroinConfig.AutoSteal = p762

				if v2228 then
					v2228:setEnabled(p762)
				end
			end
		})
		v2272:AddToggle({
			Title = "Auto Treadmill",
			Content = "Automatically ride plot treadmill when idle",
			Column = "Right",
			Row = 1,
			Default = zeroinConfig.AutoTreadmillIdle == true,
			Callback = function(p763)
				zeroinConfig.AutoTreadmillIdle = p763

				if v2240 then
					v2240:setIdleFarm(p763)
				end
			end
		})
		v2272:AddToggle({
			Title = "Anti Knock Back",
			Content = "Blocks chicken & guard hits, knockback, and ragdoll",
			Column = "Left",
			Row = 2,
			Default = true,
			Callback = function(p764)
				zeroinConfig.AntiGuardKnockback = p764

				if v2244 then
					v2244:setEnabled(p764)
				end
			end
		})
		v2272:AddToggle({
			Title = "God Mode",
			Content = "Equip bat & spam hit nearby players when egg is dropped",
			Column = "Right",
			Row = 2,
			Default = zeroinConfig.GodMode == nil and true or zeroinConfig.GodMode == true,
			Callback = function(p765)
				zeroinConfig.GodMode = p765

				if v2245 then
					v2245:setEnabled(p765)
				end
			end
		})

		local v2273 = v2272:AddInput({
			Title = "Speed",
			Content = "Auto Steal tween x10 (20 = 200, 80 = 800, 120 = 1200 studs/s)",
			Column = "Left",
			Row = 3,
			Default = tostring(zeroinConfig.TweenSpeedMultiplier or 80),
			Callback = function(p766)
				local v2274 = tonumber(p766)

				if not v2274 then
					v2274 = zeroinConfig.TweenSpeedMultiplier or 80
				end

				v332(v2274)

				if v2228 then
					v2228:setSpeed(v2274)
				end
			end
		})
		local v2275 = v2272
		local AddInput = v2272.AddInput
		local t112 = {
			Title = "Steal By Value",
			Content = "Minimum value; supports k, m, b",
			Column = "Right",
			Row = 3
		}
		local StealMinValueInput = zeroinConfig.StealMinValueInput

		if not StealMinValueInput then
			StealMinValueInput = tostring(zeroinConfig.StealMinValue or 0)
		end

		t112.Default = StealMinValueInput
		t112.Callback = function(p767)
			if zeroinConfig:applyStealValueInput(p767) and v2228 then
				v2228:setMinValuePerSec(zeroinConfig.StealMinValue)
			end
		end
		AddInput(v2275, t112)
		getgenv().__zeroinSetSpeed = function(p768)
			local v2279 = tonumber(p768)

			if v2279 then
				if v2273 and v2273.SetValue then
					pcall(function()
						v2273:SetValue(tostring(v2279))
					end)
				end

				v332(v2279)

				if v2228 then
					v2228:setSpeed(v2279)
				end

				return true
			end

			return false
		end

		local t113 = { "None" }

		if not pcall(function()
			local Directory = require(game:GetService("ReplicatedStorage").Data.Areas).Directory
			local ok, result = pcall(function()
				return require(game:GetService("ReplicatedStorage").Data.Assets)
			end)

			if ok and result and result.Directory then
				local Directory2 = result.Directory
				local t114 = {}

				for _, v in pairs(Directory) do
					if type(v) == "table" and type(v.DropTable) == "table" then
						for _, v2 in ipairs(v.DropTable) do
							local v2290 = v2[1]

							if not (type(v2290) ~= "string" or t114[v2290]) then
								t114[v2290] = true

								local v2291 = Directory2[v2290]

								t113[#t113 + 1] = v2291 and v2291.DisplayName or v2290
							end
						end
					end
				end
			end
		end) or #t113 <= 1 then
			t113 = { "None" }
		end

		table.sort(t113, function(p769, p770)
			if p769 == "None" then
				return true
			end

			if p770 == "None" then
				return false
			end

			return p769 < p770
		end)
		v2272:AddToggle({
			Title = "Steal Zigzag",
			Content = "Return through alternating wall-bounded waypoints before depositing",
			Column = "Full",
			Row = 4,
			Default = zeroinConfig.StealZigzag == true,
			Callback = function(p771)
				zeroinConfig.StealZigzag = p771 == true

				if v2228 then
					v2228:setStealZigzag(zeroinConfig.StealZigzag)
				end
			end
		})
		u2262 = v2272:AddToggle({
			Title = "Steal From Players",
			Content = "Chase and hit players carrying filtered eggs with bat to steal their egg",
			Column = "Full",
			Row = 5,
			Default = zeroinConfig.StealFromPlayers == true,
			Callback = v2263
		})
		v2272:AddToggle({
			Title = "Drop Egg At Forest",
			Content = "Deliver stolen eggs to Forest and drop them instead of returning to Safe Zone",
			Column = "Full",
			Row = 6,
			Default = zeroinConfig.DropAtFirstArea == true,
			Callback = v2266
		})

		local v2292

		v2292 = v2272:AddDropdown({
			Title = "Steal Mode",
			Content = "Tween or Instant (Semi Teleport) using selected egg filters",
			Column = "Full",
			Row = 8,
			Options = {
				"Tween",
				"Instant"
			},
			Default = zeroinConfig.StealMode and { zeroinConfig.StealMode } or { "Tween" },
			Multi = false,
			Callback = function(p772)
				local v2293 = v308(p772, v2292)
				local v2294 = type(v2293) == "table" and v2293[1] or p772
				local stealMode = (v2294 == "Instant" or v2294 == "Semi Teleport") and "Instant" or "Tween"

				zeroinConfig.StealMode = stealMode

				if v2228 then
					v2228:setStealMode(stealMode)
				end
			end
		})

		local v2296

		v2296 = v2272:AddDropdown({
			Title = "Filter By Egg Name",
			Content = "Choose specific eggs to steal",
			Column = "Full",
			Row = 9,
			Options = t113,
			Default = zeroinConfig.StealNamesFilter,
			Multi = true,
			Callback = function(p773)
				local v2297 = v308(p773, v2296)

				zeroinConfig.StealNamesFilter = v2297

				if v2228 then
					local t115 = {}

					if not table.find(v2297, "None") then
						for _, v in ipairs(v2297) do
							if v ~= "None" then
								table.insert(t115, v)
							end
						end
					end

					v2228:setFilter("names", t115)
					v2228:setFilterEnabled("name", #t115 > 0)
				end
			end
		})

		local t116 = { "None" }
		local t117 = {
			None = "None"
		}
		local t118 = {
			"Lake",
			"Jungle",
			"Desert",
			"Snow",
			"Volcano",
			"Abyss Ocean",
			"Prehistoric",
			"Cosmic",
			"Cherry Blossom",
			"Titan Temple",
			"Light Dark"
		}
		local t119 = {}

		if not pcall(function()
			for k, v in pairs(require(game:GetService("ReplicatedStorage").Data.Areas).Directory) do
				if type(v) == "table" then
					if type(v.DropTable) == "table" then
						t119[k] = v.DisplayName or k
					end
				end
			end
		end) or next(t119) == nil then
			for _, v in ipairs(t118) do
				t119[v] = v == "Light Dark" and "Angels & Demons" or v
			end
		end

		local function v2309(p774)
			local v2310 = t119[p774]

			if type(v2310) ~= "string" or v2310 == "" then
				return
			end

			table.insert(t116, v2310)
			t117[v2310] = p774
		end

		local t120 = {
			None = true,
			Forest = true
		}

		for _, v in ipairs(t118) do
			if t119[v] then
				v2309(v)
				t120[v] = true
			end
		end

		local t121 = {}

		for k in pairs(t119) do
			if not t120[k] then
				table.insert(t121, k)
			end
		end

		table.sort(t121)

		for _, v in ipairs(t121) do
			v2309(v)
		end

		local t122 = {}
		local ipairs_ = ipairs
		local StealAreas = zeroinConfig.StealAreas or { "None" }

		for _, StealArea in ipairs_(StealAreas) do
			table.insert(t122, StealArea == "Light Dark" and "Angels & Demons" or StealArea)
		end

		local v2323

		v2323 = v2272:AddDropdown({
			Title = "Select Area",
			Content = "Choose which area to farm",
			Column = "Full",
			Row = 10,
			Options = t116,
			Default = t122,
			Multi = true,
			Callback = function(p775)
				local v2324 = v308(p775, v2323)

				zeroinConfig.StealAreas = v2324

				if v2228 then
					local t123 = {}

					if not table.find(v2324, "None") then
						for _, v in ipairs(v2324) do
							if v ~= "None" then
								table.insert(t123, t117[v] or v)
							end
						end
					end

					v2228:setFilter("areas", t123)
					v2228:setFilterEnabled("area", #t123 > 0)
				end
			end
		})

		local v2328

		v2328 = v2272:AddDropdown({
			Title = "Filter By Rarity",
			Content = "Choose egg rarities to prioritize",
			Column = "Full",
			Row = 11,
			Options = {
				"None",
				"Common",
				"Uncommon",
				"Rare",
				"Epic",
				"Legendary",
				"Mythic",
				"Cosmic",
				"Secret",
				"Eternal",
				"Divine"
			},
			Default = zeroinConfig.StealRarities or { "None" },
			Multi = true,
			Callback = function(p776)
				local v2329 = v308(p776, v2328)

				zeroinConfig.StealRarities = v2329

				if v2228 then
					local t124 = {}

					if not table.find(v2329, "None") then
						for _, v in ipairs(v2329) do
							if v ~= "None" then
								table.insert(t124, v)
							end
						end
					end

					v2228:setFilter("rarities", t124)
					v2228:setFilterEnabled("rarity", #t124 > 0)
				end
			end
		})

		local v2333 = v512:AddTab({
			Name = "Event",
			Icon = "party-popper"
		})
		local v2334 = v2333:AddSection({
			Title = "Capture The Egg",
			Layout = "Grid",
			ItemGap = 4
		})
		local v2335 = v2334:AddParagraph({
			Title = "Capture The Egg Event",
			Content = "Waiting for event...",
			Icon = "trophy",
			Column = "Full",
			Row = 1
		})

		v2334:AddToggle({
			Title = "Auto Capture The Egg",
			Content = "Snatch event egg, hover at 45 studs safe altitude, and hold until victory",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoCaptureEgg == true,
			Callback = function(p777)
				zeroinConfig.AutoCaptureEgg = p777

				if v2239 then
					v2239:setEnabled(p777)
				end
			end
		})

		if v2239 then
			v2239:onChanged(function(p778)
				pcall(function()
					if v2335 then
						local v2336 = v2335
						local SetTitle = v2335.SetTitle
						local title = p778.title

						SetTitle(v2336, title or "Capture The Egg Event")
						v2335:SetContent(p778.content or "Waiting for event...")
					end
				end)
			end)
		end

		local v2339 = v2333:AddSection({
			Title = "The Rift",
			Layout = "Grid",
			ItemGap = 4
		})
		local v2340 = v2339:AddParagraph({
			Title = "Auto Riftborn",
			Content = "Collect required eggs, place and hatch them, then trade matching pets at The Rift. Runs alongside Auto Steal and pauses only for the final trade.",
			Icon = "sparkles",
			Column = "Full",
			Row = 1
		})

		v2339:AddToggle({
			Title = "Auto The Rift",
			Content = "Automatically complete the active Rift requirements",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoRift == true,
			Callback = function(p779)
				v2259(p779)
			end
		})

		local v2341

		v2341 = v2339:AddDropdown({
			Title = "Target Prize",
			Content = "Choose which Rift Egg prize to target (or None for any active)",
			Column = "Full",
			Row = 3,
			Options = {
				"None",
				"Riftborn Egg",
				"Riftbeasts Egg",
				"Shattered Rift Egg"
			},
			Default = zeroinConfig.RiftTargetPrize and { zeroinConfig.RiftTargetPrize } or { "None" },
			Multi = false,
			Callback = function(p780)
				local v2342 = v308(p780, v2341)
				local v2343 = type(v2342) == "table" and v2342[1] or p780
				local v2344

				if v2343 ~= "None" then
					v2344 = v2343
				end

				zeroinConfig.RiftTargetPrize = v2344

				if v2237 then
					v2237:setTargetPrize(v2344)
				end
			end
		})

		local v2345 = v2333:AddSection({
			Title = "Dr. Scramble Event",
			Layout = "Grid",
			ItemGap = 4
		})
		local v2346 = v2345:AddParagraph({
			Title = "Dr. Scramble · IDLE",
			Content = "Waits for filtered Auto Steal eggs, then farms highest health drones during an outbreak window.",
			Icon = "bot",
			Column = "Full",
			Row = 1
		})

		v2345:AddToggle({
			Title = "Auto Dr. Scramble",
			Content = "Tween into drone auto-attack range and advance when its Health reaches zero",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoScramble == true,
			Callback = v2260
		})

		local v2347 = v2333:AddSection({
			Title = "Dr. Scramble Shop",
			Layout = "Grid",
			ItemGap = 4
		})
		local v2348 = v2347:AddParagraph({
			Title = "Scramble Shop · IDLE",
			Content = "Select items and the number of purchases for each item.",
			Icon = "shopping-cart",
			Column = "Full",
			Row = 1
		})

		v2347:AddToggle({
			Title = "Auto Buy Scramble Shop",
			Content = "Buy selected offers serially while Samples and stock are available",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoBuyScrambleShop == true,
			Callback = v2261
		})

		local v2349

		v2349 = v2347:AddDropdown({
			Title = "Scramble Shop Items",
			Content = "Select one or more offers to buy",
			Column = "Full",
			Row = 3,
			Options = {
				"Scrambled",
				"Experiment #001",
				"Nibbles #013",
				"2x Cash Booster",
				"1.25x Speed",
				"2x Treadmill Booster"
			},
			Default = zeroinConfig.ScrambleShopItems,
			Multi = true,
			Callback = function(p781)
				local v2350 = v308(p781, v2349)

				zeroinConfig.ScrambleShopItems = type(v2350) == "table" and v2350 or {}
				v2238:setShopItems(zeroinConfig.ScrambleShopItems)
			end
		})
		v2347:AddInput({
			Title = "Buy Count per Item",
			Content = "Number of serial purchases for each selected offer (1-100)",
			Column = "Full",
			Row = 4,
			Default = tostring(zeroinConfig.ScrambleShopAmount or 1),
			Callback = function(p782)
				zeroinConfig.ScrambleShopAmount = v2238:setShopAmount(p782)
			end
		})
		v2347:AddInput({
			Title = "Scramble Shop Interval",
			Content = "Seconds to wait before starting the next purchase cycle (1-3600)",
			Column = "Full",
			Row = 5,
			Default = tostring(zeroinConfig.ScrambleShopInterval or 15),
			Callback = function(p783)
				zeroinConfig.ScrambleShopInterval = v2238:setShopInterval(p783)
			end
		})

		local function v2351()
			local __ZeroinRiftStatus = genv.__ZeroinRiftStatus

			if zeroinConfig.AutoRift and __ZeroinRiftStatus then
				pcall(function()
					local v2353 = math.max(tonumber(__ZeroinRiftStatus.rotation) or 0, 0)
					local v2354 = math.floor(v2353 / 3600)
					local v2355 = math.floor(v2353 % 3600 / 60)
					local v2356 = tostring(__ZeroinRiftStatus.status or "Active")
					local s4 = "ACTIVE"
					local v2358 = string.lower(v2356)

					if string.find(v2358, "placing") or string.find(v2358, "placed") then
						s4 = "PLACING"
					elseif string.find(v2358, "hatch") then
						s4 = "HATCHING"
					elseif string.find(v2358, "stealing") or string.find(v2358, "steal") then
						s4 = "STEALING"
					elseif string.find(v2358, "trading") or string.find(v2358, "trade") then
						s4 = "TRADING"
					end

					local v2359 = __ZeroinRiftStatus.targetPrize and __ZeroinRiftStatus.targetPrize ~= "None" and string.format("Target: %s · ", __ZeroinRiftStatus.targetPrize)

					v2359 = v2359 or ""
					v2340:SetTitle(string.format("The Rift · %s", s4))
					v2340:SetContent(string.format([[%sBanner: %s (%dh %02dm)
Progress: %d/%d Ready (Missing: %s)
Action: %s]], v2359, tostring(__ZeroinRiftStatus.banner or "Unknown"), v2354, v2355, tonumber(__ZeroinRiftStatus.ready) or 0, tonumber(__ZeroinRiftStatus.total) or 3, tostring(__ZeroinRiftStatus.missing or "None"), v2356))
				end)
			else
				pcall(function()
					v2340:SetTitle("The Rift · IDLE")
					v2340:SetContent("Collect required eggs, place and hatch them, then trade matching pets at The Rift.")
				end)
			end

			local v2360 = v2238:getSnapshot()

			pcall(function()
				local v2361 = v2360.active and "LIVE" or v2360.enabled and "ARMED" or "IDLE"
				local v2362 = math.max(0, math.floor(tonumber(v2360.secondsLeft) or 0))
				local v2363 = string.format("%02d:%02d", math.floor(v2362 / 60), v2362 % 60)

				v2346:SetTitle("Dr. Scramble · " .. v2361 .. " · " .. v2363)

				local v2364 = tonumber(v2360.health) or 0
				local v2365 = tonumber(v2360.maxHealth) or 0
				local targetTier = v2360.targetTier or v2360.active and "Searching..." or "None"
				local v2367 = v2365 > 0 and string.format(" | HP: %d/%d", v2364, v2365) or ""
				local v2368 = v2346
				local SetContent = v2346.SetContent
				local format = string.format

				SetContent(v2368, format("%s: %s\nTarget: %s%s\nStatus: %s", v2360.active and "Ends in" or "Next outbreak", v2363, targetTier, v2367, tostring(v2360.status or "Waiting")))
			end)
			pcall(function()
				v2348:SetTitle("Scramble Shop · " .. (zeroinConfig.AutoBuyScrambleShop and "ACTIVE" or "IDLE"))
				v2348:SetContent(string.format("Samples: %d · Selected: %d · Count each: %d · Interval: %ds\nStatus: %s", tonumber(v2360.samples) or 0, tonumber(v2360.shopItemCount) or 0, tonumber(v2360.shopAmount) or 1, tonumber(v2360.shopInterval) or 15, tostring(v2360.shopStatus or "Off")))
			end)
		end

		local t125 = {}

		genv.__ZeroinEventStatusGeneration = t125

		local ok, result = pcall(v2351)

		if not ok then
			warn("[Event UI] Initial status update failed:", result)
		end

		local v2374 = v511:CreateCleanupToken()

		coroutine.wrap(function()
			while v2374.Alive and genv.__ZeroinEventStatusGeneration == t125 do
				local ok2, result2 = pcall(v2351)

				if not ok2 then
					warn("[Event UI] Status update failed:", result2)
				end

				task.wait(1)
			end
		end)()
	end,
	Auto = function()
		local v2377 = v512:AddTab({
			Name = "Auto",
			Icon = "repeat-2"
		})
		local v2378 = v2377:AddSection({
			Title = "Egg Automation",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 2
		})

		t20.AutoPlaceLoop = function()
			if zeroinConfig.IsAutoPlaceWorkerRunning then
				return
			end

			zeroinConfig.IsAutoPlaceWorkerRunning = true

			while zeroinConfig.AutoPlace or zeroinConfig.AutoRift do
				local autoPlace
				local ok, result = pcall(function()
					if zeroinConfig.IsStealing then
						return
					end

					local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
					local EggState2 = require(ReplicatedStorage2.Client.EggState)
					local Assets = require(ReplicatedStorage2.Data.Assets)
					local PlotState2 = require(ReplicatedStorage2.Client.PlotState)
					local ResolveLocalSlot = PlotState2.ResolveLocalSlot and PlotState2.ResolveLocalSlot() or PlotState2.GetMySlot()
					local ResolveFolder = PlotState2.ResolveFolder and PlotState2.ResolveFolder() or PlotState2.GetPlotsFolder() or workspace:FindFirstChild("Plots")
					local v2388 = ResolveFolder and ResolveLocalSlot and ResolveFolder:FindFirstChild(tostring(ResolveLocalSlot))

					if not v2388 and ResolveFolder then
						for _, child in ipairs(ResolveFolder:GetChildren()) do
							local PlotSign = child:FindFirstChild("PlotSign")
							local PlayerPlotSign = PlotSign and PlotSign:FindFirstChild("PlayerPlotSign")

							if PlayerPlotSign and PlayerPlotSign:FindFirstChild("Frame") then
								if PlayerPlotSign.Frame:FindFirstChild("PlayerName") then
									local v2393 = string.gsub(PlayerPlotSign.Frame.PlayerName.Text, "<[^>]+>", "")

									if string.find(string.lower(v2393), string.lower(LocalPlayer.Name)) or string.find(string.lower(v2393), string.lower(LocalPlayer.DisplayName)) then
										v2388 = child

										break
									end
								end
							end
						end
					end

					if not v2388 then
						return
					end

					local ToUpdate = v2388:FindFirstChild("ToUpdate")
					local PetArea = ToUpdate and ToUpdate:FindFirstChild("PetArea")
					local CenterPoint = v2388:FindFirstChild("CenterPoint")

					CenterPoint = CenterPoint or ToUpdate and ToUpdate:FindFirstChild("CenterPoint") or PetArea

					if not PetArea or not PetArea:IsA("BasePart") then
						return
					end

					local function v2397()
						local t126 = {}
						local t127 = {}
						local Save = require(ReplicatedStorage2.Shared.Save)

						pcall(function()
							local v2401 = EggState2.GetOwnerRuntimeRecords(LocalPlayer.UserId)

							if type(v2401) == "table" then
								for k, v in pairs(v2401) do
									t127[k] = v
								end
							end
						end)
						pcall(function()
							local v2404 = Save.Get()
							local EggInventory = v2404 and v2404.EggInventory

							if type(EggInventory) == "table" then
								for k, v in pairs(EggInventory) do
									if not t127[k] then
										t127[k] = v
									end
								end
							end
						end)

						local v2408 = table.clone(zeroinConfig.RiftObjectiveCategories)
						local n35 = 0
						local t128 = {}

						for k, v in pairs(t127) do
							if v.Placement == nil then
								local AssetCategory = v.AssetCategory
								local v2414 = AssetCategory and Assets.Directory[AssetCategory]
								local s5 = "Unknown"

								if v2414 and v2414.Rarity then
									local Rarity = v2414.Rarity

									s5 = Rarity.DisplayName or Rarity._id or Rarity.Name or "Unknown"
								end

								local v2417

								if #zeroinConfig.PlaceRarities == 0 or table.find(zeroinConfig.PlaceRarities, "None") or table.find(zeroinConfig.PlaceRarities, "All") then
									v2417 = true
								else
									v2417 = table.find(zeroinConfig.PlaceRarities, s5) ~= nil
								end

								local v2418 = tonumber(v.Kg) or tonumber(v.Weight) or tonumber(v.kg)

								if not v2418 and v2414 then
									v2418 = tonumber(v2414.Kg) or tonumber(v2414.Weight) or tonumber(v2414.kg)
								end

								local v2419 = v2418 or 0
								local v2420 = (v2408[AssetCategory] or 0) > 0

								if v2420 or zeroinConfig.AutoPlace and v2417 then
									table.insert(t126, {
										Uid = k,
										Rarity = s5,
										Kg = v2419,
										IsRift = v2420
									})

									if v2420 then
										v2408[AssetCategory] -= 1
									end
								end
							else
								n35 += 1

								local Position

								if typeof(v.Placement) == "CFrame" then
									Position = v.Placement.Position
								elseif typeof(v.Placement) == "Vector3" then
									Position = v.Placement
								elseif type(v.Placement) == "table" and v.Placement.Position then
									Position = v.Placement.Position
								end

								if Position then
									table.insert(t128, Position)
								end
							end
						end

						table.sort(t126, function(p784, p785)
							if p784.IsRift == p785.IsRift then
								return p784.Kg > p785.Kg
							end

							return p784.IsRift == true
						end)

						return t126, n35, t128
					end

					local v2422, v2423 = v2397()
					local Character = LocalPlayer.Character
					local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
					local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
					local CFrame_2

					if #v2422 == 0 or v2423 >= 30 then
						return
					end

					autoPlace = v2225:tryAcquire("auto_place", {})

					if not autoPlace then
						return
					end

					if HumanoidRootPart then
						CFrame_2 = HumanoidRootPart.CFrame
					end

					if zeroinConfig.IsStealing then
						return
					end

					zeroinConfig.IsPlacing = true

					local function v2429()
						return not zeroinConfig.AutoPlace and not zeroinConfig.AutoRift or zeroinConfig.IsStealing or zeroinConfig.IsRiftTrading or zeroinConfig.IsScrambleFarming
					end

					if HumanoidRootPart then
						local v2430 = PetArea.CFrame * cFrameNew(0, 3, 0)

						if not v513(HumanoidRootPart.Position + Vector3.new(0, 2, 0), v2430.Position + Vector3.new(0, 2, 0), Character) then
							v338(HumanoidRootPart, Humanoid, cFrameNew(518.66, 70.57, -364.73) * Angles(3.1415926535897931, -1.5676547341413067, 3.1415926535897931), v2429)

							if v2429() then
								return
							end
						end

						v338(HumanoidRootPart, Humanoid, v2430, v2429)

						if v2429() then
							return
						end

						local n36 = 0

						while n36 < 0.3 and not v2429() do
							task.wait(0.05)
							n36 += 0.05
						end

						if zeroinConfig.IsStealing then
							return
						end

						if not zeroinConfig.AutoPlace and not zeroinConfig.AutoRift then
							return
						end
					end

					local n37 = 0
					local v2433 = false

					while not v2433 and (zeroinConfig.AutoPlace or zeroinConfig.AutoRift) and not v2429() do
						local v2434, v2435, v2436 = v2397()

						if #v2434 ~= 0 and not (v2435 >= 30) then
							local v2437 = v2435
							local v2438 = v2436
							local v2439 = false

							for _, v in ipairs(v2434) do
								if not zeroinConfig.AutoPlace and not zeroinConfig.AutoRift or v2433 or v2429() then
									break
								end

								if v2437 >= 30 then
									v2433 = true

									break
								end

								local Uid = v.Uid

								if EggState2.RequestEquipTool(Uid) and not v2429() then
									task.wait(0.15)

									local v2443 = false

									while n37 < 30 and not v2443 and not v2429() do
										local v2444

										if CenterPoint then
											while n37 < 30 do
												local v2445 = PetArea.Size.X - 6
												local v2446 = v2445 / 10
												local v2447 = CenterPoint.CFrame:PointToObjectSpace(PetArea.CFrame * Vector3.new(-(v2445 / 2) + v2446 / 2 + n37 % 10 * v2446, 0, -((PetArea.Size.Z - 6) / 2) + 3 + math.floor(n37 / 10) * 6))
												local cFrame = cFrameNew(v2447.X, -0.5, v2447.Z)
												local v2449 = false

												for _, v2 in ipairs(v2438) do
													if (v2 - cFrame.Position).Magnitude < 1 then
														v2449 = true

														break
													end
												end

												if not v2449 then
													v2444 = cFrame

													break
												end

												n37 += 1
											end
										end

										if not v2444 then
											v2433 = true

											break
										end

										if not v2429() then
											local v2452, v2453 = EggState2.RequestPlaceEgg(Uid, v2444)

											if v2452 then
												table.insert(v2438, v2444.Position)
												v2437 += 1
												v2443 = true
												v2439 = true
												n37 += 1
												task.wait(0.15)

												continue
											end

											local v2454 = v2453 and string.lower(tostring(v2453)) or ""

											if not string.find(v2454, "full") and not string.find(v2454, "limit") and not string.find(v2454, "capacity") and not string.find(v2454, "maximum") then
												table.insert(v2438, v2444.Position)
												n37 += 1
												task.wait(0.1)

												continue
											end

											if zeroinConfig.AutoPlace then
												zeroinConfig.AutoPlace = false
											end

											v2433 = true

											break
										end

										break
									end
								end
							end

							if v2439 then
								task.wait(0.2)

								continue
							end
						end

						break
					end

					if CFrame_2 and HumanoidRootPart and not zeroinConfig.IsStealing then
						if not v513(HumanoidRootPart.Position + Vector3.new(0, 2, 0), CFrame_2.Position + Vector3.new(0, 2, 0), Character) then
							v338(HumanoidRootPart, Humanoid, cFrameNew(518.66, 70.57, -364.73) * Angles(3.1415926535897931, -1.5676547341413067, 3.1415926535897931), v2429)
						end

						if v2429() then
							return
						end

						v338(HumanoidRootPart, Humanoid, CFrame_2, v2429)
						task.wait(0.2)
					end
				end)

				if autoPlace then
					v2225:release(autoPlace)
					autoPlace = nil
				end

				zeroinConfig.IsPlacing = false

				if not ok then
					warn("Auto Place Error: " .. tostring(result))
				end

				task.wait(1.5)
			end

			zeroinConfig.IsAutoPlaceWorkerRunning = false
		end
		v2378:AddToggle({
			Title = "Auto Place Egg",
			Column = "Left",
			Row = 1,
			Default = zeroinConfig.AutoPlace == true,
			Callback = function(p786)
				zeroinConfig.AutoPlace = p786

				if p786 then
					task.spawn(t20.AutoPlaceLoop)
				end
			end
		})

		local v2455

		v2455 = v2378:AddDropdown({
			Title = "Place Egg Rarity",
			Content = "Choose which egg rarities to place",
			Column = "Full",
			Row = 2,
			Options = {
				"None",
				"All",
				"Common",
				"Uncommon",
				"Rare",
				"Epic",
				"Legendary",
				"Mythic",
				"Cosmic",
				"Secret",
				"Eternal",
				"Divine"
			},
			Default = zeroinConfig.PlaceRarities,
			Multi = true,
			Callback = function(p787)
				zeroinConfig.PlaceRarities = v308(p787, v2455)
			end
		})
		t20.AutoHatchLoop = function()
			if zeroinConfig.IsAutoHatchWorkerRunning then
				return
			end

			zeroinConfig.IsAutoHatchWorkerRunning = true
			task.spawn(function()
				local t129 = {}

				while zeroinConfig.AutoHatch or zeroinConfig.AutoRift do
					task.wait(1.5)
					pcall(function()
						local EggState2 = require(game:GetService("ReplicatedStorage").Client.EggState)
						local v2458 = EggState2.GetOwnerRuntimeRecords(LocalPlayer.UserId)

						if not v2458 then
							return
						end

						local t130 = {}
						local v2460 = table.clone(zeroinConfig.RiftObjectiveCategories)

						for k, v in pairs(v2458) do
							if v.Placement ~= nil then
								if not zeroinConfig.AutoHatch then
									if not ((v2460[v.AssetCategory] or 0) > 0) then
										continue
									end
								end

								table.insert(t130, k)

								if not zeroinConfig.AutoHatch then
									v2460[v.AssetCategory] = (v2460[v.AssetCategory] or 1) - 1
								end
							end
						end

						local now = os.time()

						for _, v in ipairs(t130) do
							if not zeroinConfig.AutoHatch and not zeroinConfig.AutoRift then
								break
							end

							if not t129[v] or not (now < t129[v]) then
								local v2466 = v2458[v]

								if zeroinConfig.AutoHatch or v2466 and v265(v2466.AssetCategory) then
									local v2467 = false

									if type(EggState2.IsReadyToHatch) == "function" then
										local ok, result = pcall(EggState2.IsReadyToHatch, v)

										v2467 = ok and result == true
									end

									if v2467 or v2466.Ready == true or not t129[v] then
										if EggState2.RequestHatchEgg(v) then
											EggState2.RequestCompleteHatchEgg(v)
											t129[v] = nil
											task.wait(0.1)
										else
											t129[v] = now + 10
										end
									end
								end
							end
						end
					end)
				end

				zeroinConfig.IsAutoHatchWorkerRunning = false
			end)
		end
		v2378:AddToggle({
			Title = "Auto Hatch Egg",
			Column = "Right",
			Row = 1,
			Default = zeroinConfig.AutoHatch == true,
			Callback = function(p788)
				zeroinConfig.AutoHatch = p788

				if p788 and t20.AutoHatchLoop then
					task.spawn(t20.AutoHatchLoop)
				end
			end
		})

		local v2470 = v2377:AddSection({
			Title = "Auto Consume Mutation",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 2
		})
		local v2471 = v2470:AddParagraph({
			Title = "Auto Consume Mutation | IDLE",
			Content = "Automatically apply Boss or Scrambled consumables to eligible placed eggs.",
			Icon = "sparkles",
			Column = "Full",
			Row = 1
		})

		v2470:AddToggle({
			Title = "Auto Consume Mutation",
			Content = "Uses the selected consumable on matching eggs placed in your plot",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoMutate == true,
			Callback = function(p789)
				zeroinConfig.AutoMutate = p789 == true
				v2242:setEnabled(zeroinConfig.AutoMutate)
			end
		})
		v2470:AddDropdown({
			Title = "Mutation Type",
			Content = "Choose Boss or Scrambled consumables",
			Column = "Left",
			Row = 3,
			Options = v2118.getMutationTypes(),
			Default = { zeroinConfig.AutoMutateType or "Boss" },
			Multi = false,
			Callback = function(p790)
				zeroinConfig.AutoMutateType = v2242:setMutationType(p790)
			end
		})

		local t131 = { "All" }

		for _, v in ipairs(v630.getRarities()) do
			if v ~= "All" then
				t131[#t131 + 1] = v
			end
		end

		local v2475
		local u2476 = false
		local u2477 = table.find(zeroinConfig.AutoMutateRarities or {}, "All") ~= nil

		v2475 = v2470:AddDropdown({
			Title = "Mutation Egg Rarities",
			Content = "All means every rarity",
			Column = "Right",
			Row = 3,
			Options = t131,
			Default = zeroinConfig.AutoMutateRarities,
			Multi = true,
			Callback = function(p791)
				if u2476 then
					return
				end

				local v2478 = type(p791) == "table" and table.clone(p791) or { p791 }
				local v2479 = table.find(v2478, "All") ~= nil
				local v2480 = false

				if #v2478 == 0 then
					v2478 = { "All" }
					v2480 = true
				elseif #v2478 > 1 and v2479 then
					if u2477 then
						local t132 = {}

						for _, v in ipairs(v2478) do
							if v ~= "All" then
								t132[#t132 + 1] = v
							end
						end

						v2478 = #t132 > 0 and t132 or { "All" }
					else
						v2478 = { "All" }
					end

					v2480 = true
				end

				u2477 = table.find(v2478, "All") ~= nil
				zeroinConfig.AutoMutateRarities = v2242:setRarities(v2478)

				if v2480 then
					task.defer(function()
						u2476 = true
						v2475:Set(zeroinConfig.AutoMutateRarities)
						u2476 = false
					end)
				end
			end
		})

		local v2484 = v2470:AddDropdown({
			Title = "Egg Names (Placed)",
			Content = "Leave empty to target every placed egg",
			Column = "Left",
			Row = 4,
			Options = v2242:getPlacedEggNames(),
			Default = zeroinConfig.AutoMutateNames,
			Multi = true,
			Callback = function(p792)
				zeroinConfig.AutoMutateNames = v2242:setNames(p792)
			end
		})
		local v2485

		v2485 = v2470:AddInput({
			Title = "Min Mutation Value /s",
			Content = "0 targets every value; accepts 100m, 50b, or 5t",
			Column = "Right",
			Row = 4,
			Default = zeroinConfig.AutoMutateMinValueInput or "0",
			Callback = function(p793)
				local v2486, v2487 = v228(p793)

				if v2486 == nil then
					task.defer(function()
						v2485:Set(zeroinConfig.AutoMutateMinValueInput or "0")
					end)

					return
				end

				zeroinConfig.AutoMutateMinValueInput = v2487
				zeroinConfig.AutoMutateMinValue = v2242:setMinValue(v2486)

				if tostring(p793):lower():gsub("[%s,$]", ""):gsub("/s$", "") ~= v2487 then
					task.defer(function()
						v2485:Set(v2487)
					end)
				end
			end
		})
		v2470:AddButton({
			Title = "Consume 1 Mutation Once",
			Icon = "sparkles",
			Column = "Full",
			Row = 5,
			Callback = function()
				v2242:requestOnce()
			end
		})

		local u2488

		v2242:onChanged(function(p794)
			local v2489 = tostring(p794.status or "Disabled")
			local v2490 = v2489:lower()
			local v2491 = p794.enabled and "ARMED" or "IDLE"

			if v2490:find("moving", 1, true) then
				v2491 = "MOVING"
			elseif v2490:find("applying", 1, true) then
				v2491 = "APPLYING"
			elseif v2490:find("ready:", 1, true) then
				v2491 = "CONFIRM"
			elseif v2490:find("applied", 1, true) then
				v2491 = "SUCCESS"
			elseif v2490:find("no ", 1, true) or v2490:find("unavailable", 1, true) or v2490:find("rejected", 1, true) or v2490:find("error", 1, true) then
				v2491 = "BLOCKED"
			end

			v2471:SetTitle("Auto Consume Mutation | " .. v2491)

			local v2492 = v2471
			local SetContent = v2471.SetContent
			local format = string.format
			local s6 = [[Status: %s
Mutation: %s | Consumables: %d | Eligible: %d
Target: %s | Last mutated: %s
Rarities: %s | Min value: $%s/s]]
			local v2496 = v2489
			local mutationType = p794.mutationType
			local v2498 = tonumber(p794.consumables) or 0
			local v2499 = tonumber(p794.eligible) or 0
			local target = p794.target or "--"

			SetContent(v2492, format(s6, v2496, mutationType, v2498, v2499, target, p794.lastMutated or "None", table.concat(p794.rarities or { "All" }, ", "), t20.formatMoneyShort(p794.minValuePerSec or 0)))

			local placedNames = p794.placedNames or {}
			local v2502 = table.concat(placedNames, "\0")

			if v2502 ~= u2488 then
				u2488 = v2502

				local t133 = {}
				local ipairs_ = ipairs
				local AutoMutateNames = zeroinConfig.AutoMutateNames or {}

				for _, AutoMutateName in ipairs_(AutoMutateNames) do
					if table.find(placedNames, AutoMutateName) then
						t133[#t133 + 1] = AutoMutateName
					end
				end

				v2484:SetValues(placedNames, t133)
			end
		end)

		local v2508 = v2377:AddSection({
			Title = "Pet Fusion",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 2
		})
		local v2509 = v2508:AddParagraph({
			Title = "Pet Fusion · IDLE",
			Content = "Auto Fuse is disabled. It only uses safe groups of 3 matching pet types.",
			Icon = "combine",
			Column = "Full",
			Row = 1
		})

		v2508:AddToggle({
			Title = "Auto Fuse",
			Content = "Continuously fuse eligible groups using the settings below",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.AutoFuse == true,
			Callback = function(p795)
				zeroinConfig.AutoFuse = p795 == true
				v2241:setEnabled(zeroinConfig.AutoFuse)
			end
		})
		v2508:AddDropdown({
			Title = "Fuse Priority",
			Content = "Choose which eligible group goes first",
			Column = "Left",
			Row = 3,
			Options = v1986.getPriorities(),
			Default = { zeroinConfig.AutoFusePriority or "Lowest Rarity" },
			Multi = false,
			Callback = function(p796)
				zeroinConfig.AutoFusePriority = v2241:setPriority(p796)
			end
		})

		local t134 = { "All" }

		for _, v in ipairs(v630.getRarities()) do
			if v ~= "All" then
				t134[#t134 + 1] = v
			end
		end

		local v2513
		local u2514 = false
		local u2515 = table.find(zeroinConfig.AutoFuseRarities or {}, "All") ~= nil

		v2513 = v2508:AddDropdown({
			Title = "Fuse Rarities",
			Content = "All means no rarity filter",
			Column = "Right",
			Row = 3,
			Options = t134,
			Default = zeroinConfig.AutoFuseRarities or { "All" },
			Multi = true,
			Callback = function(p797)
				if u2514 then
					return
				end

				local v2516 = type(p797) == "table" and table.clone(p797) or { p797 }
				local v2517 = table.find(v2516, "All") ~= nil
				local v2518 = false

				if #v2516 == 0 then
					v2516 = { "All" }
					v2518 = true
				elseif #v2516 > 1 and v2517 then
					if u2515 then
						local t135 = {}

						for _, v in ipairs(v2516) do
							if v ~= "All" then
								t135[#t135 + 1] = v
							end
						end

						v2516 = #t135 > 0 and t135 or { "All" }
					else
						v2516 = { "All" }
					end

					v2518 = true
				end

				u2515 = table.find(v2516, "All") ~= nil
				zeroinConfig.AutoFuseRarities = v2241:setRarities(v2516)

				if v2518 then
					task.defer(function()
						if not v2513 then
							return
						end

						u2514 = true
						v2513:Set(zeroinConfig.AutoFuseRarities)
						u2514 = false
					end)
				end
			end
		})

		local v2522

		v2522 = v2508:AddInput({
			Title = "Keep Pet Copies",
			Content = "Copies preserved per pet type; 1 recommended",
			Column = "Left",
			Row = 4,
			Default = tostring(zeroinConfig.AutoFuseKeepPerPet or 1),
			Callback = function(p798)
				local v2523 = v2241:setKeepPerCategory(p798)

				zeroinConfig.AutoFuseKeepPerPet = v2523

				if v2522 and tonumber(p798) ~= v2523 then
					task.defer(function()
						v2522:Set(tostring(v2523))
					end)
				end
			end
		})

		local v2524

		v2524 = v2508:AddInput({
			Title = "Max Weight (Kg)",
			Content = "0 means no limit; higher values protect heavier pets",
			Column = "Right",
			Row = 4,
			Default = tostring(zeroinConfig.AutoFuseMaxWeightKg or 0),
			Callback = function(p799)
				local v2525 = v2241:setMaxWeightKg(p799)

				zeroinConfig.AutoFuseMaxWeightKg = v2525

				if v2524 and tonumber(p799) ~= v2525 then
					task.defer(function()
						v2524:Set(tostring(v2525))
					end)
				end
			end
		})
		v2508:AddButton({
			Title = "Fuse 3 Pets Once",
			Icon = "combine",
			Column = "Full",
			Row = 5,
			Callback = function()
				v2241:requestFuseOnce()
			end
		})
		v2241:onChanged(function(p800)
			local v2526 = tostring(p800.status or "Disabled")
			local v2527 = v2526:lower()
			local v2528 = p800.enabled and "ARMED" or "IDLE"

			if v2527:find("moving", 1, true) then
				v2528 = "MOVING"
			elseif v2527:find("loading", 1, true) then
				v2528 = "LOADING"
			elseif v2527:find("fusing", 1, true) then
				v2528 = "FUSING"
			elseif v2527:find("waiting", 1, true) then
				v2528 = "WAITING"
			elseif v2527:find("ready:", 1, true) then
				v2528 = "CONFIRM"
			elseif v2527:find("fused ", 1, true) or v2527:find("recovered", 1, true) then
				v2528 = "COMPLETE"
			elseif v2527:find("failed", 1, true) or v2527:find("error", 1, true) or v2527:find("timed out", 1, true) or v2527:find("unavailable", 1, true) then
				v2528 = "ERROR"
			end

			local v2529 = p800.maxWeightKg > 0 and tostring(p800.maxWeightKg) .. " Kg" or "None"

			v2509:SetTitle("Pet Fusion · " .. v2528)
			v2509:SetContent(string.format([[Status: %s
Eligible groups: %s · Machine: %d/3 · Last fused: %s
Priority: %s · Keep copies: %d
Rarities: %s · Weight limit: %s]], v2526, p800.eligibleGroups == nil and "--" or tostring(p800.eligibleGroups), tonumber(p800.machineCount) or 0, tostring(p800.lastFused or "None"), tostring(p800.priority or "Lowest Rarity"), tonumber(p800.keepPerCategory) or 1, table.concat(p800.rarities or { "All" }, ", "), v2529))
		end)

		local v2530 = v2377:AddSection({
			Title = "Pet Selling",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 2
		})
		local v2531
		local v2532
		local v2533

		local function v2534(p801, p802, p803, p804)
			if type(p803) == "string" and v2225:isCategoryProtected(p803, p801) then
				return false, "item category is reserved for The Rift", "item"
			end

			local v2535, v2536 = v2225:tryAcquireBackground(p801, { p802 })

			if not v2535 then
				return false, v2536 or "another background operation is active", "global"
			end

			if v2240 and v2240:isEngaged() then
				v2240:yieldForBackground()

				local v2537 = os.clock() + 5

				while v2240:isEngaged() and os.clock() < v2537 do
					task.wait(0.05)
				end

				if v2240:isEngaged() then
					v2225:release(v2535)

					return false, "treadmill did not release its tool", "global"
				end
			end

			local ok, result, result2, result3 = xpcall(p804, debug.traceback)

			v2225:release(v2535)

			if ok then
				return result, result2, result3
			end

			return false, result, "global"
		end

		local u2542 = false

		t20.startAutoSellLoop = function()
			if u2542 then
				return
			end

			u2542 = true
			task.spawn(function()
				local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
				local Assets = require(ReplicatedStorage2.Data.Assets)
				local Save = require(ReplicatedStorage2.Shared.Save)
				local AssetRoster = require(ReplicatedStorage2.Client.AssetRoster)
				local Remotes = require(ReplicatedStorage2.Shared.Remotes)
				local LocalPlayer2 = game:GetService("Players").LocalPlayer

				local function v2549()
					local ok, result = pcall(function()
						return AssetRoster.ReadOwnerPen(LocalPlayer2.UserId)
					end)

					if not ok or type(result) ~= "table" then
						return nil
					end

					local t136 = {}

					for k, v in pairs(result) do
						if type(k) == "string" then
							t136[k] = true
						end

						if type(v) == "table" and v.UID then
							t136[v.UID] = true
						end
					end

					return t136
				end
				local function v2555(p805, p806)
					if not zeroinConfig.AutoSell then
						return false, "toggle Auto Sell Pet udah OFF", "global"
					end

					if not v268() then
						return false, "Auto Steal lagi megang kendali", "global"
					end

					if v267(p805.uid) then
						return false, "pet reserved for The Rift", "pet"
					end

					if v2225:isCategoryProtected(p805.category, "auto_sell_pets") then
						return false, "pet category is reserved for The Rift", "pet"
					end

					local v2556 = v318(v2531)
					local v2557 = v318(v2532)

					if not v2556 or not v2557 then
						return false, "filter dropdown gak bisa dibaca", "global"
					end

					if type(p806) ~= "table" then
						return false, "status pet dipajang gak bisa diverifikasi", "global"
					end

					if p806[p805.uid] then
						return false, "pet ini dipajang di plot", "pet"
					end

					if not v324(p805.petName, p805.rarity, v2556, v2557) then
						return false, "pet ini udah gak match filter yang sekarang", "pet"
					end

					local v2558 = Save.Get()
					local Inventory = v2558 and v2558.Inventory

					Inventory = Inventory and v2558.Inventory[p805.uid]

					if Inventory == nil then
						return false, "pet ini udah gak ada di inventory", "pet"
					end

					if Inventory.IsFavorite == true then
						return false, "pet ini di-favorite", "pet"
					end

					if Inventory.InFuse == true then
						return false, "pet ini sedang di-fuse", "pet"
					end

					if table.find(v2558.EquippedAssets or {}, p805.uid) == nil then
						return true
					end

					return false, "pet ini sedang dipasang", "pet"
				end

				while zeroinConfig.AutoSell do
					local ok, result = pcall(function()
						if not v268() then
							return
						end

						local v2562 = v318(v2531)
						local v2563 = v318(v2532)

						if not v2562 or not v2563 then
							warn("[AutoSell] Filter dropdown gak bisa dibaca -- ronde ini di-SKIP, gak ada yang dijual. Kalau ini terus-terusan, matiin Auto Sell Pet dan lapor.")

							return
						end

						local v2564 = Save.Get()
						local Inventory = v2564 and v2564.Inventory or {}
						local v2566 = v2549()

						if not v2566 then
							warn("[AutoSell] Status pet yang dipajang gak bisa diverifikasi -- ronde ini di-SKIP, gak ada yang dijual.")

							return
						end

						local t137 = {}
						local n38 = 0

						if type(Inventory) == "table" then
							for k, v in pairs(Inventory) do
								n38 += 1

								if n38 % 250 == 0 then
									RunService.Heartbeat:Wait()

									if not zeroinConfig.AutoSell then
										return
									end
								end

								if type(v) == "table" then
									local v2571 = v2566[k] == true
									local v2572 = v.IsFavorite == true or v["Jadikan Favorit"] == true or v.Favorite == true
									local v2573 = table.find(v2564.EquippedAssets or {}, k) ~= nil
									local v2574 = v.InFuse == true
									local Category = v.Category or v.id or v.AssetCategory or v.ItemId
									local v2576 = Category and Assets.Directory[Category]
									local DisplayName = v2576

									if DisplayName then
										DisplayName = v2576.DisplayName or v2576._id or v2576.Name
									end

									DisplayName = DisplayName or "Unknown"

									local Rarity = v2576 and v2576.Rarity
									local DisplayName2 = Rarity and (Rarity.DisplayName or Rarity._id or Rarity.Name) or "Unknown"

									if v324(DisplayName, DisplayName2, v2562, v2563) and not v2572 and not v2571 and not v2573 and not v2574 and not v267(k) and not v2225:isCategoryProtected(Category, "auto_sell_pets") then
										table.insert(t137, {
											uid = k,
											petName = DisplayName,
											rarity = DisplayName2,
											category = Category
										})
									end
								end
							end
						end

						if #t137 > 0 then
							for _, v in ipairs(t137) do
								local v2582, v2583, v2584 = v2534("auto_sell_pets", v.uid, v.category, function()
									local v2585 = v2549()
									local v2586, v2587, v2588 = v2555(v, v2585)

									if not v2586 then
										return false, v2587, v2588
									end

									local Character = LocalPlayer2.Character
									local Humanoid = Character and Character:FindFirstChildOfClass("Humanoid")
									local v2591

									for _, v2 in ipairs({
										LocalPlayer2.Backpack,
										Character
									}) do
										if v2 then
											for _, child in ipairs(v2:GetChildren()) do
												if child:IsA("Tool") and child:GetAttribute("UID") == v.uid then
													v2591 = child

													break
												end
											end
										end

										if v2591 then
											break
										end
									end

									if not v2591 or not Humanoid then
										return false, "pet tool is unavailable", "pet"
									end

									Humanoid:EquipTool(v2591)
									task.wait(0.2)

									local v2596 = v2549()
									local v2597, v2598, v2599 = v2555(v, v2596)

									if v2597 then
										Remotes.PetSatchel.SellPet:FireServer({ v.uid })
										task.wait(0.05)

										return true
									end

									return false, v2598, v2599
								end)

								if v2582 then
									continue
								else
									warn("[AutoSell] Gak jual " .. tostring(v.petName) .. " -- " .. tostring(v2583))

									if v2584 ~= "global" then
										continue
									end
								end

								break
							end
						end
					end)

					if not ok then
						warn("Auto Sell Error:", result)
					end

					task.wait(1.5)
				end

				u2542 = false
			end)
		end

		local u2600 = false
		local u2601 = false

		local function v2602()
			local __ZeroinScrambleRuntime = genv.__ZeroinScrambleRuntime
			local v2604 = __ZeroinScrambleRuntime and type(__ZeroinScrambleRuntime.isMovementBusy) == "function" and __ZeroinScrambleRuntime:isMovementBusy()

			if zeroinConfig.IsRiftTrading or v2604 then
				return false
			end

			if not zeroinConfig.IsStealing then
				return v268()
			end

			local __ZeroinEggRuntime = genv.__ZeroinEggRuntime

			if not __ZeroinEggRuntime or __ZeroinEggRuntime.destroyed or not __ZeroinEggRuntime.enabled or not __ZeroinEggRuntime.activeTween or __ZeroinEggRuntime.carryAttemptToken or __ZeroinEggRuntime.playerHuntToken or __ZeroinEggRuntime.waitingGuardHit or __ZeroinEggRuntime.carry and __ZeroinEggRuntime.carry.active then
				return false
			end

			local Character = LocalPlayer.Character
			local HumanoidRootPart = Character and Character:FindFirstChild("HumanoidRootPart")
			local activeTarget = __ZeroinEggRuntime.activeTarget
			local Position = activeTarget and activeTarget.BottomCFrame and activeTarget.BottomCFrame.Position

			if HumanoidRootPart and Position then
				return (HumanoidRootPart.Position - Position).Magnitude > math.max(60, (__ZeroinEggRuntime.config and __ZeroinEggRuntime.config.speed or 0) * 0.5 + 30)
			end

			return false
		end
		local function v2610()
			if not zeroinConfig.AutoSellEgg then
				return false
			end

			local v2611 = v318(v2533)

			if not v2611 or #v2611 == 0 or table.find(v2611, "None") then
				return false
			end

			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
			local ok, result = pcall(function()
				return require(ReplicatedStorage2.Shared.Save)
			end)

			if not ok or not result then
				return false
			end

			local v2615 = result.Get()
			local EggInventory = v2615 and v2615.EggInventory

			if type(EggInventory) ~= "table" then
				return false
			end

			local ok2, result2 = pcall(function()
				return require(ReplicatedStorage2.Data.Assets)
			end)
			local Directory = ok2 and result2 and result2.Directory

			if not Directory then
				return false
			end

			for _, v in pairs(EggInventory) do
				local v2622 = type(v) == "table" and Directory[v.AssetCategory]
				local DisplayName = v2622 and v2622.Rarity and (v2622.Rarity.DisplayName or v2622.Rarity._id)

				if v.Placement ~= nil then
					continue
				end

				if not v265(v.AssetCategory) and not v2225:isCategoryProtected(v.AssetCategory, "auto_sell") then
					if v327(DisplayName or "Unknown", v2611) then
						return true
					end
				end
			end

			return false
		end

		genv.__ZeroinIsAutoSellEggBusy = function()
			return u2601 or v2610()
		end
		t20.startAutoSellEggLoop = function()
			if u2600 then
				return
			end

			u2600 = true
			task.spawn(function()
				local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
				local Directory = require(ReplicatedStorage2.Data.Assets).Directory
				local EggState2 = require(ReplicatedStorage2.Client.EggState)
				local Remotes = require(ReplicatedStorage2.Shared.Remotes)
				local Save = require(ReplicatedStorage2.Shared.Save)

				while zeroinConfig.AutoSellEgg do
					local v2629 = v318(v2533)
					local v2630 = Save.Get()
					local EggInventory = v2630 and v2630.EggInventory

					if v2629 and type(EggInventory) == "table" and v2602() then
						for k, v in pairs(EggInventory) do
							if zeroinConfig.AutoSellEgg and v2602() then
								local v2634 = type(v) == "table" and Directory[v.AssetCategory]
								local DisplayName = v2634 and v2634.Rarity and (v2634.Rarity.DisplayName or v2634.Rarity._id)

								if v.Placement ~= nil or v265(v.AssetCategory) or v2225:isCategoryProtected(v.AssetCategory, "auto_sell") then
									continue
								end

								if not v327(DisplayName or "Unknown", v2629) then
									continue
								end

								if v2602() then
									local v2636, v2637, v2638 = v2534("auto_sell", k, v.AssetCategory, function()
										if not zeroinConfig.AutoSellEgg or not v2602() then
											return false, "Auto Sell Egg is no longer available", "global"
										end

										u2601 = true

										if not EggState2.WearEggTool(k) then
											return false, "egg tool is unavailable", "item"
										end

										task.wait(0.2)

										if not zeroinConfig.AutoSellEgg or not v2602() then
											return false, "Auto Sell Egg is no longer available", "global"
										end

										local v2639 = Save.Get()
										local EggInventory2 = v2639 and v2639.EggInventory and v2639.EggInventory[k]

										if not EggInventory2 or EggInventory2.Placement ~= nil then
											return false, "egg is no longer sellable", "item"
										end

										if v265(EggInventory2.AssetCategory) or v2225:isCategoryProtected(EggInventory2.AssetCategory, "auto_sell") then
											return false, "egg category is reserved for The Rift", "item"
										end

										Remotes.PetSatchel.SellPet:FireServer({ k })
										task.wait(0.25)

										return true
									end)

									u2601 = false

									if v2636 then
										continue
									else
										warn("[AutoSellEgg] Gak jual " .. tostring(k) .. " -- " .. tostring(v2637))

										if v2638 ~= "global" then
											continue
										end
									end
								end
							end

							break
						end
					end

					u2601 = false
					task.wait(0.5)
				end

				u2601 = false
				u2600 = false
			end)
		end
		v2530:AddToggle({
			Title = "Auto Sell Pet",
			Column = "Left",
			Row = 1,
			Default = zeroinConfig.AutoSell == true,
			Callback = function(p807)
				zeroinConfig.AutoSell = p807

				if p807 then
					t20.startAutoSellLoop()
				end
			end
		})
		v2530:AddToggle({
			Title = "Sell All Pets",
			Column = "Right",
			Row = 1,
			Default = false,
			Callback = function(p808)
				zeroinConfig.SellAll = p808
			end
		})

		local t138 = {
			"None",
			"All"
		}

		pcall(function()
			local t139 = {}

			for _, v in pairs(require(game:GetService("ReplicatedStorage").Data.Assets).Directory) do
				if type(v) == "table" and (v.DisplayName or v._id or v.Name) then
					local DisplayName = v.DisplayName or v._id or v.Name

					if not t139[DisplayName] then
						t139[DisplayName] = true
						table.insert(t138, DisplayName)
					end
				end
			end

			table.sort(t138, function(p809, p810)
				if p809 == "None" then
					return true
				end

				if p810 == "None" then
					return false
				end

				if p809 == "All" then
					return true
				end

				if p810 == "All" then
					return false
				end

				return p809 < p810
			end)
		end)
		v2531 = v2530:AddDropdown({
			Title = "Pet Name Filter",
			Content = "Choose specific pets to sell",
			Column = "Full",
			Row = 2,
			Options = t138,
			Default = zeroinConfig.SellNames or { "None" },
			Multi = true,
			Callback = function(p811)
				zeroinConfig.SellNames = v308(p811, v2531)
			end
		})
		v2532 = v2530:AddDropdown({
			Title = "Pet Rarity Filter",
			Content = "Choose which pet rarities to sell",
			Column = "Full",
			Row = 3,
			Options = {
				"None",
				"All",
				"Common",
				"Uncommon",
				"Rare",
				"Epic",
				"Legendary",
				"Mythic",
				"Secret",
				"Divine",
				"Cosmic",
				"Eternal"
			},
			Default = { "None" },
			Multi = true,
			Callback = function(p812)
				zeroinConfig.SellRarities = v308(p812, v2532)
			end
		})

		local v2646 = v2377:AddSection({
			Title = "Egg Selling",
			Layout = "Grid",
			ItemGap = 4
		})

		v2646:AddToggle({
			Title = "Auto Sell Egg",
			Content = "Automatically sell matching unplaced eggs",
			Column = "Full",
			Row = 1,
			Default = zeroinConfig.AutoSellEgg == true,
			Callback = function(p813)
				zeroinConfig.AutoSellEgg = p813

				if p813 then
					t20.startAutoSellEggLoop()
				end
			end
		})
		v2533 = v2646:AddDropdown({
			Title = "Egg Rarity Filter",
			Content = "Choose which egg rarities to sell",
			Column = "Full",
			Row = 2,
			Options = {
				"None",
				"All",
				"Common",
				"Uncommon",
				"Rare",
				"Epic",
				"Legendary",
				"Mythic",
				"Secret",
				"Divine",
				"Cosmic",
				"Eternal"
			},
			Default = zeroinConfig.SellEggRarities or { "None" },
			Multi = true,
			Callback = function(p814)
				zeroinConfig.SellEggRarities = v308(p814, v2533)
			end
		})
	end,
	Webhook = function()
		local v2647 = v512:AddTab({
			Name = "Webhook",
			Icon = "webhook"
		}):AddSection({
			Title = "Discord Webhook",
			Layout = "Grid",
			ItemGap = 4
		})

		v2647:AddParagraph({
			Title = "Egg Claim Notifications",
			Content = "Send an embed to Discord whenever an egg is claimed, including its rarity, weight, value, area, and player information.",
			Icon = "send",
			Column = "Full",
			Row = 1
		})

		local function v2648(p815)
			local match = tostring(p815 or ""):match("^%s*(.-)%s*$") or ""

			if match == "" then
				return nil
			end

			local v2650 = match:gsub("[?#].*$", ""):gsub("/+$", "")

			if #v2650 > 2000 then
				return nil
			end

			return (v2650:match("^https://discord%.com/api/webhooks/%d+/[^/]+$") or v2650:match("^https://canary%.discord%.com/api/webhooks/%d+/[^/]+$") or v2650:match("^https://ptb%.discord%.com/api/webhooks/%d+/[^/]+$") or v2650:match("^https://discordapp%.com/api/webhooks/%d+/[^/]+$")) and v2650 or nil
		end

		v2647:AddToggle({
			Title = "Webhook Logs",
			Content = "Send a Discord log each time an egg is claimed",
			Column = "Full",
			Row = 3,
			Default = zeroinConfig.WebhookEnabled == true,
			Callback = function(p816)
				zeroinConfig.WebhookEnabled = p816 == true and v2648(zeroinConfig.WebhookURL) ~= nil
			end
		})
		v2647:AddInput({
			Title = "Webhook URL",
			Content = "Paste your Discord webhook URL here",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.WebhookURL or "",
			Persist = true,
			Sensitive = false,
			Callback = function(p817)
				zeroinConfig.WebhookURL = tostring(p817 or ""):match("^%s*(.-)%s*$") or ""

				if v2648(zeroinConfig.WebhookURL) == nil then
					zeroinConfig.WebhookEnabled = false
				end
			end
		})

		local function v2651(p818, p819)
			local request_ = syn and syn.request or request or http_request or http and http.request or fluxus and fluxus.request

			if type(request_) ~= "function" then
				return false, "Executor HTTP request is unavailable"
			end

			local v2653 = p818 .. (p818:find("?", 1, true) and "&wait=true" or "?wait=true")

			for i = 1, 3 do
				local ok, result = pcall(request_, {
					Url = v2653,
					url = v2653,
					Method = "POST",
					method = "POST",
					Headers = {
						["Content-Type"] = "application/json"
					},
					headers = {
						["Content-Type"] = "application/json"
					},
					Body = p819,
					body = p819
				})

				if not ok then
					return false, "Webhook request failed"
				end

				local v2657 = tonumber(result and (result.StatusCode or result.Status or result.status_code or result.statusCode))

				if v2657 and v2657 >= 200 and v2657 < 300 then
					return true
				end

				if v2657 ~= 429 or not (i < 3) then
					return false, "Discord rejected the webhook (HTTP " .. tostring(v2657 or "?") .. ")"
				end

				local Body = result and (result.Body or result.body)
				local pcall_ = pcall
				local JSONDecode = game:GetService("HttpService").JSONDecode
				local ok2, result2 = pcall_(JSONDecode, game:GetService("HttpService"), Body or "")

				task.wait(math.clamp(ok2 and type(result2) == "table" and tonumber(result2.retry_after) or 1, 0.5, 10))
			end

			return false, "Discord rate limit retry failed"
		end

		local t140 = {}
		local u2664 = false
		local v2665 = (genv.__ZeroinWebhookGeneration or 0) + 1

		genv.__ZeroinWebhookGeneration = v2665
		genv.__ZeroinWebhookCleanup = function()
			if genv.__ZeroinWebhookGeneration == v2665 then
				genv.__ZeroinWebhookGeneration += 1
			end

			table.clear(t140)
		end

		local function v2666(p820, p821, p822)
			if #t140 >= 20 then
				return false, "Webhook queue is full"
			end

			t140[#t140 + 1] = {
				url = p820,
				payload = p821,
				callback = p822
			}

			if u2664 then
				return true
			end

			u2664 = true
			task.spawn(function()
				while true do
					if genv.__ZeroinWebhookGeneration ~= v2665 then
						u2664 = false

						return
					end

					local v2667 = table.remove(t140, 1)

					if not v2667 then
						u2664 = false

						if #t140 ~= 0 then
							u2664 = true

							continue
						end

						break
					end

					local v2668, v2669 = v2651(v2667.url, v2667.payload)

					if type(v2667.callback) == "function" then
						task.defer(v2667.callback, v2668, v2669)
					elseif not v2668 then
						warn("[Webhook] " .. tostring(v2669))
					end

					task.wait(0.25)
				end
			end)

			return true
		end
		local function v2670(p823)
			local request_ = syn and syn.request or request or http_request or http and http.request or fluxus and fluxus.request

			if not request_ then
				return game:HttpGet(p823)
			end

			local v2672 = request_({
				Url = p823,
				Method = "GET"
			})

			return v2672 and (v2672.Body or v2672.body)
		end

		t20.formatMoneyShort = function(p824)
			local v2673 = math.floor(p824 + 0.5)

			if v2673 >= 1e9 then
				return string.format("%.2fB", v2673 / 1e9)
			end

			if v2673 >= 1000000 then
				return string.format("%.2fM", v2673 / 1000000)
			end

			if v2673 >= 1000 then
				return string.format("%.1fK", v2673 / 1000)
			end

			return tostring(v2673)
		end

		local function v2674()
			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
			local EggState2 = require(ReplicatedStorage2.Client.EggState)
			local ok, result = pcall(function()
				local ReadOwnerEggs = EggState2.ReadOwnerEggs or EggState2.GetOwnerRuntimeRecords

				if type(ReadOwnerEggs) == "function" then
					return ReadOwnerEggs(LocalPlayer.UserId)
				end

				return nil
			end)

			if ok and type(result) == "table" then
				return result
			end

			local ok2, result2 = pcall(function()
				return require(ReplicatedStorage2.Shared.Save)
			end)
			local Get = ok2 and result2 and result2.Get and result2.Get()

			if Get and type(Get.EggInventory) == "table" then
				return Get.EggInventory
			end

			return {}
		end

		local t141 = {}

		pcall(function()
			local v2684 = v2674()

			for k in pairs(v2684) do
				t141[tostring(k)] = true
			end
		end)

		local function v2686(p825)
			local ok, result = pcall(function()
				local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
				local AssetItems = require(ReplicatedStorage2.Shared.Util.AssetItems)
				local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
				local AssetCategory = p825 and p825.AssetCategory
				local v2693 = t10 and t10[AssetCategory]

				if not v2693 or v2693 == "Unknown" then
					v2693 = v235(AssetCategory)
				end

				local __ZeroinLastStolenEgg = genv.__ZeroinLastStolenEgg
				local v2695
				local exitTo
				local v2697

				for i = 1, 10 do
					v2697 = v2674()

					if type(v2697) == "table" then
						for k, v in pairs(v2697) do
							local v2701 = tostring(k)

							if not t141[v2701] and (not AssetCategory or v.AssetCategory == AssetCategory) then
								v2695 = v
								t141[v2701] = true

								break
							end
						end

						if v2695 then
							exitTo = 1

							break
						end

						task.wait(0.15)
					else
						task.wait(0.15)
					end
				end

				if exitTo == 1 then
					for k in pairs(v2697) do
						t141[tostring(k)] = true
					end

					if not v2695 and __ZeroinLastStolenEgg and __ZeroinLastStolenEgg.AssetCategory == AssetCategory then
						local now = os.clock()
						local Timestamp = __ZeroinLastStolenEgg.Timestamp or 0

						if now - Timestamp < 30 then
							v2695 = __ZeroinLastStolenEgg
						end
					end
				elseif not v2695 and __ZeroinLastStolenEgg and __ZeroinLastStolenEgg.AssetCategory == AssetCategory then
					if os.clock() - (__ZeroinLastStolenEgg.Timestamp or 0) < 30 then
						v2695 = __ZeroinLastStolenEgg
					end
				end

				if not v2695 then
					local v2705 = v2674()

					if type(v2705) == "table" then
						for _, v in pairs(v2705) do
							if v.AssetCategory == AssetCategory and v.Placement == nil then
								v2695 = v

								break
							end
						end

						if not v2695 then
							for _, v in pairs(v2705) do
								if v.AssetCategory == AssetCategory then
									v2695 = v

									break
								end
							end
						end
					end
				end

				local AssetScale = v2695 and (v2695.AssetScale or v2695.Scale) or 1
				local t142 = {
					Category = AssetCategory,
					Scale = AssetScale,
					Mutations = v2695 and v2695.Mutations or {},
					BaseMutation = v2695 and v2695.BaseMutation,
					EyeColor = v2695 and v2695.AssetEyeColor,
					ColorSeed = v2695 and v2695.AssetColorSeed,
					ColorIndex = v2695 and v2695.AssetColorIndex,
					Gender = v2695 and v2695.Gender,
					Personality = v2695 and (v2695.Personality or "Normal"),
					HasBeenFirstPlaced = v2695 and v2695.HasBeenFirstPlaced == true
				}
				local ok, result = pcall(AssetItems.WeightKg, t142)
				local ok2, result2 = pcall(function()
					return AssetEarnings.MutationOnlyRatePerSecond(t142)
				end)

				if not ok2 or not result2 then
					pcall(function()
						result2 = AssetEarnings.RatePerSecond(t142)
					end)
				end

				local t143 = {
					WeightKg = ok and result or nil,
					Scale = AssetScale,
					RatePerSec = result2,
					AreaId = v2693
				}

				return t143
			end)

			if ok and result then
				return result
			end

			return {
				WeightKg = nil,
				Scale = nil,
				RatePerSec = nil,
				AreaId = v235(p825 and p825.AssetCategory)
			}
		end

		local u2717

		local function v2718()
			if u2717 then
				return u2717
			end

			local ok, result = pcall(function()
				local HttpService = game:GetService("HttpService")
				local v2722 = v2670("https://thumbnails.roblox.com/v1/users/avatar-headshot?userIds=" .. LocalPlayer.UserId .. "&size=150x150&format=Png&isCircular=false")
				local data = HttpService:JSONDecode(v2722)
				local data2 = data and data.data and data.data[1]

				if data2 and data2.state == "Completed" and data2.imageUrl then
					return data2.imageUrl
				end

				return nil
			end)

			if ok and result then
				u2717 = result
			end

			return u2717
		end
		local function v2725()
			local v2726 = v2648(zeroinConfig.WebhookURL)

			if not v2726 then
				v305:MakeNotify({
					Title = "Webhook",
					Description = "Invalid URL",
					Content = "Enter a valid Discord webhook URL.",
					Color = Color3.fromRGB(220, 170, 80),
					Delay = 3
				})

				return
			end

			local t144 = {
				username = "Zeroin - Steal An Egg",
				embeds = { {
					title = "Webhook Test Successful",
					description = "Your Zeroin webhook is configured correctly.",
					color = 52410,
					footer = {
						text = "Zeroin - Steal An Egg"
					},
					timestamp = DateTime.now():ToIsoDate()
				} }
			}
			local v2728, v2729 = v2666(v2726, game:GetService("HttpService"):JSONEncode(t144), function(p826, p827)
				v305:MakeNotify({
					Title = "Webhook",
					Description = p826 and "Success" or "Failed",
					Content = p826 and "Test webhook sent successfully." or tostring(p827),
					Color = p826 and Color3.fromRGB(0, 205, 122) or Color3.fromRGB(220, 90, 90),
					Delay = 3
				})
			end)

			if not v2728 then
				v305:MakeNotify({
					Title = "Webhook",
					Description = "Failed",
					Content = tostring(v2729),
					Color = Color3.fromRGB(220, 90, 90),
					Delay = 3
				})
			end
		end
		local function v2730(p828)
			if not zeroinConfig.WebhookEnabled then
				return
			end

			local v2731 = v2648(zeroinConfig.WebhookURL)

			if not v2731 then
				zeroinConfig.WebhookEnabled = false

				return
			end

			if type(p828) ~= "table" then
				return
			end

			task.spawn(function()
				local ok, result = pcall(function()
					local HttpService = game:GetService("HttpService")
					local Assets = require(game:GetService("ReplicatedStorage").Data.Assets)
					local Rarity = p828.Rarity or "Unknown"
					local AssetCategory = p828.AssetCategory
					local DisplayName = p828.DisplayName

					if not DisplayName then
						DisplayName = tostring(AssetCategory or "Egg") .. " Egg"
					end

					local v2739
					local ok, result = pcall(function()
						return AssetCategory and Assets.Directory[AssetCategory]
					end)

					if ok and result and result.Egg and result.Egg.Icon then
						v2739 = tostring(result.Egg.Icon):gsub("rbxassetid://", "")
					end

					local v2742

					if v2739 then
						local ok2, result2 = pcall(function()
							local v2745 = v2670("https://thumbnails.roblox.com/v1/assets?assetIds=" .. v2739 .. "&size=420x420&format=Png&isCircular=false")
							local data = HttpService:JSONDecode(v2745)
							local data2 = data and data.data and data.data[1]

							if data2 and data2.state == "Completed" and data2.imageUrl then
								return data2.imageUrl
							end

							return nil
						end)

						if ok2 and result2 then
							v2742 = result2
						end
					end

					local n39 = 0

					if typeof(p828.Color) == "Color3" then
						local Color = p828.Color

						n39 = math.floor(Color.R * 255) * 65536 + math.floor(Color.G * 255) * 256 + math.floor(Color.B * 255)
					end

					local v2750 = v2686(p828) or {}
					local s7 = "Unknown"

					if type(v2750.WeightKg) == "number" then
						s7 = string.format("%s Kg", tostring(math.floor(v2750.WeightKg * 100 + 0.5) / 100))
					end

					local s8 = "Unknown"

					if type(v2750.Scale) == "number" then
						s8 = string.format("%.2fx", v2750.Scale)
					end

					local s9 = "Unknown"

					if type(v2750.RatePerSec) == "number" then
						s9 = "$" .. t20.formatMoneyShort(v2750.RatePerSec) .. "/s"
					end

					local v2754 = v2750.AreaId and v2750.AreaId ~= "Unknown" and tostring(v2750.AreaId)

					v2754 = v2754 or v235(p828.AssetCategory)

					local t145 = {
						author = {
							name = LocalPlayer.Name,
							icon_url = v2718()
						},
						description = "### " .. tostring(DisplayName),
						color = n39
					}
					local fields = {
						{
							name = "Rarity",
							value = tostring(Rarity),
							inline = true
						},
						{
							name = "Pet Species",
							value = tostring(AssetCategory or "Unknown"),
							inline = true
						},
						{
							name = "Weight",
							value = s7,
							inline = true
						},
						{
							name = "Value",
							value = s9,
							inline = true
						},
						{
							name = "Size",
							value = s8,
							inline = true
						},
						{
							name = "Area",
							value = v2754,
							inline = true
						}
					}

					t145.fields = fields
					t145.footer = {
						text = "Zeroin - Steal An Egg"
					}
					t145.timestamp = DateTime.now():ToIsoDate()

					if v2742 then
						t145.thumbnail = {
							url = v2742
						}
					end

					local v2759, v2760 = v2666(v2731, HttpService:JSONEncode({
						username = "Zeroin - Steal An Egg",
						embeds = { t145 }
					}))

					if not v2759 then
						error(v2760)
					end
				end)

				if not ok then
					warn("[Webhook] Gagal kirim webhook:", result)
				end
			end)
		end

		v2647:AddButton({
			Title = "Test Webhook",
			Icon = "send-horizontal",
			Column = "Full",
			Row = 4,
			Callback = v2725
		})
		pcall(function()
			v44(require(game:GetService("ReplicatedStorage").Client.EggState).AreaEggClaimed:Connect(function(p829)
				v2730(p829)
			end))
		end)
	end,
	Community = function()
		local v2761 = v512:AddTab({
			Name = "Community",
			Icon = "users"
		})

		genv.__ZeroinCommunityGeneration = (genv.__ZeroinCommunityGeneration or 0) + 1

		local __ZeroinCommunityGeneration = genv.__ZeroinCommunityGeneration
		local u2763 = true
		local HttpService = game:GetService("HttpService")
		local TeleportService = game:GetService("TeleportService")

		local function v2766(p830, p831, p832, p833)
			pcall(function()
				v305:MakeNotify({
					Title = p833 or "Zeroin",
					Description = "Community",
					Content = tostring(p830 or ""),
					Color = p832 or Color3.fromRGB(0, 205, 122),
					Delay = p831 or 3
				})
			end)
		end

		local t148 = {
			"wss://socket.zeroinhub.com",
			"wss://tunnel.zeroinhub.com"
		}
		local n40 = 1
		local t149 = {
			"Skeleton Horse (Dark Eternal)",
			"Pegasus (Light Eternal)",
			"World Burner (Dark Divine)",
			"ArchAngel (Light Divine)"
		}
		local t150 = {
			["Pegasus (Light Eternal)"] = "Skeleton Horse (Dark Eternal)",
			["Skeleton Horse (Dark Eternal)"] = "Pegasus (Light Eternal)",
			["ArchAngel (Light Divine)"] = "World Burner (Dark Divine)",
			["World Burner (Dark Divine)"] = "ArchAngel (Light Divine)"
		}
		local s10 = "Skeleton Horse (Dark Eternal)"
		local u2772 = t150[s10] or "Pegasus (Light Eternal)"
		local u2773
		local v2774 = tostring(LocalPlayer.UserId) == "11498668262"
		local u2775
		local u2776 = false
		local u2777 = false
		local u2778 = false
		local n41 = 0
		local u2780 = false
		local t151 = {}
		local u2782 = false
		local s11 = "Find Partner"
		local t152 = {}
		local t153 = {}
		local v2786 = v2761:AddSection({
			Title = "Community Mode",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 4
		})
		local v2787 = v2761:AddSection({
			Title = "Find Partner",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 4
		})
		local v2788 = v2761:AddSection({
			Title = "Community Feed",
			Layout = "Columns",
			ColumnGap = 6,
			ItemGap = 4
		})
		local v2789
		local v2790
		local n42 = 0

		local function createScreenGui()
			local PlayerGui = LocalPlayer:WaitForChild("PlayerGui")
			local ZeroinBroadcastGui = PlayerGui:FindFirstChild("ZeroinBroadcastGui")

			if ZeroinBroadcastGui then
				return ZeroinBroadcastGui
			end

			local ScreenGui = Instance.new("ScreenGui")

			ScreenGui.Name = "ZeroinBroadcastGui"
			ScreenGui.DisplayOrder = 999999
			ScreenGui.IgnoreGuiInset = false
			ScreenGui.ResetOnSpawn = false
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			ScreenGui.Parent = PlayerGui

			return ScreenGui
		end
		local function v2796(p834)
			n42 += 1

			local v2797 = n42
			local v2798 = createScreenGui()
			local BroadcastCard = v2798:FindFirstChild("BroadcastCard")

			if BroadcastCard then
				BroadcastCard:Destroy()
			end

			local ViewportSize = workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or Vector2.new(800, 450)
			local v2801 = ViewportSize.X < 600 or ViewportSize.Y < 360
			local v2802 = v2801 and 82 or 94
			local Frame = Instance.new("Frame")

			Frame.Name = "BroadcastCard"
			Frame.AnchorPoint = Vector2.new(0.5, 0)
			Frame.Position = UDim2.new(0.5, 0, 0, -v2802 - 18)
			Frame.Size = UDim2.new(v2801 and 0.92 or 0.76, 0, 0, v2802)
			Frame.BackgroundColor3 = Color3.fromRGB(5, 30, 20)
			Frame.BackgroundTransparency = 0.04
			Frame.BorderSizePixel = 0
			Frame.ClipsDescendants = true
			Frame.ZIndex = 20
			Frame.Parent = v2798

			local UISizeConstraint = Instance.new("UISizeConstraint")

			UISizeConstraint.MinSize = Vector2.new(math.min(270, math.max(220, ViewportSize.X - 20)), v2802)
			UISizeConstraint.MaxSize = Vector2.new(640, v2802)
			UISizeConstraint.Parent = Frame

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0, 12)
			UICorner.Parent = Frame

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = Color3.fromRGB(245, 194, 74)
			UIStroke.Transparency = 0.08
			UIStroke.Thickness = 1.5
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Frame

			local UIGradient = Instance.new("UIGradient")
			local colorSequenceKeypointNew = ColorSequenceKeypoint.new

			UIGradient.Color = ColorSequence.new({
				ColorSequenceKeypoint.new(0, Color3.fromRGB(5, 30, 20)),
				ColorSequenceKeypoint.new(0.65, Color3.fromRGB(9, 62, 40)),
				colorSequenceKeypointNew(1, Color3.fromRGB(55, 44, 18))
			})
			UIGradient.Rotation = 8
			UIGradient.Parent = Frame

			local Frame2 = Instance.new("Frame")

			Frame2.Name = "Accent"
			Frame2.Size = UDim2.new(1, 0, 0, 3)
			Frame2.BackgroundColor3 = Color3.fromRGB(245, 194, 74)
			Frame2.BorderSizePixel = 0
			Frame2.ZIndex = 21
			Frame2.Parent = Frame

			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Name = "OwnerAvatar"
			ImageLabel.BackgroundColor3 = Color3.fromRGB(10, 53, 35)
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Position = UDim2.fromOffset(v2801 and 12 or 15, v2801 and 15 or 18)
			ImageLabel.Size = UDim2.fromOffset(v2801 and 52 or 58, v2801 and 52 or 58)
			ImageLabel.ZIndex = 22
			ImageLabel.Parent = Frame

			local UICorner2 = Instance.new("UICorner")

			UICorner2.CornerRadius = UDim.new(1, 0)
			UICorner2.Parent = ImageLabel

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Color = Color3.fromRGB(0, 229, 137)
			UIStroke2.Thickness = 1.5
			UIStroke2.Transparency = 0.05
			UIStroke2.Parent = ImageLabel
			task.spawn(function()
				local ok, image = pcall(function()
					return Players:GetUserThumbnailAsync(tonumber("11498668262"), Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size150x150)
				end)

				if ok and ImageLabel.Parent then
					ImageLabel.Image = image
				end
			end)

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Name = "OwnerBadge"
			TextLabel.BackgroundColor3 = Color3.fromRGB(245, 194, 74)
			TextLabel.BorderSizePixel = 0
			TextLabel.Position = UDim2.fromOffset(v2801 and 76 or 86, v2801 and 12 or 15)
			TextLabel.Size = UDim2.fromOffset(v2801 and 112 or 122, 20)
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.Text = "ZEROIN OWNER"
			TextLabel.TextColor3 = Color3.fromRGB(39, 29, 7)
			TextLabel.TextSize = v2801 and 9 or 10
			TextLabel.ZIndex = 22
			TextLabel.Parent = Frame

			local UICorner3 = Instance.new("UICorner")

			UICorner3.CornerRadius = UDim.new(0, 5)
			UICorner3.Parent = TextLabel

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Name = "LiveLabel"
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.Position = UDim2.fromOffset(v2801 and 194 or 214, v2801 and 12 or 15)
			TextLabel2.Size = UDim2.fromOffset(90, 20)
			TextLabel2.Font = Enum.Font.GothamBold
			TextLabel2.Text = "LIVE BROADCAST"
			TextLabel2.TextColor3 = Color3.fromRGB(0, 229, 137)
			TextLabel2.TextSize = v2801 and 8 or 9
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.ZIndex = 22
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Name = "BroadcastText"
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.Position = UDim2.fromOffset(v2801 and 76 or 86, v2801 and 36 or 42)
			TextLabel3.Size = UDim2.new(1, v2801 and -88 or -101, 0, v2801 and 34 or 38)
			TextLabel3.Font = Enum.Font.GothamMedium
			TextLabel3.Text = tostring(p834.text or "")
			TextLabel3.TextColor3 = Color3.fromRGB(240, 250, 244)
			TextLabel3.TextSize = v2801 and 11 or 12
			TextLabel3.TextWrapped = true
			TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.TextYAlignment = Enum.TextYAlignment.Top
			TextLabel3.ZIndex = 22
			TextLabel3.Parent = Frame

			local v2819 = v2801 and 8 or 14

			TweenService:Create(Frame, TweenInfo.new(0.42, Enum.EasingStyle.Back, Enum.EasingDirection.Out), {
				Position = UDim2.new(0.5, 0, 0, v2819)
			}):Play()
			task.delay(math.clamp(6 + #TextLabel3.Text / 45, 7, 14), function()
				if v2797 ~= n42 or not Frame.Parent then
					return
				end

				local tween = TweenService:Create(Frame, TweenInfo.new(0.3, Enum.EasingStyle.Quart, Enum.EasingDirection.In), {
					Position = UDim2.new(0.5, 0, 0, -v2802 - 18),
					BackgroundTransparency = 1
				})

				tween:Play()
				tween.Completed:Wait()

				if Frame.Parent then
					Frame:Destroy()
				end
			end)
		end
		local function v2821(p835)
			local ZeroinOnTop = LocalPlayer.PlayerGui:FindFirstChild("ZeroinOnTop")

			if not ZeroinOnTop then
				return
			end

			for _, descendant in ipairs(ZeroinOnTop:GetDescendants()) do
				if descendant:IsA("Frame") and descendant.Name == "ChatBox" then
					local BottomBar = descendant:FindFirstChild("BottomBar")
					local MessagesScroll = descendant:FindFirstChild("MessagesScroll")

					if BottomBar and MessagesScroll then
						BottomBar.Visible = p835
						MessagesScroll.Size = p835 and UDim2.new(1, -12, 1, -60) or UDim2.new(1, -12, 1, -34)
					end
				end
			end
		end
		local function v2827(p836)
			local ZeroinOnTop = LocalPlayer.PlayerGui:FindFirstChild("ZeroinOnTop")

			if not ZeroinOnTop then
				return
			end

			for _, descendant in ipairs(ZeroinOnTop:GetDescendants()) do
				if descendant:IsA("TextButton") then
					if (descendant.Text:find("Teleport To Partner Server", 1, true) or descendant.Text:find("Leave / Disconnect Partner", 1, true)) and descendant.Parent then
						descendant.Parent.Visible = p836
					end
				end
			end
		end
		local function v2831(p837)
			if u2763 and genv.__ZeroinCommunityGeneration == __ZeroinCommunityGeneration and u2775 then
				if u2776 then
					pcall(function()
						u2775:Send(HttpService:JSONEncode(p837))
					end)
				end
			end
		end

		v44(TeleportService.TeleportInitFailed:Connect(function(p838, p839, p840)
			if p838 == LocalPlayer and u2773 and u2782 then
				u2782 = false
				v2831({
					action = "cancel_teleport"
				})
				v2766("Could not join " .. u2773.username .. "'s server: " .. tostring(p840 or p839), 5, Color3.fromRGB(255, 150, 90), "Teleport Failed")
			end
		end))

		local function v2832(p841)
			if s11 ~= "Find Partner" or u2773 or not v2789 then
				return
			end

			v2789:Clear()
			v2789:SetTitle("Find Partner (Global Feed)")
			v2789:SetPartner("Lobby Online (" .. tostring(#p841) .. ")")
			v2821(false)
			v2827(false)

			if #p841 == 0 then
				v2789:AddMessage({
					from = "partner",
					sender = "System",
					text = "No active partner requests. Posts appear here for 1 minute after a player clicks 'Find Partner (Post Request)'.",
					time = os.date("%H:%M")
				})
			else
				for _, v in ipairs(p841) do
					v.isOwn = tostring(v.userId) == tostring(LocalPlayer.UserId)

					local t154 = {
						from = v.isOwn and "self" or "partner",
						sender = v.isOwn and v.username .. " (Your Request)" or v.username,
						text = (v.isOwn and "YOUR REQUEST\n" or "") .. "🔍 Needs: " .. tostring(v.needsPet or "-") .. "\n💼 Has: " .. tostring(v.hasPet or "-"),
						time = os.date("%H:%M")
					}

					if not v.isOwn then
						t154.buttonText = "Join & Chat"
						t154.onButtonClick = function()
							v2831({
								action = "invite_partner",
								targetUserId = v.userId
							})
							v2766("Requesting Join & Chat with " .. v.username .. "...", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")
						end
					end

					v2789:AddMessage(t154)
				end
			end
		end
		local function v2836(p842)
			local v2837 = tonumber(p842)

			if v2837 and v2837 > 1e11 then
				v2837 = math.floor(v2837 / 1000)
			end

			return v2837 and os.date("%H:%M", v2837) or os.date("%H:%M")
		end
		local function v2838()
			if s11 ~= "Global Chat" or not v2789 then
				return
			end

			v2789:Clear()
			v2789:SetTitle("Global Chat")
			v2789:SetPartner("Public Community")
			v2821(true)
			v2827(false)

			if #t152 == 0 then
				v2789:AddMessage({
					from = "partner",
					sender = "System",
					text = "No messages yet. Start a conversation with players across all servers.",
					time = os.date("%H:%M")
				})

				return
			end

			for _, v in ipairs(t152) do
				local v2841 = tostring(v.userId) == tostring(LocalPlayer.UserId)
				local v2842 = v2789
				local AddMessage = v2789.AddMessage
				local t155 = {
					from = v2841 and "self" or "partner"
				}
				local displayName = v.isOwner and "ZEROIN OWNER" or v.displayName or v.username

				t155.sender = displayName or "Player"
				t155.variant = v.isOwner and "owner" or nil
				t155.text = tostring(v.text or "")
				t155.time = v2836(v.time)
				AddMessage(v2842, t155)
			end
		end
		local function v2846()
			if s11 ~= "Find Partner" or not u2773 or not v2789 then
				return
			end

			v2787:SetVisible(false)
			v2789:Clear()
			v2789:SetTitle("Private Chat")
			v2789:SetPartner(u2773.username, "Connected")
			v2821(true)
			v2827(true)

			for _, v in ipairs(t153) do
				v2789:AddMessage(v)
			end
		end
		local function v2849(p843)
			u2773 = p843
			v2787:SetVisible(false)
			t153 = { {
				from = "partner",
				sender = "System",
				text = "You are now privately connected with " .. p843.username .. "! You can now chat and teleport together.",
				time = os.date("%H:%M")
			} }

			if s11 ~= "Find Partner" and v2790 then
				v2790:SetValue("Find Partner")
			else
				v2846()
			end
		end
		local function v2850()
			u2773 = nil
			t153 = {}

			if s11 == "Find Partner" then
				v2787:SetVisible(true)
				v2832(t151)
				v2831({
					action = "list_partners"
				})
			end
		end
		local function v2851(p844)
			local v2852 = p844 == "Global Chat" and "Global Chat"

			s11 = v2852 or "Find Partner"
			v2787:SetVisible(s11 == "Find Partner" and not u2773)

			if s11 == "Global Chat" then
				v2838()
				v2831({
					action = "get_global_chat"
				})
			elseif u2773 then
				v2846()
			else
				v2832(t151)
				v2831({
					action = "list_partners"
				})
			end
		end

		v2790 = v2786:AddDropdown({
			Title = "Chat Mode",
			Content = "Switch between partner matchmaking and public conversation",
			Column = "Full",
			Row = 1,
			Multi = false,
			Options = {
				"Find Partner",
				"Global Chat"
			},
			Default = "Find Partner",
			Callback = function(p845)
				v2851(p845)
			end
		})

		if v2774 then
			local v2853 = v2786:AddInput({
				Title = "Owner Broadcast",
				Content = "Send a live announcement to every player currently using Zeroin",
				Column = "Full",
				Row = 2,
				Default = "",
				Callback = function()
				end
			})

			v2786:AddButton({
				Title = "Broadcast To All Players",
				Content = "Display this announcement at the top of every connected player's screen",
				Icon = "radio-tower",
				Column = "Full",
				Row = 3,
				Callback = function()
					local v2854 = tostring(v2853:GetValue() or ""):gsub("^%s+", ""):gsub("%s+$", "")

					if v2854 == "" then
						v2766("Enter a broadcast message first.", 3, Color3.fromRGB(245, 194, 74), "Owner Broadcast")

						return
					end

					v2831({
						action = "owner_broadcast",
						text = v2854
					})
					v2853:Set("")
					v2766("Broadcast sent to all connected Zeroin users.", 3, Color3.fromRGB(0, 229, 137), "Owner Broadcast")
				end
			})
		end

		v2787:AddDropdown({
			Title = "Required Egg / Pet",
			Content = "Select the partner pet or egg you need for fusion",
			Column = "Full",
			Row = 1,
			Multi = false,
			Options = t149,
			Default = s10,
			Callback = function(p846)
				s10 = p846
				u2772 = t150[p846] or u2772
			end
		})
		v2787:AddButton({
			Title = "Find Partner (Post Request)",
			Content = "Broadcast your request to the public feed so other players can join & chat",
			Column = "Full",
			Row = 2,
			Callback = function()
				v2766("Posting request for " .. tostring(s10) .. "...", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")
				v2831({
					action = "update_request",
					hasPet = u2772,
					needsPet = s10
				})
			end
		})
		v2788:AddButton({
			Title = "Teleport To Partner Server",
			Content = "Instantly join the active partner's server",
			Column = "Left",
			Row = 1,
			Callback = function()
				if not u2773 or not u2773.jobId or u2773.jobId == "" then
					v2766("You are not connected to a private partner!", 3, Color3.fromRGB(255, 120, 120), "Fuse Partner")

					return
				end

				u2782 = true
				v2831({
					action = "begin_teleport"
				})
				v2766("Preparing transfer to " .. u2773.username .. "'s server...", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")
			end
		})
		v2788:AddButton({
			Title = "Leave / Disconnect Partner",
			Content = "End private chat and return to the global feed",
			Column = "Right",
			Row = 1,
			Callback = function()
				if not u2773 then
					v2766("You are currently in the public feed.", 2, Color3.fromRGB(200, 200, 200), "Fuse Partner")

					return
				end

				v2831({
					action = "leave_partner"
				})
				v2850()
				v2766("Disconnected from private partner.", 2, Color3.fromRGB(200, 200, 200), "Fuse Partner")
			end
		})
		v2789 = v2788:AddChatBox({
			Title = "Community Feed",
			Height = 260,
			Placeholder = "Type a message...",
			Partner = "Community",
			Column = "Full",
			Row = 2,
			OnSend = function(p847)
				if s11 == "Global Chat" then
					v2831({
						action = "global_chat",
						text = p847
					})
				elseif u2773 then
					v2831({
						action = "chat",
						text = p847
					})
				else
					v2766("Join & Chat with a partner from the feed above first!", 3, Color3.fromRGB(220, 180, 60), "Fuse Partner")
				end
			end
		})
		v2851(v2790:GetValue())

		local v2855

		local function v2856()
			if u2763 then
				if genv.__ZeroinCommunityGeneration == __ZeroinCommunityGeneration and not u2776 and not u2777 and not u2778 then
					n41 += 1
					u2778 = true
					task.delay(math.min(30, 2 ^ math.min(n41, 5)) + math.random() * 1.5, function()
						u2778 = false

						if u2763 and not (genv.__ZeroinCommunityGeneration ~= __ZeroinCommunityGeneration or u2776) then
							v2855()
						end
					end)

					return
				end
			end
		end

		v2855 = function()
			if not u2763 or genv.__ZeroinCommunityGeneration ~= __ZeroinCommunityGeneration or u2776 or u2777 then
				return
			end

			u2777 = true

			local genv2 = getgenv and getgenv() or _G
			local connect = WebSocket and (WebSocket.connect or WebSocket.Connect) or syn and syn.websocket and syn.websocket.connect or KRNL and KRNL.WebSocket and (KRNL.WebSocket.connect or KRNL.WebSocket.Connect) or websocket and (websocket.connect or websocket.Connect) or fluxus and fluxus.websocket and fluxus.websocket.connect or genv2.WebSocket and (genv2.WebSocket.connect or genv2.WebSocket.Connect)

			if not connect then
				if v2789 then
					v2789:AddMessage({
						from = "partner",
						sender = "System",
						text = "Your executor does not support WebSocket.",
						time = os.date("%H:%M")
					})
				end

				u2777 = false

				return
			end

			local ok, result = pcall(connect, t148[n40])

			u2777 = false

			if not u2763 or genv.__ZeroinCommunityGeneration ~= __ZeroinCommunityGeneration then
				if ok and result then
					pcall(function()
						result:Close()
					end)
				end

				return
			end

			if ok and result then
				u2775 = result
				u2776 = true
				result:Send(HttpService:JSONEncode({
					action = "register",
					userId = tostring(LocalPlayer.UserId),
					username = LocalPlayer.Name,
					jobId = tostring(game.JobId),
					placeId = game.PlaceId,
					hasPet = u2772,
					needsPet = s10
				}))
				result.OnMessage:Connect(function(p848)
					if not u2763 or genv.__ZeroinCommunityGeneration ~= __ZeroinCommunityGeneration or u2775 ~= result then
						return
					end

					local ok2, result2 = pcall(function()
						return HttpService:JSONDecode(p848)
					end)

					if not ok2 or type(result2) ~= "table" then
						return
					end

					local type_ = result2.type

					if type_ == "registered" then
						n41 = 0

						if u2780 and v2789 then
							u2780 = false
							v2789:AddMessage({
								from = "partner",
								sender = "System",
								text = "Backend connection restored.",
								time = os.date("%H:%M")
							})
						end

						v2831({
							action = "list_partners"
						})

						if s11 == "Global Chat" then
							v2831({
								action = "get_global_chat"
							})
						end
					elseif type_ == "partners_list" then
						t151 = result2.partners or {}
						v2832(t151)
					elseif type_ == "global_chat_history" then
						t152 = result2.messages or {}
						v2838()
					elseif type_ == "global_chat_message" then
						local message = result2.message

						if type(message) == "table" then
							table.insert(t152, message)

							while #t152 > 50 do
								table.remove(t152, 1)
							end

							if s11 == "Global Chat" and v2789 then
								local v2865 = tostring(message.userId) == tostring(LocalPlayer.UserId)
								local v2866 = v2789
								local AddMessage = v2789.AddMessage
								local t156 = {
									from = v2865 and "self" or "partner",
									sender = message.isOwner and "ZEROIN OWNER" or message.displayName or message.username or "Player"
								}
								local variant = message.isOwner and "owner"

								t156.variant = variant or nil
								t156.text = tostring(message.text or "")
								t156.time = v2836(message.time)
								AddMessage(v2866, t156)
							end
						end
					elseif type_ ~= "owner_broadcast" then
						if type_ == "partner_invite" then
							local fromUsername = result2.fromUsername or "Player"

							v2766(string.format("%s invited you to fuse!\nOpen Community tab to accept/decline.", fromUsername), 5, Color3.fromRGB(0, 229, 137), "Incoming Invitation")

							if v2789 and not u2773 then
								if s11 ~= "Find Partner" and v2790 then
									v2790:SetValue("Find Partner")
								end

								local v2871 = v2789
								local AddMessage = v2789.AddMessage
								local t157 = {
									from = "partner",
									sender = "🔔 INVITATION: " .. fromUsername,
									text = string.format([[💼 Has: %s
🔍 Needs: %s
Do you want to accept and start private chat?]], result2.hasPet or "-", result2.needsPet or "-"),
									bubbleColor = Color3.fromRGB(15, 60, 42)
								}
								local actions = {
									{
										text = "Decline ✕",
										width = 72,
										color = Color3.fromRGB(65, 25, 25),
										textColor = Color3.fromRGB(255, 170, 170),
										onClick = function()
											v2831({
												action = "reject_invite",
												fromUserId = result2.fromUserId
											})
											v2766("Declined invitation from " .. fromUsername, 2, Color3.fromRGB(200, 200, 200), "Fuse Partner")
											v2832(t151)
										end
									},
									{
										text = "Accept ✓",
										width = 78,
										color = Color3.fromRGB(0, 205, 122),
										textColor = Color3.fromRGB(4, 25, 16),
										onClick = function()
											v2831({
												action = "accept_invite",
												fromUserId = result2.fromUserId
											})
											v2766("Accepted invitation! Connecting...", 2, Color3.fromRGB(0, 205, 122), "Fuse Partner")
										end
									}
								}

								t157.actions = actions
								t157.time = os.date("%H:%M")
								AddMessage(v2871, t157)
							end
						elseif type_ == "invite_rejected" then
							v2766("Player " .. tostring(result2.fromUsername or "") .. " declined the invitation.", 3, Color3.fromRGB(255, 120, 120), "Fuse Partner")
						elseif type_ == "partner_connected" then
							u2782 = false
							v2766("Connected with partner " .. tostring(result2.partner and result2.partner.username or "") .. "!", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")
							v2849(result2.partner)
						elseif type_ == "request_updated" then
							v2766("Your partner request is live for 1 minute.", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")
						elseif type_ == "request_expired" then
							v2766("Your partner request expired. Post again if you still need a partner.", 3, Color3.fromRGB(220, 160, 60), "Fuse Partner")
						elseif type_ ~= "teleport_ready" then
							if type_ == "error" then
								v2766(tostring(result2.message or "Partner request failed."), 4, Color3.fromRGB(255, 120, 120), "Fuse Partner")
							elseif type_ == "chat_message" then
								local t160 = {
									from = "partner",
									sender = result2.fromUsername or u2773 and u2773.username or "Partner",
									text = result2.text,
									time = os.date("%H:%M")
								}

								table.insert(t153, t160)

								if v2789 and s11 == "Find Partner" then
									v2789:AddMessage(t160)
								end
							elseif type_ == "chat_sent" then
								local t161 = {
									from = "self",
									text = result2.text,
									time = os.date("%H:%M")
								}

								table.insert(t153, t161)

								if v2789 and s11 == "Find Partner" then
									v2789:AddMessage(t161)
								end
							elseif type_ == "partner_disconnected" or type_ == "partner_left" then
								v2766("Partner has left or disconnected.", 3, Color3.fromRGB(220, 160, 60), "Fuse Partner")
								v2850()
							end
						elseif u2782 and u2773 then
							v2766("Teleporting to " .. u2773.username .. "...", 3, Color3.fromRGB(0, 205, 122), "Fuse Partner")

							local ok3, result3 = pcall(function()
								TeleportService:TeleportToPlaceInstance(u2773.placeId or game.PlaceId, u2773.jobId, LocalPlayer)
							end)

							if not ok3 then
								u2782 = false
								v2831({
									action = "cancel_teleport"
								})
								v2766("Could not join the partner server. Private chat is still connected.", 4, Color3.fromRGB(255, 150, 90), "Teleport Failed")
								warn("[Fuse Partner] Teleport failed: " .. tostring(result3))
							end
						end
					elseif type(result2.announcement) == "table" then
						v2796(result2.announcement)
					end
				end)
				result.OnClose:Connect(function()
					if u2775 ~= result then
						return
					end

					u2776 = false
					u2775 = nil
					n40 = n40 % #t148 + 1
					v2856()
				end)

				return
			end

			n40 = n40 % #t148 + 1

			if v2789 and not u2780 then
				u2780 = true
				v2789:AddMessage({
					from = "partner",
					sender = "System",
					text = "Backend connection is temporarily unavailable. Reconnecting automatically...",
					time = os.date("%H:%M")
				})
			end

			v2856()
		end
		v511:OnClose(function()
			u2763 = false

			if genv.__ZeroinCommunityGeneration == __ZeroinCommunityGeneration then
				genv.__ZeroinCommunityGeneration = __ZeroinCommunityGeneration + 1
			end

			u2776 = false
			u2777 = false
			u2778 = false

			local v2881 = u2775

			u2775 = nil

			if v2881 then
				pcall(function()
					v2881:Close()
				end)
			end
		end)
		task.spawn(v2855)
	end,
	Misc = function()
		local v2882 = v512:AddTab({
			Name = "ESP",
			Icon = "scan-eye"
		})
		local v2883 = v512:AddTab({
			Name = "Panel",
			Icon = "panels-top-left"
		})
		local v2884 = v512:AddTab({
			Name = "Misc",
			Icon = "settings"
		})
		local v2885 = v2884:AddSection({
			Title = "Performance",
			Layout = "Grid",
			ItemGap = 4
		})

		v2885:AddToggle({
			Title = "Boost FPS",
			Content = "Extreme: grey parts, delete other plots, treadmills & decorations",
			Column = "Left",
			Row = 1,
			Default = false,
			Callback = function(p849)
				if p849 then
					v508()
				end
			end
		})
		v2885:AddToggle({
			Title = "Uncap FPS (240 FPS)",
			Content = "Unlock 240 FPS & smooth graphics (no texture, keep colors)",
			Column = "Right",
			Row = 1,
			Default = false,
			Callback = function(p850)
				if p850 then
					local __ZeroinSetCapFps = genv.__ZeroinSetCapFps

					if type(__ZeroinSetCapFps) == "function" then
						__ZeroinSetCapFps(240)
					end

					v401()
				end
			end
		})
		v2884:AddSection({
			Title = "Anti AFK",
			Layout = "Grid",
			ItemGap = 4
		}):AddToggle({
			Title = "Anti AFK",
			Content = "Disable captured LocalPlayer.Idled connections",
			Column = "Full",
			Row = 1,
			Default = zeroinConfig.AntiAFK == true,
			Callback = function(p851)
				zeroinConfig.AntiAFK = v281:setEnabled(p851)
			end
		})
		v2884:AddSection({
			Title = "Auto Reconnect",
			Layout = "Grid",
			ItemGap = 4
		}):AddToggle({
			Title = "Auto Reconnect",
			Content = "Automatically rejoin server when disconnected or kicked",
			Column = "Full",
			Row = 1,
			Default = zeroinConfig.AutoReconnect == true,
			Callback = function(p852)
				zeroinConfig.AutoReconnect = p852 == true
			end
		})
		v2884:AddSection({
			Title = "Community & Support",
			Layout = "Grid",
			ItemGap = 4
		}):AddButton({
			Title = "Join Discord",
			Content = "Get update info, report bugs & suggest features",
			Column = "Full",
			Row = 1,
			Callback = function()
				pcall(function()
					if setclipboard then
						setclipboard("https://discord.gg/CvVW5DBZKR")
					end

					local openurl_ = openurl or open_url

					openurl_ = openurl_ or syn and syn.open_url

					if type(openurl_) == "function" then
						pcall(openurl_, "https://discord.gg/CvVW5DBZKR")
					end

					game:GetService("StarterGui"):SetCore("SendNotification", {
						Title = "Zeroin",
						Text = "Opening Discord & copying link to clipboard!",
						Duration = 4
					})
				end)
			end
		})

		local function v2888()
			local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
			local Directory = require(ReplicatedStorage2.Data.Assets).Directory
			local AssetEarnings = require(ReplicatedStorage2.Shared.Util.AssetEarnings)
			local EggRecords = require(ReplicatedStorage2.Shared.Util.EggRecords)
			local Save = require(ReplicatedStorage2.Shared.Save)
			local EggState2 = require(ReplicatedStorage2.Client.EggState)
			local AreaEggs = require(ReplicatedStorage2.Shared.Types.AreaEggs)

			local function v2896(p853)
				local v2897 = math.max(tonumber(p853) or 0, 0)

				if v2897 >= 1e15 then
					return string.format("%.2fQ", v2897 / 1e15):gsub("%.00Q", "Q")
				end

				if v2897 >= 1e12 then
					return string.format("%.2fT", v2897 / 1e12):gsub("%.00T", "T")
				end

				return t20.formatMoneyShort(v2897)
			end
			local function v2898(p854, p855)
				local AssetCategory = p854.AssetCategory or p854.Category

				if type(AssetCategory) ~= "string" then
					return nil
				end

				local ok, result = pcall(AssetEarnings.LiveRatePerSecond, {
					Category = AssetCategory,
					Scale = math.max(tonumber(p854.AssetScale or p854.Scale) or 1, 0.01),
					Mutations = type(p854.Mutations) == "table" and p854.Mutations or {},
					BaseMutation = p854.BaseMutation
				}, p855 and p855.Gamepasses, p855 and p855.Products)
				local v2902 = ok and type(result) == "number"

				return v2902 and math.max(result, 0) or nil
			end
			local function v2903(p856)
				local ok, result = pcall(EggRecords.WeightKg, p856)

				if ok and type(result) == "number" then
					return math.max(result, 0)
				end

				local AssetCategory = p856.AssetCategory or p856.Category
				local v2907 = tonumber(p856.AssetScale or p856.Scale)
				local ok2, result2 = pcall(EggRecords.WeightKgForScale, AssetCategory, v2907)

				return ok2 and type(result2) == "number" and math.max(result2, 0) or nil
			end
			local function v2910(p857)
				local v2911 = type(p857) == "string" and Directory[p857] or nil
				local Rarity = v2911 and v2911.Rarity
				local DisplayName = Rarity and (Rarity.DisplayName or Rarity._id) or "Unknown"
				local Color = Rarity and Rarity.Color or Color3.fromRGB(255, 255, 255)
				local DisplayName2 = v2911 and (v2911.DisplayName or v2911._id)

				if not DisplayName2 then
					DisplayName2 = tostring(p857 or "Egg")
				end

				return DisplayName, Color, DisplayName2
			end
			local function v2916(p858)
				local t162 = {}

				local function v2918(p859)
					if type(p859) == "string" and p859 ~= "" and not table.find(t162, p859) then
						t162[#t162 + 1] = p859
					end
				end

				v2918(p858.BaseMutation)

				local ipairs_ = ipairs
				local Mutations = type(p858.Mutations) == "table" and p858.Mutations or {}

				for _, Mutation in ipairs_(Mutations) do
					v2918(Mutation)
				end

				return #t162 > 0 and table.concat(t162, ", ") or "None"
			end
			local function v2923(p860, p861)
				local __ZeroinAreaEggESP = p860:FindFirstChild("__ZeroinAreaEggESP")

				if not __ZeroinAreaEggESP then
					__ZeroinAreaEggESP = Instance.new("BillboardGui")
					__ZeroinAreaEggESP.Name = "__ZeroinAreaEggESP"
					__ZeroinAreaEggESP.AlwaysOnTop = true
					__ZeroinAreaEggESP.Size = UDim2.fromOffset(230, 42)
					__ZeroinAreaEggESP.StudsOffset = Vector3.new(0, 3.2, 0)
					__ZeroinAreaEggESP.MaxDistance = 850

					local TextLabel = Instance.new("TextLabel")

					TextLabel.Name = "Text"
					TextLabel.Size = UDim2.fromScale(1, 1)
					TextLabel.BackgroundTransparency = 1
					TextLabel.Font = Enum.Font.GothamBold
					TextLabel.TextSize = 12
					TextLabel.TextStrokeColor3 = Color3.fromRGB(4, 10, 7)
					TextLabel.TextStrokeTransparency = 0.2
					TextLabel.TextXAlignment = Enum.TextXAlignment.Center
					TextLabel.TextYAlignment = Enum.TextYAlignment.Center
					TextLabel.Parent = __ZeroinAreaEggESP
					__ZeroinAreaEggESP.Parent = p860
				end

				__ZeroinAreaEggESP.Adornee = p861

				return __ZeroinAreaEggESP:FindFirstChild("Text")
			end
			local function v2926(p862)
				local ok, result = pcall(EggRecords.DisplayNameWithWeight, p862)

				return ok and type(result) == "string" and result ~= "" and result or nil
			end
			local function createTextLabel(p863)
				local __ZeroinInventoryValue = p863:FindFirstChild("__ZeroinInventoryValue")

				if __ZeroinInventoryValue then
					return __ZeroinInventoryValue
				end

				local TextLabel = Instance.new("TextLabel")

				TextLabel.Name = "__ZeroinInventoryValue"
				TextLabel.AnchorPoint = Vector2.new(0.5, 0)
				TextLabel.Position = UDim2.new(0.5, 0, 0, 3)
				TextLabel.Size = UDim2.new(1, -8, 0, 18)
				TextLabel.BackgroundColor3 = Color3.fromRGB(6, 31, 21)
				TextLabel.BackgroundTransparency = 0.14
				TextLabel.BorderSizePixel = 0
				TextLabel.Font = Enum.Font.GothamBold
				TextLabel.TextColor3 = Color3.fromRGB(110, 244, 166)
				TextLabel.TextStrokeColor3 = Color3.fromRGB(2, 10, 7)
				TextLabel.TextStrokeTransparency = 0.45
				TextLabel.TextSize = 12
				TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
				TextLabel.TextXAlignment = Enum.TextXAlignment.Center
				TextLabel.ZIndex = math.max(p863.ZIndex + 6, 30)

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(0, 4)
				UICorner.Parent = TextLabel
				TextLabel.Parent = p863

				return TextLabel
			end
			local function createTextBox(p864)
				local __ZeroinInventoryTotal = p864:FindFirstChild("__ZeroinInventoryTotal", true)

				if __ZeroinInventoryTotal and __ZeroinInventoryTotal:IsA("TextBox") then
					return __ZeroinInventoryTotal
				end

				local v2935

				for _, descendant in ipairs(p864:GetDescendants()) do
					if descendant:IsA("TextBox") then
						v2935 = descendant

						break
					end
				end

				local Parent = v2935 and v2935.Parent
				local Parent2 = Parent and Parent.Parent

				if not v2935 or not Parent or not Parent2 or not Parent2:IsA("GuiObject") then
					return nil
				end

				local TextBox = Instance.new("TextBox")

				TextBox.Name = "__ZeroinInventoryTotal"
				TextBox.AnchorPoint = Vector2.new(0, 0)
				TextBox.Position = UDim2.new(0, 8, Parent.Position.Y.Scale, Parent.Position.Y.Offset)
				TextBox.Size = UDim2.new(Parent.Position.X.Scale, Parent.Position.X.Offset - 16, Parent.Size.Y.Scale, Parent.Size.Y.Offset)
				TextBox.BackgroundColor3 = Color3.fromRGB(7, 34, 23)
				TextBox.BackgroundTransparency = 0.06
				TextBox.BorderSizePixel = 0
				TextBox.Font = Enum.Font.GothamBold
				TextBox.ClearTextOnFocus = false
				TextBox.TextEditable = false
				TextBox.TextColor3 = Color3.fromRGB(110, 244, 166)
				TextBox.TextSize = 13
				TextBox.TextXAlignment = Enum.TextXAlignment.Left
				TextBox.ZIndex = math.max(v2935.ZIndex + 2, 20)

				local UIPadding = Instance.new("UIPadding")

				UIPadding.PaddingLeft = UDim.new(0, 10)
				UIPadding.PaddingRight = UDim.new(0, 10)
				UIPadding.Parent = TextBox

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(0, 5)
				UICorner.Parent = TextBox

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = Color3.fromRGB(34, 91, 68)
				UIStroke.Transparency = 0.25
				UIStroke.Parent = TextBox
				TextBox.Parent = Parent2

				return TextBox
			end

			local t163 = {
				destroyed = false,
				areaEnabled = false,
				placedEnabled = false,
				inventoryEnabled = false,
				labels = {},
				resources = {},
				refreshPending = false,
				areaGeneration = 0,
				placedGeneration = 0,
				inventoryGeneration = 0,
				refreshArea = function(p865)
					local AreaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")

					if not AreaEggSlotsClient then
						return
					end

					local v2946 = Save.Get()
					local v2947 = EggState2.ReadFieldEggs()
					local Records = v2947 and v2947.Records or {}

					if #Records == 0 then
						pcall(function()
							local v2949 = EggState2.SyncFieldEggs()

							if v2949 and v2949.Records then
								Records = v2949.Records
							end
						end)
					end

					local t164 = {}

					for _, Record in ipairs(Records) do
						if Record.Uid then
							t164[Record.Uid] = Record
						end
					end

					for _, child in ipairs(AreaEggSlotsClient:GetChildren()) do
						local v2955 = t164[child.Name] or EggState2.ReadFieldEgg(child.Name)
						local v2956 = p865.areaEnabled and type(v2955) == "table" and (v2955.State == AreaEggs.States.Slot or v2955.State == AreaEggs.States.Dropped)
						local Hitbox = v2956 and (child:FindFirstChild("Hitbox") or child:FindFirstChildWhichIsA("BasePart", true))
						local __ZeroinAreaEggESP = child:FindFirstChild("__ZeroinAreaEggESP")
						local __ZeroinAreaEggHighlight = child:FindFirstChild("__ZeroinAreaEggHighlight")

						if v2956 then
							if Hitbox then
								local v2960, v2961, v2962 = v2910(v2955.AssetCategory)
								local v2963 = v2898(v2955, v2946)
								local v2964 = v2903(v2955)
								local v2965 = v2923(child, Hitbox)

								v2965.TextColor3 = v2961
								v2965.Text = string.format("%s\n%s  |  $%s/s  |  %s Kg", v2962, v2960, v2963 and v2896(v2963) or "?", v2964 and string.format("%.1f", v2964) or "?")

								if not __ZeroinAreaEggHighlight then
									__ZeroinAreaEggHighlight = Instance.new("Highlight")
									__ZeroinAreaEggHighlight.Name = "__ZeroinAreaEggHighlight"
									__ZeroinAreaEggHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
									__ZeroinAreaEggHighlight.Parent = child
								end

								__ZeroinAreaEggHighlight.Adornee = child
								__ZeroinAreaEggHighlight.FillColor = v2961
								__ZeroinAreaEggHighlight.FillTransparency = 0.82
								__ZeroinAreaEggHighlight.OutlineColor = v2961
								__ZeroinAreaEggHighlight.OutlineTransparency = 0.12

								continue
							end
						end

						if __ZeroinAreaEggESP then
							__ZeroinAreaEggESP:Destroy()
						end

						if __ZeroinAreaEggHighlight then
							__ZeroinAreaEggHighlight:Destroy()
						end
					end
				end,
				refreshPlaced = function(p866)
					local PlacedEggRenders = workspace:FindFirstChild("PlacedEggRenders")

					if not PlacedEggRenders then
						return
					end

					local v2967 = Save.Get()
					local t165 = {}
					local pairs_ = pairs
					local EggInventory = v2967 and v2967.EggInventory or {}

					for k, v in pairs_(EggInventory) do
						if p866.placedEnabled and type(k) == "string" and type(v) == "table" and v.Placement ~= nil and type(v.AssetCategory) == "string" then
							local v2973 = PlacedEggRenders:FindFirstChild(string.format("%d_%s", LocalPlayer.UserId, k))

							if v2973 and v2973:IsA("Model") then
								t165[v2973] = true

								local PrimaryPart = v2973.PrimaryPart or v2973:FindFirstChild("Hitbox") or v2973:FindFirstChildWhichIsA("BasePart", true)

								if PrimaryPart then
									local v2975, v2976, v2977 = v2910(v.AssetCategory)
									local v2978 = v2898(v, v2967)
									local v2979 = v2903(v)
									local __ZeroinPlacedEggESP = v2973:FindFirstChild("__ZeroinPlacedEggESP")

									if not __ZeroinPlacedEggESP then
										__ZeroinPlacedEggESP = Instance.new("BillboardGui")
										__ZeroinPlacedEggESP.Name = "__ZeroinPlacedEggESP"
										__ZeroinPlacedEggESP.AlwaysOnTop = true
										__ZeroinPlacedEggESP.Size = UDim2.fromOffset(250, 58)
										__ZeroinPlacedEggESP.StudsOffset = Vector3.new(0, 3.4, 0)
										__ZeroinPlacedEggESP.MaxDistance = 650

										local TextLabel = Instance.new("TextLabel")

										TextLabel.Name = "Text"
										TextLabel.Size = UDim2.fromScale(1, 1)
										TextLabel.BackgroundTransparency = 1
										TextLabel.Font = Enum.Font.GothamBold
										TextLabel.TextSize = 12
										TextLabel.TextStrokeColor3 = Color3.fromRGB(4, 10, 7)
										TextLabel.TextStrokeTransparency = 0.2
										TextLabel.TextXAlignment = Enum.TextXAlignment.Center
										TextLabel.TextYAlignment = Enum.TextYAlignment.Center
										TextLabel.Parent = __ZeroinPlacedEggESP
										__ZeroinPlacedEggESP.Parent = v2973
									end

									__ZeroinPlacedEggESP.Adornee = PrimaryPart

									local Text = __ZeroinPlacedEggESP:FindFirstChild("Text")

									Text.TextColor3 = v2976
									Text.Text = string.format("%s\n%s  |  $%s/s  |  %s Kg\nMutation: %s", v2977, v2975, v2978 and v2896(v2978) or "?", v2979 and string.format("%.1f", v2979) or "?", v2916(v))

									local __ZeroinPlacedEggHighlight = v2973:FindFirstChild("__ZeroinPlacedEggHighlight")

									if not __ZeroinPlacedEggHighlight then
										__ZeroinPlacedEggHighlight = Instance.new("Highlight")
										__ZeroinPlacedEggHighlight.Name = "__ZeroinPlacedEggHighlight"
										__ZeroinPlacedEggHighlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
										__ZeroinPlacedEggHighlight.Parent = v2973
									end

									__ZeroinPlacedEggHighlight.Adornee = v2973
									__ZeroinPlacedEggHighlight.FillColor = v2976
									__ZeroinPlacedEggHighlight.FillTransparency = 0.88
									__ZeroinPlacedEggHighlight.OutlineColor = v2976
									__ZeroinPlacedEggHighlight.OutlineTransparency = 0.18
								end
							end
						end
					end

					for _, child in ipairs(PlacedEggRenders:GetChildren()) do
						if not t165[child] then
							local __ZeroinPlacedEggESP = child:FindFirstChild("__ZeroinPlacedEggESP")
							local __ZeroinPlacedEggHighlight = child:FindFirstChild("__ZeroinPlacedEggHighlight")

							if __ZeroinPlacedEggESP then
								__ZeroinPlacedEggESP:Destroy()
							end

							if __ZeroinPlacedEggHighlight then
								__ZeroinPlacedEggHighlight:Destroy()
							end
						end
					end
				end,
				inventoryValues = function()
					local v2988 = Save.Get()
					local t166 = {}
					local n43 = 0
					local pairs_ = pairs
					local EggInventory = v2988 and v2988.EggInventory or {}

					for _, v in pairs_(EggInventory) do
						if type(v) == "table" then
							if v.Placement == nil then
								local v2995 = v2926(v)
								local v2996 = v2898(v, v2988)

								if v2995 and v2996 then
									t166[v2995] = t166[v2995] or {}
									t166[v2995][#t166[v2995] + 1] = v2996
									n43 += v2996
								end
							end
						end
					end

					for _, v in pairs(t166) do
						table.sort(v, function(p867, p868)
							return p867 > p868
						end)
					end

					return t166, n43
				end,
				refreshInventory = function(p869)
					if not p869.inventoryEnabled then
						return
					end

					local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
					local BackpackGui = PlayerGui and PlayerGui:FindFirstChild("BackpackGui")

					if not BackpackGui then
						return
					end

					local v3001, v3002 = p869:inventoryValues()
					local t167 = {}

					for _, descendant in ipairs(BackpackGui:GetDescendants()) do
						if descendant:IsA("GuiButton") and descendant:GetAttribute("IsInventorySlot") == true and descendant.Name ~= "Template" then
							t167[#t167 + 1] = descendant
						end
					end

					table.sort(t167, function(p870, p871)
						return p870.LayoutOrder < p871.LayoutOrder
					end)

					for _, v in ipairs(t167) do
						local ToolName = v:FindFirstChild("ToolName")
						local v3009 = ToolName and v3001[ToolName.Text]
						local v3010 = v3009 and table.remove(v3009, 1)
						local __ZeroinInventoryValue = v:FindFirstChild("__ZeroinInventoryValue")

						if v3010 then
							local v3012 = createTextLabel(v)

							v3012.Text = "$" .. v2896(v3010) .. "/s"
							v3012.Visible = ToolName.Text ~= ""
						elseif __ZeroinInventoryValue then
							__ZeroinInventoryValue.Visible = false
						end
					end

					local v3013 = createTextBox(BackpackGui)

					if v3013 then
						v3013.Text = "Total Egg Value  |  $" .. v2896(v3002) .. "/s"
					end
				end,
				removeInventory = function()
					local PlayerGui = LocalPlayer:FindFirstChildOfClass("PlayerGui")
					local ipairs_ = ipairs
					local descendants = PlayerGui and PlayerGui:GetDescendants() or {}

					for _, descendant in ipairs_(descendants) do
						if descendant.Name == "__ZeroinInventoryValue" or descendant.Name == "__ZeroinInventoryTotal" then
							descendant:Destroy()
						end
					end
				end,
				scheduleInventory = function(p872)
					if not p872.refreshPending and p872.inventoryEnabled then
						if not p872.destroyed then
							p872.refreshPending = true
							task.delay(0.08, function()
								p872.refreshPending = false
								p872:refreshInventory()
							end)

							return
						end
					end
				end,
				setAreaEnabled = function(p873, p874)
					p873.areaEnabled = p874 == true
					p873.areaGeneration += 1

					local areaGeneration = p873.areaGeneration

					if p873.areaEnabled then
						p873:refreshArea()
						task.spawn(function()
							while not p873.destroyed and p873.areaEnabled and p873.areaGeneration == areaGeneration do
								task.wait(0.75)

								if not p873.destroyed and p873.areaEnabled and p873.areaGeneration == areaGeneration then
									p873:refreshArea()
								end
							end
						end)
					else
						local AreaEggSlotsClient = workspace:FindFirstChild("AreaEggSlotsClient")
						local ipairs_ = ipairs
						local children = AreaEggSlotsClient and AreaEggSlotsClient:GetChildren() or {}

						for _, child in ipairs_(children) do
							local __ZeroinAreaEggESP = child:FindFirstChild("__ZeroinAreaEggESP")
							local __ZeroinAreaEggHighlight = child:FindFirstChild("__ZeroinAreaEggHighlight")

							if __ZeroinAreaEggESP then
								__ZeroinAreaEggESP:Destroy()
							end

							if __ZeroinAreaEggHighlight then
								__ZeroinAreaEggHighlight:Destroy()
							end
						end
					end
				end,
				setInventoryEnabled = function(p875, p876)
					p875.inventoryEnabled = p876 == true
					p875.inventoryGeneration += 1

					local inventoryGeneration = p875.inventoryGeneration

					if p875.inventoryEnabled then
						p875:scheduleInventory()
						task.spawn(function()
							while not p875.destroyed do
								if not p875.inventoryEnabled or p875.inventoryGeneration ~= inventoryGeneration then
									break
								end

								task.wait(0.75)

								if not p875.destroyed and p875.inventoryEnabled and p875.inventoryGeneration == inventoryGeneration then
									p875:refreshInventory()
								end
							end
						end)
					else
						p875:removeInventory()
					end
				end,
				setPlacedEnabled = function(p877, p878)
					p877.placedEnabled = p878 == true
					p877.placedGeneration += 1

					local placedGeneration = p877.placedGeneration

					if p877.placedEnabled then
						p877:refreshPlaced()
						task.spawn(function()
							while not p877.destroyed and p877.placedEnabled and p877.placedGeneration == placedGeneration do
								task.wait(0.75)

								if not p877.destroyed and p877.placedEnabled and p877.placedGeneration == placedGeneration then
									p877:refreshPlaced()
								end
							end
						end)
					else
						local PlacedEggRenders = workspace:FindFirstChild("PlacedEggRenders")
						local ipairs_ = ipairs
						local children = PlacedEggRenders and PlacedEggRenders:GetChildren() or {}

						for _, child in ipairs_(children) do
							local __ZeroinPlacedEggESP = child:FindFirstChild("__ZeroinPlacedEggESP")
							local __ZeroinPlacedEggHighlight = child:FindFirstChild("__ZeroinPlacedEggHighlight")

							if __ZeroinPlacedEggESP then
								__ZeroinPlacedEggESP:Destroy()
							end

							if __ZeroinPlacedEggHighlight then
								__ZeroinPlacedEggHighlight:Destroy()
							end
						end
					end
				end,
				destroy = function(p879)
					if p879.destroyed then
						return
					end

					p879.destroyed = true
					p879:setAreaEnabled(false)
					p879:setPlacedEnabled(false)
					p879:setInventoryEnabled(false)

					for _, resource in ipairs(p879.resources) do
						pcall(resource.Disconnect, resource)
					end

					table.clear(p879.resources)
				end
			}

			if EggState2.FieldRefreshed then
				t163.resources[#t163.resources + 1] = EggState2.FieldRefreshed:Connect(function()
					if t163.areaEnabled then
						t163:refreshArea()
					end
				end)
			end

			t163.resources[#t163.resources + 1] = EggState2.FieldShifted:Connect(function()
				if t163.areaEnabled then
					t163:refreshArea()
				end
			end)
			t163.resources[#t163.resources + 1] = EggState2.FieldGone:Connect(function()
				if t163.areaEnabled then
					t163:refreshArea()
				end
			end)
			t163.resources[#t163.resources + 1] = LocalPlayer.PlayerGui.DescendantAdded:Connect(function(descendant)
				if t163.inventoryEnabled and (descendant.Name == "ToolName" or descendant.Name == "BackpackGui" or descendant:GetAttribute("IsInventorySlot") == true) then
					t163:scheduleInventory()
				end
			end)
			t163.resources[#t163.resources + 1] = Save.WatchFields({
				"Inventory",
				"EggInventory",
				"Gamepasses",
				"Products"
			}, function()
				if t163.placedEnabled then
					t163:refreshPlaced()
				end

				t163:scheduleInventory()
			end)

			return t163
		end

		local v3038 = v2888()

		genv.__ZeroinVisualRuntime = v3038
		genv.__ZeroinVisualCleanup = function()
			v3038:destroy()

			if genv.__ZeroinVisualRuntime == v3038 then
				genv.__ZeroinVisualRuntime = nil
			end

			genv.__ZeroinVisualCleanup = nil
		end

		local v3039 = v2882:AddSection({
			Title = "Area Egg ESP",
			Layout = "Grid",
			ItemGap = 4
		})

		v3039:AddParagraph({
			Title = "Live Area Eggs",
			Content = "Show egg name, rarity, value per second, and weight above every available egg in the world.",
			Icon = "scan-search",
			Column = "Full",
			Row = 1
		})
		v3039:AddToggle({
			Title = "Area Egg ESP",
			Content = "Track Slot and Dropped eggs across all areas",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.EggESP == true,
			Callback = function(p880)
				zeroinConfig.EggESP = p880 == true
				v3038:setAreaEnabled(zeroinConfig.EggESP)
			end
		})

		local v3040 = v2882:AddSection({
			Title = "Placed Egg ESP",
			Layout = "Grid",
			ItemGap = 4
		})

		v3040:AddParagraph({
			Title = "Your Plot Eggs",
			Content = "Show name, rarity, value per second, and weight above eggs placed in your plot.",
			Icon = "map-pinned",
			Column = "Full",
			Row = 1
		})
		v3040:AddToggle({
			Title = "Placed Egg ESP",
			Content = "Only tracks eggs placed by your account",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.PlacedEggESP == true,
			Callback = function(p881)
				zeroinConfig.PlacedEggESP = p881 == true
				v3038:setPlacedEnabled(zeroinConfig.PlacedEggESP)
			end
		})

		local v3041 = v2882:AddSection({
			Title = "Inventory ESP",
			Layout = "Grid",
			ItemGap = 4
		})

		v3041:AddParagraph({
			Title = "Inventory Value",
			Content = "Add total $/s above the native search bar and a compact $/s label at the top of each inventory card.",
			Icon = "badge-dollar-sign",
			Column = "Full",
			Row = 1
		})
		v3041:AddToggle({
			Title = "Inventory Value ESP",
			Content = "Keep egg names clear while showing each card's value",
			Column = "Full",
			Row = 2,
			Default = zeroinConfig.InventoryValueESP == true,
			Callback = function(p882)
				zeroinConfig.InventoryValueESP = p882 == true
				v3038:setInventoryEnabled(zeroinConfig.InventoryValueESP)
			end
		})
		v3038:setAreaEnabled(zeroinConfig.EggESP)
		v3038:setPlacedEnabled(zeroinConfig.PlacedEggESP)
		v3038:setInventoryEnabled(zeroinConfig.InventoryValueESP)

		local function v3042(p883)
			local v3043 = math.max(0, math.floor(p883))
			local v3044 = math.floor(v3043 / 86400)
			local v3045 = math.floor(v3043 % 86400 / 3600)
			local v3046 = math.floor(v3043 % 3600 / 60)

			if v3044 > 0 then
				return string.format("%dd %dh %dm", v3044, v3045, v3046)
			end

			if v3045 > 0 then
				return string.format("%dh %dm", v3045, v3046)
			end

			return string.format("%dm %02ds", v3046, v3043 % 60)
		end

		local ReplicatedStorage2 = game:GetService("ReplicatedStorage")
		local Directory = require(ReplicatedStorage2.Data.Assets).Directory
		local Directory2 = require(ReplicatedStorage2.Data.Areas).Directory
		local AreaEggCycle = require(ReplicatedStorage2.Shared.Util.AreaEggCycle)
		local EggState2 = require(ReplicatedStorage2.Client.EggState)

		local function v3052()
			local t168 = {}
			local t169 = {}

			for _, v in pairs(Directory) do
				local Rarity = v.Rarity

				if Rarity and Rarity.DisplayName and not t168[Rarity.DisplayName] then
					t168[Rarity.DisplayName] = true
					table.insert(t169, {
						name = Rarity.DisplayName,
						color = Rarity.Color or Color3.fromRGB(255, 255, 255),
						order = Rarity.RarityNumber or 0
					})
				end
			end

			table.sort(t169, function(p884, p885)
				return p884.order > p885.order
			end)

			return t169
		end

		local v3058 = v3052()
		local t170 = {
			Any = Color3.fromRGB(255, 255, 255)
		}

		for _, v in ipairs(v3058) do
			t170[v.name] = v.color
		end

		local t171 = {
			Rainbow = Color3.fromRGB(255, 60, 255),
			Golden = Color3.fromRGB(255, 234, 0),
			Silver = Color3.fromRGB(220, 220, 220)
		}

		local function v3063()
			local t172 = {}
			local v3065 = EggState2.ReadFieldEggs()
			local Records = v3065 and v3065.Records

			if not Records or #Records == 0 then
				pcall(function()
					local v3067 = EggState2.SyncFieldEggs()

					if v3067 and v3067.Records then
						Records = v3067.Records
					end
				end)
			end

			if Records then
				for _, Record in pairs(Records) do
					local State = Record.State

					if State == "Slot" or State == "Dropped" or State == "Carried" or State == "GuardCarried" then
						local v3071 = Directory[Record.AssetCategory]

						if v3071 then
							local Egg = v3071.Egg or {}
							local v3073 = Directory2[Record.AreaId]
							local v3074

							if Record.Mutations and #Record.Mutations > 0 then
								v3074 = table.concat(Record.Mutations, " + ")
							end

							local s12 = ""

							if State == "Carried" then
								s12 = "[Carried] "
							elseif State == "GuardCarried" then
								s12 = "[Guard] "
							end

							table.insert(t172, {
								uid = Record.Uid,
								petName = v3071.DisplayName or Record.AssetCategory,
								eggName = s12 .. (Egg.DisplayName or v3071.DisplayName and v3071.DisplayName .. " Egg" or Record.AssetCategory),
								eggIcon = Egg.Icon or v3071.Icon or "",
								weightKg = Egg.WeightKg or 0,
								rarityName = v3071.Rarity and v3071.Rarity.DisplayName or "Common",
								rarityOrder = v3071.Rarity and v3071.Rarity.RarityNumber or 0,
								mutationText = v3074,
								mutationColor = t171[Record.BaseMutation] or Color3.fromRGB(255, 255, 255),
								area = v3073 and v3073.DisplayName or Record.AreaId or "Unknown"
							})
						end
					end
				end
			end

			table.sort(t172, function(p886, p887)
				if p886.rarityOrder == p887.rarityOrder then
					return p886.petName < p887.petName
				end

				return p886.rarityOrder > p887.rarityOrder
			end)

			return t172
		end

		local u3076

		if type(genv.__ZeroinEggPanelCleanup) == "function" then
			pcall(genv.__ZeroinEggPanelCleanup)
		end

		genv.__ZeroinEggPanelGeneration = (genv.__ZeroinEggPanelGeneration or 0) + 1

		local __ZeroinEggPanelGeneration = genv.__ZeroinEggPanelGeneration
		local t173 = {
			ActiveTab = "Logs",
			SearchText = "",
			SelectedRarity = "Any"
		}
		local u3079
		local u3080 = true
		local t174 = {
			Background = Color3.fromRGB(4, 28, 18),
			Surface = Color3.fromRGB(10, 40, 29),
			Input = Color3.fromRGB(8, 36, 25),
			Border = Color3.fromRGB(34, 91, 68),
			Accent = Color3.fromRGB(0, 205, 122),
			AccentSoft = Color3.fromRGB(151, 218, 184),
			Text = Color3.fromRGB(225, 238, 231),
			TextSecondary = Color3.fromRGB(151, 190, 169),
			TextMuted = Color3.fromRGB(116, 159, 136)
		}

		local function v3082()
			genv.__ZeroinEnterUICallback()

			local v3083 = t174
			local Accent = v3083.Accent
			local ScreenGui = Instance.new("ScreenGui")

			ScreenGui.Name = "ZeroinEggPanelUI"
			ScreenGui.ZIndexBehavior = Enum.ZIndexBehavior.Sibling
			ScreenGui.ResetOnSpawn = false

			if not genv.__ZeroinParentGui(ScreenGui) then
				ScreenGui:Destroy()

				return nil
			end

			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Name = "DropShadow"
			ImageLabel.AnchorPoint = Vector2.new(0.5, 0.5)
			ImageLabel.BackgroundTransparency = 1
			ImageLabel.BorderSizePixel = 0
			ImageLabel.Image = "rbxassetid://6015897843"
			ImageLabel.ImageColor3 = Color3.fromRGB(0, 0, 0)
			ImageLabel.ImageTransparency = 0.55
			ImageLabel.ScaleType = Enum.ScaleType.Slice
			ImageLabel.SliceCenter = Rect.new(49, 49, 450, 450)
			ImageLabel.ZIndex = 0
			ImageLabel.Parent = ScreenGui

			local Frame = Instance.new("Frame")

			Frame.Name = "Main"
			Frame.Size = UDim2.new(0.72, 0, 0.62, 0)
			Frame.Position = UDim2.new(0.5, 0, 0.5, 0)
			Frame.AnchorPoint = Vector2.new(0.5, 0.5)
			Frame.BackgroundColor3 = v3083.Background
			Frame.BackgroundTransparency = 0.01
			Frame.BorderSizePixel = 0
			Frame.ZIndex = 1
			Frame.Active = true
			Frame.ClipsDescendants = true
			Frame.Parent = ScreenGui

			local UISizeConstraint = Instance.new("UISizeConstraint")

			UISizeConstraint.MinSize = Vector2.new(260, 340)
			UISizeConstraint.MaxSize = Vector2.new(320, 400)
			UISizeConstraint.Parent = Frame

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0, 8)
			UICorner.Parent = Frame

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Name = "MainOutline"
			UIStroke.Color = v3083.Border
			UIStroke.Thickness = 1.2
			UIStroke.Transparency = 0.18
			UIStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
			UIStroke.Parent = Frame

			local function v3091()
				genv.__ZeroinEnterUICallback()
				ImageLabel.Position = UDim2.fromOffset(Frame.AbsolutePosition.X + Frame.AbsoluteSize.X * 0.5, Frame.AbsolutePosition.Y + Frame.AbsoluteSize.Y * 0.5)
				ImageLabel.Size = UDim2.fromOffset(Frame.AbsoluteSize.X + 44, Frame.AbsoluteSize.Y + 44)
			end

			Frame:GetPropertyChangedSignal("AbsolutePosition"):Connect(v3091)
			Frame:GetPropertyChangedSignal("AbsoluteSize"):Connect(v3091)
			task.defer(v3091)

			local UserInputService = game:GetService("UserInputService")
			local u3093
			local u3094
			local Position
			local Position2

			Frame.InputBegan:Connect(function(input)
				genv.__ZeroinEnterUICallback()

				if input.UserInputType == Enum.UserInputType.MouseButton1 then
					u3093 = true
					Position = input.Position
					Position2 = Frame.Position
					input.Changed:Connect(function()
						genv.__ZeroinEnterUICallback()

						if input.UserInputState == Enum.UserInputState.End then
							u3093 = false
						end
					end)

					return
				elseif input.UserInputType == Enum.UserInputType.Touch then
					u3093 = true
					Position = input.Position
					Position2 = Frame.Position
					input.Changed:Connect(function()
						genv.__ZeroinEnterUICallback()

						if input.UserInputState == Enum.UserInputState.End then
							u3093 = false
						end
					end)
				end
			end)
			Frame.InputChanged:Connect(function(input)
				genv.__ZeroinEnterUICallback()

				if input.UserInputType == Enum.UserInputType.MouseMovement or input.UserInputType == Enum.UserInputType.Touch then
					u3094 = input
				end
			end)
			v44(UserInputService.InputChanged:Connect(function(input)
				genv.__ZeroinEnterUICallback()

				if input == u3094 and u3093 then
					local v3097 = input.Position - Position

					Frame.Position = UDim2.new(Position2.X.Scale, Position2.X.Offset + v3097.X, Position2.Y.Scale, Position2.Y.Offset + v3097.Y)
				end
			end))

			local Frame2 = Instance.new("Frame")

			Frame2.Size = UDim2.new(1, 0, 0, 36)
			Frame2.BackgroundColor3 = v3083.Background
			Frame2.BackgroundTransparency = 0.01
			Frame2.BorderSizePixel = 0
			Frame2.Parent = Frame

			local UICorner2 = Instance.new("UICorner")

			UICorner2.CornerRadius = UDim.new(0, 8)
			UICorner2.Parent = Frame2

			local Frame3 = Instance.new("Frame")

			Frame3.Size = UDim2.new(1, 0, 0, 10)
			Frame3.Position = UDim2.new(0, 0, 1, -10)
			Frame3.BackgroundColor3 = v3083.Background
			Frame3.BackgroundTransparency = 0.01
			Frame3.BorderSizePixel = 0
			Frame3.Parent = Frame2

			local ImageLabel2 = Instance.new("ImageLabel")

			ImageLabel2.Size = UDim2.new(0, 20, 0, 20)
			ImageLabel2.Position = UDim2.new(0, 10, 0.5, -10)
			ImageLabel2.BackgroundTransparency = 1
			ImageLabel2.Image = "rbxassetid://124404129684886"
			ImageLabel2.Parent = Frame2

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, -66, 1, 0)
			TextLabel.Position = UDim2.new(0, 36, 0, 0)
			TextLabel.BackgroundTransparency = 1
			TextLabel.Text = "ZEROIN | EGG PANEL"
			TextLabel.TextColor3 = v3083.Text
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.TextSize = 12
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Parent = Frame2

			local TextButton = Instance.new("TextButton")

			TextButton.Size = UDim2.new(0, 24, 0, 24)
			TextButton.Position = UDim2.new(1, -30, 0.5, -12)
			TextButton.BackgroundColor3 = v3083.Surface
			TextButton.BackgroundTransparency = 0
			TextButton.Text = "×"
			TextButton.TextColor3 = v3083.Text
			TextButton.Font = Enum.Font.GothamBold
			TextButton.TextSize = 13
			TextButton.Parent = Frame2

			local UICorner3 = Instance.new("UICorner")

			UICorner3.CornerRadius = UDim.new(0, 6)
			UICorner3.Parent = TextButton

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Color = v3083.Border
			UIStroke2.Transparency = 0.35
			UIStroke2.Thickness = 1
			UIStroke2.Parent = TextButton
			TextButton.MouseButton1Click:Connect(function()
				genv.__ZeroinEnterUICallback()
				ScreenGui.Enabled = false
			end)

			local Frame4 = Instance.new("Frame")

			Frame4.Size = UDim2.new(1, -16, 0, 30)
			Frame4.Position = UDim2.new(0, 8, 0, 42)
			Frame4.BackgroundTransparency = 1
			Frame4.Parent = Frame

			local UIListLayout = Instance.new("UIListLayout")

			UIListLayout.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout.Padding = UDim.new(0, 6)
			UIListLayout.Parent = Frame4

			local function createTextButton(p888)
				local TextButton2 = Instance.new("TextButton")

				TextButton2.Size = UDim2.new(0, 110, 1, 0)
				TextButton2.BackgroundColor3 = v3083.Surface
				TextButton2.BackgroundTransparency = 0
				TextButton2.Text = p888
				TextButton2.TextColor3 = v3083.TextSecondary
				TextButton2.Font = Enum.Font.GothamBold
				TextButton2.TextSize = 12
				TextButton2.Parent = Frame4

				local UICorner4 = Instance.new("UICorner")

				UICorner4.CornerRadius = UDim.new(0, 6)
				UICorner4.Parent = TextButton2

				local UIStroke3 = Instance.new("UIStroke")

				UIStroke3.Color = v3083.Border
				UIStroke3.Transparency = 0.35
				UIStroke3.Thickness = 1
				UIStroke3.Parent = TextButton2

				return TextButton2
			end

			local eggLogs = createTextButton("Egg Logs")
			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Size = UDim2.new(1, -16, 0, 18)
			TextLabel2.Position = UDim2.new(0, 8, 0, 76)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.Font = Enum.Font.GothamMedium
			TextLabel2.TextSize = 11
			TextLabel2.TextColor3 = v3083.AccentSoft
			TextLabel2.Text = "Next Reset: --"
			TextLabel2.Parent = Frame

			local TextBox = Instance.new("TextBox")

			TextBox.Size = UDim2.new(1, -72, 0, 26)
			TextBox.Position = UDim2.new(0, 8, 0, 98)
			TextBox.BackgroundColor3 = v3083.Input
			TextBox.BackgroundTransparency = 0
			TextBox.TextColor3 = v3083.Text
			TextBox.Text = ""
			TextBox.PlaceholderText = "Cari nama pet/egg..."
			TextBox.PlaceholderColor3 = v3083.TextMuted
			TextBox.Font = Enum.Font.Gotham
			TextBox.TextSize = 12
			TextBox.ClearTextOnFocus = false
			TextBox.TextXAlignment = Enum.TextXAlignment.Left
			TextBox.Parent = Frame

			local UICorner4 = Instance.new("UICorner")

			UICorner4.CornerRadius = UDim.new(0, 6)
			UICorner4.Parent = TextBox

			local UIStroke3 = Instance.new("UIStroke")

			UIStroke3.Color = v3083.Border
			UIStroke3.Transparency = 0.45
			UIStroke3.Thickness = 1
			UIStroke3.Parent = TextBox

			local UIPadding = Instance.new("UIPadding")

			UIPadding.PaddingLeft = UDim.new(0, 8)
			UIPadding.Parent = TextBox

			local TextButton2 = Instance.new("TextButton")

			TextButton2.Size = UDim2.new(0, 58, 0, 26)
			TextButton2.Position = UDim2.new(1, -62, 0, 98)
			TextButton2.BackgroundColor3 = v3083.Input
			TextButton2.BackgroundTransparency = 0
			TextButton2.Text = "Clear"
			TextButton2.TextColor3 = v3083.Text
			TextButton2.Font = Enum.Font.GothamMedium
			TextButton2.TextSize = 11
			TextButton2.Parent = Frame

			local UICorner5 = Instance.new("UICorner")

			UICorner5.CornerRadius = UDim.new(0, 6)
			UICorner5.Parent = TextButton2

			local UIStroke4 = Instance.new("UIStroke")

			UIStroke4.Color = v3083.Border
			UIStroke4.Transparency = 0.45
			UIStroke4.Thickness = 1
			UIStroke4.Parent = TextButton2
			TextButton2.MouseButton1Click:Connect(function()
				genv.__ZeroinEnterUICallback()
				TextBox.Text = ""
			end)

			local ScrollingFrame = Instance.new("ScrollingFrame")

			ScrollingFrame.Size = UDim2.new(1, -16, 0, 34)
			ScrollingFrame.Position = UDim2.new(0, 8, 0, 130)
			ScrollingFrame.BackgroundTransparency = 1
			ScrollingFrame.BorderSizePixel = 0
			ScrollingFrame.ScrollBarThickness = 0
			ScrollingFrame.ScrollingDirection = Enum.ScrollingDirection.X
			ScrollingFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
			ScrollingFrame.AutomaticCanvasSize = Enum.AutomaticSize.X
			ScrollingFrame.Parent = Frame

			local UIListLayout2 = Instance.new("UIListLayout")

			UIListLayout2.FillDirection = Enum.FillDirection.Horizontal
			UIListLayout2.VerticalAlignment = Enum.VerticalAlignment.Center
			UIListLayout2.Padding = UDim.new(0, 8)
			UIListLayout2.Parent = ScrollingFrame

			local ScrollingFrame2 = Instance.new("ScrollingFrame")

			ScrollingFrame2.Size = UDim2.new(1, -16, 1, -180)
			ScrollingFrame2.Position = UDim2.new(0, 8, 0, 172)
			ScrollingFrame2.BackgroundTransparency = 1
			ScrollingFrame2.BorderSizePixel = 0
			ScrollingFrame2.ScrollBarThickness = 3
			ScrollingFrame2.ScrollBarImageColor3 = v3083.Border
			ScrollingFrame2.ScrollBarImageTransparency = 0.2
			ScrollingFrame2.CanvasSize = UDim2.new(0, 0, 0, 0)
			ScrollingFrame2.AutomaticCanvasSize = Enum.AutomaticSize.Y
			ScrollingFrame2.Parent = Frame

			local UIPadding2 = Instance.new("UIPadding")

			UIPadding2.PaddingTop = UDim.new(0, 2)
			UIPadding2.Parent = ScrollingFrame2

			local UIListLayout3 = Instance.new("UIListLayout")

			UIListLayout3.Padding = UDim.new(0, 6)
			UIListLayout3.Parent = ScrollingFrame2

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Size = UDim2.new(1, 0, 0, 14)
			TextLabel3.LayoutOrder = -1
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.Font = Enum.Font.GothamMedium
			TextLabel3.TextSize = 10
			TextLabel3.TextColor3 = v3083.TextSecondary
			TextLabel3.Text = ""
			TextLabel3.Parent = ScrollingFrame2

			return {
				Gui = ScreenGui,
				Frame = Frame,
				LogsTabBtn = eggLogs,
				ResetLabel = TextLabel2,
				SearchBox = TextBox,
				ChipScroll = ScrollingFrame,
				ListScroll = ScrollingFrame2,
				CountLabel = TextLabel3,
				AccentColor = Accent
			}
		end
		local function createFrame(p889, p890)
			genv.__ZeroinEnterUICallback()

			local Frame = Instance.new("Frame")

			Frame.Size = UDim2.new(1, 0, 0, 56)

			local v3129 = t174

			Frame.BackgroundColor3 = v3129.Surface
			Frame.BackgroundTransparency = 0.08
			Frame.LayoutOrder = p889
			Frame.Parent = u3076.ListScroll

			local UICorner = Instance.new("UICorner")

			UICorner.CornerRadius = UDim.new(0, 8)
			UICorner.Parent = Frame

			local UIStroke = Instance.new("UIStroke")

			UIStroke.Color = v3129.Border
			UIStroke.Thickness = 1
			UIStroke.Transparency = 0.38
			UIStroke.Parent = Frame

			local Frame2 = Instance.new("Frame")

			Frame2.Size = UDim2.new(0, 4, 1, -12)
			Frame2.Position = UDim2.new(0, 0, 0, 6)
			Frame2.BackgroundColor3 = p890.rarityColor or Color3.fromRGB(255, 255, 255)
			Frame2.BorderSizePixel = 0
			Frame2.Parent = Frame

			local UICorner2 = Instance.new("UICorner")

			UICorner2.CornerRadius = UDim.new(1, 0)
			UICorner2.Parent = Frame2

			local ImageLabel = Instance.new("ImageLabel")

			ImageLabel.Size = UDim2.new(0, 40, 0, 40)
			ImageLabel.Position = UDim2.new(0, 12, 0.5, -20)
			ImageLabel.BackgroundColor3 = v3129.Input
			ImageLabel.BackgroundTransparency = 0
			ImageLabel.Image = p890.icon or ""
			ImageLabel.Parent = Frame

			local UICorner3 = Instance.new("UICorner")

			UICorner3.CornerRadius = UDim.new(0, 6)
			UICorner3.Parent = ImageLabel

			local UIStroke2 = Instance.new("UIStroke")

			UIStroke2.Color = v3129.Border
			UIStroke2.Transparency = 0.5
			UIStroke2.Thickness = 1
			UIStroke2.Parent = ImageLabel

			local TextLabel = Instance.new("TextLabel")

			TextLabel.Size = UDim2.new(1, -228, 0, 15)
			TextLabel.Position = UDim2.new(0, 60, 0, 4)
			TextLabel.BackgroundTransparency = 1
			TextLabel.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel.Font = Enum.Font.GothamBold
			TextLabel.TextSize = 13
			TextLabel.TextColor3 = v3129.Text
			TextLabel.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel.Text = p890.title or ""
			TextLabel.Parent = Frame

			local TextLabel2 = Instance.new("TextLabel")

			TextLabel2.Size = UDim2.new(1, -228, 0, 13)
			TextLabel2.Position = UDim2.new(0, 60, 0, 19)
			TextLabel2.BackgroundTransparency = 1
			TextLabel2.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel2.Font = Enum.Font.Gotham
			TextLabel2.TextSize = 10
			TextLabel2.TextColor3 = v3129.TextSecondary
			TextLabel2.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel2.Text = p890.subtitle or ""
			TextLabel2.Parent = Frame

			local TextLabel3 = Instance.new("TextLabel")

			TextLabel3.Size = UDim2.new(1, -228, 0, 13)
			TextLabel3.Position = UDim2.new(0, 60, 0, 33)
			TextLabel3.BackgroundTransparency = 1
			TextLabel3.TextXAlignment = Enum.TextXAlignment.Left
			TextLabel3.Font = Enum.Font.Gotham
			TextLabel3.TextSize = 10
			TextLabel3.TextColor3 = p890.metaColor or v3129.TextSecondary
			TextLabel3.TextTruncate = Enum.TextTruncate.AtEnd
			TextLabel3.Text = p890.meta or ""
			TextLabel3.Parent = Frame

			local TextLabel4 = Instance.new("TextLabel")

			TextLabel4.Size = UDim2.new(0, 90, 0, 16)
			TextLabel4.Position = UDim2.new(1, -164, 0, 8)
			TextLabel4.BackgroundTransparency = 1
			TextLabel4.TextXAlignment = Enum.TextXAlignment.Right
			TextLabel4.Font = Enum.Font.GothamBold
			TextLabel4.TextSize = 12
			TextLabel4.TextColor3 = p890.rightTopColor or v3129.Accent
			TextLabel4.Text = p890.rightTop or ""
			TextLabel4.Parent = Frame

			local TextLabel5 = Instance.new("TextLabel")

			TextLabel5.Size = UDim2.new(0, 90, 0, 14)
			TextLabel5.Position = UDim2.new(1, -164, 0, 26)
			TextLabel5.BackgroundTransparency = 1
			TextLabel5.TextXAlignment = Enum.TextXAlignment.Right
			TextLabel5.Font = Enum.Font.Gotham
			TextLabel5.TextSize = 10
			TextLabel5.TextColor3 = v3129.TextMuted
			TextLabel5.Text = p890.rightBottom or ""
			TextLabel5.Parent = Frame

			local TextButton = Instance.new("TextButton")

			TextButton.Name = "StealButton"
			TextButton.Size = UDim2.new(0, 56, 0, 26)
			TextButton.Position = UDim2.new(1, -66, 0.5, -13)
			TextButton.BackgroundColor3 = v3129.Accent
			TextButton.AutoButtonColor = false
			TextButton.Font = Enum.Font.GothamBold
			TextButton.TextSize = 11
			TextButton.TextColor3 = Color3.fromRGB(4, 28, 18)
			TextButton.Text = "Steal"
			TextButton.Parent = Frame

			local UICorner4 = Instance.new("UICorner")

			UICorner4.CornerRadius = UDim.new(0, 6)
			UICorner4.Parent = TextButton

			local UIStroke3 = Instance.new("UIStroke")

			UIStroke3.Color = Color3.fromRGB(0, 240, 140)
			UIStroke3.Transparency = 0.5
			UIStroke3.Thickness = 1
			UIStroke3.Parent = TextButton
			TextButton.MouseEnter:Connect(function()
				TextButton.BackgroundColor3 = Color3.fromRGB(0, 230, 138)
			end)
			TextButton.MouseLeave:Connect(function()
				TextButton.BackgroundColor3 = v3129.Accent
			end)
			TextButton.MouseButton1Click:Connect(function()
				if not p890.uid then
					return
				end

				local __ZeroinEggRuntime = v2228 or genv and genv.__ZeroinEggRuntime

				if not __ZeroinEggRuntime then
					pcall(function()
						v305:MakeNotify({
							Title = "Egg Steal",
							Description = "Error",
							Content = "Auto Steal runtime is not ready.",
							Color = Color3.fromRGB(220, 90, 90),
							Delay = 2.5
						})
					end)

					return
				end

				local v3146, v3147 = __ZeroinEggRuntime:requestPanelSteal(p890.uid)

				if v3146 then
					TextButton.Text = "Queued"
					TextButton.BackgroundColor3 = Color3.fromRGB(34, 91, 68)
					TextButton.TextColor3 = Color3.fromRGB(225, 238, 231)
					pcall(function()
						v305:MakeNotify({
							Title = "Egg Steal",
							Description = "Queued",
							Content = "Stealing " .. tostring(p890.title or "Egg") .. "...",
							Color = Color3.fromRGB(0, 205, 122),
							Delay = 2
						})
					end)
					task.delay(1.5, function()
						if TextButton and TextButton.Parent then
							TextButton.Text = "Steal"
							TextButton.BackgroundColor3 = v3129.Accent
							TextButton.TextColor3 = Color3.fromRGB(4, 28, 18)
						end
					end)
				else
					pcall(function()
						v305:MakeNotify({
							Title = "Egg Steal",
							Description = "Failed",
							Content = tostring(v3147 or "Cannot steal this egg"),
							Color = Color3.fromRGB(220, 90, 90),
							Delay = 3
						})
					end)
				end
			end)

			return Frame
		end
		local function v3148()
			genv.__ZeroinEnterUICallback()

			for _, child in ipairs(u3076.ListScroll:GetChildren()) do
				if child:IsA("Frame") then
					child:Destroy()
				end
			end
		end
		local function v3151(p891)
			if t173.SearchText == "" then
				return true
			end

			return string.find(string.lower(p891), string.lower(t173.SearchText), 1, true) ~= nil
		end
		local function v3152()
			genv.__ZeroinEnterUICallback()

			if not u3076 then
				return
			end

			v3148()

			local v3153 = u3079 or {}
			local n44 = 0

			for _, v in ipairs(v3153) do
				local v3157 = t173.SelectedRarity == "Any" or v.rarityName == t173.SelectedRarity
				local v3158 = v3151(v.petName) or v3151(v.eggName)

				if v3157 and v3158 then
					n44 += 1

					local color32 = t170[v.rarityName] or Color3.fromRGB(255, 255, 255)

					createFrame(n44, {
						uid = v.uid,
						icon = v.eggIcon,
						title = v.eggName,
						subtitle = v.petName,
						rarityColor = color32,
						meta = v.rarityName .. " • " .. (v.mutationText and "Mutasi: " .. v.mutationText or "No Mutation"),
						metaColor = color32,
						rightTop = v.area,
						rightTopColor = t174.AccentSoft,
						rightBottom = string.format("%s kg", tostring(v.weightKg or 0))
					})
				end
			end

			u3076.CountLabel.Text = n44 .. " egg(s) di area sekarang"
		end
		local function v3160(p892)
			local t175 = {}
			local ipairs_ = ipairs
			local v3163 = p892 or {}

			for _, v in ipairs_(v3163) do
				local insert = table.insert
				local v3167 = t175
				local concat = table.concat
				local t176 = {}
				local v3170 = tostring(v.uid)
				local v3171 = tostring(v.petName or "")
				local v3172 = tostring(v.eggName or "")
				local v3173 = tostring(v.eggIcon or "")
				local v3174 = tostring(v.weightKg or "")
				local v3175 = tostring(v.rarityName or "")
				local v3176 = tostring(v.mutationText or "")
				local tostring_ = tostring
				local area = v.area or ""

				do
					local values = table.pack(v3170, v3171, v3172, v3173, v3174, v3175, v3176, tostring_(area))

					table.move(values, 1, values.n, 1, t176)
				end

				insert(v3167, concat(t176, ":"))
			end

			table.sort(t175)

			return t173.SelectedRarity .. "|" .. t173.SearchText .. "|" .. table.concat(t175, ",")
		end

		local u3180

		local function v3181()
			genv.__ZeroinEnterUICallback()

			if not u3076 then
				return
			end

			u3079 = v3063()
			v3152()
			u3180 = v3160(u3079)
		end
		local function v3182()
			genv.__ZeroinEnterUICallback()

			if not u3076 then
				return
			end

			local AccentColor = u3076.AccentColor

			local function v3184(p893, p894)
				p893.BackgroundColor3 = p894 and AccentColor or t174.Surface
				p893.BackgroundTransparency = p894 and 0 or 0.08
				p893.TextColor3 = p894 and Color3.fromRGB(4, 28, 18) or t174.TextSecondary
			end

			v3184(u3076.LogsTabBtn, t173.ActiveTab == "Logs")
		end
		local function v3185()
			genv.__ZeroinEnterUICallback()

			if not u3076 then
				return
			end

			for _, child in ipairs(u3076.ChipScroll:GetChildren()) do
				if child:IsA("TextButton") then
					if child.Text == t173.SelectedRarity then
						child.BackgroundColor3 = t170[child.Text] or u3076.AccentColor
						child.TextColor3 = Color3.fromRGB(10, 10, 15)
					else
						child.BackgroundColor3 = Color3.fromRGB(25, 25, 32)
						child.TextColor3 = Color3.fromRGB(200, 200, 200)
					end
				end
			end
		end
		local function v3188()
			genv.__ZeroinEnterUICallback()

			for _, child in ipairs(u3076.ChipScroll:GetChildren()) do
				if child:IsA("TextButton") then
					child:Destroy()
				end
			end

			local function createTextButton(p895)
				local TextButton = Instance.new("TextButton")

				TextButton.Size = UDim2.new(0, math.max(50, #p895 * 7 + 24), 0, 24)
				TextButton.BackgroundColor3 = t174.Surface
				TextButton.BackgroundTransparency = 0.08
				TextButton.Text = p895
				TextButton.TextColor3 = t174.TextSecondary
				TextButton.Font = Enum.Font.GothamBold
				TextButton.TextSize = 11
				TextButton.Parent = u3076.ChipScroll

				local UICorner = Instance.new("UICorner")

				UICorner.CornerRadius = UDim.new(1, 0)
				UICorner.Parent = TextButton

				local UIStroke = Instance.new("UIStroke")

				UIStroke.Color = t174.Border
				UIStroke.Transparency = 0.4
				UIStroke.Parent = TextButton
				TextButton.MouseButton1Click:Connect(function()
					genv.__ZeroinEnterUICallback()
					t173.SelectedRarity = p895
					v3185()
					v3181()
				end)

				return TextButton
			end

			createTextButton("Any")

			for _, v in ipairs(v3058) do
				createTextButton(v.name)
			end
		end

		t20.toggleEggPanelUI = function(p896)
			genv.__ZeroinEnterUICallback()

			if p896 then
				if not u3076 then
					u3076 = v3082()
					v3188()
					v3185()
					v3182()
					u3076.LogsTabBtn.MouseButton1Click:Connect(function()
						genv.__ZeroinEnterUICallback()
						t173.ActiveTab = "Logs"
						v3182()
						v3181()
					end)
					u3076.SearchBox:GetPropertyChangedSignal("Text"):Connect(function()
						genv.__ZeroinEnterUICallback()
						t173.SearchText = u3076.SearchBox.Text
						v3181()
					end)
				end

				u3076.Gui.Enabled = true
				pcall(function()
					EggState2.SyncFieldEggs()
				end)
				v3181()
			elseif u3076 then
				u3076.Gui.Enabled = false
			end
		end
		v44(EggState2.FieldRefreshed:Connect(function()
			u3080 = true
		end))
		v44(EggState2.FieldShifted:Connect(function()
			u3080 = true
		end))
		v44(EggState2.FieldGone:Connect(function()
			u3080 = true
		end))
		v44(EggState2.ResetCountdown:Connect(function()
			u3080 = true
		end))
		v44(EggState2.RarityRevealed:Connect(function()
			u3080 = true
		end))

		local u3197 = false

		genv.__ZeroinEggPanelCleanup = function()
			u3197 = false
			zeroinConfig.EggPredictUI = false

			if u3076 and u3076.Gui then
				pcall(function()
					u3076.Gui:Destroy()
				end)
			end

			u3076 = nil
		end
		t20.startEggPanelLoop = function()
			if u3197 then
				return
			end

			u3197 = true
			task.spawn(function()
				genv.__ZeroinEnterUICallback()

				local n45 = 0

				while zeroinConfig.EggPredictUI and genv.__ZeroinEggPanelGeneration == __ZeroinEggPanelGeneration do
					genv.__ZeroinEnterUICallback()

					local ok, result = pcall(function()
						local serverTimeNow = game:GetService("Workspace"):GetServerTimeNow()
						local v3202 = AreaEggCycle.NextResetTime(serverTimeNow)

						if u3076 then
							genv.__ZeroinEnterUICallback()
							u3076.ResetLabel.Text = "Next Reset: " .. v3042(math.max(0, v3202 - serverTimeNow))

							local now = os.clock()

							if not u3079 or #u3079 == 0 or now - n45 >= 15 then
								n45 = now
								pcall(function()
									EggState2.SyncFieldEggs()
								end)
							end

							local v3204 = v3063()
							local v3205 = v3160(v3204)

							if v3205 ~= u3180 or u3080 then
								u3080 = false
								u3180 = v3205
								u3079 = v3204
								v3152()
							end
						end
					end)

					if not ok then
						warn("[EggPanel] Error di tick loop:", result)
					end

					task.wait(1.5)
				end

				u3197 = false

				if genv.__ZeroinEggPanelGeneration == __ZeroinEggPanelGeneration then
					t20.toggleEggPanelUI(false)
				end
			end)
		end

		local v3206 = v2883:AddSection({
			Title = "Egg Panel",
			Layout = "Grid",
			ItemGap = 4
		})

		v3206:AddParagraph({
			Title = "Area Egg Panel",
			Content = "Enable the Egg Panel to view which eggs are currently available in every area, including egg name, rarity, weight, mutation, and area.",
			Icon = "scan-search",
			Column = "Full",
			Row = 1
		})
		v3206:AddToggle({
			Title = "Show Egg Panel",
			Content = "Open the live egg list and area information panel",
			Column = "Full",
			Row = 2,
			Default = false,
			Callback = function(p897)
				zeroinConfig.EggPredictUI = p897

				if p897 then
					t20.toggleEggPanelUI(true)
					t20.startEggPanelLoop()
				else
					t20.toggleEggPanelUI(false)
				end
			end
		})
	end
}

genv.__ZeroinRunUICallback(function()
	local ok, result = pcall(t111.Main)

	if not ok then
		warn("[Zeroin] Error loading MainTab:", result)
	end

	pcall(t111.Auto)
	pcall(t111.Webhook)
	pcall(t111.Community)
	pcall(t111.Misc)
end)
pcall(function()
	local __ZeroinUIHost = genv.__ZeroinUIHost

	if not __ZeroinUIHost then
		return
	end

	for _, descendant in ipairs(__ZeroinUIHost:GetDescendants()) do
		if descendant.Name == "ScrollSelect" and descendant:IsA("ScrollingFrame") then
			local UIListLayout = descendant:FindFirstChildOfClass("UIListLayout")

			if UIListLayout then
				local function v3213()
					genv.__ZeroinEnterUICallback()
					descendant.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
				end

				v3213()
				UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(v3213)
			end
		end
	end
end)
task.spawn(function()
	genv.__ZeroinEnterUICallback()

	if not game:IsLoaded() then
		game.Loaded:Wait()
		genv.__ZeroinEnterUICallback()
	end

	local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

	genv.__ZeroinEnterUICallback()
	Character:WaitForChild("HumanoidRootPart", 15)
	genv.__ZeroinEnterUICallback()
	Character:WaitForChild("Humanoid", 15)
	genv.__ZeroinEnterUICallback()

	local now = os.clock()

	while os.clock() - now < 15 do
		genv.__ZeroinEnterUICallback()

		local __ZeroinUIHost = genv.__ZeroinUIHost
		local ZeroinOnTop = __ZeroinUIHost and __ZeroinUIHost:FindFirstChild("ZeroinOnTop")

		if ZeroinOnTop and ZeroinOnTop:FindFirstChild("DropShadowHolder", true) then
			genv.__Stored_ZeroinOnTop = ZeroinOnTop
			pcall(function()
				ZeroinOnTop.ResetOnSpawn = false
			end)

			local ToggleUIZeroin = __ZeroinUIHost and __ZeroinUIHost:FindFirstChild("ToggleUIZeroin")

			if ToggleUIZeroin then
				genv.__Stored_ToggleUIZeroin = ToggleUIZeroin
				pcall(function()
					ToggleUIZeroin.ResetOnSpawn = false
				end)
			end

			local NotifyGui = __ZeroinUIHost and __ZeroinUIHost:FindFirstChild("NotifyGui")

			if NotifyGui then
				genv.__Stored_NotifyGui = NotifyGui
				pcall(function()
					NotifyGui.ResetOnSpawn = false
				end)
			end

			break
		end

		task.wait(0.5)
	end

	task.wait(1.5)
	genv.__ZeroinEnterUICallback()
	genv.__ZeroinRunUICallback(function()
		if zeroinConfig.AutoRift then
			if v2237 and not v2237.enabled then
				v2259(true)
			end
		end

		if zeroinConfig.AutoSteal and v2228 then
			v2228:setEnabled(true)
		end

		if zeroinConfig.AutoPlace or zeroinConfig.AutoRift then
			task.spawn(t20.AutoPlaceLoop)
		end

		if zeroinConfig.AutoHatch or zeroinConfig.AutoRift then
			task.spawn(t20.AutoHatchLoop)
		end

		if zeroinConfig.AutoSell then
			t20.startAutoSellLoop()
		end

		if zeroinConfig.AutoSellEgg then
			t20.startAutoSellEggLoop()
		end

		if zeroinConfig.EggPredictUI then
			t20.toggleEggPanelUI(true)
			t20.startEggPanelLoop()
		end
	end)
end)
