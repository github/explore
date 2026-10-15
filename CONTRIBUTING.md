local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UserInputService = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer
local camera = workspace.CurrentCamera

local targetPlayer = nil
local connection = nil

local function lockCameraOnPlayer(player)
	if not player or not player.Character then return end
	
	local character = player.Character
	local humanoidRootPart = character:FindFirstChild("HumanoidRootPart") or character:FindFirstChild("Torso")
	if not humanoidRootPart then return end

	camera.CameraType = Enum.CameraType.Scriptable

	if connection then
		connection:Disconnect()
	end

	connection = RunService.RenderStepped:Connect(function()
		if not player.Character or not player.Character:FindFirstChild("HumanoidRootPart") then
			unlockCamera()
			return
		end

		local targetPart = player.Character.HumanoidRootPart
		local offset = Vector3.new(0, 5, 12)

		local cameraPosition = targetPart.Position + targetPart.CFrame.LookVector * -offset.Z + Vector3.new(0, offset.Y, 0)
		
		camera.CFrame = CFrame.new(cameraPosition, targetPart.Position + Vector3.new(0, 2, 0))
	end)
end

local function unlockCamera()
	if connection then
		connection:Disconnect()
		connection = nil
	end
	camera.CameraType = Enum.CameraType.Custom
end

UserInputService.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end

	if input.KeyCode == Enum.KeyCode.L then
		local closestPlayer = nil
		local shortestDistance = math.huge

		for _, player in pairs(Players:GetPlayers()) do
			if player \~= localPlayer and player.Character and player.Character:FindFirstChild("HumanoidRootPart") then
				local distance = (localPlayer.Character.HumanoidRootPart.Position - player.Character.HumanoidRootPart.Position).Magnitude
				if distance < shortestDistance then
					shortestDistance = distance
					closestPlayer = player
				end
			end
		end

		if closestPlayer then
			targetPlayer = closestPlayer
			lockCameraOnPlayer(closestPlayer)
		end
	end

	if input.KeyCode == Enum.KeyCode.U then
		unlockCamera()
		targetPlayer = nil
	end
end)
