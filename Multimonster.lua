local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local SoundService = game:GetService("SoundService")

local GLITCH_SOUND_ID = "rbxassetid://9114223177"

local function playGlitchCue()
	local sound = Instance.new("Sound")
	sound.Name = "Multimonster_SpawnGlitch"
	sound.SoundId = GLITCH_SOUND_ID
	sound.Volume = 2.5
	sound.RollOffMaxDistance = 250
	sound.Parent = SoundService
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

local Multimonster = Spawner:Create({
	Entity = {
		Name = "Multimonster",
		Asset = "https://github.com/FireGiraffe/Violent-Mode-Doors/raw/main/Multimonster.rbxm",
		HeightOffset = 0
	},
	Movement = {
		Speed = 320,
		Delay = 2,
		Reversed = false
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
		Range = 50,
		Amount = 150
	},
	Rebounding = {
		Enabled = true,
		Type = "Ambush",
		Min = 4,
		Max = 8,
		Delay = 1.2
	},
	Lights = {
		Flicker = {
			Enabled = false
		},
		Shatter = true,
		Repair = false
	},
	Earthquake = {
		Enabled = true
	},
	CameraShake = {
		Enabled = true,
		Values = {5.0, 35, 0.05, 2.0},
		Range = 160
	},
	Crucifixion = {
		Type = "Curious",
		Enabled = true,
		Range = 45,
		Resist = false,
		Break = true
	},
	Death = {
		Type = "Curious",
		Hints = {
			"You encountered Multimonster...",
			"It moves at extreme speeds and rebounds constantly.",
			"When the hotel begins to shake and lights flicker endlessly, find cover immediately.",
			"Do not leave your hiding spot too early; it returns multiple times."
		},
		Cause = "Multimonster"
	}
})

Multimonster:SetCallback("OnSpawned", function()
	playGlitchCue()
	local root = Multimonster.Model and (Multimonster.Model.PrimaryPart or Multimonster.Model:FindFirstChildWhichIsA("BasePart"))
	if root then
		local loopSound = Instance.new("Sound")
		loopSound.SoundId = "rbxassetid://9069609200"
		loopSound.Looped = true
		loopSound.Volume = 1.8
		loopSound.RollOffMaxDistance = 150
		loopSound.Parent = root
		loopSound:Play()
	end

	print("[Violent Mode] Multimonster has breached the hotel!")
end)

Multimonster:SetCallback("OnDespawned", function()
	print("[Violent Mode] Multimonster has departed.")
end)

task.wait(5)

Multimonster:Run(true)
