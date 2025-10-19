local plrgui = game:GetService("Players").LocalPlayer.PlayerGui

local Gui = Instance.new("ScreenGui")
Gui.Parent = plrgui
Gui.Enabled = true
Gui.Name = "PlayerUi"

local PlayerFrame = Instance.new("ScrollingFrame")
PlayerFrame.Parent = Gui
PlayerFrame.Size = UDim2.new(0, 165, 0, 638)
PlayerFrame.Position = UDim2.new(0, 0, 0, 0)
PlayerFrame.BackgroundTransparency = 0.5

local Uicorner = Instance.new("UICorner")
Uicorner.Parent = PlayerFrame

local UiListLayout = Instance.new("UIListLayout")
UiListLayout.Parent = PlayerFrame

game.Players.PlayerAdded:Connect(function(plr)
	local PlayerLabel = Instance.new("TextLabel")
	PlayerLabel.Size = UDim2.new(0, 165, 0, 50)
	PlayerLabel.Text = plr.Name .." Has Joined"
	PlayerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	PlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	PlayerLabel.Font = Enum.Font.SourceSans
	PlayerLabel.TextSize = 20
	PlayerLabel.Parent = PlayerFrame  -- Questo è fondamentale
end)
