-- Animations.lua
AnimSection:NewButton("Flop Mode", "Flops side to side", function()
    local char = game.Players.LocalPlayer.Character
    while true do
        char:TranslateBy(Vector3.new(1,0,0))
        wait(0.2)
        char:TranslateBy(Vector3.new(-1,0,0))
        wait(0.2)
    end
end)

AnimSection:NewButton("Backflip Spam", "Bugged Backflip", function()
    local char = game.Players.LocalPlayer.Character
    while true do
        char.HumanoidRootPart.CFrame *= CFrame.Angles(math.rad(45), 0, 0)
        wait(0.1)
    end
end)
