local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made By Exploding Car", "DarkTheme")

local Tab = Window:NewTab("Tools")
local Section = Tab:NewSection("Hinge Tools")

--// Function to Make a Tool
local function makeTool(name, onActivate)
    local tool = Instance.new("Tool")
    tool.Name = name
    tool.RequiresHandle = false
    tool.Activated:Connect(onActivate)
    tool.Parent = game.Players.LocalPlayer.Backpack
end

--// Button 1: Break Hinges Tool
Section:NewButton("Get Break Hinges Tool", "Destroys all hinges", function()
    makeTool("Break Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                obj:Destroy()
            end
        end
    end)
end)

--// Button 2: Spin Hinges Tool
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

--// Button 3: Fling Hinges Tool
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

-- Chat Bypass Tab
local ChatTab = Window:NewTab("Chat Bypass")
local ChatSection = ChatTab:NewSection("Chat Bypass")

-- Create the Chat Bypass GUI
local chatGUI = Instance.new("ScreenGui")
chatGUI.Parent = game.Players.LocalPlayer.PlayerGui

local chatFrame = Instance.new("Frame")
chatFrame.Parent = chatGUI
chatFrame.Size = UDim2.new(0, 300, 0, 150)
chatFrame.Position = UDim2.new(0.5, -150, 0.5, -75)
chatFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
chatFrame.BorderSizePixel = 2
chatFrame.BorderColor3 = Color3.fromRGB(255, 255, 255)

local inputBox = Instance.new("TextBox")
inputBox.Parent = chatFrame
inputBox.Size = UDim2.new(1, -20, 0, 40)
inputBox.Position = UDim2.new(0, 10, 0, 10)
inputBox.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
inputBox.BorderSizePixel = 1
inputBox.TextColor3 = Color3.fromRGB(255, 255, 255)
inputBox.PlaceholderText = "Type your message here..."
inputBox.ClearTextOnFocus = false

local sendButton = Instance.new("TextButton")
sendButton.Parent = chatFrame
sendButton.Size = UDim2.new(0, 100, 0, 40)
sendButton.Position = UDim2.new(0, 10, 1, -50)
sendButton.BackgroundColor3 = Color3.fromRGB(30, 30, 30)
sendButton.BorderSizePixel = 1
sendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
sendButton.Text = "Send Message"

-- Function to send message
sendButton.MouseButton1Click:Connect(function()
    local message = inputBox.Text
    if message ~= "" then
        -- Convert message to bypassed format (e.g., "s.ͥ.g.ͫ..ͣ.")
        local convertedMessage = ""
        for i = 1, #message do
            local char = message:sub(i, i)
            convertedMessage = convertedMessage .. char .. string.char(math.random(32, 126)) -- Add random characters in between
        end
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(convertedMessage, "All")
    end
end)

-- Create the Open/Close Button for Chat Bypass
local openCloseButton = Instance.new("TextButton")
openCloseButton.Parent = chatGUI
openCloseButton.Size = UDim2.new(0, 100, 0, 30)
openCloseButton.Position = UDim2.new(0, 10, 0, 50)  -- Move the button lower to avoid chatbox overlap
openCloseButton.BackgroundColor3 = Color3.fromRGB(255, 0, 0)
openCloseButton.TextColor3 = Color3.fromRGB(255, 255, 255)
openCloseButton.Text = "Open/Close"
openCloseButton.TextSize = 14

-- Function to toggle the chat bypass GUI visibility
local isOpen = false
openCloseButton.MouseButton1Click:Connect(function()
    isOpen = not isOpen
    chatFrame.Visible = isOpen
end)

-- Initially hide the chat bypass GUI (it will only show when the button is clicked)
chatFrame.Visible = false

-- Open/Close the Chat Bypass GUI when "K" key is pressed
local UserInputService = game:GetService("UserInputService")
UserInputService.InputBegan:Connect(function(input)
    if input.KeyCode == Enum.KeyCode.K then
        isOpen = not isOpen
        chatFrame.Visible = isOpen
    end
end)

-- Add draggable functionality to the chat bypass frame
local dragging = false
local dragInput, dragStart, startPos

local function updatePosition(input)
    local delta = input.Position - dragStart
    chatFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
end

chatFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = chatFrame.Position
        input.Changed:Connect(function()
            if not input.UserInputState == Enum.UserInputState.Change then
                dragging = false
            end
        end)
    end
end)

chatFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        updatePosition(input)
    end
end)

-- Open the Chat Bypass GUI when the Chat Bypass tab button is clicked
ChatSection:NewButton("Activate Chat Bypass", "Open the chat bypass GUI", function()
    chatFrame.Visible = true
end)

-- Therapy Tab
local TherapyTab = Window:NewTab("Therapy")
local TherapySection = TherapyTab:NewSection("Therapy Tools")

-- Button to Find Player's Name and make AdminGui Visible
TherapySection:NewButton("Make AdminGui Visible", "Find Player's Name and Make AdminGui Visible", function()
    local playerName = game.Players.LocalPlayer.Name
    local adminGui = game.Players.LocalPlayer.PlayerGui:FindFirstChild("AdminGui")
    if adminGui then
        adminGui.Visible = true
        print("AdminGui made visible for player: " .. playerName)
    else
        print("AdminGui not found in PlayerGui.")
    end
end)

-- Button to Steal All Items (except from players' backpacks)
TherapySection:NewButton("Steal All Items in Game", "Get all items in the game", function()
    for _, obj in pairs(game:GetDescendants()) do
        -- Exclude players' backpacks
        if obj:IsA("BasePart") and not obj:IsDescendantOf(game.Players.LocalPlayer.Backpack) then
            local clone = obj:Clone()
            clone.Parent = game.Players.LocalPlayer.Backpack
        end
    end
end)

-- Make sure the buttons work correctly.
