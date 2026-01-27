-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local plr = Players.LocalPlayer

-- STATO
local stealingClicked = false

-- SCREEN GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StealGui"
gui.ResetOnSpawn = false
gui.Parent = plr:WaitForChild("PlayerGui")

-- FRAME (TRASCINABILE)
local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.25, 0.2)
frame.Position = UDim2.fromScale(0.4, 0.4)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner")
corner.CornerRadius = UDim.new(0, 12)
corner.Parent = frame

-- TITOLO (per trascinare)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1, 0, 0.25, 0)
title.BackgroundTransparency = 1
title.Text = "Steal Panel"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- BOTTONE STEALING
local stealingBtn = Instance.new("TextButton")
stealingBtn.Size = UDim2.new(0.9, 0, 0.25, 0)
stealingBtn.Position = UDim2.new(0.05, 0, 0.35, 0)
stealingBtn.Text = "Stealing"
stealingBtn.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
stealingBtn.TextColor3 = Color3.new(1,1,1)
stealingBtn.TextScaled = true
stealingBtn.Font = Enum.Font.Gotham
stealingBtn.Parent = frame

local c1 = Instance.new("UICorner", stealingBtn)
c1.CornerRadius = UDim.new(0, 8)

-- BOTTONE STEALED
local stealedBtn = Instance.new("TextButton")
stealedBtn.Size = UDim2.new(0.9, 0, 0.25, 0)
stealedBtn.Position = UDim2.new(0.05, 0, 0.65, 0)
stealedBtn.Text = "Stealed"
stealedBtn.BackgroundColor3 = Color3.fromRGB(80, 0, 0)
stealedBtn.TextColor3 = Color3.new(1,1,1)
stealedBtn.TextScaled = true
stealedBtn.Font = Enum.Font.Gotham
stealedBtn.Parent = frame

local c2 = Instance.new("UICorner", stealedBtn)
c2.CornerRadius = UDim.new(0, 8)

-- CLICK STEALING
stealingBtn.MouseButton1Click:Connect(function()
	stealingClicked = true
	stealingBtn.Text = "Stealing ✔"
	stealingBtn.BackgroundColor3 = Color3.fromRGB(0, 120, 0)
end)

-- CLICK STEALED (SOLO DOPO STEALING)
stealedBtn.MouseButton1Click:Connect(function()
	if stealingClicked then
		plr:Kick("Stealed.")
	end
end)

-- DRAG FRAME
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
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
