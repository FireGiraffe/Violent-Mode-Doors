---====== Load spawner ======---
local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

---====== Create entity ======---
local Thrash = Spawner:Create({
    Entity = {
        Name = "Thrash",
        Asset = "https://github.com/FireGiraffe/Violent-Mode-Doors/raw/main/Thrash.rbxm",
        HeightOffset = 0
    },
    Movement = {
        Speed = 280,
        Delay = 1.2,
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
            Enabled = true,
            Duration = 1.8
        },
        Shatter = true,
        Repair = false
    },
    Earthquake = {
        Enabled = true
    },
    CameraShake = {
        Enabled = true,
        Values = {3.2, 28, 0.08, 1.4},
        Range = 120
    },
    Crucifixion = {
        Type = "Curious",
        Enabled = true,
        Range = 40,
        Resist = false,
        Break = true
    },
    Death = {
        Type = "Curious",
        Hints = {
            "You died to Thrash.",
            "It moves around violently, coming back a few times.",
            "His indication is the lights flickering a little more than usual.",
            "Use what you've learned from Ambush!"
        },
        Cause = "Thrash"
    }
})

Thrash:SetCallback("OnSpawned", function()
    print("[Violent Mode] Thrash has spawned")
end)

---====== Run the entity ======---
Thrash:Run(true)
