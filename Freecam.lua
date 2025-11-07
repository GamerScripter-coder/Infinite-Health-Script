-- ✅ FREECAM VELOCITÀ RIDOTTA (TOGGLE CON "L")
-- ✅ Si muove solo se NON si scrive nella chat

local UserInputService = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Players = game.Players
local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

local Chat = game:GetService("Chat")

local freecam = false
local speed = 2
local boost = 6
local camPos
local camRot = Vector2.new()

-- ✅ Controllo chat aperta
local typing = false
UserInputService.TextBoxFocused:Connect(function()
	typing = true
end)
UserInputService.TextBoxFocusReleased:Connect(function()
	typing = false
end)

local function getHRP()
	local char = player.Character or player.CharacterAdded:Wait()
	return char:WaitForChild("HumanoidRootPart", 5)
end

local function enableFreecam()
	freecam = true
	camPos = camera.CFrame.Position
	
	local HRP = getHRP()
	if HRP then HRP.Anchored = true end
end

local function disableFreecam()
	freecam = false
	
	local HRP = getHRP()
	if HRP then HRP.Anchored = false end
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
	if typing then return end   -- ✅ Stop movimento quando si scrive

	local delta = UserInputService:GetMouseDelta()
	camRot = camRot + Vector2.new(-delta.X, -delta.Y) * 0.002

	local moveSpeed = speed
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
