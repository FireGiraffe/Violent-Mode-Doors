print("Thanks for playing Violent Mode.")
loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Sprint.lua"))()

if game.Workspace:FindFirstChild("SeekMovingNewClone") then return end

coroutine.wrap(function()
    while true do
        task.wait(100)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Rampage.lua"))()
        end
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(155)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Thrash.lua"))()
        end
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(230)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Wail.lua"))()
        end
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(155)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Paralyze.lua"))()
        end
    end
end)()

coroutine.wrap(function()
    while true do
        task.wait(230)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Multimonster.lua"))()
        end
    end
end)()

require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Violent Mode V1.0 Activated",true)
task.wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Made by FireGiraffe, help from jack_thebritishfella and Rip_Silence",true)
task.wait(2)
require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Models by FireGiraffe, jack_thebritishfella, and rebound0193",true)
