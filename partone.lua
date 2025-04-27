-- ChatBypass.lua
local meta = getrawmetatable(game)
setreadonly(meta, false)
local old = meta.__namecall
meta.__namecall = newcclosure(function(self, ...)
    local args = {...}
    if tostring(getnamecallmethod()) == "FireServer" and self.Name == "SayMessageRequest" then
        local msg = args[1]
        msg = msg:gsub(".", "%1ۘॱ")
        return old(self, msg, args[2])
    end
    return old(self, ...)
end)
setreadonly(meta, true)
