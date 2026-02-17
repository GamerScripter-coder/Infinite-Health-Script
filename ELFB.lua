--// SERVICES
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local Player = Players.LocalPlayer
local Mouse = Player:GetMouse()

--// CHARACTER
local function Char()
	return Player.Character or Player.CharacterAdded:Wait()
end

local function Humanoid()
	return Char():WaitForChild("Humanoid")
end

local function HRP()
	return Char():WaitForChild("HumanoidRootPart")
end

--// RAYFIELD
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "FULL CLIENT ADMIN PANEL V5",
	LoadingTitle = "Client Panel",
	LoadingSubtitle = "Client-only",
	ConfigurationSaving = {Enabled = false}
})

--// TABS
local PlayerTab = Window:CreateTab("Player", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local MiscTab = Window:CreateTab("Misc", 4483362458)

-------------------------------------------------
-- PLAYER TAB
-------------------------------------------------
PlayerTab:CreateSlider({
	Name = "WalkSpeed",
	Range = {0, 200},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		Humanoid().WalkSpeed = v
	end
})

PlayerTab:CreateSlider({
	Name = "JumpPower",
	Range = {0, 300},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(v)
		Humanoid().JumpPower = v
	end
})

-- FAKE RAGDOLL
local fakeRagdoll = false
PlayerTab:CreateToggle({
	Name = "Fake Ragdoll (No ragdoll)",
	CurrentValue = false,
	Callback = function(v)
		fakeRagdoll = v
	end
})

RunService.Stepped:Connect(function()
	if fakeRagdoll and Humanoid() then
		Humanoid():ChangeState(Enum.HumanoidStateType.GettingUp)
	end
end)

-- NOCLIP
local noclip = false
PlayerTab:CreateToggle({
	Name = "Noclip",
	CurrentValue = false,
	Callback = function(v)
		noclip = v
	end
})

RunService.Stepped:Connect(function()
	if noclip then
		for _, p in pairs(Char():GetDescendants()) do
			if p:IsA("BasePart") then
				p.CanCollide = false
			end
		end
	end
end)

-------------------------------------------------
-- FLY (WITH WARNING)
-------------------------------------------------
local flying = false
local flyBV, flyBG

local function stopFly()
	if flyBV then flyBV:Destroy() end
	if flyBG then flyBG:Destroy() end
	flying = false
end

PlayerTab:CreateButton({
	Name = "Fly (WARNING)",
	Callback = function()
		Rayfield:Notify({
			Title = "WARNING",
			Content = "Fly può bannarti in giochi con anti-cheat.\nUsala SOLO in giochi senza controlli.",
			Duration = 6,
			Actions = {
				Ignore = {
					Name = "OK",
					Callback = function()
						if flying then stopFly() return end
						flying = true

						flyBV = Instance.new("BodyVelocity", HRP())
						flyBV.MaxForce = Vector3.new(1e5,1e5,1e5)

						flyBG = Instance.new("BodyGyro", HRP())
						flyBG.MaxTorque = Vector3.new(1e5,1e5,1e5)

						RunService.RenderStepped:Connect(function()
							if not flying then return end
							local cam = workspace.CurrentCamera
							flyBV.Velocity = cam.CFrame.LookVector * 60
							flyBG.CFrame = cam.CFrame
						end)
					end
				}
			}
		})
	end
})

-------------------------------------------------
-- TELEPORT TAB (STABILE, TASTI PERSONALIZZATI)
-------------------------------------------------
local Teleports = {}
local currentName = ""
local currentKey = nil

TeleportTab:CreateInput({
	Name = "Nome Teleport",
	PlaceholderText = "Es: Casa",
	RemoveTextAfterFocusLost = false,
	Callback = function(t)
		currentName = t
	end
})

TeleportTab:CreateInput({
	Name = "Tasto (es: E, Q, Z)",
	PlaceholderText = "KeyCode",
	RemoveTextAfterFocusLost = false,
	Callback = function(t)
		if Enum.KeyCode[t] then
			currentKey = Enum.KeyCode[t]
		end
	end
})

TeleportTab:CreateButton({
	Name = "Salva Posizione",
	Callback = function()
		if currentName ~= "" and currentKey then
			Teleports[currentName] = {
				CFrame = HRP().CFrame,
				Key = currentKey
			}
			Rayfield:Notify({
				Title = "Teleport",
				Content = "Salvato: "..currentName.." ("..currentKey.Name..")",
				Duration = 3
			})
		end
	end
})

TeleportTab:CreateButton({
	Name = "Teletrasportati",
	Callback = function()
		if Teleports[currentName] then
			HRP().CFrame = Teleports[currentName].CFrame
		end
	end
})

TeleportTab:CreateButton({
	Name = "Cancella Teleport",
	Callback = function()
		Teleports[currentName] = nil
	end
})

UIS.InputBegan:Connect(function(input, gpe)
	if gpe then return end
	for _, tp in pairs(Teleports) do
		if input.KeyCode == tp.Key then
			HRP().CFrame = tp.CFrame
		end
	end
end)

-------------------------------------------------
-- MISC TAB
-------------------------------------------------
-- FAKE GRAVITY / FLOAT
local float = false
local floatBV

MiscTab:CreateToggle({
	Name = "Fake Gravity / Float",
	CurrentValue = false,
	Callback = function(v)
		float = v
		if v then
			floatBV = Instance.new("BodyVelocity", HRP())
			floatBV.Velocity = Vector3.new(0, 2, 0)
			floatBV.MaxForce = Vector3.new(0,1e5,0)
		else
			if floatBV then floatBV:Destroy() end
		end
	end
})

-- OPEN UI
MiscTab:CreateInput({
	Name = "Apri UI (ScreenGui name)",
	PlaceholderText = "UI Name",
	Callback = function(t)
		local ui = Player.PlayerGui:FindFirstChild(t)
		if ui then
			ui.Enabled = not ui.Enabled
		end
	end
})

-- LOADSTRING
MiscTab:CreateInput({
	Name = "Esegui Script (loadstring)",
	PlaceholderText = "URL",
	Callback = function(url)
		pcall(function()
			loadstring(game:HttpGet(url))()
		end)
	end
})
