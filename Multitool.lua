-- MultiTool by Exploding Car

-- Load Kavo UI
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("MultiTool By Exploding Car", "DarkTheme")

-- Tabs
local MainTab = Window:NewTab("Main")
local AnimTab = Window:NewTab("Animations")
local ToolsTab = Window:NewTab("Tools")
local ChatTab = Window:NewTab("Chat Bypass")
local SettingsTab = Window:NewTab("Settings")

-- Sections
local MainSection = MainTab:NewSection("Main Features")
local AnimSection = AnimTab:NewSection("Funny Animations")
local ToolsSection = ToolsTab:NewSection("Tools")
local ChatSection = ChatTab:NewSection("Chat Bypass")
local SettingsSection = SettingsTab:NewSection("Settings")

-- Variables
local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Char = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

-- Chat Bypass Script
ChatSection:NewButton("Enable Chat Bypass", "Bypass Roblox Filter", function()
    local meta = getrawmetatable(game)
    if (make_writeable ~= nil) then
        make_writeable(meta)
    elseif (setreadonly ~= nil) then
        setreadonly(meta, false)
    end
    local old = meta.__namecall
    meta.__namecall = newcclosure(function(self, ...)
        local args = {...}
        if tostring(getnamecallmethod()) == "FireServer" and self.Name == "SayMessageRequest" then
            local msg = args[1]
            msg = msg:gsub(".", "%1ۘॱ")
            msg = msg:gsub(" ", "  ")
            return old(self, msg, args[2])
        end
        return old(self, ...)
    end)
    if (setreadonly ~= nil) then
        setreadonly(meta, true)
    elseif (make_readonly ~= nil) then
        make_readonly(meta)
    end
end)

-- Invis Tool
ToolsSection:NewButton("Give Invis Tool", "Makes you invisible with a tool", function()
    local Tool = Instance.new("Tool")
    Tool.Name = "InvisTool"
    Tool.RequiresHandle = false
    Tool.Parent = LocalPlayer.Backpack

    Tool.Activated:Connect(function()
        local HRP = Char:FindFirstChild("HumanoidRootPart")
        if HRP then
            -- Sky Platform
            local SkyPlatform = Instance.new("Part", workspace)
            SkyPlatform.Size = Vector3.new(20,1,20)
            SkyPlatform.Position = Vector3.new(0,10000,0)
            SkyPlatform.Anchored = true
            SkyPlatform.CanCollide = true
            wait(0.2)
            HRP.CFrame = SkyPlatform.CFrame + Vector3.new(0,5,0)
            wait(0.5)
            SkyPlatform:Destroy()
            -- Fake HRP
            local FakeHRP = HRP:Clone()
            wait(0.25)
            HRP:Destroy()
            FakeHRP.Parent = Char
        end
    end)
end)

-- R6/R15 Detection
local function isR6(char)
    return #char:GetChildren() == 13
end

-- Animation Functions
local function playR6Anim(animName)
    local Hum = Char:FindFirstChildWhichIsA("Humanoid")
    if Hum then
        if animName == "Jerk" then
            -- Jerk off Anim R6
            for i = 1, 1000 do
                pcall(function()
                    Char.Torso.CFrame = Char.Torso.CFrame * CFrame.Angles(math.rad(20), 0, 0)
                    wait(0.1)
                    Char.Torso.CFrame = Char.Torso.CFrame * CFrame.Angles(math.rad(-20), 0, 0)
                    wait(0.1)
                end)
            end
        elseif animName == "Flop" then
            -- Flop Mode
            Hum.PlatformStand = true
            for i = 1, 500 do
                Char.Torso.CFrame = Char.Torso.CFrame * CFrame.Angles(0, math.rad(5), 0)
                wait(0.1)
            end
            Hum.PlatformStand = false
        elseif animName == "BackflipSpam" then
            -- Backflip Spam
            Hum.PlatformStand = true
            for i = 1, 500 do
                Char.Torso.CFrame = Char.Torso.CFrame * CFrame.Angles(math.rad(30), 0, 0)
                wait(0.05)
            end
            Hum.PlatformStand = false
        elseif animName == "CartwheelGlitch" then
            -- Cartwheel Glitch
            Hum.PlatformStand = true
            for i = 1, 500 do
                Char.Torso.CFrame = Char.Torso.CFrame * CFrame.Angles(0, 0, math.rad(20))
                wait(0.05)
            end
            Hum.PlatformStand = false
        end
    end
end

-- Animation Buttons
AnimSection:NewButton("Sit Jerk (R6 Only)", "Funny Sit jerk animation", function()
    if isR6(Char) then
        playR6Anim("Jerk")
    else
        warn("Only works on R6")
    end
end)

AnimSection:NewButton("Flop Mode", "Fall over and flop", function()
    if isR6(Char) then
        playR6Anim("Flop")
    else
        warn("Only works on R6")
    end
end)

AnimSection:NewButton("Backflip Spam", "Backflip bug", function()
    if isR6(Char) then
        playR6Anim("BackflipSpam")
    else
        warn("Only works on R6")
    end
end)

AnimSection:NewButton("Cartwheel Glitch", "Glitch spin", function()
    if isR6(Char) then
        playR6Anim("CartwheelGlitch")
    else
        warn("Only works on R6")
    end
end)

-- GUI Finder
MainSection:NewButton("GUI Finder", "Find and enable any GUI", function()
    for i,v in pairs(LocalPlayer.PlayerGui:GetDescendants()) do
        if v:IsA("ScreenGui") then
            print(v.Name)
            v.Enabled = true
        end
    end
end)

-- Settings
SettingsSection:NewKeybind("Toggle UI", "Opens/Closes UI", Enum.KeyCode.RightShift, function()
	Library:ToggleUI()
end)

