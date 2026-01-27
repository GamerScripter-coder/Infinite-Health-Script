-- PULIZIA GUI
pcall(function()
	game:GetService("CoreGui"):FindFirstChild("ScriptLoaderGui"):Destroy()
end)

-- SERVIZI
local CoreGui = game:GetService("CoreGui")
local UserInputService = game:GetService("UserInputService")

-- LISTA SCRIPTS PUBBLICI (ESEMPI REALI)
local scriptsList = {
	["Infinite Yield"] = "https://raw.githubusercontent.com/EdgeIY/infiniteyield/master/source",
	["CMD-X"] = "https://pastebin.com/raw/ftTV0FJN",
	["HD Admin"] = "https://pastebin.com/raw/JTg6nTnR",
	["Dex Explorer"] = "https://pastebin.com/raw/8h2rT5Zc"
	-- Puoi aggiungerne altri pubblici
}

-- CREAZIONE GUI
local gui = Instance.new("ScreenGui")
gui.Name = "ScriptLoaderGui"
gui.ResetOnSpawn = false
gui.Parent = CoreGui

local frame = Instance.new("Frame")
frame.Size = UDim2.fromScale(0.3,0.4)
frame.Position = UDim2.fromScale(0.35,0.3)
frame.BackgroundColor3 = Color3.fromRGB(40,40,40)
frame.BorderSizePixel = 0
frame.Parent = gui
Instance.new("UICorner", frame).CornerRadius = UDim.new(0,12)

local title = Instance.new("TextLabel")
title.Size = UDim2.new(1,0,0.15,0)
title.BackgroundTransparency = 1
title.Text = "Script Loader"
title.TextColor3 = Color3.new(1,1,1)
title.TextScaled = true
title.Font = Enum.Font.GothamBold
title.Parent = frame

-- SCROLLFRAME PER LISTA BOTTONI
local scrollFrame = Instance.new("ScrollingFrame")
scrollFrame.Size = UDim2.new(0.95,0,0.8,0)
scrollFrame.Position = UDim2.new(0.025,0,0.15,0)
scrollFrame.BackgroundTransparency = 1
scrollFrame.ScrollBarThickness = 8
scrollFrame.Parent = frame

local uiListLayout = Instance.new("UIListLayout")
uiListLayout.SortOrder = Enum.SortOrder.LayoutOrder
uiListLayout.Padding = UDim.new(0,5)
uiListLayout.Parent = scrollFrame

-- CREA BOTTONI
for name, url in pairs(scriptsList) do
	local btn = Instance.new("TextButton")
	btn.Size = UDim2.new(1,0,0,50)
	btn.BackgroundColor3 = Color3.fromRGB(0,100,180)
	btn.TextColor3 = Color3.new(1,1,1)
	btn.TextScaled = true
	btn.Font = Enum.Font.Gotham
	btn.Text = name
	btn.Parent = scrollFrame
	Instance.new("UICorner", btn)

	btn.MouseButton1Click:Connect(function()
		local success, err = pcall(function()
			loadstring(game:HttpGet(url,true))()
		end)
		if not success then
			warn("Errore nel caricare lo script: "..tostring(err))
		end
	end)
end

-- AGGIORNA CANVAS SIZE
scrollFrame.CanvasSize = UDim2.new(0,0,0,uiListLayout.AbsoluteContentSize.Y)
uiListLayout:GetPropertyChangedSignal("AbsoluteContentSize"):Connect(function()
	scrollFrame.CanvasSize = UDim2.new(0,0,0,uiListLayout.AbsoluteContentSize.Y)
end)

-- TRASCINAMENTO
local dragging = false
local dragStart
local startPos

title.InputBegan:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = true
		dragStart = input.Position
		startPos = frame.Position
	end
end)

title.InputEnded:Connect(function(input)
	if input.UserInputType == Enum.UserInputType.MouseButton1 then
		dragging = false
	end
end)

UserInputService.InputChanged:Connect(function(input)
	if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
		local delta = input.Position - dragStart
		frame.Position = UDim2.new(
			startPos.X.Scale,
			startPos.X.Offset + delta.X,
			startPos.Y.Scale,
			startPos.Y.Offset + delta.Y
		)
	end
end)
