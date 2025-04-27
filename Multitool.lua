local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made By Exploding Car", "DarkTheme")

-- Tabs and Sections Setup
local Tab = Window:NewTab("Random")
local Section = Tab:NewSection("Goofy Stuff")

-- Enter Player's Name and Play Animation + Move Player
Section:NewTextBox("Enter Player's Name", "Type the player's name to give them the 'ykyk hawk tuah' and play animation", function(playerName)
    local player = game.Players:FindFirstChild(playerName)
    
    if player and player.Character and player.Character:FindFirstChild("Humanoid") then
        local humanoid = player.Character.Humanoid
        local character = player.Character
        local humanoidRootPart = character:FindFirstChild("HumanoidRootPart")
        
        if humanoidRootPart then
            -- Teleport to the player (around their HumanoidRootPart)
            local targetPosition = humanoidRootPart.Position + Vector3.new(0, 5, 0)
            game.Players.LocalPlayer.Character.HumanoidRootPart.CFrame = CFrame.new(targetPosition)
            
            -- Play and loop the animation
            local anim = Instance.new("Animation")
            anim.AnimationId = "rbxassetid://18135776429"
            local animTrack = humanoid:LoadAnimation(anim)
            animTrack:Play()
            animTrack.Looped = true

            -- Move the player forward and backward by 0.30 studs
            while animTrack.IsPlaying do
                -- Move the player forward by 0.30 studs
                humanoidRootPart.CFrame = humanoidRootPart.CFrame + humanoidRootPart.CFrame.LookVector * 0.30
                wait(0.5)  -- Wait for a short moment before moving backward
                
                -- Move the player backward by 0.30 studs
                humanoidRootPart.CFrame = humanoidRootPart.CFrame - humanoidRootPart.CFrame.LookVector * 0.30
                wait(0.5)  -- Wait for a short moment before moving forward again
            end
        else
            print("HumanoidRootPart not found in the player's character.")
        end
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
