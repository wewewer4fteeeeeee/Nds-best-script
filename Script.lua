-- Load Kavo UI
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()

-- Loading Message
print("Loading ExplodingCar's Script...")

-- Services
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local mouse = LocalPlayer:GetMouse()

-- Sound Setup
local popSound = Instance.new("Sound")
popSound.SoundId = "rbxassetid://7415640695" -- Glass breaking sound
popSound.Volume = 1
popSound.Parent = game.SoundService

-- UI Setup
local Window = KavoUI.CreateLib("Natural Disaster Survival | ExplodingCar", "DarkTheme")

-- NDS Tab
local NDSTab = Window:NewTab("NDS")
local NDSSection = NDSTab:NewSection("Tools")

NDSSection:NewButton("Steal Balloon", "Steals a balloon", function()
    local targetPlayer = Players:FindFirstChild("TargetPlayerName") -- change to your target
    if targetPlayer and targetPlayer.Backpack:FindFirstChild("GreenBalloon") then
        local balloonCopy = targetPlayer.Backpack.GreenBalloon:Clone()
        balloonCopy.Parent = LocalPlayer.Backpack
    end
end)

NDSSection:NewButton("Play Balloon Anim", "Float Animation", function()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        local anim = game.ReplicatedStorage:WaitForChild("BalloonFloatAnimationR15")
        humanoid:LoadAnimation(anim):Play()
    end
end)

NDSSection:NewButton("Play Apple Eating Anim", "Eat Apple Animation", function()
    local humanoid = LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("Humanoid")
    if humanoid then
        local anim = game.ReplicatedStorage:WaitForChild("AppleEatAnimR15")
        humanoid:LoadAnimation(anim):Play()
    end
end)

NDSSection:NewButton("Fling Unanchored", "Fling loose parts", function()
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(math.random(-5000,5000), math.random(1000,5000), math.random(-5000,5000))
            bv.Parent = part
            game.Debris:AddItem(bv, 0.5)
        end
    end
end)

NDSSection:NewButton("Fling Tool", "Spawn a Fling Tool", function()
    local tool = Instance.new("Tool")
    tool.RequiresHandle = false
    tool.Name = "Fling Tool"
    tool.Parent = LocalPlayer.Backpack
    tool.Activated:Connect(function()
        local obj = mouse.Target
        if obj and obj:IsA("BasePart") then
            local bv = Instance.new("BodyVelocity")
            bv.MaxForce = Vector3.new(1e6, 1e6, 1e6)
            bv.Velocity = Vector3.new(math.random(-5000,5000), math.random(1000,5000), math.random(-5000,5000))
            bv.Parent = obj
            game.Debris:AddItem(bv, 0.5)
        end
    end)
end)

-- Tornado Tab
local TornadoTab = Window:NewTab("Tornado")
local TornadoSection = TornadoTab:NewSection("Tornado Settings")

-- Tornado Variables
local tornadoActive = false
local tornadoHeight = 40
local tornadoSpeed = 2
local tornadoWidth = 10
local tornadoPattern = "Default"

-- Sliders
TornadoSection:NewSlider("Height", "Height above head", 100, 40, function(val)
    tornadoHeight = val
end)

TornadoSection:NewSlider("Speed", "Spin speed", 10, 2, function(val)
    tornadoSpeed = val
end)

TornadoSection:NewSlider("Width", "How wide", 50, 10, function(val)
    tornadoWidth = val
end)

-- Pattern Buttons
TornadoSection:NewButton("Pattern: Tight Spin", "Small tight tornado", function()
    tornadoPattern = "Tight"
    popSound:Play()
    game.StarterGui:SetCore("SendNotification", {Title = "Hello Monke", Text = "Pattern Set: Tight", Duration = 2})
end)

TornadoSection:NewButton("Pattern: Wide Spin", "Wide tornado", function()
    tornadoPattern = "Wide"
    popSound:Play()
    game.StarterGui:SetCore("SendNotification", {Title = "Hello Monke", Text = "Pattern Set: Wide", Duration = 2})
end)

TornadoSection:NewButton("Pattern: Chaos Spin", "Crazy random tornado", function()
    tornadoPattern = "Chaos"
    popSound:Play()
    game.StarterGui:SetCore("SendNotification", {Title = "Hello Monke", Text = "Pattern Set: Chaos", Duration = 2})
end)

-- Activate Tornado
TornadoSection:NewToggle("Tornado On/Off", "Toggle the tornado", function(state)
    tornadoActive = state
end)

-- Tornado Loop
task.spawn(function()
    while task.wait() do
        if tornadoActive and LocalPlayer.Character and LocalPlayer.Character:FindFirstChild("HumanoidRootPart") then
            for _, part in pairs(workspace:GetDescendants()) do
                if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(LocalPlayer.Character) then
                    local offset = Vector3.new(math.cos(tick() * tornadoSpeed), 0, math.sin(tick() * tornadoSpeed)) * tornadoWidth
                    if tornadoPattern == "Tight" then
                        offset = offset * 0.5
                    elseif tornadoPattern == "Wide" then
                        offset = offset * 1.5
                    elseif tornadoPattern == "Chaos" then
                        offset = Vector3.new(math.random(-tornadoWidth, tornadoWidth), 0, math.random(-tornadoWidth, tornadoWidth))
                    end
                    local goalPos = LocalPlayer.Character.HumanoidRootPart.Position + Vector3.new(0, tornadoHeight, 0) + offset
                    local bp = part:FindFirstChild("BodyPosition") or Instance.new("BodyPosition", part)
                    bp.MaxForce = Vector3.new(9e9,9e9,9e9)
                    bp.Position = goalPos
                end
            end
        end
    end
end)
