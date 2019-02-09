local function processArgs(args)
    local args =  {}
    local i = 1
    for arg in string.gmatch(msg, "%a+") do
        args[i] = arg
        i = i + 1
    end
    return args
end

local function gam(msg)
    local args = processArgs(msg)
    for value in args do
        print(value)
    end
end
    
SLASH_GAM1 = '/gam'
SlashCmdList["GAM"] = gam