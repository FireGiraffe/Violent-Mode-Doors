local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local localPlayer = Players.LocalPlayer

local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

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
			"The lights turned blue...",
			"You must not move.",
			"Stand completely still."
		},
		Cause = "Paralyze"
	}
})

-- Kill only if moving AND within 100 studs
local moveConnection
Paralyze:SetCallback("OnSpawned", function()
	local model = Paralyze.Model
	if not model then return end

	local character = localPlayer.Character
	if not character then return end

	local humanoid = character:FindFirstChildOfClass("Humanoid")
	local root = character:FindFirstChild("HumanoidRootPart")
	if not humanoid or not root then return end

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
