--// Natural Disaster Survival Script Made By Exploding Car

-- Rayfield UI
loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()

local Rayfield = loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()

local player = game.Players.LocalPlayer
local mouse = player:GetMouse()
local tornadoActive = false
local spinSpeed = 5
local tornadoWidth = 10
local tornadoHeight = 40
local pattern = "Normal"

local frozenParts = {}

function Notify(title, content, duration)
	game.StarterGui:SetCore("SendNotification", {
		Title = title,
		Text = content,
		Duration = duration or 5
	})
end

function CreateTornado()
	while tornadoActive do
		for _, part in pairs(workspace:GetDescendants()) do
			if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
				if not table.find(frozenParts, part) then
					local bodyPosition = Instance.new("BodyPosition", part)
					bodyPosition.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
					table.insert(frozenParts, part)
				end
			end
		end

		local tickTime = tick()
		for _, part in pairs(frozenParts) do
			if part and part.Parent then
				local angle = (tickTime * spinSpeed) + (part.Position.X + part.Position.Z) / 5
				local radius = tornadoWidth
				local heightOffset = math.sin(tickTime + (part.Position.X / 10)) * 5
				local x = math.cos(angle) * radius
				local z = math.sin(angle) * radius
				local y = tornadoHeight + heightOffset

				if part:FindFirstChildOfClass("BodyPosition") then
					part.BodyPosition.Position = player.Character.Head.Position + Vector3.new(x, y, z)
				end
			end
		end
		task.wait(0.03)
	end
end

function StopTornado()
	for _, part in pairs(frozenParts) do
		if part and part:FindFirstChildOfClass("BodyPosition") then
			part.BodyPosition:Destroy()
		end
	end
	table.clear(frozenParts)
end

function FlingUnanchored()
	for _, part in pairs(workspace:GetDescendants()) do
		if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) then
			local bv = Instance.new("BodyVelocity", part)
			bv.Velocity = Vector3.new(math.random(-5000,5000), math.random(1000,5000), math.random(-5000,5000))
			bv.MaxForce = Vector3.new(1e9,1e9,1e9)
			game.Debris:AddItem(bv, 0.5)
		end
	end
end

function StartBalloonAnim()
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid then
		local anim = humanoid.RigType == Enum.HumanoidRigType.R15 and ReplicatedStorage:WaitForChild("BalloonFloatAnimationR15") or ReplicatedStorage:WaitForChild("BalloonFloatAnimationR6")
		humanoid:LoadAnimation(anim):Play()
	end
end

function StartAppleAnim()
	local humanoid = player.Character and player.Character:FindFirstChild("Humanoid")
	if humanoid then
		local anim = humanoid.RigType == Enum.HumanoidRigType.R15 and ReplicatedStorage:WaitForChild("AppleEatAnimR15") or ReplicatedStorage:WaitForChild("AppleEatAnimR6")
		humanoid:LoadAnimation(anim):Play()
	end
end

function StealBalloon()
	local targetPlayer = game.Players:FindFirstChild("TargetPlayerName")
	if targetPlayer and targetPlayer.Backpack:FindFirstChild("GreenBalloon") then
		local clone = targetPlayer.Backpack.GreenBalloon:Clone()
		clone.Parent = player.Backpack
		Notify("Balloon Stolen!", "You stole a balloon!", 5)
	else
		Notify("Error", "Target player doesn't have a balloon!", 5)
	end
end

-- GUI Setup
local Window = Rayfield:CreateWindow({
	Name = "NDS Script | Made By Exploding Car",
	LoadingTitle = "Natural Disaster Survival Script",
	LoadingSubtitle = "Made by Exploding Car 🚗💥",
	ConfigurationSaving = {
		Enabled = true,
		FolderName = "NDSSaveData",
		FileName = "ExplodingCarNDS"
	},
	KeySystem = false,
})

local TornadoTab = Window:CreateTab("🌪️ Tornado Control", nil)

local NdsTab = Window:CreateTab("🛠️ NDS Fun Stuff", nil)

-- Tornado Controls
TornadoTab:CreateToggle({
	Name = "Enable Tornado",
	CurrentValue = false,
	Callback = function(Value)
		tornadoActive = Value
		if tornadoActive then
			Notify("Tornado Active!", "Tornado Started!", 5)
			task.spawn(CreateTornado)
		else
			StopTornado()
			Notify("Tornado Stopped", "Tornado has been disabled.", 5)
		end
	end,
})

TornadoTab:CreateSlider({
	Name = "Spin Speed",
	Range = {1, 20},
	Increment = 1,
	Suffix = "Speed",
	CurrentValue = 5,
	Callback = function(Value)
		spinSpeed = Value
	end,
})

TornadoTab:CreateSlider({
	Name = "Tornado Width",
	Range = {5, 50},
	Increment = 1,
	Suffix = "Studs",
	CurrentValue = 10,
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

-- NDS Stuff
NdsTab:CreateButton({
	Name = "Fling Unanchored Parts",
	Callback = function()
		FlingUnanchored()
		Notify("Fling Activated", "All unanchored parts flung!", 5)
	end,
})

NdsTab:CreateButton({
	Name = "Start Balloon Animation",
	Callback = function()
		StartBalloonAnim()
		Notify("Balloon Float", "Balloon animation started.", 5)
	end,
})

NdsTab:CreateButton({
	Name = "Start Apple Eating Animation",
	Callback = function()
		StartAppleAnim()
		Notify("Apple Eating", "Apple eating animation started.", 5)
	end,
})

NdsTab:CreateButton({
	Name = "Steal Balloon",
	Callback = function()
		StealBalloon()
	end,
})

