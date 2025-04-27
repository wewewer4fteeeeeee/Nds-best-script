local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made By Exploding Car", "DarkTheme")

local Tab = Window:NewTab("Tools")
local Section = Tab:NewSection("Hinge Tools")
local Section2 = Tab:NewSection("Steal Everything")
local Section3 = Tab:NewSection("Chat Bypass")

-- Function to make a tool
local function makeTool(name, onActivate)
    local tool = Instance.new("Tool")
    tool.Name = name
    tool.RequiresHandle = false
    tool.Activated:Connect(onActivate)
    tool.Parent = game.Players.LocalPlayer.Backpack
end

-- Hinge Tools
Section:NewButton("Get Break Hinges Tool", "Destroys all hinges", function()
    makeTool("Break Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                obj:Destroy()
            end
        end
    end)
end)

Section:NewButton("Get Spin Hinges Tool", "Spins all hinges crazy fast", function()
    makeTool("Spin Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                obj.AngularVelocity = 10000
                obj.MotorMaxTorque = math.huge
            end
        end
    end)
end)

Section:NewButton("Get Fling Hinges Tool", "Flings parts with hinges", function()
    makeTool("Fling Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                local att0 = obj.Attachment0
                if att0 and att0.Parent and att0.Parent:IsA("BasePart") then
                    att0.Parent.Velocity = Vector3.new(
                        math.random(-500, 500),
                        math.random(500, 1000),
                        math.random(-500, 500)
                    )
                end
            end
        end
    end)
end)

-- Steal Everything Tool
Section2:NewButton("Steal Everything", "Steals all objects in the game (except backpacks)", function()
    local player = game.Players.LocalPlayer
    for _, obj in pairs(game.Workspace:GetDescendants()) do
        -- Exclude parts from other players' backpacks
        if obj.Parent ~= player.Backpack and obj.Parent ~= game.Players.LocalPlayer.Character then
            local clonedObj = obj:Clone()
            clonedObj.Parent = player.Character -- Adding to the player's character for now
        end
    end
end)

-- Chat Bypass
Section3:NewButton("Open Chat Bypass", "Opens a textbox for chat bypass", function()
    -- Create the ScreenGui
    local screenGui = Instance.new("ScreenGui")
    screenGui.Parent = game.Players.LocalPlayer.PlayerGui

    -- Create the Frame for the textbox and button
    local frame = Instance.new("Frame")
    frame.Size = UDim2.new(0, 300, 0, 150)
    frame.Position = UDim2.new(0.5, -150, 0.5, -75)
    frame.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
    frame.Parent = screenGui

    -- Create the TextBox for input
    local textBox = Instance.new("TextBox")
    textBox.Size = UDim2.new(0, 250, 0, 50)
    textBox.Position = UDim2.new(0.5, -125, 0, 20)
    textBox.Text = ""
    textBox.PlaceholderText = "Enter your message"
    textBox.TextColor3 = Color3.fromRGB(255, 255, 255)
    textBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
    textBox.BorderSizePixel = 0
    textBox.Parent = frame

    -- Create the "Send Message" button
    local sendButton = Instance.new("TextButton")
    sendButton.Size = UDim2.new(0, 250, 0, 30)
    sendButton.Position = UDim2.new(0.5, -125, 0, 80)
    sendButton.Text = "Send Message"
    sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
    sendButton.BackgroundColor3 = Color3.fromRGB(50, 200, 50)
    sendButton.BorderSizePixel = 0
    sendButton.Parent = frame

    -- Function to bypass chat and send the message in the encoded format
    local function bypassChat(message)
        local encodedMessage = ""
        for i = 1, #message do
            local char = message:sub(i, i)
            encodedMessage = encodedMessage .. char .. "." .. string.char(math.random(0, 255)) .. "."
        end
        -- Send the encoded message in the chat
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(encodedMessage, "All")
    end

    -- When the "Send Message" button is clicked
    sendButton.MouseButton1Click:Connect(function()
        local message = textBox.Text
        if message ~= "" then
            bypassChat(message)
            textBox.Text = "" -- Clear the textbox after sending
        end
    end)
end)
