-- Final Script for NDS UI made by Exploding Car
-- Using Kavo UI Library with Dark Purple Theme and Smooth Animations

local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Natural Disaster Survival | Made By Exploding Car", "Midnight")

-- NDS Tab and Setup
local NDS = Window:NewTab("NDS")
local NDSSection = NDS:NewSection("Natural Disaster Survival")

-- Tornado Tab Setup
local TornadoTab = Window:NewTab("Tornado")
local TornadoSection = TornadoTab:NewSection("Tornado Settings")

-- Add tornado pattern options here
local function SetTornadoPattern()
    -- Function to set tornado patterns
    -- Example: You could add patterns here, specific to your tornado behavior.
end

TornadoSection:NewButton("Start Tornado", "Start the tornado effect", function()
    -- Code to start tornado
    SetTornadoPattern()
end)

TornadoSection:NewButton("Stop Tornado", "Stop the tornado effect", function()
    -- Code to stop tornado
end)

-- Fun Tab Wacky FE Scripts
local FunTab = Window:NewTab("Fun")
local FunSection = FunTab:NewSection("Wacky FE Scripts")

-- FE Spin
local function FeSpin()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            while true do
                humanoid.RootPart.CFrame = humanoid.RootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
                wait(0.1)
            end
        end
    end
end

-- FE Head Stretch
local function FeHeadStretch()
    local character = game.Players.LocalPlayer.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            head.Size = Vector3.new(10, 10, 10)
        end
    end
end

-- FE Shrink Body
local function FeShrinkBody()
    local character = game.Players.LocalPlayer.Character
    if character then
        character:SetPrimaryPartCFrame(character.PrimaryPart.CFrame * CFrame.new(0, -10, 0))
        for _, part in pairs(character:GetChildren()) do
            if part:IsA("BasePart") then
                part.Size = part.Size * 0.5
            end
        end
    end
end

-- Add buttons to fun tab
FunSection:NewButton("FE Spin", "Spin your character", FeSpin)
FunSection:NewButton("FE Head Stretch", "Stretch your character's head", FeHeadStretch)
FunSection:NewButton("FE Shrink Body", "Shrink your character's body", FeShrinkBody)

-- Credits Tab Setup
local CreditsTab = Window:NewTab("Credits")
local CreditsSection = CreditsTab:NewSection("Credits")

CreditsSection:NewLabel("Made By Exploding Car")
CreditsSection:NewLabel("Powered by Kavo UI Library")

-- Button Functions (R6/R15 Smart Detection)
local function CreateButton(name, callback)
    -- Button creation code, based on UI library used
    local button = Instance.new("TextButton")
    button.Text = name
    button.Size = UDim2.new(0, 200, 0, 50)
    button.MouseButton1Click:Connect(callback)
    return button
end

-- Function to handle "Don't Click" button with folding body animation (works for both R6 and R15)
local function DontClick()
    local character = game.Players.LocalPlayer.Character
    if character then
        local humanoid = character:FindFirstChildOfClass("Humanoid")
        if humanoid then
            humanoid.WalkSpeed = 0
            local rootPart = character:FindFirstChild("HumanoidRootPart")
            if rootPart then
                local foldDirection = Vector3.new(0, -0.1, 0)
                while true do
                    rootPart.CFrame = rootPart.CFrame * CFrame.new(foldDirection)
                    for _, part in pairs(character:GetChildren()) do
                        if part:IsA("BasePart") then
                            part.Size = part.Size * 0.95
                        end
                    end
                    wait(0.1)
                end
            end
        end
    end
end

-- Add the "Don't Click" button
FunSection:NewButton("Don't Click", "Clicking this will fold your body in on itself", DontClick)

-- End of Script Content (add additional FE functions or any more tabs here as needed)
