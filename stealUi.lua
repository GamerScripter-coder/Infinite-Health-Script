local plr = game.Players.LocalPlayer
local char = plr.Character or plr.CharacterAdded:Wait()
local ReplicatedStorage = game:GetService("ReplicatedStorage")

---------------------------------------------------------------
-- 🔹 TROVA UN REMOTEEVENT CASUALE NEL REPLICATEDSTORAGE
---------------------------------------------------------------

local function GetRandomRemoteEvent()
    local list = {}

    -- cerca ovunque nel replicatedstorage
    for _, obj in ipairs(ReplicatedStorage:GetDescendants()) do
        if obj:IsA("RemoteEvent") then
            table.insert(list, obj)
        end
    end

    if #list == 0 then
        warn("❌ Nessun RemoteEvent trovato nel ReplicatedStorage!")
        return nil
    end

    local chosen = list[math.random(1, #list)]
    print("📡 RemoteEvent scelto casualmente:", chosen:GetFullName())
    return chosen
end

local RandomRemote = GetRandomRemoteEvent()


---------------------------------------------------------------
-- 🔹 GUI
---------------------------------------------------------------

local gui = Instance.new("ScreenGui")
gui.Name = "StealUi"
gui.Parent = plr.PlayerGui

local frame = Instance.new("Frame")
frame.Size = UDim2.new(0, 400, 0, 250)
frame.Position = UDim2.new(0.5,0,0.5,0)
frame.AnchorPoint = Vector2.new(0.5,0.5)
frame.BackgroundColor3 = Color3.fromRGB(20,20,20)
frame.Parent = gui

local UICorner = Instance.new("UICorner", frame)
UICorner.CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Parent = frame
title.Size = UDim2.new(1,0,0,40)
title.Position = UDim2.new(0,0,0,5)
title.BackgroundTransparency = 1
title.Font = Enum.Font.GothamBold
title.Text = "Random RemoteEvent UI"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true

---------------------------------------------------------------
-- 🔹 Pulsanti helper
---------------------------------------------------------------

local function CreateButton(text, y)
    local btn = Instance.new("TextButton")
    btn.Parent = frame
    btn.Size = UDim2.new(0.9,0,0,40)
    btn.Position = UDim2.new(0.05,0,y,0)
    btn.BackgroundColor3 = Color3.fromRGB(40,40,40)
    btn.Text = text
    btn.TextScaled = true
    btn.Font = Enum.Font.GothamBold
    btn.TextColor3 = Color3.new(1,1,1)

    local c = Instance.new("UICorner", btn)
    c.CornerRadius = UDim.new(0,6)

    return btn
end

local CreatePartBtn = CreateButton("Place Part To Player", 0.25)
local TeleportBtn  = CreateButton("Teleport To Part (Remote)", 0.47)
local RemoveBtn    = CreateButton("Remove Part", 0.69)

---------------------------------------------------------------
-- 🔹 LOGICA TELEPORT
---------------------------------------------------------------

local stealPart = nil

CreatePartBtn.MouseButton1Click:Connect(function()
    if not char:FindFirstChild("HumanoidRootPart") then return end

    if stealPart then stealPart:Destroy() end

    stealPart = Instance.new("Part")
    stealPart.Size = Vector3.new(1,1,1)
    stealPart.Position = char.HumanoidRootPart.Position - Vector3.new(0,3,0)
    stealPart.Anchored = true
    stealPart.CanCollide = false
    stealPart.Transparency = 1
    stealPart.Color = Color3.fromRGB(255,0,0)
    stealPart.Parent = workspace

    print("📍 Part creata sotto il player")
end)


TeleportBtn.MouseButton1Click:Connect(function()
    if not RandomRemote then return end
    if not stealPart then return end

    print("📡 RemoteEvent inviato:", RandomRemote.Name)

    -- invio dati al server tramite un RemoteEvent CASUALE
    RandomRemote:FireServer(stealPart.Position)

    print("🚀 Segnale inviato. Il server deciderà cosa fare.")
end)


RemoveBtn.MouseButton1Click:Connect(function()
    if stealPart then
        stealPart:Destroy()
        stealPart = nil
        print("❌ Part rimossa")
    end
end)
