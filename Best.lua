--[=[
 d888b  db    db d888888b      .d888b.      db      db    db  .d8b.  
88' Y8b 88    88   `88'        VP  `8D      88      88    88 d8' `8b 
88      88    88    88            odD'      88      88    88 88ooo88 
88  ooo 88    88    88          .88'        88      88    88 88~~~88 
88. ~8~ 88b  d88   .88.        j88.         88booo. 88b  d88 88   88    @uniquadev
 Y888P  ~Y8888P' Y888888P      888888D      Y88888P ~Y8888P' YP   YP  CONVERTER 
]=]

-- Instances: 18 | Scripts: 5 | Modules: 0 | Tags: 0
local function Load()
	print("Aspettare per il caricamento di SAB")
	wait(1)
	print("Stiamo Installando i moduli")
	wait(4)
	print("Installazione Completa di SAB")
end

Load()
wait(0.3)
local G2L = {};

-- StarterGui.Folder.SAB
local function CreateUI()
G2L["1"] = Instance.new("ScreenGui", game:GetService("Players").LocalPlayer:WaitForChild("PlayerGui"));
G2L["1"]["Enabled"] = true;
G2L["1"]["Name"] = [[SAB]];
G2L["1"]["ZIndexBehavior"] = Enum.ZIndexBehavior.Sibling;


