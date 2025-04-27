--// Button 4: Steal Everything Tool
Section:NewButton("Get Steal Everything Tool", "Steals all tools in the game (not from players' backpacks)", function()
    -- Helper function to check if object is inside someone else's backpack
    local function isDescendantOfOtherBackpack(obj)
        for _, player in ipairs(game:GetService("Players"):GetPlayers()) do
            if player ~= game.Players.LocalPlayer and obj:IsDescendantOf(player.Backpack) then
                return true
            end
        end
        return false
    end

    -- Function that grabs everything
    local function grabEverything()
        for _, obj in ipairs(game:GetDescendants()) do
            if not isDescendantOfOtherBackpack(obj) then
                if obj:IsA("Tool") and obj.Parent ~= game.Players.LocalPlayer.Backpack then
                    obj.Parent = game.Players.LocalPlayer.Backpack
                end
            end
        end
    end

    -- Function to create the tool
    local function makeTool(name, onActivate)
        local tool = Instance.new("Tool")
        tool.Name = name
        tool.RequiresHandle = false
        tool.Activated:Connect(onActivate)
        tool.Parent = game.Players.LocalPlayer.Backpack
    end

    -- Actually make the tool
    makeTool("Steal Everything", grabEverything)
end)
