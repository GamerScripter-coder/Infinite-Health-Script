-- LocalScript: Fly 6DoF (direzione camera = direzione volo)
-- Toggle con E

local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local player = Players.LocalPlayer
local flying = false
local speed = 100

local hrp
local humanoid
local bv
local bg

-- attende character
local function loadChar()
    local char = player.Character or player.CharacterAdded:Wait()
    hrp = char:WaitForChild("HumanoidRootPart")
    humanoid = char:WaitForChild("Humanoid")
end

loadChar()
player.CharacterAdded:Connect(loadChar)

-- noclip
local function setNoclip(state)
    for _,v in ipairs(player.Character:GetDescendants()) do
        if v:IsA("BasePart") then
            v.CanCollide = not state
        end
    end
end

-- start fly
local function startFly()
    flying = true

    bv = Instance.new("BodyVelocity")
    bv.MaxForce = Vector3.new(1e6,1e6,1e6)
    bv.Parent = hrp

    bg = Instance.new("BodyGyro")
    bg.MaxTorque = Vector3.new(1e6,1e6,1e6)
    bg.Parent = hrp

    humanoid.PlatformStand = true
    setNoclip(true)
end

-- stop fly
local function stopFly()
    flying = false
    if bv then bv:Destroy() bv=nil end
    if bg then bg:Destroy() bg=nil end
    humanoid.PlatformStand = false
    setNoclip(false)
end

-- toggle tasto (ora con E)
UIS.InputBegan:Connect(function(input,GPE)
    if GPE then return end
    if input.KeyCode == Enum.KeyCode.E then
        if flying then
            stopFly()
        else
            startFly()
        end
    end
end)

-- loop movimento
RunService.RenderStepped:Connect(function()
    if not flying or not hrp or not bv or not bg then return end
    
    local cam = workspace.CurrentCamera
    local look = cam.CFrame.LookVector

    -- WASD
    local dir = Vector3.new(0,0,0)
    if UIS:IsKeyDown(Enum.KeyCode.W) then dir = dir + look end
    if UIS:IsKeyDown(Enum.KeyCode.S) then dir = dir - look end
    if UIS:IsKeyDown(Enum.KeyCode.A) then dir = dir - cam.CFrame.RightVector end
    if UIS:IsKeyDown(Enum.KeyCode.D) then dir = dir + cam.CFrame.RightVector end

    if dir.Magnitude > 0 then
        dir = dir.Unit * speed
    end

    bv.Velocity = dir
    bg.CFrame = cam.CFrame
end)

print("Fly attiva con E: segue la direzione della camera.")
