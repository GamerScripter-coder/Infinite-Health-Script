local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

local Gui = Instance.new("ScreenGui")
Gui.Name = "StealUi"
Gui.Parent = player:WaitForChild("PlayerGui")

local StealFrame = Instance.new("Frame")
StealFrame.Parent = Gui
StealFrame.AnchorPoint = Vector2.new(0.5, 0.5)
StealFrame.Position = UDim2.new(0.5, 0, 0.5, 0)
StealFrame.Size = UDim2.new(0, 381, 0, 248)
StealFrame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
StealFrame.BorderSizePixel = 0

local NameUILabel = Instance.new("TextLabel")
NameUILabel.Parent = StealFrame
NameUILabel.Position = UDim2.new(0.236, 0, 0.034, 0)
NameUILabel.Size = UDim2.new(0, 200, 0, 50)
NameUILabel.BackgroundTransparency = 1
NameUILabel.Font = Enum.Font.Arimo
NameUILabel.Text = "👤💰 StealUi 👤💰"
NameUILabel.TextColor3 = Color3.fromRGB(255, 255, 255)
NameUILabel.TextScaled = true

-- Create Part
local CreatePartLabel = Instance.new("TextLabel")
CreatePartLabel.Parent = StealFrame
CreatePartLabel.Text = "PlacePartToPlayerPosition"
CreatePartLabel.Position = UDim2.new(0.026, 0, 0.315, 0)
CreatePartLabel.Size = UDim2.new(0, 168, 0, 50)
CreatePartLabel.BackgroundTransparency = 1
CreatePartLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local CreatePartButton = Instance.new("TextButton")
CreatePartButton.Parent = CreatePartLabel
CreatePartButton.Position = UDim2.new(1.089, 0, 0, 0)
CreatePartButton.Size = UDim2.new(0, 123, 0, 50)
CreatePartButton.Text = "Execute"
CreatePartButton.TextColor3 = Color3.fromRGB(0, 255, 0)

-- Teleport Part
local TeleportPartLabel = Instance.new("TextLabel")
TeleportPartLabel.Parent = StealFrame
TeleportPartLabel.Position = UDim2.new(0.026, 0, 0.516, 0)
TeleportPartLabel.Size = UDim2.new(0, 168, 0, 50)
TeleportPartLabel.Text = "TeleportToPlayerPosition"
TeleportPartLabel.BackgroundTransparency = 1
TeleportPartLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local TeleportPartButton = Instance.new("TextButton")
TeleportPartButton.Parent = TeleportPartLabel
TeleportPartButton.Position = UDim2.new(1.089, 0, 0, 0)
TeleportPartButton.Size = UDim2.new(0, 123, 0, 50)
TeleportPartButton.Text = "Execute"
TeleportPartButton.TextColor3 = Color3.fromRGB(0, 255, 0)

-- Stop
local StopLabel = Instance.new("TextLabel")
StopLabel.Parent = StealFrame
StopLabel.Position = UDim2.new(0.026, 0, 0.718, 0)
StopLabel.Size = UDim2.new(0, 168, 0, 50)
StopLabel.Text = "Stop"
StopLabel.BackgroundTransparency = 1
StopLabel.TextColor3 = Color3.fromRGB(255, 255, 255)

local StopButton = Instance.new("TextButton")
StopButton.Parent = StopLabel
StopButton.Position = UDim2.new(1.089, 0, 0, 0)
StopButton.Size = UDim2.new(0, 123, 0, 50)
StopButton.Text = "Execute"
StopButton.TextColor3 = Color3.fromRGB(255, 0, 0)

local OpenClose = Instance.new("Frame")
OpenClose.Parent = Gui
OpenClose.Name = "Open/Close"
OpenClose.Position = UDim2.new(0.933, 0,0.895, 0)
OpenClose.Size = UDim2.new(0, 38,0, 39)
OpenClose.Visible = true
OpenClose.Transparency = 0
local OpenCloseLabel = Instance.new("TextLabel")
OpenCloseLabel.Parent = OpenClose
OpenCloseLabel.Position = UDim2.new(0, 0, -0.026, 0)
OpenCloseLabel.Size = UDim2.new(1, 0, 1, 0)
OpenCloseLabel.Transparency = 1
OpenCloseLabel.Text = "Open"
OpenCloseLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
OpenCloseLabel.Font = Enum.Font.Arimo
OpenCloseLabel.TextScaled = true
local OpenCloseButton = Instance.new("TextButton")
OpenCloseButton.Parent = OpenCloseLabel
OpenCloseButton.Position = UDim2.new(0, 0, 0, 0)
OpenCloseButton.Size = UDim2.new(1, 0, 1, 0)
OpenCloseButton.Text = ""
OpenCloseButton.Transparency = 1
-- 🔹 Variabile di controllo
local running = false

CreatePartButton.MouseButton1Click:Connect(function()
	if char and char:FindFirstChild("HumanoidRootPart") then
		local PartTeleport = Instance.new("Part")
		PartTeleport.Size = Vector3.new(4, 1, 4)
		PartTeleport.Anchored = true
		PartTeleport.Position = char.HumanoidRootPart.Position
		PartTeleport.CanCollide = false
		PartTeleport.Transparency = 1
		PartTeleport.Name = "StealPart"
		PartTeleport.Parent = workspace
	end
end)

TeleportPartButton.MouseButton1Click:Connect(function()
	if not workspace:FindFirstChild("StealPart") then return end
	running = true
	task.spawn(function()
		while running do
			task.wait(0.01)
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = workspace.StealPart.CFrame
			end
		end
	end)
end)

StopButton.MouseButton1Click:Connect(function()
	running = false
end)

OpenCloseButton.MouseButton1Click:Connect(function()
	if OpenCloseLabel.Text == "Open" then
		OpenCloseLabel.Text = "Close"
		StealFrame.Visible = true
	elseif OpenCloseLabel.Text == "Close" then
		OpenCloseLabel.Text = "Open"
		StealFrame.Visible = false
	end
end)
