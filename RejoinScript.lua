-- LocalScript da mettere in StarterPlayerScripts

local Players = game:GetService("Players")
local TweenService = game:GetService("TweenService")
local TeleportService = game:GetService("TeleportService")
local player = Players.LocalPlayer
local playerGui = player:WaitForChild("PlayerGui")

-- ===== CREAZIONE UI =====
local screenGui = Instance.new("ScreenGui")
screenGui.Name = "RejoinUI"
screenGui.Parent = playerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 200, 0, 100)
frame.Position = UDim2.new(0.5, -100, 0.5, -50)
frame.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
frame.BorderSizePixel = 0
frame.Parent = screenGui

local button = Instance.new("TextButton")
button.Size = UDim2.new(0, 180, 0, 50)
button.Position = UDim2.new(0, 10, 0, 25)
button.BackgroundColor3 = Color3.fromRGB(255, 85, 85)
button.TextColor3 = Color3.fromRGB(255, 255, 255)
button.Font = Enum.Font.SourceSansBold
button.TextSize = 24
button.Text = "Rejoin Server"
button.Parent = frame

-- Animazione hover
button.MouseEnter:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 120, 120)}):Play()
end)
button.MouseLeave:Connect(function()
    TweenService:Create(button, TweenInfo.new(0.2), {BackgroundColor3 = Color3.fromRGB(255, 85, 85)}):Play()
end)

-- ===== FUNZIONE REJOIN SERVER =====
button.MouseButton1Click:Connect(function()
    button.Text = "Rejoining..."
    button.Active = false
    
    local placeId = game.PlaceId
    local jobId = game.JobId -- JobId del server corrente

    -- Teleporta nello stesso server
    TeleportService:TeleportToPlaceInstance(placeId, jobId, player)
end)
