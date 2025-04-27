-- Natural Disaster Survival Script Made By Exploding Car

repeat task.wait() until game:IsLoaded()

-- Loading Rayfield UI Library
loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local debris = game:GetService("Debris")
local replicatedStorage = game:GetService("ReplicatedStorage")

local tornadoActive = false
local tornadoSpeed = 5
local tornadoWidth = 20
local tornadoHeight = 40
local pattern = "Circle"

local function notify(title, content)
	Rayfield:Notify({
		Title = title,
		Content = content,
		Duration = 4,
		Image = nil,
		Actions = {},
	})
end

-- Tornado Control
local function spinTornado()
	while tornadoActive do
		for _, part in ipairs(workspace:GetDescendants()) do
			if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
				local head = player.Character and player.Character:FindFirstChild("Head")
				if head then
					local t = tick() * tornadoSpeed
					local offsetX = 0
					local offsetZ = 0

					if pattern == "Circle" then
						offsetX = math.cos(t) * tornadoWidth
						offsetZ = math.sin(t) * tornadoWidth
					elseif pattern == "Wave" then
						offsetX = math.cos(t) * tornadoWidth
						offsetZ = math.sin(t * 0.5) * tornadoWidth
					elseif pattern == "Figure8" then
						offsetX = math.sin(t) * tornadoWidth
						offsetZ = math.sin(t * 2) * tornadoWidth
					end

					local goalPosition = head.Position + Vector3.new(offsetX, tornadoHeight, offsetZ)

					local bp = part:FindFirstChild("BodyPosition") or Instance.new("BodyPosition", part)
					bp.MaxForce = Vector3.new(1e6, 1e6, 1e6)
					bp.Position = goalPosition
				end
			end
		end
		task.wait()
	end
end

-- Other Powers
local function flingUnanchored()
	for _, part in ipairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and not part.Anchored then
			local bv = Instance.new("BodyVelocity")
			bv.Velocity = Vector3.new(math.random(-5000,5000), math.random(1000,5000), math.random(-5000,5000))
			bv.MaxForce = Vector3.new(1e6,1e6,1e6)
			bv.Parent = part
			debris:AddItem(bv, 0.5)
		end
	end
	notify("Fling Unanchored", "Objects have been flung!")
end

local function playBalloonAnim()
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid then
		local anim = replicatedStorage:FindFirstChild("BalloonFloatAnimationR15") or replicatedStorage:FindFirstChild("BalloonFloatAnimationR6")
		if anim then
			humanoid:LoadAnimation(anim):Play()
		end
	end
end

local function playAppleAnim()
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid then
		local anim = replicatedStorage:FindFirstChild("AppleEatAnimR15") or replicatedStorage:FindFirstChild("AppleEatAnimR6")
		if anim then
			humanoid:LoadAnimation(anim):Play()
		end
	end
end

local function stealBalloon()
	local targetPlayer = game.Players:FindFirstChild("TargetPlayerName") -- set target manually or modify to choose
	if targetPlayer then
		local balloon = targetPlayer.Backpack:FindFirstChild("GreenBalloon")
		if balloon then
			local copy = balloon:Clone()
			copy.Parent = player.Backpack
			notify("Balloon Stolen!", "Successfully stole a balloon.")
		else
			notify("Failed", "Target has no balloon.")
		end
	else
		notify("Error", "Target player not found.")
	end
end

-- GUI Setup
local Window = Rayfield:CreateWindow({
	Name = "Natural Disaster Survival Script",
	LoadingTitle = "Exploding Car Presents",
	LoadingSubtitle = "Natural Disaster Survival Script",
	ConfigurationSaving = {
		Enabled = false,
	},
	Discord = {
		Enabled = false,
	},
	KeySystem = false,
})

local TornadoTab = Window:CreateTab("🌪️ Tornado Control", 4483362458)

TornadoTab:CreateToggle({
	Name = "Tornado On/Off",
	CurrentValue = false,
	Callback = function(Value)
		tornadoActive = Value
		if tornadoActive then
			task.spawn(spinTornado)
			notify("Tornado Activated", "Tornado is now spinning!")
		else
			notify("Tornado Deactivated", "Tornado stopped.")
		end
	end,
})

TornadoTab:CreateDropdown({
	Name = "Tornado Pattern",
	Options = {"Circle", "Wave", "Figure8"},
	CurrentOption = "Circle",
	Callback = function(Option)
		pattern = Option
		notify("Pattern Changed", "Tornado Pattern: " .. pattern)
	end,
})

TornadoTab:CreateSlider({
	Name = "Spin Speed",
	Range = {1, 20},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 5,
	Callback = function(Value)
		tornadoSpeed = Value
	end,
})

TornadoTab:CreateSlider({
	Name = "Tornado Width",
	Range = {5, 100},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 20,
	Callback = function(Value)
		tornadoWidth = Value
	end,
})

TornadoTab:CreateSlider({
	Name = "Tornado Height",
	Range = {10, 100},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 40,
	Callback = function(Value)
		tornadoHeight = Value
	end,
})

local NDSTab = Window:CreateTab("🌀 NDS Powers", 4483362458)

NDSTab:CreateButton({
	Name = "Fling Unanchored",
	Callback = flingUnanchored,
})

NDSTab:CreateButton({
	Name = "Play Balloon Float Animation",
	Callback = playBalloonAnim,
})

NDSTab:CreateButton({
	Name = "Play Apple Eating Animation",
	Callback = playAppleAnim,
})

NDSTab:CreateButton({
	Name = "Steal Balloon",
	Callback = stealBalloon,
})

-- Button Sound Effect
local function setupButtonSounds()
	for _, button in pairs(game:GetDescendants()) do
		if button:IsA("TextButton") then
			button.MouseButton1Click:Connect(function()
				local sound = Instance.new("Sound")
				sound.SoundId = "rbxassetid://9121446290" -- pop sound
				sound.Volume = 2
				sound.Parent = player:WaitForChild("PlayerGui")
				sound:Play()
				debris:AddItem(sound, 1)
			end)
		end
	end
end

setupButtonSounds()

notify("NDS Script Loaded!", "Enjoy! Made by Exploding Car")
