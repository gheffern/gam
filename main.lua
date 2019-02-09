local function processArgs(argMsg)
    local args =  {}
    local i = 1
    for v in string.gmatch(argMsg, "%a+") do
        args[i] = v
        i = i + 1
    end
    return args
end

local function gam(msg)
    local args = processArgs(msg)

    for k,v in pairs(args) do
        print(k)
        print(v)
    end
end
    
SLASH_GAM1 = '/gam'
SlashCmdList["GAM"] = gam