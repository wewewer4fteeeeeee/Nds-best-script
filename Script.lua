-- // Load Kavo UI
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("NDS Script | Made by Exploding Car 🚗🔥", "DarkTheme")

-- // Variables
local player = game.Players.LocalPlayer
local mouse = player:GetMouse()

local tornadoEnabled = false
local tornadoSpeed = 10
local tornadoWidth = 10
local tornadoHeight = 40
local tornadoPattern = "Normal"
local frozenParts = {}

-- // Sound
local popSound = Instance.new("Sound", player.PlayerGui)
popSound.SoundId = "rbxassetid://7413328055" -- pop sound
popSound.Volume = 1

-- // Notification Function
local function Notify(text)
    game.StarterGui:SetCore("SendNotification", {
        Title = "NDS Script",
        Text = text,
        Duration = 5
    })
    popSound:Play()
end

-- // Tornado Logic
game:GetService("RunService").Heartbeat:Connect(function()
    if tornadoEnabled then
        local t = tick()
        for _, part in pairs(frozenParts) do
            if part and part.Parent then
                local angle = t * tornadoSpeed
                local offsetX, offsetZ

                if tornadoPattern == "Normal" then
                    offsetX = math.cos(angle) * tornadoWidth
                    offsetZ = math.sin(angle) * tornadoWidth
                elseif tornadoPattern == "Reverse" then
                    offsetX = math.cos(-angle) * tornadoWidth
                    offsetZ = math.sin(-angle) * tornadoWidth
                elseif tornadoPattern == "Spiral Up" then
                    offsetX = math.cos(angle) * tornadoWidth
                    offsetZ = math.sin(angle) * tornadoWidth
                    tornadoHeight = tornadoHeight + 0.05
                elseif tornadoPattern == "Spiral Down" then
                    offsetX = math.cos(angle) * tornadoWidth
                    offsetZ = math.sin(angle) * tornadoWidth
                    tornadoHeight = tornadoHeight - 0.05
                elseif tornadoPattern == "Chaos" then
                    offsetX = math.random(-tornadoWidth, tornadoWidth)
                    offsetZ = math.random(-tornadoWidth, tornadoWidth)
                end

                local newPos = player.Character.HumanoidRootPart.Position + Vector3.new(offsetX, tornadoHeight, offsetZ)
                if part:FindFirstChild("BodyPosition") then
                    part.BodyPosition.Position = newPos
                end
            end
        end
    end
end)

-- // Functions
local function StartTornado()
    frozenParts = {}
    for _, part in pairs(workspace:GetDescendants()) do
        if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(player.Character) and not part:FindFirstAncestorWhichIsA("Model") then
            local bodyPos = Instance.new("BodyPosition")
            bodyPos.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
            bodyPos.Position = player.Character.Head.Position
            bodyPos.Parent = part
            table.insert(frozenParts, part)
        end
    end
    Notify("hello faggot")
end

local function StopTornado()
    for _, part in pairs(frozenParts) do
        if part and part:FindFirstChild("BodyPosition") then
            part.BodyPosition:Destroy()
        end
    end
    frozenParts = {}
    Notify("Tornado stopped 🛑")
end

-- // UI Tabs
local TornadoTab = Window:NewTab("Tornado 🌪️")
local TornadoSection = TornadoTab:NewSection("Control")

TornadoSection:NewButton("Start Tornado", "Summon the tornado", function()
    StartTornado()
    tornadoEnabled = true
end)

TornadoSection:NewButton("Stop Tornado", "Stop the tornado", function()
    tornadoEnabled = false
    StopTornado()
end)

TornadoSection:NewDropdown("Spin Pattern", "Choose tornado pattern", {"Normal", "Reverse", "Spiral Up", "Spiral Down", "Chaos"}, function(option)
    tornadoPattern = option
    Notify("Pattern: " .. option)
end)

TornadoSection:NewSlider("Spin Speed", "Change tornado spin speed", 50, 1, function(value)
    tornadoSpeed = value
    Notify("Spin Speed: " .. value)
end)

TornadoSection:NewSlider("Width", "Change tornado width", 100, 5, function(value)
    tornadoWidth = value
    Notify("Width: " .. value)
end)

TornadoSection:NewSlider("Height", "Change tornado height", 100, 10, function(value)
    tornadoHeight = value
    Notify("Height: " .. value)
end)

local NDSTab = Window:NewTab("NDS Fun 🎉")
local NDSSection = NDSTab:NewSection("More coming soon twin 🔥")

NDSSection:NewButton("Pop Sound", "Plays the pop sound", function()
    popSound:Play()
    Notify("Pop sound played")
end)
