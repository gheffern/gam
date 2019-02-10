local function listSets()
    for k,v in pairs(gamSets) do
        print(k,v)
    end
end

local function createAddonSet(addonSetName)
    gamSets[addonSetName] = {}
end

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
    if gamSets == nil then
        gamSets = {}
    end
    local args = processArgs(msg)
    local cmd = table.remove(args,1)
    local setName = table.remove(args,1)
    local addOn = table.remove(args,1)
    if cmd == "create" then
        createAddonSet(setName)
    elseif cmd == "delete" then
        print("in delete")
    elseif cmd == "add" then
        print("in add")
    elseif cmd == "remove" then
        print("in remove")
    elseif cmd == "enable" then
        print("in enable")
    elseif cmd == "disable" then
        print("in disable")
    elseif cmd:lower() == "listsets" then
        listSets()
    else 
        print("Invalid GAM command please try again")
    end
end
    
SLASH_GAM1 = '/gam'
SlashCmdList["GAM"] = gam