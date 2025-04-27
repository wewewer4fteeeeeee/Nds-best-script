-- Load Kavo UI Library and setup the Window
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Natural Disaster Survival | Made By Exploding Car", "Midnight")

-- NDS Tab Setup
local NDS = Window:NewTab("NDS")
local NDSSection = NDS:NewSection("Natural Disaster Survival")

-- Start Random Disaster Button
NDSSection:NewButton("Start Disaster", "Start a random disaster", function()
    game.ReplicatedStorage:WaitForChild("StartRandomDisaster"):FireServer()  -- Fire the event to trigger a random disaster
end)

-- Add your NDS features like Steal Balloon, Apple Animation, etc.
NDSSection:NewButton("Steal Balloon", "Steals all balloons in player's backpack", function()
    -- Logic to steal green balloons from player backpacks
end)

-- Apple Animation Button
NDSSection:NewButton("Apple Animation", "Plays the Apple Eating Animation", function()
    local character = game.Players.LocalPlayer.Character
    if character then
        -- Check if the character is using R6 or R15
        if character:FindFirstChild("Right Arm") then
            -- R6 Character
            local appleAnim = game.ReplicatedStorage:WaitForChild("AppleEatAnimR6")  -- AppleEatAnimR6 is in ReplicatedStorage
            if appleAnim then
                appleAnim:Play()  -- Play the R6 animation
            end
        elseif character:FindFirstChild("RightLowerLeg") then
            -- R15 Character
            local appleAnim = game.ReplicatedStorage:WaitForChild("AppleEatAnimR15")  -- AppleEatAnimR15 is in ReplicatedStorage
            if appleAnim then
                appleAnim:Play()  -- Play the R15 animation
            end
        else
            print("Character is neither R6 nor R15, unable to play animation.")
        end
    end
end)

-- Tornado Tab Setup (Tornado Customization)
local Tornado = Window:NewTab("Tornado")
local TornadoSection = Tornado:NewSection("Tornado Settings")

-- Spin Speed Slider
TornadoSection:NewSlider("Spin Speed", "Controls the tornado's spin speed", 0, 100, 50, function(value)
    -- Adjust tornado spin speed here (0-100 range)
    print("Spin Speed Set to: " .. value)
end)

-- Width Slider
TornadoSection:NewSlider("Tornado Width", "Adjust the tornado's width", 0, 100, 50, function(value)
    -- Adjust tornado width here (0-100 range)
    print("Tornado Width Set to: " .. value)
end)

-- Height Slider
TornadoSection:NewSlider("Tornado Height", "Adjust the tornado's height", 0, 100, 50, function(value)
    -- Adjust tornado height here (0-100 range)
    print("Tornado Height Set to: " .. value)
end)

-- Fun Tab Setup (FE and Crazy Fun Stuff)
local Fun = Window:NewTab("Fun")
local FunSection = Fun:NewSection("FE and Fun Stuff")

-- FE R6 Emotes Button
FunSection:NewButton("FE R6 Emotes", "Triggers wacky R6 Emotes", function()
    loadstring(game:HttpGet("https://raw.githubusercontent.com/WinterDinder/oldfehub/main/boronide%20level%20obfuscation%20lol"))()
end)

-- FE Spin Button (Example FE Function)
FunSection:NewButton("FE Spin", "Triggers a crazy spin animation", function()
    local character = game.Players.LocalPlayer.Character
    local humanoid = character:FindFirstChildOfClass("Humanoid")
    if humanoid then
        humanoid.WalkSpeed = 0
        while true do
            humanoid.RootPart.CFrame = humanoid.RootPart.CFrame * CFrame.Angles(0, math.rad(15), 0)
            wait(0.1)
        end
    end
end)

-- Add More FE Buttons (Head Stretch, Crazy Arms, etc.)
FunSection:NewButton("FE Head Stretch", "Stretches the character's head", function()
    local character = game.Players.LocalPlayer.Character
    if character then
        local head = character:FindFirstChild("Head")
        if head then
            head.Size = Vector3.new(10, 10, 10)
        end
    end
end)

-- Optional: Add more FE stuff and wacky features!

-- End of UI Setup
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
