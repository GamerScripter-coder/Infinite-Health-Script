-- The Free Cam is For Pc
-- FREECAM VELOCITÀ RIDOTTA (TOGGLE CON "L")

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local freecam = false
local speed = 2      -- 🔹 VELOCITÀ NORMALE (prima era 5)
local boost = 6      -- 🔹 SHIFT VELOCE (prima era 15)
local moveSpeed = 0

local camPos
local camRot = Vector2.new()

local function enableFreecam()
	freecam = true
	camPos = camera.CFrame.Position
	player.character.HumanoidRootPart.Anchored = true
end

local function disableFreecam()
	freecam = false
	player.character.HumanoidRootPart.Anchored = false
end

UserInputService.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	
	if input.KeyCode == Enum.KeyCode.L then
		freecam = not freecam
		if freecam then
			enableFreecam()
		else
			disableFreecam()
		end
	end
end)

RunService.RenderStepped:Connect(function(dt)
	if not freecam then return end

	-- MOUSE ROTATION
	local delta = UserInputService:GetMouseDelta()
	camRot = camRot + Vector2.new(-delta.X, -delta.Y) * 0.002

	-- MOVIMENTO
	moveSpeed = speed
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftShift) then
		moveSpeed = boost
	end

	local moveDir = Vector3.new()
	if UserInputService:IsKeyDown(Enum.KeyCode.W) then moveDir += Vector3.new(0,0,-1) end
	if UserInputService:IsKeyDown(Enum.KeyCode.S) then moveDir += Vector3.new(0,0,1) end
	if UserInputService:IsKeyDown(Enum.KeyCode.A) then moveDir += Vector3.new(-1,0,0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.D) then moveDir += Vector3.new(1,0,0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.Space) then moveDir += Vector3.new(0,1,0) end
	if UserInputService:IsKeyDown(Enum.KeyCode.LeftControl) then moveDir += Vector3.new(0,-1,0) end

	camPos += (CFrame.fromEulerAnglesYXZ(camRot.Y, camRot.X, 0) * CFrame.new(moveDir * moveSpeed)).Position

	camera.CFrame = CFrame.fromEulerAnglesYXZ(camRot.Y, camRot.X, 0) + camPos
end)
