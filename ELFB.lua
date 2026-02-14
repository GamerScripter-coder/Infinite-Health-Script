-- FULL CLIENT ADMIN PANEL (LOCAL ONLY + FAKE DUPE)

local Players = game:GetService("Players")
local UIS = game:GetService("UserInputService")
local RunService = game:GetService("RunService")

local player = Players.LocalPlayer
local mouse = player:GetMouse()

-- ================= CHARACTER =================
local char, hum, hrp
local function loadChar(c)
	char = c
	hum = c:WaitForChild("Humanoid")
	hrp = c:WaitForChild("HumanoidRootPart")
end
loadChar(player.Character or player.CharacterAdded:Wait())
player.CharacterAdded:Connect(loadChar)

-- ================= GUI =================
local gui = Instance.new("ScreenGui", player.PlayerGui)
gui.Name = "ClientAdminPanel"
gui.ResetOnSpawn = false

local main = Instance.new("Frame", gui)
main.Size = UDim2.new(0, 800, 0, 480)
main.Position = UDim2.new(0.5, -400, 0.5, -240)
main.BackgroundColor3 = Color3.fromRGB(18,18,18)
main.Active = true
main.Draggable = true
Instance.new("UICorner", main).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel", main)
title.Size = UDim2.new(1,0,0,40)
title.Text = "CLIENT ADMIN PANEL"
title.Font = Enum.Font.GothamBold
title.TextSize = 20
title.TextColor3 = Color3.new(1,1,1)
title.BackgroundTransparency = 1

-- ================= TAB BAR =================
local tabBar = Instance.new("Frame", main)
tabBar.Size = UDim2.new(0,170,1,-40)
tabBar.Position = UDim2.new(0,0,0,40)
tabBar.BackgroundColor3 = Color3.fromRGB(22,22,22)

local function tabButton(text,y)
	local b = Instance.new("TextButton", tabBar)
	b.Size = UDim2.new(1,-10,0,40)
	b.Position = UDim2.new(0,5,0,y)
	b.Text = text
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	b.TextColor3 = Color3.new(1,1,1)
	b.BackgroundColor3 = Color3.fromRGB(45,45,45)
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

local playerTabBtn = tabButton("PLAYER",10)
local tpTabBtn     = tabButton("TELEPORTS",60)
local toolTabBtn   = tabButton("TOOLS",110)
local camTabBtn    = tabButton("CAMERA",160)

-- ================= PAGES =================
local function page()
	local f = Instance.new("ScrollingFrame", main)
	f.Position = UDim2.new(0,180,0,50)
	f.Size = UDim2.new(1,-190,1,-60)
	f.CanvasSize = UDim2.new(0,0,0,900)
	f.Visible = false
	f.BackgroundTransparency = 1
	return f
end

local playerPage = page()
local tpPage = page()
local toolPage = page()
local camPage = page()
playerPage.Visible = true

local function switch(p)
	playerPage.Visible = false
	tpPage.Visible = false
	toolPage.Visible = false
	camPage.Visible = false
	p.Visible = true
end

playerTabBtn.MouseButton1Click:Connect(function() switch(playerPage) end)
tpTabBtn.MouseButton1Click:Connect(function() switch(tpPage) end)
toolTabBtn.MouseButton1Click:Connect(function() switch(toolPage) end)
camTabBtn.MouseButton1Click:Connect(function() switch(camPage) end)

-- ================= UI HELPERS =================
local function box(parent,text,y)
	local t = Instance.new("TextBox", parent)
	t.Size = UDim2.new(1,-20,0,35)
	t.Position = UDim2.new(0,10,0,y)
	t.PlaceholderText = text
	t.BackgroundColor3 = Color3.fromRGB(35,35,35)
	t.TextColor3 = Color3.new(1,1,1)
	t.Font = Enum.Font.Gotham
	t.TextSize = 14
	t.ClearTextOnFocus = false
	Instance.new("UICorner", t).CornerRadius = UDim.new(0,8)
	return t
end

local function btn(parent,text,y)
	local b = Instance.new("TextButton", parent)
	b.Size = UDim2.new(1,-20,0,40)
	b.Position = UDim2.new(0,10,0,y)
	b.Text = text
	b.BackgroundColor3 = Color3.fromRGB(60,60,60)
	b.TextColor3 = Color3.new(1,1,1)
	b.Font = Enum.Font.GothamBold
	b.TextSize = 14
	Instance.new("UICorner", b).CornerRadius = UDim.new(0,8)
	return b
end

-- ================= PLAYER PAGE =================
local speedBox = box(playerPage,"WalkSpeed",10)
btn(playerPage,"SET SPEED",55).MouseButton1Click:Connect(function()
	local v = tonumber(speedBox.Text)
	if v then hum.WalkSpeed = v end
end)

local jumpBox = box(playerPage,"JumpPower",110)
btn(playerPage,"SET JUMP",155).MouseButton1Click:Connect(function()
	local v = tonumber(jumpBox.Text)
	if v then hum.JumpPower = v end
end)

