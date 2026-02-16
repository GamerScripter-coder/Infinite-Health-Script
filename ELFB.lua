------------------------------------------------------------
-- SERVICES
------------------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Camera = workspace.CurrentCamera

local player = Players.LocalPlayer

------------------------------------------------------------
-- CHARACTER UTILS
------------------------------------------------------------
local function Char()
	return player.Character or player.CharacterAdded:Wait()
end

local function Humanoid()
	return Char():WaitForChild("Humanoid")
end

local function HRP()
	return Char():WaitForChild("HumanoidRootPart")
end

------------------------------------------------------------
-- LOAD RAYFIELD
------------------------------------------------------------
local Rayfield = loadstring(game:HttpGet("https://sirius.menu/rayfield"))()

local Window = Rayfield:CreateWindow({
	Name = "FULL CLIENT ADMIN PANEL",
	LoadingTitle = "Client Admin",
	LoadingSubtitle = "100% Client",
	ConfigurationSaving = { Enabled = false }
})

------------------------------------------------------------
-- TABS
------------------------------------------------------------
local MoveTab   = Window:CreateTab("Movement", 4483362458)
local UITab     = Window:CreateTab("UI Manager", 4483362458)
local ScriptTab = Window:CreateTab("Script Loader", 4483362458)
local MiscTab   = Window:CreateTab("Misc", 4483362458)

------------------------------------------------------------
-- SPEED & JUMP
------------------------------------------------------------
local humanoid = Humanoid()
local DEFAULT_SPEED = humanoid.WalkSpeed
local DEFAULT_JUMP  = humanoid.JumpPower

local speedEnabled = false
local jumpEnabled  = false
local customSpeed  = DEFAULT_SPEED
local customJump   = DEFAULT_JUMP

player.CharacterAdded:Connect(function()
	task.wait(1)
	humanoid = Humanoid()
	if speedEnabled then humanoid.WalkSpeed = customSpeed end
	if jumpEnabled  then humanoid.JumpPower = customJump end
end)

MoveTab:CreateToggle({
	Name = "Custom Speed",
	Callback = function(v)
		speedEnabled = v
		humanoid.WalkSpeed = v and customSpeed or DEFAULT_SPEED
	end
})

MoveTab:CreateSlider({
	Name = "Speed Value",
	Range = {8,200},
	Increment = 1,
	CurrentValue = DEFAULT_SPEED,
	Callback = function(v)
		customSpeed = v
		if speedEnabled then humanoid.WalkSpeed = v end
	end
})

MoveTab:CreateToggle({
	Name = "Custom Jump",
	Callback = function(v)
		jumpEnabled = v
		humanoid.JumpPower = v and customJump or DEFAULT_JUMP
	end
})

MoveTab:CreateSlider({
	Name = "Jump Power",
	Range = {25,300},
	Increment = 5,
	CurrentValue = DEFAULT_JUMP,
	Callback = function(v)
		customJump = v
		if jumpEnabled then humanoid.JumpPower = v end
	end
})

------------------------------------------------------------
-- FLY (WARNING + CONFIRM)
------------------------------------------------------------
local flyConfirmed = false
local flySpeed = 60
local flyBV, flyBG, flyConn

local function startFly()
	local hrp = HRP()

	flyBV = Instance.new("BodyVelocity")
	flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)
	flyBV.Parent = hrp

	flyBG = Instance.new("BodyGyro")
	flyBG.MaxTorque = Vector3.new(1e9,1e9,1e9)
	flyBG.Parent = hrp

	flyConn = RunService.RenderStepped:Connect(function()
		local cam = Camera
		local dir = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= cam.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += cam.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += cam.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= cam.CFrame.UpVector end

		flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
		flyBG.CFrame = cam.CFrame
	end)
end

local function stopFly()
	if flyConn then flyConn:Disconnect() end
	if flyBV then flyBV:Destroy() end
	if flyBG then flyBG:Destroy() end
end

MoveTab:CreateToggle({
	Name = "Fly",
	Callback = function(v)
		if v and not flyConfirmed then
			Rayfield:Notify({
				Title = "⚠️ WARNING",
				Content = "Fly è client-only.\nUsala solo in giochi senza anti-cheat.",
				Duration = 8
			})
			return
		end
		if v then startFly() else stopFly() end
	end
})

MoveTab:CreateSlider({
	Name = "Fly Speed",
	Range = {10,200},
	Increment = 5,
	CurrentValue = flySpeed,
	Callback = function(v) flySpeed = v end
})

MoveTab:CreateButton({
	Name = "CONFIRM FLY (OK)",
	Callback = function()
		flyConfirmed = true
	end
})

------------------------------------------------------------
-- FAKE GRAVITY / FLOAT
------------------------------------------------------------
local gravityConfirmed = false
local floatForce

