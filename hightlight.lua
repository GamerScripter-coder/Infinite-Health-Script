local Players = game:GetService("Players")

-- Funzione per applicare highlight e TextLabel
local function applyEffectsToCharacter(character, player)
	if not character then return end

	-- Aspetta che la testa esista
	local head = character:WaitForChild("Head", 5)
	if not head then return end

	-- Rimuove eventuali highlight o billboard precedenti
	for _, v in pairs(character:GetChildren()) do
		if v:IsA("Highlight") then v:Destroy() end
		if v:IsA("BillboardGui") and v.Name == "PlayerLabel" then v:Destroy() end
	end

	-- Crea Highlight verde
	local hl = Instance.new("Highlight")
	hl.Parent = character
	hl.Adornee = character
	hl.FillColor = Color3.fromRGB(0, 255, 0)
	hl.OutlineColor = Color3.fromRGB(0, 255, 0)
	hl.FillTransparency = 0.5
	hl.OutlineTransparency = 0
	hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop

	-- Crea BillboardGui sopra la testa
	local billboard = Instance.new("BillboardGui")
	billboard.Name = "PlayerLabel"
	billboard.Parent = head
	billboard.Adornee = head
	billboard.Size = UDim2.new(0, 150, 0, 50)
	billboard.StudsOffset = Vector3.new(0, 1.5, 0) -- leggermente sopra la testa
	billboard.AlwaysOnTop = true

	local label = Instance.new("TextLabel")
	label.Parent = billboard
	label.Size = UDim2.new(1, 0, 1, 0)
	label.BackgroundTransparency = 1
	label.TextColor3 = Color3.fromRGB(0, 255, 0)
	label.TextStrokeTransparency = 0
	label.Font = Enum.Font.SourceSansBold
	label.TextScaled = true
	label.Text = player.Name
end

-- Gestione giocatori
local function onPlayerAdded(player)
	local function onCharacterAdded(character)
		applyEffectsToCharacter(character, player)
	end

	if player.Character then
		applyEffectsToCharacter(player.Character, player)
	end

	player.CharacterAdded:Connect(onCharacterAdded)
end

-- Tutti i giocatori già presenti
for _, plr in pairs(Players:GetPlayers()) do
	onPlayerAdded(plr)
end

-- Nuovi giocatori
Players.PlayerAdded:Connect(onPlayerAdded)
