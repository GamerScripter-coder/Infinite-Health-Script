local Players = game:GetService("Players")
local Workspace = game:GetService("Workspace")

local player = Players.LocalPlayer
local char = player.Character or player.CharacterAdded:Wait()
local stealPart = nil

local servercode = [[
                local Players = game:GetService("Players")
                local Workspace = game:GetService("Workspace")
                local player = Players:GetPlayers()[1] -- prende il primo giocatore locale
                local char = player.Character
                local stealPart = Workspace:FindFirstChild("StealPart")
                if char and char:FindFirstChild("HumanoidRootPart") and stealPart then
                    char.HumanoidRootPart.CFrame = stealPart.CFrame
                    char.HumanoidRootPart.Anchored = true
                    task.wait(1)
                    char.HumanoidRootPart.Anchored = false
                end
            ]]

-- 🔹 Creazione GUI pulsanti (funzione)
local function CreateOption(frame, yPos, labelText, color)
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

-- 🔹 Creazione GUI principale
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

-- Pulsanti
local CreatePartButton = CreateOption(frame, 0.3, "Place Part To Player", Color3.fromRGB(0,200,0))
local TeleportPartButton = CreateOption(frame, 0.52, "Teleport To Part", Color3.fromRGB(0,150,255))
local StopButton = CreateOption(frame, 0.74, "Remove Part", Color3.fromRGB(200,0,0))

-- 🔹 Funzioni pulsanti
CreatePartButton.MouseButton1Click:Connect(function()
    if char and char:FindFirstChild("HumanoidRootPart") then
        if stealPart then stealPart:Destroy() end
        stealPart = Instance.new("Part")
        stealPart.Size = Vector3.new(1,1,1)
        stealPart.Position = char.HumanoidRootPart.Position - Vector3.new(0,2,0)
        stealPart.Anchored = true
        stealPart.CanCollide = false
        stealPart.Color = Color3.fromRGB(255,100,100)
        stealPart.Transparency = 1
        stealPart.Name = "StealPart"
        stealPart.Parent = Workspace
    end
end)

TeleportPartButton.MouseButton1Click:Connect(function()
    if stealPart then
        if not Workspace:FindFirstChild("StealServerScript") then
            local serverScript = Instance.new("Script")
            serverScript.Name = "StealServerScript"
            serverScript.Source = servercode
            serverScript.Parent = Workspace
        end
    end
end)

StopButton.MouseButton1Click:Connect(function()
    if stealPart then
        stealPart:Destroy()
        stealPart = nil
    end
end)
