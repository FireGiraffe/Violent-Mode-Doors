-- credits to someone on some website i kinda forgot..

local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local CAS = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

local StaminaBar = Instance.new("ScreenGui")
local SideBar = Instance.new("Frame")
local Bar_2 = Instance.new("Frame")

local NORMAL_COLOR = Color3.fromRGB(0, 210, 255)
local EXHAUSTED_COLOR = Color3.fromRGB(255, 60, 60)

StaminaBar.Name = "StaminaBar"
StaminaBar.Parent = player:WaitForChild("PlayerGui")
StaminaBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

SideBar.Name = "SideBar"
SideBar.Parent = StaminaBar
SideBar.AnchorPoint = Vector2.new(0, 1)
SideBar.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBar.BorderSizePixel = 3
SideBar.Position = UDim2.new(0.98, 0, 0.95, 0)
SideBar.Size = UDim2.new(0.012, 0, 0.2, 0)
SideBar.Visible = true

Bar_2.Name = "Bar"
Bar_2.Parent = SideBar
Bar_2.AnchorPoint = Vector2.new(0, 1)
Bar_2.BackgroundColor3 = NORMAL_COLOR
Bar_2.BorderSizePixel = 0
Bar_2.Position = UDim2.new(0, 0, 1, 0)
Bar_2.Size = UDim2.new(1, 0, 1, 0)

local MobileSprintButton = Instance.new("ImageButton")
local ButtonCorner = Instance.new("UICorner")
local ButtonStroke = Instance.new("UIStroke")
local ButtonText = Instance.new("TextLabel")

MobileSprintButton.Name = "MobileSprintButton"
MobileSprintButton.Parent = StaminaBar
MobileSprintButton.AnchorPoint = Vector2.new(1, 1)
MobileSprintButton.Position = UDim2.new(0.95, 0, 0.78, 0)
MobileSprintButton.Size = UDim2.new(0, 65, 0, 65)
MobileSprintButton.BackgroundColor3 = Color3.fromRGB(20, 20, 20)
MobileSprintButton.BackgroundTransparency = 0.3
MobileSprintButton.Visible = UserInputService.TouchEnabled

ButtonCorner.CornerRadius = UDim.new(1, 0)
ButtonCorner.Parent = MobileSprintButton

ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
ButtonStroke.Thickness = 2
ButtonStroke.ApplyStrokeMode = Enum.ApplyStrokeMode.Border
ButtonStroke.Parent = MobileSprintButton

ButtonText.Name = "Label"
ButtonText.Parent = MobileSprintButton
ButtonText.BackgroundTransparency = 1
ButtonText.Size = UDim2.new(1, 0, 1, 0)
ButtonText.Font = Enum.Font.GothamBold
ButtonText.Text = "RUN"
ButtonText.TextColor3 = Color3.fromRGB(255, 255, 255)
ButtonText.TextSize = 16

local Started = false

function QCHWWK_fake_script()
	local bind1 = Enum.KeyCode.LeftShift
	local bind2 = Enum.KeyCode.RightShift

	local char = player.Character or player.CharacterAdded:Wait()

	local stamPower = 100
	local stamTick = 0.6
	local baseRegenTick = 0.35
	local isExhausted = false

	local wantSprint = false
	local sprinting = false
	local DEF = 15
	local Walkspeed2 = DEF

	local function showExhaustedCaption()
		pcall(function()
			require(player.PlayerGui.MainUI.Initiator.Main_Game).caption("You're exhausted.", true)
		end)
	end

	local function updateSpeed()
		if not char or not char:FindFirstChild("Humanoid") then return end
		if sprinting then
			char.Humanoid.WalkSpeed = DEF + 5
		else
			char.Humanoid.WalkSpeed = DEF
		end
		Walkspeed2 = char.Humanoid.WalkSpeed
	end
	task.spawn(function()
		while true do
			local currentHumanoid = char:FindFirstChild("Humanoid")
			local isMoving = currentHumanoid and currentHumanoid.MoveDirection.Magnitude > 0
			if wantSprint and not isExhausted and stamPower > 0 and isMoving then
				sprinting = true
				Started = true
				stamPower = math.clamp(stamPower - stamTick, 0, 100)

				if stamPower <= 0 then
					isExhausted = true
					sprinting = false
					Started = false
					updateSpeed()
					showExhaustedCaption()
				end
			else
				sprinting = false
				Started = false
				local regenRate = isExhausted and (baseRegenTick * 0.5) or baseRegenTick
				stamPower = math.clamp(stamPower + regenRate, 0, 100)

				if stamPower >= 100 and isExhausted then
					isExhausted = false
				end

				updateSpeed()
			end
				
			Bar_2.Size = UDim2.new(1, 0, stamPower / 100, 0)
			if isExhausted then
				Bar_2.BackgroundColor3 = EXHAUSTED_COLOR
				ButtonStroke.Color = EXHAUSTED_COLOR
			elseif sprinting then
				Bar_2.BackgroundColor3 = NORMAL_COLOR
				ButtonStroke.Color = NORMAL_COLOR
			else
				Bar_2.BackgroundColor3 = NORMAL_COLOR
				ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
			end

			task.wait(0.03)
		end
	end)

	function sprint(name, IS, context)
		if IS == Enum.UserInputState.Begin then
			wantSprint = true
		elseif IS == Enum.UserInputState.End then
			wantSprint = false
		end
	end

	MobileSprintButton.MouseButton1Down:Connect(function()
		wantSprint = true
	end)

	MobileSprintButton.MouseButton1Up:Connect(function()
		wantSprint = false
	end)

	char.Changed:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			local curSpeed = player.Character.Humanoid.WalkSpeed
			if curSpeed ~= Walkspeed2 and curSpeed ~= 10 then
				DEF = curSpeed
				updateSpeed()
			end
		end
	end)

	function updateBobbleEffect()
		local currentTime = tick()
		if Started and humanoid and humanoid.MoveDirection.Magnitude > 0 then
			local bobbleY = math.abs(math.sin(currentTime * 10)) * 0.35
			local bobbleX = math.abs(math.sin(currentTime * 10)) * 0.05
			local bobble = Vector3.new(bobbleX, bobbleY, 0)
			humanoid.CameraOffset = humanoid.CameraOffset:lerp(bobble, 0.75)
		elseif humanoid then
			humanoid.CameraOffset = humanoid.CameraOffset * 0
		end
	end

	runService.RenderStepped:Connect(updateBobbleEffect)

	CAS:BindAction("Sprint", sprint, false, bind1, bind2)
end

coroutine.wrap(QCHWWK_fake_script)()
