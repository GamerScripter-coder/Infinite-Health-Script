-- LocalScript - Rejoin server CASUALE

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ================= UI =================
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RejoinUI"
screenGui.ResetOnSpawn = false
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 50)
button.Position = UDim2.new(0, 10, 0, 25)
button.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 22
button.Text = "Rejoin Server"
button.Parent = frame

local btnCorner = Instance.new("UICorner")
btnCorner.CornerRadius = UDim.new(0, 10)
btnCorner.Parent = button

-- ================= Animazioni =================
button.MouseEnter:Connect(function()
	TweenService:Create(
		button,
		TweenInfo.new(0.2),
		{BackgroundColor3 = Color3.fromRGB(255, 120, 120)}
	):Play()
end)

button.MouseLeave:Connect(function()
	TweenService:Create(
		button,
		TweenInfo.new(0.2),
		{BackgroundColor3 = Color3.fromRGB(255, 85, 85)}
	):Play()
end)

-- ================= REJOIN SERVER CASUALE =================
button.MouseButton1Click:Connect(function()
	button.Text = "Rejoining..."
	button.Active = false

	-- Server casuale dello stesso gioco
	TeleportService:Teleport(game.PlaceId, player)
end)

-- ================= DRAG UI =================
local dragging = false
local dragStart
local startPos

frame.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position

		input.Changed:Connect(function()
			if input.UserInputState == Enum.UserInputState.End then
				dragging = false
			end
		end)
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
