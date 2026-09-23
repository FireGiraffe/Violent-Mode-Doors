local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local function playGlitchSound()
	local sound = Instance.new("Sound")
	sound.SoundId = "rbxassetid://3359047385"
	sound.Volume = 2.5
	sound.PlaybackSpeed = 1.1
	sound.Parent = workspace
	sound:Play()

	sound.Ended:Connect(function()
		sound:Destroy()
	end)
end

playGlitchSound()
task.wait(1)

local Rampage = Spawner:Create({
	Entity = {
		Name = "Rampage",
		Asset = "https://github.com/FireGiraffe/Violent-Mode-Doors/raw/main/Rampage.rbxm",
		HeightOffset = 0
	},
	Movement = {
		Speed = 200,
		Delay = 0.4,
		Reversed = false
	},
	Damage = {
		Enabled = true,
		IgnoreHiding = false,
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
			Enabled = false,
			Duration = 1.4
		},
		Shatter = false,
		Repair = false
	},
	Earthquake = {
		Enabled = false
	},
	CameraShake = {
		Enabled = true,
		Values = {3.8, 35, 0.06, 1.6},
		Range = 140
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
			"You died to Rampage.",
			"A glitchy sound plays before he bolts through the rooms.",
			"He is much faster than Rush.",
			"Hide the second you hear the glitch."
		},
		Cause = "Rampage"
	}
})

Rampage:SetCallback("OnSpawned", function()
	print("[Violent Mode] Rampage has spawned")

	local model = Rampage.Model
	if not model then return end

	local main = model:FindFirstChild("Main") or model.PrimaryPart or model:FindFirstChildWhichIsA("BasePart")
	if not main then return end

	local scream = Instance.new("Sound")
	scream.Name = "RampageScream"
	scream.SoundId = "rbxassetid://139310882854462"
	scream.Volume = 3.5
	scream.PlaybackSpeed = 1
	scream.Looped = true
	scream.RollOffMaxDistance = 120
	scream.Parent = main
	scream:Play()
end)

Rampage:SetCallback("OnDespawned", function()
	local model = Rampage.Model
	if model then
		local main = model:FindFirstChild("Main") or model.PrimaryPart
		if main then
			local scream = main:FindFirstChild("RampageScream")
			if scream then
				scream:Stop()
				scream:Destroy()
			end
		end
	end
end)

Rampage:Run(true)
