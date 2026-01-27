local Players = game:GetService("Players")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local savedCFrame = nil

local function getHumanoidRootPart()
	local character = player.Character or player.CharacterAdded:Wait()
	return character:WaitForChild("HumanoidRootPart")
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.X then
		savedCFrame = getHumanoidRootPart().CFrame

	elseif input.KeyCode == Enum.KeyCode.J then
		if savedCFrame then
			getHumanoidRootPart().CFrame = savedCFrame
		end
	end
end)
