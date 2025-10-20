-- LocalScript (StarterPlayerScripts)
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local guiParent = player:WaitForChild("PlayerGui")

-- tieni sempre aggiornato 'char' se il player respawna
local char = player.Character
if not char then
	char = player.CharacterAdded:Wait()
end
player.CharacterAdded:Connect(function(c)
	char = c
end)

-- GUI
local gui = Instance.new("ScreenGui")
gui.Name = "StealUi"
gui.ResetOnSpawn = false
gui.Parent = guiParent

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 260)
frame.Position = UDim2.new(0.5, 0, 0.5, 0)
frame.AnchorPoint = Vector2.new(0.5, 0.5)
frame.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
frame.BackgroundTransparency = 0.15
frame.BorderSizePixel = 0
frame.Parent = gui

local corner = Instance.new("UICorner", frame)
corner.CornerRadius = UDim.new(0, 12)
local stroke = Instance.new("UIStroke", frame)
stroke.Color = Color3.fromRGB(80, 80, 80)
stroke.Thickness = 1.2

local title = Instance.new("TextLabel")
title.Parent = frame
title.Position = UDim2.new(0, 0, 0, 10)
title.Size = UDim2.new(1, 0, 0, 40)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "👤💰 Steal UI Panel 💰👤"
title.TextColor3 = Color3.fromRGB(255, 255, 255)
title.TextScaled = true

local underline = Instance.new("Frame", frame)
underline.AnchorPoint = Vector2.new(0.5, 0)
underline.Position = UDim2.new(0.5, 0, 0, 50)
underline.Size = UDim2.new(0.8, 0, 0, 1)
underline.BackgroundColor3 = Color3.fromRGB(100, 100, 100)
underline.BorderSizePixel = 0

local function CreateOption(yPos, labelText, color)
	local Row = Instance.new("Frame")
	Row.Parent = frame
	Row.Position = UDim2.new(0.05, 0, yPos, 0)
	Row.Size = UDim2.new(0.9, 0, 0, 50)
	Row.BackgroundTransparency = 1

	local Label = Instance.new("TextLabel")
	Label.Parent = Row
	Label.Size = UDim2.new(0.6, 0, 1, 0)
	Label.BackgroundTransparency = 1
	Label.Text = labelText
	Label.Font = Enum.Font.Gotham
	Label.TextScaled = true
	Label.TextXAlignment = Enum.TextXAlignment.Left
	Label.TextColor3 = Color3.fromRGB(255, 255, 255)

	local Button = Instance.new("TextButton")
	Button.Parent = Row
	Button.AnchorPoint = Vector2.new(1, 0.5)
	Button.Position = UDim2.new(1, 0, 0.5, 0)
	Button.Size = UDim2.new(0, 120, 0, 35)
	Button.Text = "Execute"
	Button.Font = Enum.Font.GothamBold
	Button.TextScaled = true
	Button.TextColor3 = Color3.fromRGB(255, 255, 255)
	Button.BackgroundColor3 = color
	Button.AutoButtonColor = false

	local bCorner = Instance.new("UICorner", Button)
	bCorner.CornerRadius = UDim.new(0, 8)
	local bStroke = Instance.new("UIStroke", Button)
	bStroke.Color = Color3.fromRGB(255, 255, 255)
	bStroke.Thickness = 0.5

	Button.MouseEnter:Connect(function()
		Button.BackgroundColor3 = Color3.new(
			math.clamp(color.R + 0.1, 0, 1),
			math.clamp(color.G + 0.1, 0, 1),
			math.clamp(color.B + 0.1, 0, 1)
		)
	end)
	Button.MouseLeave:Connect(function()
		Button.BackgroundColor3 = color
	end)

	return Button
end

local CreatePartButton = CreateOption(0.3, "Place Part To Player", Color3.fromRGB(0, 200, 0))
local TeleportPartButton = CreateOption(0.52, "Teleport To Part", Color3.fromRGB(0, 150, 255))
local StopButton = CreateOption(0.74, "Stop Teleport", Color3.fromRGB(200, 0, 0))

