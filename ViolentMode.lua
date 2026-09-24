print("Thanks for playing Violent Mode.")

if game.Workspace:FindFirstChild("SeekMovingNewClone") then return end

local isEntitySpawning = false

local function canSpawn(bannedRooms)
    local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value
    local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
    return not bannedRooms[currentRoom] and not isSeekChase and not isEntitySpawning
end

local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

local function queueEntity(minWait, maxWait, url)
    coroutine.wrap(function()
        while true do
            task.wait(math.random(minWait, maxWait))

            game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()

            if canSpawn(bannedRooms) then
                isEntitySpawning = true
                pcall(function()
                    loadstring(game:HttpGet(url))()
                end)
                task.wait(10)
                isEntitySpawning = false
            end
        end
    end)()
end

queueEntity(80, 130, "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Rampage.lua")

queueEntity(120, 180, "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Thrash.lua")

queueEntity(180, 260, "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Wail.lua")

queueEntity(140, 200, "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Paralyze.lua")

queueEntity(220, 320, "https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Multimonster.lua")

local MainGame = require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game)
MainGame.caption("Violent Mode V1.0 Activated", true)
task.wait(2)
MainGame.caption("Made by FireGiraffe, help from jack_thebritishfella and Rip_Silence", true)
task.wait(2)
MainGame.caption("Models by FireGiraffe, jack_thebritishfella, and rebound0193", true)
task.wait(2)
MainGame.caption("And for the multimonster on toolbox yes haha :3", true)
