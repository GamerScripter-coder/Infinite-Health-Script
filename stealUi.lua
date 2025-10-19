local char = game.Players.LocalPlayer.Character

local Gui = Instance.new("ScreenGui")
Gui.Enabled = true
Gui.Name = "StealUi"
Gui.Parent = game.Players.LocalPlayer.PlayerGui
local StealFrame = Instance.new("Frame")
StealFrame.Parent = Gui
StealFrame.AnchorPoint = Vector2.new(0.5, 0.5)
StealFrame.Position = UDim2.new(0.504, 0, 0.531, 0)
StealFrame.Size = UDim2.new(0, 381, 0, 248)
local NameUILabel = Instance.new("TextLabel")
NameUILabel.Parent = StealFrame
NameUILabel.Position = UDim2.new(0.236, 0, 0.034, 0)
NameUILabel.Size = UDim2.new(0, 200, 0, 50)
NameUILabel.Transparency = 1
NameUILabel.Font = Enum.Font.Arimo
NameUILabel.Text = "👤💰 StealUi 👤💰"
local CreatePartLabel = Instance.new("TextLabel")
CreatePartLabel.Parent = StealFrame
CreatePartLabel.Text = "PlacePartToPlayerPosition"
CreatePartLabel.Position = UDim2.new(0.026, 0, 0.315, 0)
CreatePartLabel.Size = UDim2.new(0, 168,0, 50)
local CreatePartButton = Instance.new("TextButton")
CreatePartButton.Parent = CreatePartLabel
CreatePartButton.Position = UDim2.new(1.089, 0,0, 0)
CreatePartButton.Size = UDim2.new(0, 123,0, 50)
CreatePartButton.Text = "Execute"
CreatePartButton.TextColor3 = Color3.fromRGB(0,255,0)
local TeleportPartLabel = Instance.new("TextLabel")
TeleportPartLabel.Parent = StealFrame
TeleportPartLabel.Position = UDim2.new(0.026, 0,0.516, 0)
TeleportPartLabel.Size = UDim2.new(0, 168,0, 50)
TeleportPartLabel.Text = "TeleportToPlayerPosition"
local TeleportPartButton = Instance.new("TextButton")
TeleportPartButton.Parent = TeleportPartLabel
TeleportPartButton.Position = UDim2.new(1.089, 0,0, 0)
TeleportPartButton.Size = UDim2.new(0, 123,0, 50)
TeleportPartButton.Text = "Execute"
TeleportPartButton.TextColor3 = Color3.fromRGB(0,255,0)
CreatePartButton.MouseButton1Click:Connect(function()
	local char = game.Players.LocalPlayer.Character
		if char and char:FindFirstChild("HumanoidRootPart") then
			local PartTeleport = Instance.new("Part")
			PartTeleport.Size = Vector3.new(4, 1, 4) -- dimensione della part
			PartTeleport.Anchored = true
			PartTeleport.Position = char.HumanoidRootPart.Position
			PartTeleport.CanCollide = false
			PartTeleport.Transparency = 1
			PartTeleport.Name = "StealPart"
			PartTeleport.Parent = workspace
		end
end)
TeleportPartButton.MouseButton1Click:Connect(function()
	local char = game.Players.LocalPlayer.Character
		if char then
			char.HumanoidRootPart.CFrame = workspace:WaitForChild("StealPart").CFrame
		end
end)
