-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- CREAZIONE GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProximityManagerGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 200, 0, 100)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true  -- Necessario per il drag

-- TITOLO
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.Position = UDim2.new(0, 0, 0, 0)
Title.BackgroundTransparency = 1
Title.Text = "Proximity Manager"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

-- FUNZIONE PER CREARE PULSANTI
local function createButton(name, posY)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 30)
    btn.Position = UDim2.new(0, 10, 0, posY)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BorderSizePixel = 0
    btn.Text = name
    btn.TextColor3 = Color3.fromRGB(255, 255, 255)
    btn.Font = Enum.Font.SourceSansBold
    btn.TextSize = 16
    btn.Parent = Frame
    return btn
end

local btnInstant = createButton("Attiva Instant", 35)
local btnRestore = createButton("Ripristina", 70)

-- MEMORIZZAZIONE VALORI ORIGINALI
local originalHoldTimes = {}

local function setProximityInstant()
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            if originalHoldTimes[prompt] == nil then
                originalHoldTimes[prompt] = prompt.HoldDuration
            end
            prompt.HoldDuration = 0
        end
    end
end

local function restoreProximity()
    for prompt, holdTime in pairs(originalHoldTimes) do
        if prompt and prompt.Parent then
            prompt.HoldDuration = holdTime
        end
    end
end

-- COLLEGAMENTO PULSANTI
btnInstant.MouseButton1Click:Connect(setProximityInstant)
btnRestore.MouseButton1Click:Connect(restoreProximity)

-- =========================
-- DRAG FUNCTION
-- =========================
local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    Frame.Position = UDim2.new(framePos.X.Scale, framePos.X.Offset + delta.X,
                               framePos.Y.Scale, framePos.Y.Offset + delta.Y)
end

Frame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        mousePos = input.Position
        framePos = Frame.Position

        input.Changed:Connect(function()
            if input.UserInputState == Enum.UserInputState.End then
                dragging = false
            end
        end)
    end
end)

Frame.InputChanged:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseMovement then
        dragInput = input
    end
end)

game:GetService("UserInputService").InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)

game.DescendantAdded:Connect(function(item)
    if item:IsA("ProximityPrompt") then
            setProximityInstant()
    end
end)
