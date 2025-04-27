local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made By Exploding Car", "DarkTheme")

local Tab = Window:NewTab("Chat Bypass")
local Section = Tab:NewSection("Chat Bypass Tools")

-- Create the Chat Bypass GUI
local ChatFrame = Instance.new("Frame")
ChatFrame.Size = UDim2.new(0, 300, 0, 150)
ChatFrame.Position = UDim2.new(0, 10, 0, 10)
ChatFrame.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ChatFrame.BackgroundTransparency = 0.5
ChatFrame.Visible = false
ChatFrame.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

local TitleLabel = Instance.new("TextLabel")
TitleLabel.Size = UDim2.new(0, 300, 0, 25)
TitleLabel.Position = UDim2.new(0, 0, 0, 0)
TitleLabel.BackgroundColor3 = Color3.fromRGB(40, 40, 40)
TitleLabel.Text = "Chat Bypass"
TitleLabel.TextColor3 = Color3.fromRGB(255, 255, 255)
TitleLabel.Parent = ChatFrame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(0, 280, 0, 40)
TextBox.Position = UDim2.new(0, 10, 0, 30)
TextBox.PlaceholderText = "Enter your message..."
TextBox.BackgroundColor3 = Color3.fromRGB(50, 50, 50)
TextBox.TextColor3 = Color3.fromRGB(255, 255, 255)
TextBox.ClearTextOnFocus = true
TextBox.Parent = ChatFrame

local SendButton = Instance.new("TextButton")
SendButton.Size = UDim2.new(0, 280, 0, 30)
SendButton.Position = UDim2.new(0, 10, 0, 80)
SendButton.Text = "Send Message"
SendButton.BackgroundColor3 = Color3.fromRGB(50, 150, 50)
SendButton.TextColor3 = Color3.fromRGB(255, 255, 255)
SendButton.Parent = ChatFrame

local ToggleButton = Instance.new("TextButton")
ToggleButton.Size = UDim2.new(0, 80, 0, 30)
ToggleButton.Position = UDim2.new(0, 10, 0, 10)
ToggleButton.Text = "Open"
ToggleButton.BackgroundColor3 = Color3.fromRGB(0, 0, 0)
ToggleButton.TextColor3 = Color3.fromRGB(255, 255, 255)
ToggleButton.Parent = game.Players.LocalPlayer.PlayerGui:WaitForChild("ScreenGui")

-- Function to handle the open/close toggle of the Chat GUI
ToggleButton.MouseButton1Click:Connect(function()
    if ChatFrame.Visible then
        ChatFrame.Visible = false
        ToggleButton.Text = "Open"
    else
        ChatFrame.Visible = true
        ToggleButton.Text = "Close"
    end
end)

-- Function to send the message with chat bypass
SendButton.MouseButton1Click:Connect(function()
    local message = TextBox.Text
    if message and message ~= "" then
        -- Convert message to bypass format
        local bypassedMessage = ""
        for i = 1, #message do
            bypassedMessage = bypassedMessage .. string.char(string.byte(message:sub(i, i)) + math.random(-5, 5))
        end

        -- Send the bypassed message to chat (assuming we are using the Roblox chat system)
        game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(bypassedMessage, "All")
    end
end)

-- Optional: Make the GUI movable
local dragging = false
local dragInput, dragStart, startPos

ChatFrame.InputBegan:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = true
        dragStart = input.Position
        startPos = ChatFrame.Position
    end
end)

ChatFrame.InputChanged:Connect(function(input)
    if dragging and input.UserInputType == Enum.UserInputType.MouseMovement then
        local delta = input.Position - dragStart
        ChatFrame.Position = UDim2.new(startPos.X.Scale, startPos.X.Offset + delta.X, startPos.Y.Scale, startPos.Y.Offset + delta.Y)
    end
end)

ChatFrame.InputEnded:Connect(function(input)
    if input.UserInputType == Enum.UserInputType.MouseButton1 then
        dragging = false
    end
end)