-- variabili di stato
local running = false
local savedPos = nil
local stealPart = nil

-- crea la part sotto i piedi (usa HumanoidRootPart per robustezza)
CreatePartButton.MouseButton1Click:Connect(function()
	-- assicurati che il char e HumanoidRootPart esistano
	if not char or not char.Parent then
		print("[StealUI] character not ready")
		return
	end
	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		print("[StealUI] HumanoidRootPart missing")
		return
	end

	-- rimuovi part precedente se esiste
	if stealPart and stealPart.Parent then
		stealPart:Destroy()
	end

	stealPart = Instance.new("Part")
	stealPart.Size = Vector3.new(6, 1, 6)

	-- spawn 3 stud sotto i piedi (HumanoidRootPart)
	stealPart.CFrame = hrp.CFrame * CFrame.new(0, -3, 0)

	stealPart.Anchored = true
	stealPart.CanCollide = false
	stealPart.Color = Color3.fromRGB(255, 100, 100)
	stealPart.Transparency = 0.4
	stealPart.Material = Enum.Material.Neon
	stealPart.Name = "StealPart"
	stealPart.Parent = workspace

	print("[StealUI] StealPart spawned at:", tostring(stealPart.Position))
end)

-- teletrasporto (loop)
TeleportPartButton.MouseButton1Click:Connect(function()
	if not stealPart or not stealPart.Parent then
		print("[StealUI] No StealPart to teleport to.")
		return
	end

	if not char or not char.Parent then
		print("[StealUI] character not ready for teleport.")
		return
	end

	local hrp = char:FindFirstChild("HumanoidRootPart")
	if not hrp then
		print("[StealUI] HumanoidRootPart missing; cannot teleport.")
		return
	end

	-- salva posizione iniziale
	savedPos = hrp.CFrame:Clone()
	running = true
	print("[StealUI] Teleport started.")

	-- avvia loop in task.spawn
	task.spawn(function()
		while running do
			task.wait(0.05)
			-- conferma che i riferimenti esistono ancora
			if not stealPart or not stealPart.Parent then
				print("[StealUI] StealPart è stato rimosso, stop teleport.")
				running = false
				break
			end
			if char and char.Parent and char:FindFirstChild("HumanoidRootPart") then
				local targetCFrame = stealPart.CFrame * CFrame.new(0, 3, 0) -- 3 stud sopra la part
				-- applica il teletrasporto al HumanoidRootPart
				char.HumanoidRootPart.CFrame = targetCFrame
			else
				print("[StealUI] character non valido nel loop.")
			end
		end
	end)
end)

StopButton.MouseButton1Click:Connect(function()
	if running then
		running = false
		print("[StealUI] Teleport stopped.")
		-- ripristina posizione iniziale se valida
		if savedPos and char and char.Parent and char:FindFirstChild("HumanoidRootPart") then
			char.HumanoidRootPart.CFrame = savedPos
		end
	end
end)

-- Open/Close Button
local OpenClose = Instance.new("TextButton")
OpenClose.Parent = gui
OpenClose.Size = UDim2.new(0, 50, 0, 50)
OpenClose.Position = UDim2.new(0.95, 0, 0.9, 0)
OpenClose.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
OpenClose.Text = "Close"
OpenClose.Font = Enum.Font.GothamBold
OpenClose.TextColor3 = Color3.fromRGB(255, 255, 255)
local ocCorner = Instance.new("UICorner", OpenClose)
ocCorner.CornerRadius = UDim.new(0, 8)

OpenClose.MouseButton1Click:Connect(function()
	if frame.Visible then
		frame.Visible = false
		OpenClose.Text = "Open"
	else
		frame.Visible = true
		OpenClose.Text = "Close"
	end
end)
