local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()
local TweenService = game:GetService("TweenService")

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
	local lights = {}
	local neons = {}
	local rooms = {}
	local targetColor = Color3.fromRGB(85, 255, 255)
	local latestRoomVal = game.ReplicatedStorage.GameData.LatestRoom.Value

	-- Collect current rooms
	for _, room in ipairs(workspace.CurrentRooms:GetChildren()) do
		local roomNum = tonumber(room.Name)
		if roomNum and roomNum <= latestRoomVal then
			table.insert(rooms, room)
		end
	end

	-- Collect all lights and neon parts in those rooms
	for _, room in ipairs(rooms) do
		for _, desc in ipairs(room:GetDescendants()) do
			if desc:IsA("Light") then
				table.insert(lights, desc)
			elseif desc:IsA("MeshPart") and desc.Name == "Neon" then
				table.insert(neons, desc)
			end
		end
	end

	-- Tween the light sources
	for _, light in ipairs(lights) do
		task.spawn(function()
			TweenService:Create(light, TweenInfo.new(1), {Color = targetColor}):Play()
		end)
	end

	-- Tween the neon mesh parts
	for _, neon in ipairs(neons) do
		task.spawn(function()
			TweenService:Create(neon, TweenInfo.new(1), {Color = targetColor}):Play()
		end)
	end
end)

Thrash:Run(true)
