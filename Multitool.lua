
-- // Services
local Players = game:GetService("Players")
local StarterGui = game:GetService("StarterGui")
local UIS = game:GetService("UserInputService")

local localPlayer = Players.LocalPlayer

-- // Create Chat Bypass GUI
local ScreenGui = Instance.new("ScreenGui")
ScreenGui.Name = "ChatBypassUI"
ScreenGui.ResetOnSpawn = false
ScreenGui.Parent = localPlayer:WaitForChild("PlayerGui")

local Frame = Instance.new("Frame")
Frame.Name = "MainFrame"
Frame.Size = UDim2.new(0, 300, 0, 150)
Frame.Position = UDim2.new(0.5, -150, 0.4, -75)
Frame.BackgroundColor3 = Color3.fromRGB(25, 25, 25)
Frame.BorderSizePixel = 0
Frame.Active = true
Frame.Draggable = true
Frame.Visible = false
Frame.Parent = ScreenGui

local Title = Instance.new("TextLabel")
Title.Size = UDim2.new(1, 0, 0, 30)
Title.BackgroundColor3 = Color3.fromRGB(35, 35, 35)
Title.Text = "Made by Exploding Car"
Title.TextColor3 = Color3.new(1,1,1)
Title.Font = Enum.Font.GothamBold
Title.TextSize = 16
Title.Parent = Frame

local TextBox = Instance.new("TextBox")
TextBox.Size = UDim2.new(1, -20, 0, 50)
TextBox.Position = UDim2.new(0, 10, 0, 40)
TextBox.PlaceholderText = "Type Message Here..."
TextBox.BackgroundColor3 = Color3.fromRGB(45, 45, 45)
TextBox.TextColor3 = Color3.new(1,1,1)
TextBox.Font = Enum.Font.Gotham
TextBox.TextSize = 14
TextBox.ClearTextOnFocus = false
TextBox.Parent = Frame

local SendButton = Instance.new("TextButton")
SendButton.Size = UDim2.new(0, 100, 0, 40)
SendButton.Position = UDim2.new(0.5, -50, 1, -50)
SendButton.Text = "Send Message"
SendButton.BackgroundColor3 = Color3.fromRGB(55, 55, 55)
SendButton.TextColor3 = Color3.new(1,1,1)
SendButton.Font = Enum.Font.GothamBold
SendButton.TextSize = 14
SendButton.Parent = Frame

-- // Bypass Message Sender
local meta = getrawmetatable(game)
setreadonly(meta, false)
local old = meta.__namecall
meta.__namecall = newcclosure(function(self, ...)
	local args = {...}
	if tostring(getnamecallmethod()) == "FireServer" and self.Name == "SayMessageRequest" then
		local msg = args[1]
		msg = msg:gsub(".", function(c)
			if c:match("%a") then
				return c .. "ۘॱ"
			end
			return c
		end)
		return old(self, msg, args[2])
	end
	return old(self, ...)
end)
setreadonly(meta, true)

-- // Send Message
SendButton.MouseButton1Click:Connect(function()
	local msg = TextBox.Text
	if msg ~= "" then
		game:GetService("ReplicatedStorage").DefaultChatSystemChatEvents.SayMessageRequest:FireServer(msg, "All")
	end
end)

-- // Toggle GUI with Key ("K")
UIS.InputBegan:Connect(function(input, gameProcessed)
	if gameProcessed then return end
	if input.KeyCode == Enum.KeyCode.K then
		Frame.Visible = not Frame.Visible
	end
end)