local infJump = false
btn(playerPage,"INFINITE JUMP",210).MouseButton1Click:Connect(function()
	infJump = not infJump
end)

UIS.JumpRequest:Connect(function()
	if infJump then hum:ChangeState(Enum.HumanoidStateType.Jumping) end
end)

local noclip = false
btn(playerPage,"NOCLIP",260).MouseButton1Click:Connect(function()
	noclip = not noclip
end)

RunService.Stepped:Connect(function()
	if noclip and char then
		for _,p in ipairs(char:GetDescendants()) do
			if p:IsA("BasePart") then p.CanCollide = false end
		end
	end
end)

local hrpLock = false
btn(playerPage,"LOCK HRP",310).MouseButton1Click:Connect(function()
	hrpLock = not hrpLock
	if hrpLock then
		hum.WalkSpeed = 0
		hum.JumpPower = 0
	else
		hum.WalkSpeed = 16
		hum.JumpPower = 50
	end
end)

RunService.Stepped:Connect(function()
	if hrpLock and hrp then
		hrp.Velocity = Vector3.zero
		hrp.RotVelocity = Vector3.zero
	end
end)

local clickTP = false
btn(playerPage,"CLICK TELEPORT",360).MouseButton1Click:Connect(function()
	clickTP = not clickTP
end)

mouse.Button1Down:Connect(function()
	if clickTP and hrp then
		hrp.CFrame = CFrame.new(mouse.Hit.Position + Vector3.new(0,3,0))
	end
end)

btn(playerPage,"RESET STATS",410).MouseButton1Click:Connect(function()
	hum.WalkSpeed = 16
	hum.JumpPower = 50
end)

-- ================= TELEPORT PAGE =================
local teleportSlots = {}
local slotCount = 0

btn(tpPage,"+ ADD SLOT",10).MouseButton1Click:Connect(function()
	slotCount += 1
	local y = 60 + (slotCount-1)*110

	local saveBtn = btn(tpPage,"SAVE SLOT "..slotCount, y)
	local tpBtn   = btn(tpPage,"TP SLOT "..slotCount, y+45)

	local keyBox = box(tpPage,"Keybind (es. Z)", y+90)
	keyBox.Size = UDim2.new(0.4,0,0,35)
	keyBox.Position = UDim2.new(0.55,0,0,y+90)

	teleportSlots[slotCount] = {cframe=nil, key=nil}

	saveBtn.MouseButton1Click:Connect(function()
		teleportSlots[slotCount].cframe = hrp.CFrame
	end)

	tpBtn.MouseButton1Click:Connect(function()
		if teleportSlots[slotCount].cframe then
			hrp.CFrame = teleportSlots[slotCount].cframe
		end
	end)

	keyBox.FocusLost:Connect(function()
		local k = keyBox.Text:upper()
		if Enum.KeyCode[k] then
			teleportSlots[slotCount].key = Enum.KeyCode[k]
		end
	end)

	tpPage.CanvasSize = UDim2.new(0,0,0,y+160)
end)

UIS.InputBegan:Connect(function(input,gp)
	if gp then return end
	for _,slot in pairs(teleportSlots) do
		if slot.key and slot.cframe and input.KeyCode == slot.key then
			hrp.CFrame = slot.cframe
		end
	end
end)

-- ================= TOOLS PAGE (FAKE DUPE) =================
local toolNameBox = box(toolPage,"Nome Tool (es. Sword)",10)

btn(toolPage,"DUPE TOOL (BACKPACK)",55).MouseButton1Click:Connect(function()
	local name = toolNameBox.Text
	if name == "" then return end
	local bp = player:WaitForChild("Backpack")
	local tool = bp:FindFirstChild(name)
	if tool and tool:IsA("Tool") then
		tool:Clone().Parent = bp
	end
end)

btn(toolPage,"DUPE EQUIPPED TOOL",110).MouseButton1Click:Connect(function()
	if not char then return end
	for _,obj in ipairs(char:GetChildren()) do
		if obj:IsA("Tool") then
			obj:Clone().Parent = player.Backpack
			break
		end
	end
end)

local amountBox = box(toolPage,"Quantità (es. 5)",160)

btn(toolPage,"DUPE xN (EQUIPPED)",205).MouseButton1Click:Connect(function()
	local n = tonumber(amountBox.Text)
	if not n or n < 1 then return end
	if not char then return end
	for _,obj in ipairs(char:GetChildren()) do
		if obj:IsA("Tool") then
			for i = 1, n do
				obj:Clone().Parent = player.Backpack
			end
			break
		end
	end
end)

-- ================= CAMERA PAGE =================
local fovBox = box(camPage,"FOV",10)
btn(camPage,"SET FOV",55).MouseButton1Click:Connect(function()
	local v = tonumber(fovBox.Text)
	if v then workspace.CurrentCamera.FieldOfView = v end
end)

-- ================= TOGGLE PANEL =================
UIS.InputBegan:Connect(function(i,gp)
	if not gp and i.KeyCode == Enum.KeyCode.RightShift then
		main.Visible = not main.Visible
	end
end)
