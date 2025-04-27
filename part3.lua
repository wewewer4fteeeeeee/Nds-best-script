-- RandomTab.lua
RandomSection:NewButton("Give Invis Tool", "Become invisible by tool", function()
    local Tool = Instance.new("Tool")
    Tool.Name = "Invis Tool"
    Tool.RequiresHandle = false

    Tool.Activated:Connect(function()
        local char = game.Players.LocalPlayer.Character
        if char and char:FindFirstChild("HumanoidRootPart") then
            local hrpClone = char.HumanoidRootPart:Clone()
            wait(0.1)
            char.HumanoidRootPart:Destroy()
            hrpClone.Parent = char
        end
    end)

    Tool.Parent = game.Players.LocalPlayer.Backpack
end)
