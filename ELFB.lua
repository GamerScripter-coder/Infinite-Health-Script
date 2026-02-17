------------------------------------------------------------
-- SERVICES
------------------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")
local Lighting = game:GetService("Lighting")
local VirtualUser = game:GetService("VirtualUser")
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
	Name = "FULL CLIENT ADMIN PANEL V5",
	LoadingTitle = "Client Admin",
	LoadingSubtitle = "100% Client Only",
	ConfigurationSaving = { Enabled = false }
})

------------------------------------------------------------
-- TABS
------------------------------------------------------------
local MoveTab     = Window:CreateTab("Movement", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local UITab       = Window:CreateTab("UI Manager", 4483362458)
local ScriptTab   = Window:CreateTab("Script Loader", 4483362458)
local MiscTab     = Window:CreateTab("Misc", 4483362458)

------------------------------------------------------------
-- SPEED & JUMP
------------------------------------------------------------
local humanoid = Humanoid()
local DEFAULT_SPEED = humanoid.WalkSpeed
local DEFAULT_JUMP  = humanoid.JumpPower

local speedEnabled, jumpEnabled = false, false
local customSpeed, customJump = DEFAULT_SPEED, DEFAULT_JUMP

player.CharacterAdded:Connect(function()
	task.wait(1)
	humanoid = Humanoid()
	if speedEnabled then humanoid.WalkSpeed = customSpeed end
	if jumpEnabled then humanoid.JumpPower = customJump end
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

	flyBV = Instance.new("BodyVelocity", hrp)
	flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)

	flyBG = Instance.new("BodyGyro", hrp)
	flyBG.MaxTorque = Vector3.new(1e9,1e9,1e9)

	flyConn = RunService.RenderStepped:Connect(function()
		local dir = Vector3.zero
		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= Camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += Camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += Camera.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= Camera.CFrame.UpVector end

		flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
		flyBG.CFrame = Camera.CFrame
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
				Title = "⚠ WARNING",
				Content = "Fly è client-only.\nUsala solo in giochi senza anti-cheat.",
				Duration = 7
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
-- FAKE GRAVITY
------------------------------------------------------------
local gravityConfirmed = false
local floatForce

MoveTab:CreateToggle({
	Name = "Fake Gravity / Float",
	Callback = function(v)
		if v and not gravityConfirmed then
			Rayfield:Notify({
				Title = "⚠ WARNING",
				Content = "Fake Gravity è client-only.",
				Duration = 5
			})
			return
		end

		if v then
			floatForce = Instance.new("BodyForce", HRP())
			floatForce.Force = Vector3.new(0, workspace.Gravity * HRP().AssemblyMass, 0)
		else
			if floatForce then floatForce:Destroy() end
		end
	end
})

MoveTab:CreateButton({
	Name = "CONFIRM FAKE GRAVITY",
	Callback = function()
		gravityConfirmed = true
	end
})

------------------------------------------------------------
-- ANTI RAGDOLL
------------------------------------------------------------
local antiRagdoll = false
local ragConn

MoveTab:CreateToggle({
	Name = "Fake Ragdoll (Anti Ragdoll)",
	Callback = function(v)
		antiRagdoll = v
		local hum = Humanoid()

		if v then
			ragConn = hum.StateChanged:Connect(function(_, new)
				if new == Enum.HumanoidStateType.Ragdoll then
					hum:ChangeState(Enum.HumanoidStateType.GettingUp)
				end
			end)
		else
			if ragConn then ragConn:Disconnect() end
		end
	end
})

------------------------------------------------------------
-- CLICK TELEPORT
------------------------------------------------------------
local clickTP = false
MoveTab:CreateToggle({
	Name = "Click Teleport",
	Callback = function(v) clickTP = v end
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
-- NOCLIP
------------------------------------------------------------
local noclip = false
local noclipConn

local function setNoclip(state)
	noclip = state
	if state then
		noclipConn = RunService.Stepped:Connect(function()
			for _,v in ipairs(Char():GetDescendants()) do
				if v:IsA("BasePart") then
					v.CanCollide = false
				end
			end
		end)
	else
		if noclipConn then noclipConn:Disconnect() end
	end
end

MoveTab:CreateToggle({
	Name = "Noclip",
	Callback = function(v)
		setNoclip(v)
	end
})

------------------------------------------------------------
-- TELEPORT TAB (FIXED)
------------------------------------------------------------
local teleportPoints = {}
local selectedTP
local tpDropdown
local tpIndex = 0

local function refreshTP()
	local list = {}
	for k,_ in pairs(teleportPoints) do
		table.insert(list, k)
	end

	if tpDropdown then tpDropdown:Destroy() end
	tpDropdown = TeleportTab:CreateDropdown({
		Name = "Saved Positions",
		Options = list,
		Callback = function(opt)
			selectedTP = opt
		end
	})
end

TeleportTab:CreateButton({
	Name = "➕ Save Current Position",
	Callback = function()
		pcall(function()
			local hrp = HRP()
			if not hrp then return end

			tpIndex += 1
			local name = "TP_" .. tpIndex
			teleportPoints[name] = hrp.CFrame

			refreshTP()

			Rayfield:Notify({
				Title = "Teleport",
				Content = "Saved position: " .. name,
				Duration = 3
			})
		end)
	end
})

TeleportTab:CreateButton({
	Name = "Teleport to Selected",
	Callback = function()
		if selectedTP and teleportPoints[selectedTP] then
			HRP().CFrame = teleportPoints[selectedTP]
		end
	end
})

TeleportTab:CreateButton({
	Name = "🗑 Delete Selected",
	Callback = function()
		if selectedTP then
			teleportPoints[selectedTP] = nil
			selectedTP = nil
			refreshTP()
		end
	end
})

refreshTP()

UIS.InputBegan:Connect(function(i,gp)
	if gp then return end
	local num = tonumber(i.KeyCode.Name:match("%d"))
	if num then
		local key = "TP_" .. num
		if teleportPoints[key] then
			HRP().CFrame = teleportPoints[key]
		end
	end
end)

------------------------------------------------------------
-- UI MANAGER
------------------------------------------------------------
local playerGui = player:WaitForChild("PlayerGui")
local selectedUI
local uiDropdown

local function getUIList()
	local list = {}
	for _,g in ipairs(playerGui:GetChildren()) do
		if g:IsA("ScreenGui") then
			table.insert(list, g.Name)
		end
	end
	return list
end

local function createUIDropdown()
	if uiDropdown then uiDropdown:Destroy() end
	uiDropdown = UITab:CreateDropdown({
		Name = "Select UI",
		Options = getUIList(),
		Callback = function(opt) selectedUI = opt end
	})
end

createUIDropdown()

UITab:CreateButton({
	Name = "Refresh UI List",
	Callback = createUIDropdown
})

UITab:CreateButton({
	Name = "Open Selected UI",
	Callback = function()
		local g = playerGui:FindFirstChild(selectedUI)
		if g then g.Enabled = true end
	end
})

UITab:CreateButton({
	Name = "Close Selected UI",
	Callback = function()
		local g = playerGui:FindFirstChild(selectedUI)
		if g then g.Enabled = false end
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
	Callback = function(t) scriptURL = t end
})

ScriptTab:CreateButton({
	Name = "RUN SCRIPT",
	Callback = function()
		if scriptURL ~= "" then
			pcall(function()
				loadstring(game:HttpGet(scriptURL))()
			end)
		end
	end
})

------------------------------------------------------------
-- MISC TAB
------------------------------------------------------------
MiscTab:CreateToggle({
	Name = "Anti AFK",
	Callback = function(v)
		if v then
			player.Idled:Connect(function()
				VirtualUser:Button2Down(Vector2.new(), Camera.CFrame)
				task.wait(1)
				VirtualUser:Button2Up(Vector2.new(), Camera.CFrame)
			end)
		end
	end
})

MiscTab:CreateToggle({
	Name = "FullBright",
	Callback = function(v)
		if v then
			Lighting.Brightness = 5
			Lighting.ClockTime = 14
			Lighting.FogEnd = 1e9
		end
	end
})

MiscTab:CreateSlider({
	Name = "FOV",
	Range = {40,120},
	CurrentValue = Camera.FieldOfView,
	Callback = function(v)
		Camera.FieldOfView = v
	end
})

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
