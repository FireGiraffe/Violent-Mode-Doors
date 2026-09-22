local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local lights = {}
local neons = {}
local rooms = {}
local TweenService = game:GetService("TweenService")
for ,v in workspace.CurrentRooms:GetChildren() do
    if game.ReplicatedStorage.GameData.LatestRoom.Value<=tonumber(v.Name) then
        table.insert(rooms, v)
    end
end
for ,v in rooms do
    for _, v in v:GetDescendants() do
        if v:IsA("Light") then
            table.insert(lights, v)
        end

        if v:IsA("MeshPart") then
            if v.Name == "Neon" then
                table.insert(neons, v)
            end
        end
    end
end

coroutine.wrap(function()
    for i,v in lights do
        local color = Color3.fromRGB(85, 255, 255)
        task.spawn(function()
            TweenService:Create(v,TweenInfo.new(1),{Color = color}):Play()
        end)
    end
end)()

coroutine.wrap(function()
    for i,v in neons do
        local color = Color3.fromRGB(85, 255, 255)
        task.spawn(function()
            TweenService:Create(v,TweenInfo.new(1),{Color = color}):Play()
        end)
    end
end)()

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
