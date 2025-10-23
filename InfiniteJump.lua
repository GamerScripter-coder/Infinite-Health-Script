local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")
local uis = game:GetService("UserInputService")

local canDoubleJump = true
local jumpCount = 0
local maxJumps = 1000000000000000000000 -- 2 per doppio salto

local function unlimitedjumps()
	maxJumps += 10000000000000000000000
end

unlimitedjumps()


-- Resetta il conteggio quando il giocatore tocca terra
humanoid.StateChanged:Connect(function(oldState, newState)
	if newState == Enum.HumanoidStateType.Landed then
		jumpCount = 0
		canDoubleJump = true
	end
end)

-- Gestione input jump
uis.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.Space then
		if humanoid.FloorMaterial ~= Enum.Material.Air then
			-- Salto normale
			jumpCount = 1
		elseif jumpCount < maxJumps and canDoubleJump then
			-- Doppio salto
			humanoid:ChangeState(Enum.HumanoidStateType.Jumping)
			jumpCount += 1
			canDoubleJump = false
			wait(0.1)
			canDoubleJump = true
		end
	end
end)
