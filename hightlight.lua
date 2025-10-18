local Players = game:GetService("Players")

-- Funzione che applica il highlight a un personaggio
local function applyHighlightToCharacter(character)
    if not character then return end
    -- Evita duplicati: se ha già un Highlight, distruggilo
    local existing = character:FindFirstChildOfClass("Highlight")
    if existing then
        existing:Destroy()
    end

    -- Crea un nuovo Highlight
    local hl = Instance.new("Highlight")
    hl.Parent = character
    hl.Adornee = character  -- evidenzia tutto il modello (tutte le parti)
    hl.FillColor = Color3.fromRGB(0, 255, 0)       -- verde
    hl.OutlineColor = Color3.fromRGB(0, 255, 0)    -- contorno verde
    hl.FillTransparency = 0.5    -- puoi regolare trasparenza del “riempimento”
    hl.OutlineTransparency = 0   -- contorno pienamente visibile
    hl.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop  -- renderizza sopra tutto
end

-- Funzione che gestisce un nuovo giocatore
local function onPlayerAdded(player)
    local function onCharacterAdded(character)
        -- Aspetta che il modello sia pronto
        character:WaitForChild("HumanoidRootPart", 5)
        applyHighlightToCharacter(character)
    end

    -- Se il giocatore ha già un personaggio (gioco già iniziato)
    if player.Character then
        applyHighlightToCharacter(player.Character)
    end

    player.CharacterAdded:Connect(onCharacterAdded)
end

-- Applica anche ai giocatori già presenti
for _, plr in pairs(Players:GetPlayers()) do
    onPlayerAdded(plr)
end

-- Nuovi giocatori
Players.PlayerAdded:Connect(onPlayerAdded)
