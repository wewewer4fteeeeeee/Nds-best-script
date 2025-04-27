
-- Full Exploding Car NDS Script with Kavo UI Library

local KavoUI = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = KavoUI.CreateLib("Natural Disaster Survival | Made By Exploding Car", "Midnight")

local NDS = Window:NewTab("NDS")
local NDSSection = NDS:NewSection("Natural Disaster Survival")

NDSSection:NewButton("Teleport Unanchored", "Teleports all unanchored parts", function()
    loadstring([[ 
        local frozenParts = {}
        for _,part in pairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and part.Anchored == false and not part:IsDescendantOf(game.Players.LocalPlayer.Character) then
                for _,c in pairs(part:GetChildren()) do
                    if c:IsA("BodyPosition") or c:IsA("BodyGyro") then c:Destroy() end
                end
                local ForceInstance = Instance.new("BodyPosition", part)
                ForceInstance.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
                ForceInstance.Position = game.Players.LocalPlayer.Character.Head.Position + Vector3.new(0,40,0)
                table.insert(frozenParts,part)
            end
        end
    ]])()
end)

local Tornado = Window:NewTab("Tornado")
local TornadoSection = Tornado:NewSection("Tornado Controls")

TornadoSection:NewButton("Start Tornado", "Summons a tornado above your head", function()
    -- Tornado summon logic (simplified)
    local tornado = Instance.new("Part", workspace)
    tornado.Size = Vector3.new(20,50,20)
    tornado.Anchored = true
    tornado.Position = game.Players.LocalPlayer.Character.Head.Position + Vector3.new(0,40,0)
    tornado.Shape = Enum.PartType.Cylinder
    tornado.BrickColor = BrickColor.new("Royal purple")
end)

local FunTab = Window:NewTab("Fun Stuff")
local FunSection = FunTab:NewSection("Goofy FE Stuff")

FunSection:NewButton("FE J3rk R6", "Funny animation R6", function()
    loadstring(game:HttpGet("https://pastefy.app/wa3v2Vgm/raw"))()
end)

FunSection:NewButton("FE J3rk R15", "Funny animation R15", function()
    loadstring(game:HttpGet("https://pastefy.app/YZoglOyJ/raw"))()
end)

FunSection:NewButton("DON'T CLICK", "Totally not a trap", function()
    local char = game.Players.LocalPlayer.Character
    if char then
        for _,v in pairs(char:GetDescendants()) do
            if v:IsA("BasePart") then
                v.RotVelocity = Vector3.new(math.random()*20, math.random()*20, math.random()*20)
            end
        end
    end
end)
