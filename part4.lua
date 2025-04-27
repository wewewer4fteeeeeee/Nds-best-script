-- HawkTuah.lua
local HawkActive = false

HawkSection:NewButton("Toggle Hawk Tuah", "Move Forward/Back Loops", function()
    HawkActive = not HawkActive
    local char = game.Players.LocalPlayer.Character
    while HawkActive do
        char:TranslateBy(Vector3.new(0.3, 0, 0))
        wait(0.1)
        char:TranslateBy(Vector3.new(-0.3, 0, 0))
        wait(0.1)
    end
end)
