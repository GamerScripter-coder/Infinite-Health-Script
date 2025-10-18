local Players = game:GetService("Players")
local player = Players.LocalPlayer

local function onCharacter(char)
	local humanoid = char:WaitForChild("Humanoid")

	-- Imposta vita e velocità iniziale
	humanoid.MaxHealth = 100
	humanoid.Health = humanoid.MaxHealth
	humanoid.WalkSpeed = 45

	-- Blocca qualsiasi danno
	humanoid:GetPropertyChangedSignal("Health"):Connect(function()
		if humanoid.Health < humanoid.MaxHealth then
			humanoid.Health = humanoid.MaxHealth
		end
	end)

	-- Mantiene sempre la velocità a 45
	humanoid:GetPropertyChangedSignal("WalkSpeed"):Connect(function()
		if humanoid.WalkSpeed ~= 45 then
			humanoid.WalkSpeed = 45
		end
	end)
end

-- Applica subito se il personaggio è già spawnato
if player.Character then
	onCharacter(player.Character)
end

-- Riapplica ogni volta che rinasce
player.CharacterAdded:Connect(onCharacter)

