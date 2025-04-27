--// Load Kavo UI
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Multitool | Made by Exploding Car", "DarkTheme")

--// Tabs
local toolsTab = Window:NewTab("Tools")
local randomTab = Window:NewTab("Random")
local chatBypassTab = Window:NewTab("Chat Bypass")

--// Sections
local hingeSection = toolsTab:NewSection("Hinge Tools")
local randomSection = randomTab:NewSection("Funny Animations")
local chatSection = chatBypassTab:NewSection("Chat Tools")

------------------------
-- Hinge Tools
------------------------

local function makeTool(name, onActivate)
    local tool = Instance.new("Tool")
    tool.Name = name
    tool.RequiresHandle = false
    tool.Activated:Connect(onActivate)
    tool.Parent = game.Players.LocalPlayer.Backpack
end

hingeSection:NewButton("Get Break Hinges Tool", "Destroys all hinges", function()
    makeTool("Break Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                obj:Destroy()
            end
        end
    end)
end)

hingeSection:NewButton("Get Spin Hinges Tool", "Spins all hinges crazy fast", function()
    makeTool("Spin Hinges", function()
        for _, obj in pairs(game:GetDescendants()) do
            if obj:IsA("HingeConstraint") then
                obj.AngularVelocity = 10000
                obj.MotorMaxTorque = math.huge
            end
        end
    end)
end)

hingeSection:NewButton("Get Fling Hinges Tool", "Flings parts with hinges", function()
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

------------------------
-- Invis Tool
------------------------

randomSection:NewButton("Get Invis Tool", "Toggle invisibility + ghost clone", function()
    -- Invis Tool Script
    local Players = game:GetService("Players")
    local LocalPlayer = Players.LocalPlayer
    local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()

    local tool = Instance.new("Tool")
    tool.Name = "Invis Tool by Exploding Car"
    tool.RequiresHandle = false

    local isInvisible = false
    local ghostModel = nil

    local function createGhost(character)
        local ghost = Instance.new("Model")
        ghost.Name = "GhostClone"

        for _, part in ipairs(character:GetDescendants()) do
            if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                local clone = part:Clone()
                clone.Anchored = false
                clone.CanCollide = false
                clone.Transparency = 0.5
                clone.Parent = ghost
            end
        end

        local root = character:FindFirstChild("HumanoidRootPart")
        if root then
            local ghostRoot = root:Clone()
            ghostRoot.Anchored = false
            ghostRoot.CanCollide = false
            ghostRoot.Transparency = 1
            ghostRoot.Parent = ghost
        end

        ghost.Parent = workspace

        -- Weld Ghost Parts to Player Parts
        for _, ghostPart in ipairs(ghost:GetChildren()) do
            if ghostPart:IsA("BasePart") then
                local playerPart = character:FindFirstChild(ghostPart.Name)
                if playerPart then
                    local weld = Instance.new("WeldConstraint")
                    weld.Part0 = ghostPart
                    weld.Part1 = playerPart
                    weld.Parent = ghostPart
                end
            end
        end

        return ghost
    end

    local function invisibility(on)
        if on then
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") and part.Name ~= "HumanoidRootPart" then
                    part.Transparency = 1
                elseif part:IsA("Decal") then
                    part.Transparency = 1
                end
            end
            ghostModel = createGhost(Character)
        else
            for _, part in ipairs(Character:GetDescendants()) do
                if part:IsA("BasePart") then
                    part.Transparency = 0
                elseif part:IsA("Decal") then
                    part.Transparency = 0
                end
            end
            if ghostModel then
                ghostModel:Destroy()
                ghostModel = nil
            end
        end
    end

    tool.Activated:Connect(function()
        isInvisible = not isInvisible
        invisibility(isInvisible)
    end)

    tool.Parent = LocalPlayer.Backpack
end)

------------------------
-- Funny Animations (SERVER SIDE VIA RIG EDIT)
------------------------

randomSection:NewButton("Flop Mode", "Fall and flop around", function()
    local char = game.Players.LocalPlayer.Character
    if char and char:FindFirstChildOfClass("Humanoid") then
        for _, part in ipairs(char:GetChildren()) do
            if part:IsA("Motor6D") then
                part:Destroy()
            end
        end
    end
end)

randomSection:NewButton("Float Dance", "Spin and float upward", function()
    local hrp = game.Players.LocalPlayer.Character:FindFirstChild("HumanoidRootPart")
    if hrp then
        game:GetService("RunService").Heartbeat:Connect(function()
            hrp.CFrame = hrp.CFrame * CFrame.Angles(0, math.rad(10), 0) + Vector3.new(0, 0.05, 0)
        end)
    end
end)

randomSection:NewButton("Backflip Spam", "Spam flopping", function()
    local hum = game.Players.LocalPlayer.Character:FindFirstChildOfClass("Humanoid")
    if hum then
        while task.wait(0.1) do
            hum:ChangeState(Enum.HumanoidStateType.Jumping)
        end
    end
end)

randomSection:NewButton("Cartwheel Glitch", "Washing machine", function()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _, part in ipairs(char:GetDescendants()) do
            if part:IsA("Motor6D") then
                part.C0 = part.C0 * CFrame.Angles(math.random(), math.random(), math.random())
            end
        end
    end
end)

------------------------
-- Chat Bypass
------------------------

chatSection:NewButton("Enable Chat Bypass", "Bypass chat filters", function()
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
            msg = msg:gsub(".", "%1ۘॱ") -- every letter gets bypassed
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

------------------------
-- END
------------------------