MoveTab:CreateToggle({
	Name = "Fake Gravity / Float",
	Callback = function(v)
		if v and not gravityConfirmed then
			Rayfield:Notify({
				Title = "⚠️ WARNING",
				Content = "Fake Gravity è client-only.",
				Duration = 6
			})
			return
		end

		if v then
			floatForce = Instance.new("BodyForce")
			floatForce.Force = Vector3.new(0, workspace.Gravity * HRP().AssemblyMass, 0)
			floatForce.Parent = HRP()
		else
			if floatForce then floatForce:Destroy() end
		end
	end
})

MoveTab:CreateButton({
	Name = "CONFIRM FAKE GRAVITY (OK)",
	Callback = function()
		gravityConfirmed = true
	end
})

------------------------------------------------------------
-- FAKE RAGDOLL / ANTI RAGDOLL
------------------------------------------------------------
local antiRagdoll = false
local ragdollConn

local BLOCKED_STATES = {
	[Enum.HumanoidStateType.Ragdoll] = true,
	[Enum.HumanoidStateType.FallingDown] = true,
	[Enum.HumanoidStateType.Physics] = true
}

local function applyAntiRagdoll()
	local hum = Humanoid()

	for state in pairs(BLOCKED_STATES) do
		hum:SetStateEnabled(state, false)
	end

	ragdollConn = hum.StateChanged:Connect(function(_, new)
		if BLOCKED_STATES[new] then
			hum:ChangeState(Enum.HumanoidStateType.GettingUp)
		end
	end)
end

local function removeAntiRagdoll()
	local hum = Humanoid()
	if ragdollConn then ragdollConn:Disconnect() end
	for state in pairs(BLOCKED_STATES) do
		hum:SetStateEnabled(state, true)
	end
end

MoveTab:CreateToggle({
	Name = "Fake Ragdoll (Anti Ragdoll)",
	Callback = function(v)
		antiRagdoll = v
		if v then applyAntiRagdoll() else removeAntiRagdoll() end
	end
})

player.CharacterAdded:Connect(function()
	task.wait(1)
	if antiRagdoll then applyAntiRagdoll() end
end)

------------------------------------------------------------
-- CLICK TELEPORT
------------------------------------------------------------
local clickTP = false

MoveTab:CreateToggle({
	Name = "Click Teleport",
	Callback = function(v)
		clickTP = v
	end
})

UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	if clickTP and i.UserInputType == Enum.UserInputType.MouseButton1 then
		local mouse = player:GetMouse()
		if mouse.Hit then
			HRP().CFrame = mouse.Hit + Vector3.new(0,3,0)
		end
	end
end)

------------------------------------------------------------
-- UI MANAGER (SELEZIONE MANUALE)
------------------------------------------------------------
local playerGui = player:WaitForChild("PlayerGui")
local uiList = {}
local selectedUI

local function refreshUI()
	uiList = {}
	for _,g in ipairs(playerGui:GetChildren()) do
		if g:IsA("ScreenGui") then
			table.insert(uiList, g.Name)
		end
	end
end

refreshUI()

UITab:CreateButton({
	Name = "Refresh UI List",
	Callback = refreshUI
})

UITab:CreateDropdown({
	Name = "Select UI",
	Options = uiList,
	Callback = function(opt)
		selectedUI = opt
	end
})

UITab:CreateButton({
	Name = "Open Selected UI",
	Callback = function()
		if selectedUI then
			local g = playerGui:FindFirstChild(selectedUI)
			if g then g.Enabled = true end
		end
	end
})

UITab:CreateButton({
	Name = "Close Selected UI",
	Callback = function()
		if selectedUI then
			local g = playerGui:FindFirstChild(selectedUI)
			if g then g.Enabled = false end
		end
	end
})

------------------------------------------------------------
-- SCRIPT LOADER
------------------------------------------------------------
local scriptURL = ""

ScriptTab:CreateInput({
	Name = "Script URL",
	PlaceholderText = "https://site/script.lua",
	RemoveTextAfterFocusLost = false,
	Callback = function(txt)
		scriptURL = txt
	end
})

ScriptTab:CreateButton({
	Name = "RUN SCRIPT",
	Callback = function()
		if scriptURL == "" then return end
		pcall(function()
			loadstring(game:HttpGet(scriptURL))()
		end)
	end
})

------------------------------------------------------------
-- MISC
------------------------------------------------------------
MiscTab:CreateButton({
	Name = "Reset Character",
	Callback = function()
		Humanoid().Health = 0
	end
})

MiscTab:CreateButton({
	Name = "Rejoin",
	Callback = function()
		TeleportService:Teleport(game.PlaceId, player)
	end
})
