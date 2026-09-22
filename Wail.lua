local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local function playSpawnSound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://140043289814504"
	sound.Volume = 3
	sound.PlaybackSpeed = 1
	sound.Parent = workspace
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

playSpawnSound()
task.wait(0.4)

local Wail = Spawner:Create({
	Entity = {
		Name = "Wail",
		Asset = "https://github.com/FireGiraffe/Violent-Mode-Doors/raw/main/Wail.rbxm", -- FIXED (raw link)
		HeightOffset = 0
	},
	Movement = {
		Speed = 60,
		Delay = 1.6,
		Reversed = false
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = true,
		Range = 50,
		Amount = 125
	},
	Rebounding = {
		Enabled = false,
		Type = "Ambush",
		Min = 1,
		Max = 1,
		Delay = 1
	},
	Lights = {
		Flicker = {
			Enabled = true,
			Duration = 0.5
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Values = {2.9, 50, 0.09, 1.4},
		Range = 115
	},
	Crucifixion = {
		Type = "Curious",
		Enabled = true,
		Range = 51,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"Oh, hello...",
			"You died to Wail.",
			"He is slower than Rush, but hiding will not save you.",
			"Find an area out of his range.",
			"I hope you don't mind trying again, it would be helpful."
		},
		Cause = "Wail"
	}
})

Wail:SetCallback("OnSpawned", function()
	print("[Violent Mode] Wail has spawned")
end)

Wail:Run(true)