-- StarterGui.Folder.SAB.Frame
G2L["2"] = Instance.new("Frame", G2L["1"]);
G2L["2"]["BorderSizePixel"] = 0;
G2L["2"]["BackgroundColor3"] = Color3.fromRGB(57, 57, 57);
G2L["2"]["Size"] = UDim2.new(0, 352, 0, 418);
G2L["2"]["Position"] = UDim2.new(0.37164, 0, 0.15486, 0);
G2L["2"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["2"]["BackgroundTransparency"] = 0.2;


-- StarterGui.Folder.SAB.Frame.Frame
G2L["3"] = Instance.new("Frame", G2L["2"]);
G2L["3"]["BorderSizePixel"] = 0;
G2L["3"]["BackgroundColor3"] = Color3.fromRGB(106, 106, 106);
G2L["3"]["Size"] = UDim2.new(0, 351, 0, 51);
G2L["3"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);


-- StarterGui.Folder.SAB.Frame.Frame.TextLabel
G2L["4"] = Instance.new("TextLabel", G2L["3"]);
G2L["4"]["TextWrapped"] = true;
G2L["4"]["BorderSizePixel"] = 0;
G2L["4"]["TextSize"] = 14;
G2L["4"]["TextScaled"] = true;
G2L["4"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["4"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["4"]["BackgroundTransparency"] = 1;
G2L["4"]["Size"] = UDim2.new(1, 0, 1, 0);
G2L["4"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["4"]["Text"] = [[NO KEYLESS HUB]];


-- StarterGui.Folder.SAB.Frame.Frame.TextLabel.UIStroke
G2L["5"] = Instance.new("UIStroke", G2L["4"]);
G2L["5"]["Thickness"] = 2;


-- StarterGui.Folder.SAB.Frame.AbuseFrame
G2L["6"] = Instance.new("Frame", G2L["2"]);
G2L["6"]["BorderSizePixel"] = 0;
G2L["6"]["BackgroundColor3"] = Color3.fromRGB(255, 255, 255);
G2L["6"]["Size"] = UDim2.new(0, 352, 0, 367);
G2L["6"]["Position"] = UDim2.new(0, 0, 0.12201, 0);
G2L["6"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["6"]["Name"] = [[AbuseFrame]];
G2L["6"]["BackgroundTransparency"] = 1;


-- StarterGui.Folder.SAB.Frame.AbuseFrame.SavePos
G2L["7"] = Instance.new("TextButton", G2L["6"]);
G2L["7"]["TextWrapped"] = true;
G2L["7"]["BorderSizePixel"] = 0;
G2L["7"]["TextSize"] = 14;
G2L["7"]["TextScaled"] = true;
G2L["7"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["7"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
G2L["7"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["7"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["7"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["7"]["Text"] = [[SavePos]];
G2L["7"]["Name"] = [[SavePos]];
G2L["7"]["Position"] = UDim2.new(0.04261, 0, 0.04632, 0);


-- StarterGui.Folder.SAB.Frame.AbuseFrame.SavePos.LocalScript
G2L["8"] = Instance.new("LocalScript", G2L["7"]);



-- StarterGui.Folder.SAB.Frame.AbuseFrame.PositionTeleport
G2L["9"] = Instance.new("Vector3Value", G2L["6"]);
G2L["9"]["Name"] = [[PositionTeleport]];


-- StarterGui.Folder.SAB.Frame.AbuseFrame.TeleportPos
G2L["a"] = Instance.new("TextButton", G2L["6"]);
G2L["a"]["TextWrapped"] = true;
G2L["a"]["BorderSizePixel"] = 0;
G2L["a"]["TextSize"] = 14;
G2L["a"]["TextScaled"] = true;
G2L["a"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["a"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
G2L["a"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["a"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["a"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["a"]["Text"] = [[TeleportPos]];
G2L["a"]["Name"] = [[TeleportPos]];
G2L["a"]["Position"] = UDim2.new(0.53125, 0, 0.04632, 0);


-- StarterGui.Folder.SAB.Frame.AbuseFrame.TeleportPos.LocalScript
G2L["b"] = Instance.new("LocalScript", G2L["a"]);



-- StarterGui.Folder.SAB.Frame.AbuseFrame.Gravity
G2L["c"] = Instance.new("TextButton", G2L["6"]);
G2L["c"]["TextWrapped"] = true;
G2L["c"]["BorderSizePixel"] = 0;
G2L["c"]["TextSize"] = 14;
G2L["c"]["TextScaled"] = true;
G2L["c"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["c"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
G2L["c"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["c"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["c"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["c"]["Text"] = [[SetGravity]];
G2L["c"]["Name"] = [[Gravity]];
G2L["c"]["Position"] = UDim2.new(0.04261, 0, 0.19346, 0);


-- StarterGui.Folder.SAB.Frame.AbuseFrame.Gravity.LocalScript
G2L["d"] = Instance.new("LocalScript", G2L["c"]);



-- StarterGui.Folder.SAB.Frame.AbuseFrame.StopGravity
G2L["e"] = Instance.new("TextButton", G2L["6"]);
G2L["e"]["TextWrapped"] = true;
G2L["e"]["BorderSizePixel"] = 0;
G2L["e"]["TextSize"] = 14;
G2L["e"]["TextScaled"] = true;
G2L["e"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["e"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
G2L["e"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["e"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["e"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["e"]["Text"] = [[StopGravity]];
G2L["e"]["Name"] = [[StopGravity]];
G2L["e"]["Position"] = UDim2.new(0.53125, 0, 0.19346, 0);


-- StarterGui.Folder.SAB.Frame.AbuseFrame.StopGravity.LocalScript
G2L["f"] = Instance.new("LocalScript", G2L["e"]);



-- StarterGui.Folder.SAB.Frame.AbuseFrame.InfJump
G2L["10"] = Instance.new("TextButton", G2L["6"]);
G2L["10"]["TextWrapped"] = true;
G2L["10"]["BorderSizePixel"] = 0;
G2L["10"]["TextSize"] = 14;
G2L["10"]["TextScaled"] = true;
G2L["10"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["10"]["BackgroundColor3"] = Color3.fromRGB(86, 86, 86);
G2L["10"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["10"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["10"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["10"]["Text"] = [[InfJump]];
G2L["10"]["Name"] = [[InfJump]];
G2L["10"]["Position"] = UDim2.new(0.04261, 0, 0.33787, 0);


-- StarterGui.Folder.SAB.Frame.AbuseFrame.InfJump.LocalScript
G2L["11"] = Instance.new("LocalScript", G2L["10"]);



-- StarterGui.Folder.SAB.Frame.AbuseFrame.InfJump.TextBox
G2L["12"] = Instance.new("TextBox", G2L["10"]);
G2L["12"]["BorderSizePixel"] = 0;
G2L["12"]["TextWrapped"] = true;
G2L["12"]["TextSize"] = 14;
G2L["12"]["TextColor3"] = Color3.fromRGB(255, 255, 255);
G2L["12"]["TextScaled"] = true;
G2L["12"]["BackgroundColor3"] = Color3.fromRGB(176, 176, 176);
G2L["12"]["FontFace"] = Font.new([[rbxasset://fonts/families/Nunito.json]], Enum.FontWeight.Bold, Enum.FontStyle.Normal);
G2L["12"]["Size"] = UDim2.new(0, 140, 0, 33);
G2L["12"]["Position"] = UDim2.new(1.22857, 0, 0, 0);
G2L["12"]["BorderColor3"] = Color3.fromRGB(0, 0, 0);
G2L["12"]["Text"] = [[X]];
G2L["12"]["BackgroundTransparency"] = 0.2;


-- StarterGui.Folder.SAB.Frame.AbuseFrame.SavePos.LocalScript
local function C_8()
local script = G2L["8"];
	local SP = script.Parent
	local Pos = SP.Parent.PositionTeleport
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	
	local function GetChar()
		char = plr.Character or plr.CharacterAdded:Wait()
		hrp = char:WaitForChild("HumanoidRootPart")
		
		return char, hrp
	end
	
	SP.MouseButton1Click:Connect(function()
		local PlrChar, hrp = GetChar()
		
		Pos.Value = hrp.Position
		
		if workspace:FindFirstChild("SavePosPart") then
			workspace:FindFirstChild("SavePosPart"):Destroy()
		end
		
		local SavePosPart = Instance.new("Part")
		SavePosPart.Name = "SavePosPart"
		SavePosPart.Size = Vector3.new(3.5,10000,3.5)
		SavePosPart.Position = Pos.Value
		SavePosPart.Anchored = true
		SavePosPart.Transparency = 0.5
		SavePosPart.CanCollide = false
		SavePosPart.Parent = workspace
	end)
end;
task.spawn(C_8);
-- StarterGui.Folder.SAB.Frame.AbuseFrame.TeleportPos.LocalScript
local function C_b()
local script = G2L["b"];
	local SP = script.Parent
	local Pos = SP.Parent:WaitForChild("PositionTeleport")
	local UIS = game:GetService("UserInputService")
	local plr = game.Players.LocalPlayer
	
	local cancelTeleport = false
	
	-- Cartella per le part create durante il teleport
	local PartFolder = Instance.new("Folder")
	PartFolder.Name = "TeleportParts"
	PartFolder.Parent = workspace
	
	-- Velocità diverse per ogni esperienza
	local PlaceSpeed = {
		[131623223084840] = 125, -- esempio esperienza 1
		[109983668079237] = 25   -- esempio esperienza 2
	}
	
	local function GetSpeed()
		return PlaceSpeed[game.PlaceId] or 35
	end
	
	local function GetChar()
		local char = plr.Character or plr.CharacterAdded:Wait()
		local hrp = char:WaitForChild("HumanoidRootPart")
		return char, hrp
	end
	
	-- Cancella teleport con C
	UIS.InputBegan:Connect(function(input, gpe)
		if gpe then return end
		if input.KeyCode == Enum.KeyCode.C then
			cancelTeleport = true
		end
	end)
	
	SP.MouseButton1Click:Connect(function()
		if not workspace:FindFirstChild("SavePosPart") and Pos.Value == Vector3.new(0,0,0) then
			warn("No position saved")
			return
		end
	
		cancelTeleport = false
		local char, hrp = GetChar()
		local target = Pos.Value
		local speed = GetSpeed()
	
		-- Assicurati che esista la part di salvataggio
		local SavedPos = workspace:FindFirstChild("SavePosPart")
		if Pos.Value == Vector3.new(0,0,0) then
			Pos.Value = SavedPos.Position
		end
		local connection
	
		if SavedPos then
			-- Connetti Touched una volta sola
			connection = SavedPos.Touched:Connect(function(hit)
				if hit:IsDescendantOf(char) then
					cancelTeleport = true
				end
			end)
		end
	
		-- Teleport loop
		task.spawn(function()
			while hrp and (hrp.Position - target).Magnitude > 2 and not cancelTeleport do
				local current = hrp.Position
				local direction = (Vector3.new(target.X,current.Y,target.Z) - current).Unit
	
				-- Muovi player
				hrp.AssemblyLinearVelocity = direction * speed + Vector3.new(0, hrp.AssemblyLinearVelocity.Y, 0)
	
				-- Crea part invisibile sotto i piedi
				local LegPart = Instance.new("Part")
				LegPart.Name = "LegPart"
				LegPart.Size = Vector3.new(2.5,1.5,2.5)
				LegPart.CFrame = hrp.CFrame - Vector3.new(0,4.5,0)
				LegPart.Anchored = true
				LegPart.Transparency = 1
				LegPart.Parent = PartFolder
	
				task.wait(0.05)
			end
	
			-- Ferma il movimento
			if hrp then
				hrp.AssemblyLinearVelocity = Vector3.zero
			end
	
			-- Pulizia part
			for _,p in pairs(PartFolder:GetChildren()) do
				p:Destroy()
			end
	
			-- Disconnetti Touched
			if connection then
				connection:Disconnect()
			end
		end)
	end)
end;
task.spawn(C_b);
-- StarterGui.Folder.SAB.Frame.AbuseFrame.Gravity.LocalScript
local function C_d()
local script = G2L["d"];
	local SP = script.Parent
	local Pos = SP.Parent.PositionTeleport
	
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	
	local VectorForce
	
	SP.MouseButton1Click:Connect(function()
		workspace.Gravity = 75
	end)
end;
task.spawn(C_d);
-- StarterGui.Folder.SAB.Frame.AbuseFrame.StopGravity.LocalScript
local function C_f()
local script = G2L["f"];
	local SP = script.Parent
	local Pos = SP.Parent.PositionTeleport
	local plr = game.Players.LocalPlayer
	local char = plr.Character or plr.CharacterAdded:Wait()
	local hrp = char:WaitForChild("HumanoidRootPart")
	
	SP.MouseButton1Click:Connect(function()
		workspace.Gravity = 196.2
	end)
end;
task.spawn(C_f);
-- StarterGui.Folder.SAB.Frame.AbuseFrame.InfJump.LocalScript
local function C_11()
local script = G2L["11"];
	local SP = script.Parent
	local ButtonBox = SP.TextBox
	local Button = ButtonBox.Text
	
	local UIS = game:GetService("UserInputService")
	local player = game.Players.LocalPlayer
	
	ButtonBox:GetPropertyChangedSignal("Text"):Connect(function()
		Button = ButtonBox.Text
	end)
	
	UIS.InputBegan:Connect(function(input, gameProcessed)
		if gameProcessed then return end
	
		local key = Enum.KeyCode[Button]
		if not key then return end
	
		if input.KeyCode == key then
			local char = player.Character or player.CharacterAdded:Wait()
			local hrp = char:WaitForChild("HumanoidRootPart")
	
			local jumpVelocity =65 -- default salto normale
			
			if workspace.Gravity == 75 then
				jumpVelocity = 35 -- salto più alto
			end
	
			-- Applica la velocità verticale per il salto
			hrp.AssemblyLinearVelocity = Vector3.new(
				hrp.AssemblyLinearVelocity.X,
				jumpVelocity,
				hrp.AssemblyLinearVelocity.Z
			)
		end
	end)
end;
task.spawn(C_11);

return G2L["1"], require;
end

CreateUI()

game.Players.LocalPlayer.CharacterAdded:Connect(function()
	CreateUI()
end)
