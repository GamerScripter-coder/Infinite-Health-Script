-- LocalScript

local plrgui = game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui")

-- 🟢 Crea GUI principale
local Gui = Instance.new("ScreenGui")
Gui.Name = "PlayerUi"
Gui.Enabled = true
Gui.Parent = plrgui

-- 🟢 Crea ScrollingFrame
local PlayerFrame = Instance.new("ScrollingFrame")
PlayerFrame.Parent = Gui
PlayerFrame.Size = UDim2.new(0, 165, 0, 638)
PlayerFrame.Position = UDim2.new(0, 0, 0, 0)
PlayerFrame.BackgroundTransparency = 0.5
PlayerFrame.CanvasSize = UDim2.new(0, 0, 0, 0)
PlayerFrame.AutomaticCanvasSize = Enum.AutomaticSize.Y -- 🔹 aggiorna automaticamente l'altezza
PlayerFrame.ScrollBarThickness = 6

-- 🟢 Bordo arrotondato
local UICorner = Instance.new("UICorner")
UICorner.Parent = PlayerFrame

-- 🟢 Layout automatico
local UIListLayout = Instance.new("UIListLayout")
UIListLayout.Parent = PlayerFrame
UIListLayout.Padding = UDim.new(0, 4)

-- 🔹 Aggiorna la CanvasSize se AutomaticSize non è disponibile o per sicurezza
local function updateCanvas()
	PlayerFrame.CanvasSize = UDim2.new(0, 0, 0, UIListLayout.AbsoluteContentSize.Y)
end

UIListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(updateCanvas)

-- 🟢 Quando un giocatore entra
game.Players.PlayerAdded:Connect(function(plr)
	local PlayerLabel = Instance.new("TextLabel")
	PlayerLabel.Size = UDim2.new(0, 165, 0, 50)
	PlayerLabel.Text = plr.Name .. " has joined"
	PlayerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	PlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	PlayerLabel.Font = Enum.Font.SourceSansBold
	PlayerLabel.TextSize = 20
	PlayerLabel.Parent = PlayerFrame
	updateCanvas()
end)

-- 🟢 (Facoltativo) Mostra anche chi è già nel server
for _, plr in pairs(game.Players:GetPlayers()) do
	local PlayerLabel = Instance.new("TextLabel")
	PlayerLabel.Size = UDim2.new(0, 165, 0, 50)
	PlayerLabel.Text = plr.Name
	PlayerLabel.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
	PlayerLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
	PlayerLabel.Font = Enum.Font.SourceSansBold
	PlayerLabel.TextSize = 20
	PlayerLabel.Parent = PlayerFrame
end
updateCanvas()
