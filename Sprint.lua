-- credits to someone on some website i kinda forgot..

local runService = game:GetService("RunService")
local Players = game:GetService("Players")
local CAS = game:GetService("ContextActionService")

local player = Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()
local humanoid = character:WaitForChild("Humanoid")

-- Instances:
local StaminaBar = Instance.new("ScreenGui")
local Border = Instance.new("Frame")
local Bar = Instance.new("Frame")
local SideBar = Instance.new("Frame")
local Bar_2 = Instance.new("Frame")

-- Properties:
StaminaBar.Name = "StaminaBar"
StaminaBar.Parent = player:WaitForChild("PlayerGui")
StaminaBar.ZIndexBehavior = Enum.ZIndexBehavior.Sibling

Border.Name = "Border"
Border.Parent = StaminaBar
Border.AnchorPoint = Vector2.new(0, 1)
Border.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
Border.BorderColor3 = Color3.fromRGB(0, 0, 0)
Border.BorderSizePixel = 4
Border.Position = UDim2.new(0.25, 0, 0.85, 0)
Border.Size = UDim2.new(0.6, 0, 0.0263093561, 0)

Bar.Name = "Bar"
Bar.Parent = Border
Bar.AnchorPoint = Vector2.new(0, 1)
Bar.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
Bar.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar.BorderSizePixel = 0
Bar.Position = UDim2.new(0, 0, 1, 0)
Bar.Size = UDim2.new(1, 0, 1, 0)

SideBar.Name = "SideBar"
SideBar.Parent = StaminaBar
SideBar.AnchorPoint = Vector2.new(0, 1)
SideBar.BackgroundColor3 = Color3.fromRGB(255, 255, 255)
SideBar.BorderColor3 = Color3.fromRGB(0, 0, 0)
SideBar.BorderSizePixel = 4
SideBar.Position = UDim2.new(0.985890269, 0, 1, 0)
SideBar.Size = UDim2.new(0.0141097549, 0, 0.17468825, 0)
SideBar.Visible = false

Bar_2.Name = "Bar"
Bar_2.Parent = SideBar
Bar_2.AnchorPoint = Vector2.new(0, 1)
Bar_2.BackgroundColor3 = Color3.fromRGB(255, 255, 0)
Bar_2.BorderColor3 = Color3.fromRGB(0, 0, 0)
Bar_2.BorderSizePixel = 0
Bar_2.Position = UDim2.new(0, 0, 1, 0)
Bar_2.Size = UDim2.new(1, 0, 1, 0)

local Started = false
local OO = 0

function QCHWWK_fake_script()
	local script = Instance.new("LocalScript", StaminaBar)
	local Bool = Instance.new("NumberValue", script.Parent)
	Bool.Name = "Dissapear"

	script.Parent.Dissapear.Changed:Connect(function(Value)
		for _, v in pairs(script:GetChildren()) do
			v:Destroy()
		end

		local A = Instance.new("Part")
		A.Parent = script
		A.Name = "Keep" .. tick() .. game.JobId .. player.Name

		Border.Visible = true
		SideBar.Visible = false
		task.wait(1)
		if script:FindFirstChild(A.Name) then
			OO = 0
			repeat
				task.wait(1)
				OO = OO + 1
			until Value > OO or not script:FindFirstChild(A.Name)

			if script:FindFirstChild(A.Name) then
				Border.Visible = false
				SideBar.Visible = true
			end
		end
	end)

	local bind1 = Enum.KeyCode.LeftShift
	local bind2 = Enum.KeyCode.RightShift

	local char = player.Character or player.CharacterAdded:Wait()
	local bar = script.Parent.Border.Bar

	local stamPower = 100
	local stamTick = 0.6 -- Lowered: Drains slower so sprinting lasts longer
	local regenTick = 0.25 -- Lowered: Takes longer to regenerate stamina

	local sprinting = false
	local DEF = 15
	local Walkspeed2 = DEF

	function sprint(name, IS, context)
		if IS == Enum.UserInputState.Begin then
			if not sprinting then
				DEF = char.Humanoid.WalkSpeed
			end

			script.Parent.Dissapear.Value = 999999999999999999999999999999999999999999999999999999999999999999999
			Walkspeed2 = DEF + 5
			char.Humanoid.WalkSpeed = Walkspeed2
			sprinting = true

			while stamPower > 0 and sprinting do
				if not Started then
					script.Parent.Dissapear.Value = 991291291291291291291289129129129129129129129129129129129129129
					Started = true
				end

				bar.Size = UDim2.new(stamPower / 100, 0, 1, 0)
				SideBar.Bar.Size = UDim2.new(1, 0, stamPower / 100, 0)
				bar.Visible = true
				SideBar.Bar.Visible = true
				stamPower = stamPower - stamTick

				task.wait()
				if stamPower <= 0 then
					bar.Visible = false
					Walkspeed2 = DEF
					char.Humanoid.WalkSpeed = Walkspeed2
					Started = false
					script.Parent.Dissapear.Value = 10
					stamPower = 0
				end
			end
		elseif IS == Enum.UserInputState.End then
			if stamPower < 1 then
				bar.Visible = false
				SideBar.Bar.Visible = false
			else
				bar.Visible = true
				SideBar.Bar.Visible = true
			end

			Walkspeed2 = DEF
			char.Humanoid.WalkSpeed = Walkspeed2
			sprinting = false

			while stamPower <= 100 and not sprinting do
				stamPower = stamPower + regenTick
				if stamPower > 100 then
					stamPower = 100
				end

				if stamPower < 1 then
					bar.Visible = false
					SideBar.Bar.Visible = false
				else
					bar.Visible = true
					SideBar.Bar.Visible = true
				end

				bar.Size = UDim2.new(stamPower / 100, 0, 1, 0)
				SideBar.Bar.Size = UDim2.new(1, 0, stamPower / 100, 0)

				if Started then
					Started = false
					script.Parent.Dissapear.Value = 10
				end

				task.wait()
			end
		end
	end

	char.Changed:Connect(function()
		if player.Character.Humanoid.WalkSpeed ~= Walkspeed2 and player.Character.Humanoid.WalkSpeed ~= 10 then
			DEF = player.Character.Humanoid.WalkSpeed
			if sprinting then
				Walkspeed2 = DEF + 5
				player.Character.Humanoid.WalkSpeed = DEF
			end
		end
	end)

	function updateBobbleEffect()
		local currentTime = tick()
		if Started then
			if humanoid.MoveDirection.Magnitude > 0 then
				local bobbleY = math.abs(math.sin(currentTime * 10)) * 0.35
				local bobbleX = math.abs(math.sin(currentTime * 10)) * 0.05
				local bobble = Vector3.new(bobbleX, bobbleY, 0)
				humanoid.CameraOffset = humanoid.CameraOffset:lerp(bobble, 0.75)
			else
				humanoid.CameraOffset = humanoid.CameraOffset * 0
			end
		end
	end

	runService.RenderStepped:Connect(updateBobbleEffect)

	CAS:BindAction("Sprint", sprint, true, bind1, bind2)
	CAS:SetPosition("Sprint", UDim2.new(0.7, 0, 0, 0))
	CAS:SetTitle("Sprint", "Shift")
end

coroutine.wrap(QCHWWK_fake_script)()
