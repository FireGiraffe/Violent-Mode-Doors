-- credits to someone on some website i kinda forgot..

local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local CAS = game:GetService("ContextActionService")
local UserInputService = game:GetService("UserInputService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Instances:
local StaminaBar = Instance.new("ScreenGui")
local SideBar = Instance.new("Frame")
local Bar_2 = Instance.new("Frame")

-- Properties:
StaminaBar.Name = "StaminaBar"
StaminaBar.Parent = player:WaitForChild("PlayerGui")
StaminaBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

SideBar.Name = "SideBar"
SideBar.Parent = StaminaBar
SideBar.AnchorPoint = Vector2.new(0, 1)
SideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBar.BorderSizePixel = 4
SideBar.Position = UDim2.new(0.985890269, 0, 1, 0)
SideBar.Size = UDim2.new(0.0141097549, 0, 0.17468825, 0)
SideBar.Visible = true

Bar_2.Name = "Bar"
Bar_2.Parent = SideBar
Bar_2.AnchorPoint = Vector2.new(0, 1)
Bar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
Bar_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar_2.BorderSizePixel = 0
Bar_2.Position = UDim2.new(0, 0, 1, 0)
Bar_2.Size = UDim2.new(1, 0, 1, 0)

-- Mobile Sprint Button Instance
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
	local stamTick = 0.5
	local baseRegenTick = 0.25
	local regenTick = baseRegenTick
	local isExhausted = false

	local sprinting = false
	local DEF = 15
	local Walkspeed2 = DEF

	local function showExhaustedCaption()
		pcall(function()
			require(player.PlayerGui.MainUI.Initiator.Main_Game).caption("You're exausted.", true)
		end)
	end

	local function startSprinting()
		if isExhausted or stamPower <= 0 or sprinting then
			return
		end

		DEF = char.Humanoid.WalkSpeed
		Walkspeed2 = DEF + 5
		char.Humanoid.WalkSpeed = Walkspeed2
		sprinting = true
		Started = true

		ButtonStroke.Color = Color3.fromRGB(255, 255, 0)

		while stamPower > 0 and sprinting do
			SideBar.Bar.Size = UDim2.new(1, 0, stamPower / 100, 0)
			stamPower = stamPower - stamTick

			task.wait()

			if stamPower <= 0 then
				stamPower = 0
				SideBar.Bar.Size = UDim2.new(1, 0, 0, 0)

				isExhausted = true
				regenTick = baseRegenTick / 2
				showExhaustedCaption()

				Walkspeed2 = DEF
				char.Humanoid.WalkSpeed = Walkspeed2
				sprinting = false
				Started = false
				ButtonStroke.Color = Color3.fromRGB(255, 50, 50)
			end
		end
	end

	local function stopSprinting()
		if not sprinting then return end

		Walkspeed2 = DEF
		char.Humanoid.WalkSpeed = Walkspeed2
		sprinting = false
		Started = false

		if not isExhausted then
			ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
		end

		while stamPower <= 100 and not sprinting do
			stamPower = stamPower + regenTick

			if stamPower >= 100 then
				stamPower = 100
				isExhausted = false
				regenTick = baseRegenTick
				ButtonStroke.Color = Color3.fromRGB(255, 255, 255)
			end

			SideBar.Bar.Size = UDim2.new(1, 0, stamPower / 100, 0)
			task.wait()
		end
	end

	function sprint(name, IS, context)
		if IS == Enum.UserInputState.Begin then
			startSprinting()
		elseif IS == Enum.UserInputState.End then
			stopSprinting()
		end
	end

	-- Touch inputs for Mobile
	MobileSprintButton.MouseButton1Down:Connect(function()
		startSprinting()
	end)

	MobileSprintButton.MouseButton1Up:Connect(function()
		stopSprinting()
	end)

	char.Changed:Connect(function()
		if player.Character and player.Character:FindFirstChild("Humanoid") then
			if player.Character.Humanoid.WalkSpeed ~= Walkspeed2 and player.Character.Humanoid.WalkSpeed ~= 10 then
				DEF = player.Character.Humanoid.WalkSpeed
				if sprinting and not isExhausted then
					Walkspeed2 = DEF + 5
					player.Character.Humanoid.WalkSpeed = Walkspeed2
				end
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
