-- ======================================
-- CLEANUP (SEMPRE ALL'INIZIO)
-- ======================================
pcall(function()
	game:GetService("CoreGui"):FindFirstChild("PositionGui"):Destroy()
end)

-- ======================================
-- SERVICES
-- ======================================
local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")
local CoreGui = game:GetService("CoreGui")

local plr = Players.LocalPlayer

-- ======================================
-- CONFIG
-- ======================================
local MAX_RESETS = 6        -- cambia a 10 se vuoi
local CHECK_DISTANCE = 5   -- distanza massima consentita

-- ======================================
-- STATE
-- ======================================
local savedCFrame = nil
local resetCount = 0
local monitoring = false

-- ======================================
-- GUI
-- ======================================
local gui = Instance.new("ScreenGui")
gui.Name = "PositionGui"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

-- FRAME
local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.25, 0.22)
frame.Position = UDim2.fromScale(0.38, 0.38)
frame.BackgroundColor3 = Color3.fromRGB(30,30,30)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

-- TITLE (DRAG)
local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.25,0)
title.BackgroundTransparency = 1
title.Text = "Position Saver"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- SAVE BUTTON
local saveBtn = Instance.new("TextButton")
saveBtn.Size = UDim2.new(0.9,0,0.25,0)
saveBtn.Position = UDim2.new(0.05,0,0.3,0)
saveBtn.Text = "Save Position"
saveBtn.BackgroundColor3 = Color3.fromRGB(0,90,140)
saveBtn.TextColor3 = Color3.new(1,1,1)
saveBtn.TextScaled = true
saveBtn.Font = Enum.Font.Gotham
saveBtn.Parent = frame
Instance.new("UICorner", saveBtn)

-- TELEPORT BUTTON
local tpBtn = Instance.new("TextButton")
tpBtn.Size = UDim2.new(0.9,0,0.25,0)
tpBtn.Position = UDim2.new(0.05,0,0.62,0)
tpBtn.Text = "Teleport"
tpBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
tpBtn.TextColor3 = Color3.new(1,1,1)
tpBtn.TextScaled = true
tpBtn.Font = Enum.Font.Gotham
tpBtn.Parent = frame
Instance.new("UICorner", tpBtn)

-- ======================================
-- LOGIC
-- ======================================
saveBtn.MouseButton1Click:Connect(function()
	local char = plr.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	savedCFrame = hrp.CFrame
	resetCount = 0
	monitoring = false

	saveBtn.Text = "Position Saved ✔"
	tpBtn.Text = "Teleport"
	tpBtn.BackgroundColor3 = Color3.fromRGB(0,120,0)
end)

tpBtn.MouseButton1Click:Connect(function()
	if not savedCFrame then return end

	local char = plr.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	hrp.CFrame = savedCFrame
	resetCount = 0
	monitoring = true
end)

-- ======================================
-- POSITION MONITOR
-- ======================================
RunService.Heartbeat:Connect(function()
	if not monitoring or not savedCFrame then return end

	local char = plr.Character
	if not char then return end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then return end

	local distance = (hrp.Position - savedCFrame.Position).Magnitude

	if distance > CHECK_DISTANCE then
		resetCount += 1

		if resetCount >= MAX_RESETS then
			monitoring = false
			return
		end

		hrp.CFrame = savedCFrame
	end
end)

-- ======================================
-- DRAG LOGIC
-- ======================================
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
