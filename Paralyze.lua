local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local TweenService = game:GetService("TweenService")
local localPlayer = Players.LocalPlayer

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local function turnLightsGreen()
	local targetColor = Color3.fromRGB(0, 255, 0)
	local tweenInfo = TweenInfo.new(1, Enum.EasingStyle.Quad, Enum.EasingDirection.Out)

	local currentRooms = workspace:FindFirstChild("CurrentRooms")
	if not currentRooms then return end

	for _, room in ipairs(currentRooms:GetChildren()) do
		for _, desc in ipairs(room:GetDescendants()) do
			if desc:IsA("Light") then
				task.spawn(function()
					TweenService:Create(desc, tweenInfo, {Color = targetColor}):Play()
				end)
			elseif desc:IsA("BasePart") and desc.Material == Enum.Material.Neon then
				task.spawn(function()
					TweenService:Create(desc, tweenInfo, {Color = targetColor}):Play()
				end)
			end
		end
	end
end

turnLightsGreen()
task.wait(1.5)

local Paralyze = Spawner:Create({
	Entity = {
		Name = "Paralyze",
		Asset = "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/main/Paralyze.rbxm",
		HeightOffset = 0
	},
	Movement = {
		Speed = 110,
		Delay = 1.5,
		Reversed = false
	},
	Damage = {
		Enabled = false,
		IgnoreHiding = true,
		Range = 55,
		Amount = 125
	},
	Rebounding = {
		Enabled = false,
		Type = "Ambush",
		Min = 1,
		Max = 1,
		Delay = 2
	},
	Lights = {
		Flicker = {Enabled = false},
		Shatter = false,
		Repair = false
	},
	Earthquake = {Enabled = false},
	CameraShake = {
		Enabled = true,
		Values = {1.2, 15, 0.1, 1},
		Range = 100
	},
	Crucifixion = {
		Type = "Curious",
		Enabled = true,
		Range = 40,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Guiding",
		Hints = {
			"You died to Paralyze.",
			"The lights turned green...",
			"You must not move.",
			"Stand completely still."
		},
		Cause = "Paralyze"
	}
})

local moveConnection
Paralyze:SetCallback("OnSpawned", function()
	local model = Paralyze.Model
	if not model then return end

	local character = localPlayer.Character or localPlayer.CharacterAdded:Wait()
	local humanoid = character:WaitForChild("Humanoid")
	local root = character:WaitForChild("HumanoidRootPart")

	moveConnection = RunService.Heartbeat:Connect(function()
		if not model or not model.Parent then return end

		local distance = (root.Position - model:GetPivot().Position).Magnitude

		if humanoid.MoveDirection.Magnitude > 0.1 and distance <= 100 then
			humanoid.Health = 0
		end
	end)
end)

Paralyze:SetCallback("OnDespawned", function()
	if moveConnection then
		moveConnection:Disconnect()
	end
	print("[Paralyze] Paralyze despawned")
end)

Paralyze:Run(true)

print("[Paralyze] Paralyze has been summoned")
