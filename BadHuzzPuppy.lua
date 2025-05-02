-- Load Kavo UI
local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Tool Dropper | Pickup & Dupe", "BloodTheme")

local Players = game:GetService("Players")
local LocalPlayer = Players.LocalPlayer
local Backpack = LocalPlayer:WaitForChild("Backpack")
local Character = LocalPlayer.Character or LocalPlayer.CharacterAdded:Wait()
local HumanoidRootPart = Character:WaitForChild("HumanoidRootPart")

local MainTab = Window:NewTab("Main")
local Section = MainTab:NewSection("Drop & Dupe")

-- 🔢 Drop Multiplier Slider
local dropCount = 1
Section:NewSlider("Drop Count", "Set how many times to drop each tool", 50, 1, function(val)
    dropCount = val
end)

-- 📦 Drop Tools with Pickup (Works for You)
Section:NewButton("Drop Tools (Pickup Works)", "Drops tools in front of you, pickup-able", function()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for i = 1, dropCount do
                local clone = tool:Clone()
                local handle = clone:FindFirstChild("Handle")

                -- Create a Handle if missing
                if not handle then
                    handle = Instance.new("Part")
                    handle.Name = "Handle"
                    handle.Size = Vector3.new(1, 1, 1)
                    handle.Anchored = false
                    handle.CanCollide = true
                    handle.Massless = false
                    handle.Position = HumanoidRootPart.Position
                    handle.Parent = clone
                end

                -- Final handle setup
                handle.Anchored = false
                handle.CanCollide = true
                handle.Massless = false
                handle.Velocity = Vector3.new(0, 0, 0)

                -- Drop in front of player
                local dropPos = HumanoidRootPart.Position + HumanoidRootPart.CFrame.LookVector * 10 + Vector3.new(0, 2, 0)
                handle.CFrame = CFrame.new(dropPos)

                -- Force tool into Workspace and simulate touch
                clone.Parent = workspace

                -- Manually trigger pickup (simulate touch with Humanoid)
                task.delay(0.1, function()
                    firetouchinterest(handle, LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 0)
                    firetouchinterest(handle, LocalPlayer.Character:FindFirstChild("HumanoidRootPart"), 1)
                end)
            end
        end
    end
end)

-- 🔁 Dupe Tools Button
Section:NewButton("Dupe All Tools x15", "Clones all backpack tools 15 times", function()
    for _, tool in ipairs(Backpack:GetChildren()) do
        if tool:IsA("Tool") then
            for i = 1, 15 do
                local clone = tool:Clone()
                clone.Parent = Backpack
            end
        end
    end
end)

-- 💻 Execute Remote Script Button
Section:NewButton("j3rk 0ff r6", "Runs external R6-related script", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

-- 🧲 Steal All Tools from Game Hierarchy
Section:NewButton("Steal All Items (Full Hierarchy)", "Searches whole game for Tools and clones them to your Backpack", function()
    local function deepScanAndSteal(parent)
        for _, item in ipairs(parent:GetChildren()) do
            if item:IsA("Tool") then
                local clone = item:Clone()
                clone.Parent = Backpack
            elseif #item:GetChildren() > 0 then
                deepScanAndSteal(item)
            end
        end
    end

    local containers = {
        workspace,
        game:GetService("ReplicatedStorage"),
        game:GetService("StarterPack"),
        game:GetService("Lighting"),
        game:GetService("Players")
    }

    for _, container in ipairs(containers) do
        deepScanAndSteal(container)
    end
end)
