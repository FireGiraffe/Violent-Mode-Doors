require(game.Players.LocalPlayer.PlayerGui.MainUI.Initiator.Main_Game).caption("Violent Mode Activated/nMade By FireGiraffe/nModels by FireGiraffe, jack_thebritishfella, and rebound0193",true)
print("Thanks for playing Violent Mode.")

if game.Workspace:FindFirstChild("SeekMovingNewClone") then return end

coroutine.wrap(function()
    while true do
        task.wait(90)

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
        task.wait(135)

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
        task.wait(170)

        game.ReplicatedStorage.GameData.LatestRoom.Changed:Wait()
        local currentRoom = game.ReplicatedStorage.GameData.LatestRoom.Value

        local isSeekChase = workspace:FindFirstChild("SeekMovingNewClone", true) ~= nil
        local bannedRooms = { [49] = true, [50] = true, [51] = true, [99] = true, [100] = true }

        if not bannedRooms[currentRoom] and not isSeekChase then
            loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Wail.lua"))()
        end
    end
end)()

task.wait(15)
loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/refs/heads/main/Sprint.lua"))()
