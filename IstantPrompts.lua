-- SERVICES
local Players = game:GetService("Players")
local player = Players.LocalPlayer
local UserInputService = game:GetService("UserInputService")

-- GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ProximityManagerGui"
ScreenGui.Parent = player:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Size = UDim2.new(0, 220, 0, 160)
Frame.Position = UDim2.new(0, 50, 0, 50)
Frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Frame.BorderSizePixel = 0
Frame.Parent = ScreenGui
Frame.Active = true

-- TITLE
local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 25)
Title.BackgroundTransparency = 1
Title.Text = "Proximity Manager"
Title.TextColor3 = Color3.fromRGB(255, 255, 255)
Title.Font = Enum.Font.SourceSansBold
Title.TextSize = 18
Title.Parent = Frame

-- TEXTBOX DISTANZA
local DistanceBox = Instance.new("TextBox")
DistanceBox.Size = UDim2.new(0, 180, 0, 25)
DistanceBox.Position = UDim2.new(0, 10, 0, 35)
DistanceBox.BackgroundColor3 = Color3.fromRGB(60, 60, 60)
DistanceBox.TextColor3 = Color3.fromRGB(255, 255, 255)
DistanceBox.PlaceholderText = "Distanza (es. 10, 20, 50)"
DistanceBox.Text = ""
DistanceBox.ClearTextOnFocus = false
DistanceBox.Parent = Frame

-- FUNZIONE BOTTONI
local function createButton(text, y)
    local btn = Instance.new("TextButton")
    btn.Size = UDim2.new(0, 180, 0, 25)
    btn.Position = UDim2.new(0, 10, 0, y)
    btn.BackgroundColor3 = Color3.fromRGB(70, 70, 70)
    btn.BorderSizePixel = 0
    btn.Text = text
    btn.TextColor3 = Color3.fromRGB(255,255,255)
    btn.Parent = Frame
    return btn
end

local btnInstant = createButton("Instant Hold", 70)
local btnRestore = createButton("Ripristina Hold", 100)
local btnDistance = createButton("Applica Distanza", 130)

-- MEMORIA HOLD
local originalHoldTimes = {}

-- PROX FUNCTIONS
local function setInstant()
    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            if originalHoldTimes[prompt] == nil then
                originalHoldTimes[prompt] = prompt.HoldDuration
            end
            prompt.HoldDuration = 0
        end
    end
end

local function restore()
    for prompt, time in pairs(originalHoldTimes) do
        if prompt and prompt.Parent then
            prompt.HoldDuration = time
        end
    end
end

local function setDistance()
    local value = tonumber(DistanceBox.Text)
    if not value then return end

    for _, prompt in pairs(workspace:GetDescendants()) do
        if prompt:IsA("ProximityPrompt") then
            prompt.MaxActivationDistance = value
        end
    end
end

-- BUTTONS
btnInstant.MouseButton1Click:Connect(setInstant)
btnRestore.MouseButton1Click:Connect(restore)
btnDistance.MouseButton1Click:Connect(setDistance)

-- NUOVI PROX AUTOMATICI
workspace.DescendantAdded:Connect(function(item)
    if item:IsA("ProximityPrompt") then
        task.wait()
        local value = tonumber(DistanceBox.Text)
        if value then
            item.MaxActivationDistance = value
        end
    end
end)

-- DRAG (FIXED)
local dragging = false
local dragInput, mousePos, framePos

local function update(input)
    local delta = input.Position - mousePos
    Frame.Position = UDim2.new(
        framePos.X.Scale, framePos.X.Offset + delta.X,
        framePos.Y.Scale, framePos.Y.Offset + delta.Y
    )
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

UserInputService.InputChanged:Connect(function(input)
    if input == dragInput and dragging then
        update(input)
    end
end)
