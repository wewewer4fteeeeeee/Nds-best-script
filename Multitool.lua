local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made By Exploding Car", "DarkTheme")

-- Tabs and Sections Setup
local Tab = Window:NewTab("Random")
local Section = Tab:NewSection("Goofy Stuff")

-- Enter Player's Name and Play Animation + Give Tool
Section:NewTextBox("Enter Player's Name", "Type the player's name to give them the 'ykyk hawk tuah' and play animation", function(playerName)
    local player = game.Players:FindFirstChild(playerName)
    
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        local character = player.Character

        -- Play animation on the player (looping the start of the animation)
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://18858673531"
        local animTrack = humanoid:LoadAnimation(anim)
        animTrack:Play()
        animTrack:AdjustSpeed(1) -- Adjust the speed if necessary

        -- Give the player the "ykyk hawk tuah" (tool)
        local tool = Instance.new("Tool")
        tool.Name = "ykyk hawk tuah"
        tool.Parent = player.Backpack
        
        -- Optionally, position the tool near the character's position in a humorous way
        local handle = Instance.new("Part")
        handle.Size = Vector3.new(1, 1, 1)
        handle.Position = character.HumanoidRootPart.Position + Vector3.new(0, 5, 0) -- Above the player
        handle.Anchored = true
        handle.Parent = game.Workspace
        
        -- After a short delay, position the tool at a comical place
        wait(0.5)
        handle.Position = character.HumanoidRootPart.Position + Vector3.new(0, -1, 0) -- Modify for humor
    else
        print("Player not found or invalid character.")
    end
end)

-- Chat Bypass Section Setup
local ChatTab = Window:NewTab("Chat Bypass")
local ChatSection = ChatTab:NewSection("Chat Bypass")

-- Chat Bypass GUI
local chatBypassOpen = false
local chatFrame = Instance.new("Frame")
chatFrame.Size = UDim2.new(0, 300, 0, 200)
chatFrame.Position = UDim2.new(0.5, -150, 0.5, -100)
chatFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chatFrame.BackgroundTransparency = 0.5
chatFrame.Visible = false
chatFrame.Parent = game.Players.LocalPlayer.PlayerGui

local textBox = Instance.new("TextBox")
textBox.Size = UDim2.new(0, 280, 0, 40)
textBox.Position = UDim2.new(0, 10, 0, 10)
textBox.Text = ""
textBox.PlaceholderText = "Type your message..."
textBox.Parent = chatFrame

local sendButton = Instance.new("TextButton")
sendButton.Size = UDim2.new(0, 280, 0, 40)
sendButton.Position = UDim2.new(0, 10, 0, 60)
sendButton.Text = "Send Message"
sendButton.Parent = chatFrame

sendButton.MouseButton1Click:Connect(function()
    local originalMessage = textBox.Text
    local modifiedMessage = string.gsub(originalMessage, ".", function(c)
        return c.."ͥ"  -- Adds the "ͥ" after each character
    end)
    game.ReplicatedStorage.DefaultChatSystemChatEvents.SayMessageRequest:FireServer(modifiedMessage, "All")
end)

-- Open/Close Button for Chat Bypass GUI
local openCloseButton = Instance.new("TextButton")
openCloseButton.Size = UDim2.new(0, 100, 0, 40)
openCloseButton.Position = UDim2.new(0, 10, 0, 250)  -- Adjusted position so it's not in the chat's way
openCloseButton.Text = "Open Chat Bypass"
openCloseButton.Parent = game.Players.LocalPlayer.PlayerGui

openCloseButton.MouseButton1Click:Connect(function()
    chatBypassOpen = not chatBypassOpen
    chatFrame.Visible = chatBypassOpen
    openCloseButton.Text = chatBypassOpen and "Close Chat Bypass" or "Open Chat Bypass"
end)

-- Bind the toggling of the GUI to the 'K' key
game:GetService("UserInputService").InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        chatBypassOpen = not chatBypassOpen
        chatFrame.Visible = chatBypassOpen
        openCloseButton.Text = chatBypassOpen and "Close Chat Bypass" or "Open Chat Bypass"
    end
end)

-- Admin-related Random Tab Section
local RandomTab = Window:NewTab("Random")
local RandomSection = RandomTab:NewSection("Goofy Stuff")

-- Button to loop animation on a target player
RandomSection:NewButton("Goofy Animation", "Plays a funny animation on the target player", function()
    local playerName = "TargetPlayerNameHere"  -- You can modify this with an actual player name or another method to get player input
    local player = game.Players:FindFirstChild(playerName)
    
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        local character = player.Character
        
        local anim = Instance.new("Animation")
        anim.AnimationId = "rbxassetid://18858673531"
        local animTrack = humanoid:LoadAnimation(anim)
        animTrack:Play()
        animTrack.Looped = true
        
        -- Place the tool or effect in the target location (like a funny position)
        local tool = Instance.new("Tool")
        tool.Name = "ykyk hawk tuah"
        tool.Parent = player.Backpack
        -- Add extra funny positioning or effects as needed
    else
        print("Player not found or invalid character.")
    end
end)
