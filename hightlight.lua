local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer

-- Funzione che crea Highlight e TextLabel su un personaggio
local function applyEffectsToCharacter(character, player)
    if not character then return end

    -- Evita duplicati Highlight
    local existingHL = character:FindFirstChildOfClass("Highlight")
    if existingHL then
        existingHL:Destroy()
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

    -- Evita duplicati TextLabel
    local existingGui = character:FindFirstChild("PlayerLabel")
    if existingGui then
        existingGui:Destroy()
    end

    -- Crea BillboardGui
    local billboard = Instance.new("BillboardGui")
    billboard.Name = "PlayerLabel"
    billboard.Parent = character
    billboard.Adornee = character:WaitForChild("HumanoidRootPart")
    billboard.Size = UDim2.new(0, 150, 0, 50)
    billboard.StudsOffset = Vector3.new(0, 3, 0)
    billboard.AlwaysOnTop = true

    -- TextLabel dentro BillboardGui
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

-- Funzione che gestisce un nuovo giocatore
local function onPlayerAdded(player)
    local function onCharacterAdded(character)
        character:WaitForChild("HumanoidRootPart", 5)
        applyEffectsToCharacter(character, player)
    end

    if player.Character then
        applyEffectsToCharacter(player.Character, player)
    end

    player.CharacterAdded:Connect(onCharacterAdded)
end

-- Applica a tutti i giocatori già presenti
for _, plr in pairs(Players:GetPlayers()) do
    onPlayerAdded(plr)
end

-- Applica ai nuovi giocatori
Players.PlayerAdded:Connect(onPlayerAdded)
