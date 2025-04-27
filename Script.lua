--// Light Obfuscation Start
local a=game:GetService("TweenService")
local b=game:GetService("Players")
local c=b.LocalPlayer
local d=c:WaitForChild("PlayerGui")
local e=Instance.new("ScreenGui",d)
e.IgnoreGuiInset=true
e.ZIndexBehavior=Enum.ZIndexBehavior.Sibling
local f=Instance.new("Frame",e)
f.Size=UDim2.new(1,0,1,0)
f.BackgroundColor3=Color3.fromRGB(30,30,30)
local g=Instance.new("TextLabel",f)
g.Size=UDim2.new(1,0,1,0)
g.BackgroundTransparency=1
g.Text="Natural Disaster Survival Script\nMade by ExplodingCar"
g.Font=Enum.Font.GothamBold
g.TextSize=40
g.TextColor3=Color3.fromRGB(255,255,255)
g.TextStrokeTransparency=0
task.wait(2)
a:Create(f,TweenInfo.new(1),{BackgroundTransparency=1}):Play()
a:Create(g,TweenInfo.new(1),{TextTransparency=1}):Play()
task.wait(1)
e:Destroy()

--// Rayfield Load
local h=loadstring(game:HttpGet("https://raw.githubusercontent.com/SiriusSoftwareLtd/Rayfield/main/source.lua"))()
local i=h:CreateWindow({
    Name="NDS | By ExplodingCar",
    LoadingTitle="Natural Disaster Script",
    LoadingSubtitle="Made by ExplodingCar",
    ConfigurationSaving={Enabled=true,FolderName="NDS_Save"},
    Discord={Enabled=false}
})

--// Tabs
local j=i:CreateTab("🌪️ Tornado Control")
local k=i:CreateTab("🔧 Other NDS Stuff")

--// Settings
local tornadoEnabled=false
local spinSpeed=10
local spinHeight=40
local spinWidth=10
local l={}
local m=Instance.new("Sound",d)
m.SoundId="rbxassetid://9118826814"
m.Volume=1

--// Tornado Functions
function ToggleTornado(state)
    tornadoEnabled=state
    if state then
        m:Play()
        Rayfield:Notify({Title="Tornado Enabled",Content="Swirling madness activated!",Duration=3})
    else
        m:Play()
        Rayfield:Notify({Title="Tornado Disabled",Content="Swirl effect stopped.",Duration=3})
    end
end

function UpdateTornado()
    while tornadoEnabled do
        for _,part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored and not part:IsDescendantOf(c.Character) then
                if not table.find(l,part) then
                    table.insert(l,part)
                    local bp=Instance.new("BodyPosition",part)
                    bp.MaxForce=Vector3.new(math.huge,math.huge,math.huge)
                    local bg=Instance.new("BodyGyro",part)
                    bg.MaxTorque=Vector3.new(math.huge,math.huge,math.huge)
                end
            end
        end
        local t=0
        while tornadoEnabled and task.wait() do
            t+=0.05
            for _,part in ipairs(l) do
                if part and part.Parent then
                    local bp=part:FindFirstChildOfClass("BodyPosition")
                    local bg=part:FindFirstChildOfClass("BodyGyro")
                    if bp and bg then
                        local x=math.cos(t*spinSpeed)*spinWidth
                        local z=math.sin(t*spinSpeed)*spinWidth
                        local y=spinHeight
                        local pos=(c.Character.Head.Position+Vector3.new(x,y,z))
                        bp.Position=pos
                        bg.CFrame=CFrame.new(pos,c.Character.Head.Position)
                    end
                end
            end
        end
        task.wait(0.1)
    end
end

--// UI Controls
j:CreateToggle({
    Name="Enable Tornado",
    CurrentValue=false,
    Callback=function(Value)
        ToggleTornado(Value)
        if Value then
            task.spawn(UpdateTornado)
        end
    end
})

j:CreateSlider({
    Name="Spin Speed",
    Range={1,50},
    Increment=1,
    CurrentValue=10,
    Callback=function(Value)
        spinSpeed=Value
    end
})

j:CreateSlider({
    Name="Spin Width",
    Range={5,50},
    Increment=1,
    CurrentValue=10,
    Callback=function(Value)
        spinWidth=Value
    end
})

j:CreateSlider({
    Name="Spin Height",
    Range={10,100},
    Increment=1,
    CurrentValue=40,
    Callback=function(Value)
        spinHeight=Value
    end
})

--// NDS Buttons
k:CreateButton({
    Name="Fling Unanchored Parts",
    Callback=function()
        for _,part in ipairs(workspace:GetDescendants()) do
            if part:IsA("BasePart") and not part.Anchored then
                local bv=Instance.new("BodyVelocity",part)
                bv.MaxForce=Vector3.new(1e6,1e6,1e6)
                bv.Velocity=Vector3.new(math.random(-5000,5000),math.random(1000,5000),math.random(-5000,5000))
                game.Debris:AddItem(bv,0.5)
            end
        end
        m:Play()
        Rayfield:Notify({Title="Flinged!",Content="All unanchored parts have been YEETED!",Duration=3})
    end
})

k:CreateButton({
    Name="Steal Balloon",
    Callback=function()
        local balloonOwner=b:FindFirstChild("TargetPlayerName") -- Manual change needed
        if balloonOwner and balloonOwner:FindFirstChild("Backpack") then
            local balloon=balloonOwner.Backpack:FindFirstChild("GreenBalloon")
            if balloon then
                local balloonClone=balloon:Clone()
                balloonClone.Parent=c.Backpack
                m:Play()
                Rayfield:Notify({Title="Balloon Stolen",Content="Green balloon stolen successfully!",Duration=3})
            else
                Rayfield:Notify({Title="No Balloon",Content="Target doesn't have a balloon.",Duration=3})
            end
        end
    end
})
--// Light Obfuscation End
