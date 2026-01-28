-- ===============================
-- PULIZIA GUI
-- ===============================
pcall(function()
	game:GetService("CoreGui"):FindFirstChild("ScriptLoaderGui"):Destroy()
end)

-- ===============================
-- SERVIZI
-- ===============================
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")
local Players = game:GetService("Players")
local player = Players.LocalPlayer

-- ===============================
-- CONFIG SICURI
-- ===============================
local ADMIN_USERID = {
	[9021091122] = true
}

local MASTER_KEYS = {}

-- Carica Master Keys con controllo
do
	local success, result = pcall(function()
		return loadstring(game:HttpGet("https://raw.githubusercontent.com/GamerScripter-coder/Secrets/refs/heads/main/MasterKeys?token=GHSAT0AAAAAADUFY2R6SYAWXKFKUV4AJFHK2L2SVVA"))()
	end)

	if success then
		MASTER_KEYS = result or {}
		if type(MASTER_KEYS) ~= "table" then
			warn("[ScriptLoader] MASTER_KEYS caricata ma NON è una tabella!")
			print("Contenuto ricevuto:", MASTER_KEYS)
			MASTER_KEYS = {}
		end
	else
		warn("[ScriptLoader] Errore nel caricamento delle MASTER_KEYS:", result)
	end
end

local timeRequired = 1200
local walkRequired = 10000

-- ===============================
-- VARIABILI
-- ===============================
local keyValid = false
local generatedKey = nil
local timePassed = 0
local walkDistance = 0

-- ===============================
-- FUNZIONE GENERA KEY
-- ===============================
local function generateKey()
	local chars = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%^&*()-_=+[]{}<>"
	local key = {}
	for i = 1, 32 do
		local r = math.random(1, #chars)
		key[i] = chars:sub(r,r)
	end
	return table.concat(key)
end

-- ===============================
-- TRACK TEMPO
-- ===============================
task.spawn(function()
	while not keyValid do
		task.wait(1)
		timePassed += 1
	end
end)

-- ===============================
-- TRACK MOVIMENTO
-- ===============================
local function trackCharacter(char)
	local humanoid = char:WaitForChild("Humanoid")
	local root = char:WaitForChild("HumanoidRootPart")
	local lastPos = root.Position

	humanoid.Running:Connect(function(speed)
		if speed > 0 then
			local newPos = root.Position
			walkDistance += (newPos - lastPos).Magnitude
			lastPos = newPos
		end
	end)
end

if player.Character then
	trackCharacter(player.Character)
end
player.CharacterAdded:Connect(trackCharacter)

-- ===============================
-- LISTA SCRIPT
-- ===============================
local scriptsList = {
	["Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
	["CMD-X"] = "https://pastebin.com/raw/ftTV0FJN",
	["HD Admin"] = "https://pastebin.com/raw/JTg6nTnR",
	["Dex Explorer"] = "https://raw.githubusercontent.com/peyton2465/Dex/master/out.lua",
	["Ban On Steal(My)"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/BanOnSteal.lua",
	["Chili Hub"] = "https://raw.githubusercontent.com/tienkhanh1/spicy/main/Chilli.lua",
	["Istant Steal"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/IstantSteal.lua",
	["OpenGui[V3]"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/OpenGui%5BV3%5D",
	["Rejoin Script"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/RejoinScript.lua",
	["Instant Prompts"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/IstantPrompts.lua",
	["Fly Hack"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/FlyHack.lua",
	["Freecam"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/Freecam.lua"
}

-- ===============================
-- GUI ROOT
-- ===============================
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptLoaderGui"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

l
