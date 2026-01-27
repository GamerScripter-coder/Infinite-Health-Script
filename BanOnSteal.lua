-- SERVICES
local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local plr = Players.LocalPlayer

-- STATE
local stealingClicked = false
local stealingEnabled = true

if CoreGui:FindFirstChild("StealGui") then
CoreGui:FindFirstChild("StealGui"):Destroy()
end

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StealGui"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.25, 0.25)
frame.Position = UDim2.fromScale(0.4, 0.35)
frame.BackgroundColor3 = Color3.fromRGB(35,35,35)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TITLE (DRAG)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.2,0)
title.BackgroundTransparency = 1
title.Text = "Steal Panel"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- STEALING BUTTON
local stealingBtn = Instance.new("TextButton")
stealingBtn.Size = UDim2.new(0.9,0,0.2,0)
stealingBtn.Position = UDim2.new(0.05,0,0.25,0)
stealingBtn.Text = "Stealing"
stealingBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
stealingBtn.TextColor3 = Color3.new(1,1,1)
stealingBtn.TextScaled = true
stealingBtn.Font = Enum.Font.Gotham
stealingBtn.AutoButtonColor = true
stealingBtn.Parent = frame
Instance.new("UICorner", stealingBtn)

-- STEALED BUTTON
local stealedBtn = Instance.new("TextButton")
stealedBtn.Size = UDim2.new(0.9,0,0.2,0)
stealedBtn.Position = UDim2.new(0.05,0,0.5,0)
stealedBtn.Text = "Stealed"
stealedBtn.BackgroundColor3 = Color3.fromRGB(80,0,0)
stealedBtn.TextColor3 = Color3.new(1,1,1)
stealedBtn.TextScaled = true
stealedBtn.Font = Enum.Font.Gotham
stealedBtn.Parent = frame
Instance.new("UICorner", stealedBtn)

-- NOT STEALING BUTTON
local notStealingBtn = Instance.new("TextButton")
notStealingBtn.Size = UDim2.new(0.9,0,0.2,0)
notStealingBtn.Position = UDim2.new(0.05,0,0.75,0)
notStealingBtn.Text = "Not Stealing"
notStealingBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
notStealingBtn.TextColor3 = Color3.new(1,1,1)
notStealingBtn.TextScaled = true
notStealingBtn.Font = Enum.Font.Gotham
notStealingBtn.Parent = frame
Instance.new("UICorner", notStealingBtn)

-- BUTTON LOGIC
stealingBtn.MouseButton1Click:Connect(function()
	if not stealingEnabled then return end

	stealingClicked = true
	stealingBtn.Text = "Stealing ✔"
	stealingBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
end)

stealedBtn.MouseButton1Click:Connect(function()
	if stealingClicked then
		plr:Kick("Stealed.")
	end
end)

notStealingBtn.MouseButton1Click:Connect(function()
	stealingEnabled = not stealingEnabled

	if stealingEnabled then
		notStealingBtn.Text = "Not Stealing"
		notStealingBtn.BackgroundColor3 = Color3.fromRGB(30,30,30)
		stealingBtn.BackgroundColor3 = Color3.fromRGB(60,60,60)
		stealingBtn.Text = "Stealing"
		stealingBtn.AutoButtonColor = true
	else
		stealingClicked = false
		notStealingBtn.Text = "Stealing Disabled"
		notStealingBtn.BackgroundColor3 = Color3.fromRGB(120,0,0)
		stealingBtn.BackgroundColor3 = Color3.fromRGB(40,40,40)
		stealingBtn.Text = "Stealing"
		stealingBtn.AutoButtonColor = false
	end
end)

-- DRAG LOGIC
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
