------------------------------------------------------------
-- SERVICES
------------------------------------------------------------
local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")
local TeleportService = game:GetService("TeleportService")

local player = Players.LocalPlayer
local camera = workspace.CurrentCamera

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
local MoveTab     = Window:CreateTab("Movement", 4483362458)
local TeleportTab = Window:CreateTab("Teleport", 4483362458)
local UITab       = Window:CreateTab("UI Manager", 4483362458)
local ScriptTab   = Window:CreateTab("Script Loader", 4483362458)
local MiscTab     = Window:CreateTab("Misc", 4483362458)

------------------------------------------------------------
-- SPEED & JUMP
------------------------------------------------------------
local speedEnabled = false
local jumpEnabled = false
local customSpeed = 16
local customJump = 50

MoveTab:CreateToggle({
	Name = "Custom Speed",
	Callback = function(v)
		speedEnabled = v
		Humanoid().WalkSpeed = v and customSpeed or 16
	end
})

MoveTab:CreateSlider({
	Name = "Speed Value",
	Range = {0, 300},
	Increment = 1,
	CurrentValue = 16,
	Callback = function(v)
		customSpeed = v
		if speedEnabled then
			Humanoid().WalkSpeed = v
		end
	end
})

MoveTab:CreateToggle({
	Name = "Custom Jump",
	Callback = function(v)
		jumpEnabled = v
		Humanoid().JumpPower = v and customJump or 50
	end
})

MoveTab:CreateSlider({
	Name = "Jump Power",
	Range = {0, 350},
	Increment = 5,
	CurrentValue = 50,
	Callback = function(v)
		customJump = v
		if jumpEnabled then
			Humanoid().JumpPower = v
		end
	end
})

------------------------------------------------------------
-- INFINITE JUMP
------------------------------------------------------------
local infiniteJump = false
local jumpConn

MoveTab:CreateToggle({
	Name = "Infinite Jump",
	Callback = function(v)
		infiniteJump = v

		if jumpConn then
			jumpConn:Disconnect()
			jumpConn = nil
		end

		if v then
			jumpConn = UIS.JumpRequest:Connect(function()
				if infiniteJump and Humanoid() then
					Humanoid():ChangeState(Enum.HumanoidStateType.Jumping)
				end
			end)
		end
	end
})

------------------------------------------------------------
-- NOCLIP
------------------------------------------------------------
local noclip = false

MoveTab:CreateToggle({
	Name = "Noclip",
	Callback = function(v)
		noclip = v
	end
})

RunService.Stepped:Connect(function()
	if noclip and Char() then
		for _, part in pairs(Char():GetDescendants()) do
			if part:IsA("BasePart") then
				part.CanCollide = false
			end
		end
	end
end)

------------------------------------------------------------
-- FLY (WARNING + CONFIRM)
------------------------------------------------------------
local flyConfirmed = false
local flying = false
local flyBV, flyBG, flyConn
local flySpeed = 70

local function startFly()
	local hrp = HRP()

	flyBV = Instance.new("BodyVelocity")
	flyBV.MaxForce = Vector3.new(1e9,1e9,1e9)
	flyBV.Parent = hrp

	flyBG = Instance.new("BodyGyro")
	flyBG.MaxTorque = Vector3.new(1e9,1e9,1e9)
	flyBG.Parent = hrp

	flyConn = RunService.RenderStepped:Connect(function()
		local dir = Vector3.zero

		if UIS:IsKeyDown(Enum.KeyCode.W) then dir += camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.S) then dir -= camera.CFrame.LookVector end
		if UIS:IsKeyDown(Enum.KeyCode.A) then dir -= camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.D) then dir += camera.CFrame.RightVector end
		if UIS:IsKeyDown(Enum.KeyCode.Space) then dir += camera.CFrame.UpVector end
		if UIS:IsKeyDown(Enum.KeyCode.LeftControl) then dir -= camera.CFrame.UpVector end

		flyBV.Velocity = dir.Magnitude > 0 and dir.Unit * flySpeed or Vector3.zero
		flyBG.CFrame = camera.CFrame
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
				Duration = 6
			})
			return
		end

		flying = v
		if v then startFly() else stopFly() end
	end
})

MoveTab:CreateButton({
	Name = "CONFIRM FLY (OK)",
	Callback = function()
		flyConfirmed = true
	end
})

------------------------------------------------------------
-- TELEPORT TAB
------------------------------------------------------------
local Teleports = {}
local tpName = ""
local tpKey = nil

TeleportTab:CreateInput({
	Name = "Teleport Name",
	PlaceholderText = "Es: Casa",
	RemoveTextAfterFocusLost = false,
	Callback = function(v)
		tpName = v
	end
})

TeleportTab:CreateInput({
	Name = "Key (E, Q, Z...)",
	PlaceholderText = "KeyCode",
	RemoveTextAfterFocusLost = false,
	Callback = function(v)
		if Enum.KeyCode[v] then
			tpKey = Enum.KeyCode[v]
		end
	end
})

TeleportTab:CreateButton({
	Name = "Save Position",
	Callback = function()
		if tpName ~= "" and tpKey then
			Teleports[tpName] = {
				CFrame = HRP().CFrame,
				Key = tpKey
			}
			Rayfield:Notify({
				Title = "Teleport",
				Content = "Saved "..tpName.." ("..tpKey.Name..")",
				Duration = 3
			})
		end
	end
})

TeleportTab:CreateButton({
	Name = "Teleport Now",
	Callback = function()
		if Teleports[tpName] then
			HRP().CFrame = Teleports[tpName].CFrame
		end
	end
})

UIS.InputBegan:Connect(function(input, gp)
	if gp then return end
	for _, data in pairs(Teleports) do
		if input.KeyCode == data.Key then
			HRP().CFrame = data.CFrame
		end
	end
end)

------------------------------------------------------------
-- UI MANAGER
------------------------------------------------------------
local playerGui = player:WaitForChild("PlayerGui")
local selectedUI = nil
local uiNames = {}

local function refreshUIList()
	uiNames = {}
	for _, ui in ipairs(playerGui:GetChildren()) do
		if ui:IsA("ScreenGui") then
			table.insert(uiNames, ui.Name)
		end
	end
end

refreshUIList()

UITab:CreateButton({
	Name = "Refresh UI List",
	Callback = refreshUIList
})

UITab:CreateDropdown({
	Name = "Select UI",
	Options = uiNames,
	Callback = function(v)
		selectedUI = v
	end
})

UITab:CreateButton({
	Name = "Open UI",
	Callback = function()
		if selectedUI then
			local ui = playerGui:FindFirstChild(selectedUI)
			if ui then ui.Enabled = true end
		end
	end
})

UITab:CreateButton({
	Name = "Close UI",
	Callback = function()
		if selectedUI then
			local ui = playerGui:FindFirstChild(selectedUI)
			if ui then ui.Enabled = false end
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
	Callback = function(v)
		scriptURL = v
	end
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
