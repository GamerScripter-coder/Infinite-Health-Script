local player = game.Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()

-- 🔹 GUI principale
local gui = Instance.new("ScreenGui")
gui.Name = "StealUi"
gui.Parent = player:WaitForChild("PlayerGui")

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 260)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0,12)

local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80,80,80)
stroke.Thickness = 1.2

local title = Instance.new("TextLabel")
title.Parent = frame
title.Position = UDim2.new(0,0,0,10)
title.Size = UDim2.new(1,0,0,40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "👤💰 Steal UI Panel 💰👤"
title.TextColor3 = Color3.fromRGB(255,255,255)
title.TextScaled = true

local underline = Instance.new("Frame", frame)
underline.AnchorPoint = Vector2.new(0.5,0)
underline.Position = UDim2.new(0.5,0,0,50)
underline.Size = UDim2.new(0.8,0,0,1)
underline.BackgroundColor3 = Color3.fromRGB(100,100,100)
underline.BorderSizePixel = 0

-- 🔹 Funzione per creare pulsanti
local function CreateOption(yPos,labelText,color)
	local Row = Instance.new("Frame")
	Row.Parent = frame
	Row.Position = UDim2.new(0.05,0,yPos,0)
	Row.Size = UDim2.new(0.9,0,0,50)
	Row.BackgroundTransparency = 1

	local Label = Instance.new("TextLabel")
	Label.Parent = Row
	Label.Size = UDim2.new(0.6,0,1,0)
	Label.BackgroundTransparency = 1
	Label.Text = labelText
	Label.Font = Enum.Font.Gotham
	Label.TextScaled = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextColor3 = Color3.fromRGB(255,255,255)

	local Button = Instance.new("TextButton")
	Button.Parent = Row
	Button.AnchorPoint = Vector2.new(1,0.5)
	Button.Position = UDim2.new(1,0,0.5,0)
	Button.Size = UDim2.new(0,120,0,35)
	Button.Text = "Execute"
	Button.Font = Enum.Font.GothamBold
	Button.TextScaled = true
	Button.TextColor3 = Color3.fromRGB(255,255,255)
	Button.BackgroundColor3 = color
	Button.AutoButtonColor = false

	local bCorner = Instance.new("UICorner", Button)
	bCorner.CornerRadius = UDim.new(0,8)
	local bStroke = Instance.new("UIStroke", Button)
	bStroke.Color = Color3.fromRGB(255,255,255)
	bStroke.Thickness = 0.5

	-- Hover effect
	Button.MouseEnter:Connect(function()
		Button.BackgroundColor3 = Color3.new(
			math.clamp(color.R+0.1,0,1),
			math.clamp(color.G+0.1,0,1),
			math.clamp(color.B+0.1,0,1)
		)
	end)
	Button.MouseLeave:Connect(function()
		Button.BackgroundColor3 = color
	end)

	return Button
end

-- 🔹 Pulsanti
local CreatePartButton = CreateOption(0.3,"Place Part To Player",Color3.fromRGB(0,200,0))
local TeleportPartButton = CreateOption(0.52,"Teleport To Part",Color3.fromRGB(0,150,255))
local StopButton = CreateOption(0.74,"Stop Teleport",Color3.fromRGB(200,0,0))

-- 🔹 Logica teletrasporto
local running = false
local savedPos = nil
local stealPart = nil -- NON esiste finché non clicchi il pulsante

CreatePartButton.MouseButton1Click:Connect(function()
	if char and char:FindFirstChild("HumanoidRootPart") then
		-- Se la StealPart esiste già, la rimuove prima
		if stealPart then
			stealPart:Destroy()
		end
		stealPart = Instance.new("Part")
		stealPart.Size = Vector3.new(1,1,1)
		stealPart.CFrame = char.RightFoot.CFrame
		stealPart.Anchored = true
		stealPart.CanCollide = false
		stealPart.Color = Color3.fromRGB(255,100,100)
		stealPart.Transparency = 1
		stealPart.Name = "StealPart"
		stealPart.Parent = workspace
	end
end)

TeleportPartButton.MouseButton1Click:Connect(function()
	if not stealPart then return end
	if char and char:FindFirstChild("HumanoidRootPart") then
		print("Ok")
	end
	running = true
			task.wait(0.05)
			if char and char:FindFirstChild("HumanoidRootPart") then
				char.HumanoidRootPart.CFrame = stealPart.CFrame + Vector3.new(0,3,0)
				char.HumanoidRootPart.Anchored = true
				wait(1)
				char.HumanoidRootPart.Anchored = false
			end
		end
	end)
end)

StopButton.MouseButton1Click:Connect(function()
	running = false
	if savedPos and char and char:FindFirstChild("HumanoidRootPart") then
		char.HumanoidRootPart.CFrame = savedPos
	end
end)

-- 🔹 Open/Close Button
local OpenClose = Instance.new("TextButton")
OpenClose.Parent = gui
OpenClose.Size = UDim2.new(0,50,0,50)
OpenClose.Position = UDim2.new(0.95,0,0.9,0)
OpenClose.BackgroundColor3 = Color3.fromRGB(25,25,25)
OpenClose.Text = "Close"
OpenClose.Font = Enum.Font.GothamBold
OpenClose.TextColor3 = Color3.fromRGB(255,255,255)

OpenClose.MouseButton1Click:Connect(function()
	if frame.Visible then
		frame.Visible = false
		OpenClose.Text = "Open"
	else
		frame.Visible = true
		OpenClose.Text = "Close"
	end
end)
