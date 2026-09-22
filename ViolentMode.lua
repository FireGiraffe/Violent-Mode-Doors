local Spawner = loadstring(game:HttpGet("https://raw.githubusercontent.com/RegularVynixu/DOORS-Entity-Spawner-V2/main/init.luau"))()

local Players = game:GetService("Players")
local player = Players.LocalPlayer

local lastRoom = 0
local minDoor = 5
local spawnChance = 0.38
local cooldownDoors = 6
local nextAllowedDoor = 0

local function isSeekChase()
	for _, room in pairs(workspace.CurrentRooms:GetChildren()) do
		if room:IsA("Model") then
			local name = room.Name:lower()
			if name:find("seek") or name:find("grandhallway") or name:find("cavern") or name:find("sewage") then
				return true
			end

			if room:FindFirstChild("Seek") or room:FindFirstChild("Seek_Moving") or room:FindFirstChild("SeekArm") then
				return true
			end
		end
	end

	if workspace:FindFirstChild("Seek") or workspace:FindFirstChild("Seek_Moving") then
		return true
	end

	return false
end

local function onDoorOpened()
	local currentRoom = player:GetAttribute("CurrentRoom") or 0

	if currentRoom < minDoor then return end
	if currentRoom == lastRoom then return end
	lastRoom = currentRoom

	if currentRoom == 50 or currentRoom == 100 then
		return
	end

	if isSeekChase() then
		return
	end

	if currentRoom < nextAllowedDoor then
		return
	end

	if math.random() > spawnChance then return end

	local choice = math.random(1, 3)

	if choice == 1 then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/main/Rampage.lua"))()
	elseif choice == 2 then
		loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/main/Thrash.lua"))()
	else
		loadstring(game:HttpGet("https://raw.githubusercontent.com/FireGiraffe/Violent-Mode-Doors/main/Wail.lua"))()
	end

	nextAllowedDoor = currentRoom + cooldownDoors
end

workspace.CurrentRooms.ChildAdded:Connect(function()
	task.wait(0.35)
	onDoorOpened()
end)

task.spawn(function()
	while true do
		task.wait(1.8)
		onDoorOpened()
	end
end)
