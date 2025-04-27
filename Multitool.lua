-- MainLoader.lua
local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("Oldschool NDS MultiTool", "BloodTheme")

-- Tabs
local MainTab = Window:NewTab("Main")
local BypassTab = Window:NewTab("Chat Bypass")
local AnimTab = Window:NewTab("Animations")
local RandomTab = Window:NewTab("Random")
local HawkTab = Window:NewTab("Hawk Tuah")

-- Sections inside tabs
local MainSection = MainTab:NewSection("Main Features")
local BypassSection = BypassTab:NewSection("Chat Bypass")
local AnimSection = AnimTab:NewSection("Funny Animations")
local RandomSection = RandomTab:NewSection("Random Stuff")
local HawkSection = HawkTab:NewSection("Hawk Mode")

-- Require other parts
loadstring(game:HttpGet("https://raw.githubusercontent.com/wewewer4fteeeeeee/Nds-best-script/refs/heads/main/partone.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wewewer4fteeeeeee/Nds-best-script/refs/heads/main/part2.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wewewer4fteeeeeee/Nds-best-script/refs/heads/main/part3.luaa"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/wewewer4fteeeeeee/Nds-best-script/refs/heads/main/part4.lua"))()
