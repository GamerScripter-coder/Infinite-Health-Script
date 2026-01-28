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
-- CONFIG
-- ===============================
local ADMIN_USERID = 9021091122

local MASTER_KEYS = {
	"ld|p61K<sy*9)-T_;H#%:deYBZE<E04r*yA:F2ZJ"
}

local timeRequired = 120
local walkRequired = 350

-- ===============================
-- VARIABILI
-- ===============================
local keyValid = false
local generatedKey = nil
local timePassed = 0
local walkDistance = 0

-- ===============================
-- GENERA KEY
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
	["Fly Hack"] = "https://raw.githubusercontent.com/GamerScripter-coder/Infinite-Health-Script/refs/heads/main/FlyHack.lua"
}

-- ===============================
-- GUI ROOT
-- ===============================
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptLoaderGui"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.32,0.45)
frame.Position = UDim2.fromScale(0.34,0.28)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.12,0)
title.BackgroundTransparency = 1
title.Text = "Script Loader"
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.TextColor3 = Color3.new(1,1,1)
title.Parent = frame

-- ===============================
-- KEY UI
-- ===============================
local keyFrame = Instance.new("Frame")
keyFrame.Size = UDim2.fromScale(1,0.88)
keyFrame.Position = UDim2.fromScale(0,0.12)
keyFrame.BackgroundColor3 = Color3.fromRGB(25,25,25)
keyFrame.Parent = frame
Instance.new("UICorner", keyFrame)

local keyLabel = Instance.new("TextLabel")
keyLabel.Size = UDim2.new(1,0,0.28,0)
keyLabel.BackgroundTransparency = 1
keyLabel.Text = "Completa le azioni per generare la key"
keyLabel.TextSize = 18
keyLabel.TextWrapped = true
keyLabel.Font = Enum.Font.Gotham
keyLabel.TextColor3 = Color3.new(1,1,1)
keyLabel.Parent = keyFrame

local keyBox = Instance.new("TextBox")
keyBox.Size = UDim2.new(0.8,0,0.14,0)
keyBox.Position = UDim2.new(0.1,0,0.34,0)
keyBox.Text = "La key verrà generata automaticamente"
keyBox.TextScaled = false
keyBox.TextSize = 18
keyBox.Font = Enum.Font.Gotham
keyBox.BackgroundColor3 = Color3.fromRGB(35,35,35)
keyBox.TextColor3 = Color3.new(1,1,1)
keyBox.ClearTextOnFocus = false
keyBox.Parent = keyFrame
Instance.new("UICorner", keyBox)

-- ===============================
-- ADMIN KEY UI (SOLO TU)
-- ===============================
if player.UserId == ADMIN_USERID then
	local adminFrame = Instance.new("Frame")
	adminFrame.Size = UDim2.new(0.9,0,0.22,0)
	adminFrame.Position = UDim2.new(0.05,0,0.5,0)
	adminFrame.BackgroundColor3 = Color3.fromRGB(30,30,30)
	adminFrame.Parent = keyFrame
	Instance.new("UICorner", adminFrame)

	local list = Instance.new("UIListLayout", adminFrame)
	list.Padding = UDim.new(0,6)

	for _, key in ipairs(MASTER_KEYS) do
		local btn = Instance.new("TextButton")
		btn.Size = UDim2.new(1,0,0,30)
		btn.Text = key
		btn.TextScaled = true
		btn.Font = Enum.Font.Gotham
		btn.BackgroundColor3 = Color3.fromRGB(120,60,160)
		btn.TextColor3 = Color3.new(1,1,1)
		btn.Parent = adminFrame
		Instance.new("UICorner", btn)

		btn.MouseButton1Click:Connect(function()
			keyBox.Text = key
		end)
	end
end

-- ===============================
-- BOTTONE VERIFICA
-- ===============================
local verifyBtn = Instance.new("TextButton")
verifyBtn.Size = UDim2.new(0.6,0,0.16,0)
verifyBtn.Position = UDim2.new(0.2,0,0.75,0)
verifyBtn.Text = "Apri Script" -- <-- testo personalizzabile
verifyBtn.TextScaled = true
verifyBtn.Font = Enum.Font.GothamBold
verifyBtn.BackgroundColor3 = Color3.fromRGB(0,170,0)
verifyBtn.TextColor3 = Color3.new(1,1,1)
verifyBtn.Parent = keyFrame
Instance.new("UICorner", verifyBtn)

-- ===============================
-- UI PRINCIPALE
-- ===============================
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.95,0,0.83,0)
scrollFrame.Position = UDim2.new(0.025,0,0.14,0)
scrollFrame.Visible = false
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = frame

local layout = Instance.new("UIListLayout", scrollFrame)
layout.Padding = UDim.new(0,6)

for name, url in pairs(scriptsList) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,44)
	btn.Text = name
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	btn.BackgroundColor3 = Color3.fromRGB(0,100,180)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.Parent = scrollFrame
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		if keyValid then
			loadstring(game:HttpGet(url,true))()
		end
	end)
end

layout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0,0,0,layout.AbsoluteContentSize.Y)
end)

-- ===============================
-- FUNZIONE AGGIORNA AZIONI & GENERA KEY AUTOMATICAMENTE
-- ===============================
task.spawn(function()
	while not keyValid do
		task.wait(1)
		keyLabel.Text = "Azioni mancanti:\nTempo: "..math.floor(timePassed).."/"..timeRequired..
						"\nCamminata: "..math.floor(walkDistance).."/"..walkRequired
						
		-- Genera key automaticamente appena completate le azioni
		if timePassed >= timeRequired and walkDistance >= walkRequired then
			generatedKey = generateKey()
			keyBox.Text = generatedKey
			keyValid = true
		end
	end
end)

-- ===============================
-- BOTTONE VERIFICA
-- ===============================
verifyBtn.MouseButton1Click:Connect(function()
	if keyValid then
		keyFrame:Destroy()
		scrollFrame.Visible = true
	else
		keyBox.BackgroundColor3 = Color3.fromRGB(170,0,0)
		keyBox.Text = "Chiave non Valida"
		task.wait(3)
		keyBox.BackgroundColor3 = Color3.fromRGB(0,170,0)
		keyBox.Text = "La Key verrà generata automaticamente"
	end
end)

-- ===============================
-- DRAG
-- ===============================
local dragging, dragStart, startPos = false

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
