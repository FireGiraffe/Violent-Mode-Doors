local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local redColor = Color3.fromRGB(255, 30, 30)
for _, v in pairs(workspace:GetDescendants()) do
	if v:IsA("PointLight") or v:IsA("SpotLight") then
		v.Color = redColor
	end
end

local Thrash = Spawner:Create({
	Entity = {
		Name = "Thrash",
		Asset = "https://github.com/FireGiraffe/Violent-Mode-Doors/raw/main/Thrash.rbxm",
		HeightOffset = 0
	},
	Movement = {
		Speed = 280,
		Delay = 0.6,
		Reversed = false
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 45,
		Amount = 125
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 3,
		Max = 6,
		Delay = 1.4
	},
	Lights = {
		Flicker = {
			Enabled = false,
			Duration = 0
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Values = {3.2, 28, 0.08, 1.4},
		Range = 120
	},
	Crucifixion = {
		Type = "Curious",
		Enabled = true,
		Range = 46,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"Oh, hello...",
			"You died to Thrash.",
			"It moves around violently, coming back a few times.",
			"His indication is the lights flickering a little more than usual.",
			"Hope you don't mind trying again, it would be helpful."
		},
		Cause = "Thrash"
	}
})

Thrash:SetCallback("OnSpawned", function()
	print("[Violent Mode] Thrash has spawned")
end)

Thrash:Run(true)
