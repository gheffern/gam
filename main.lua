local function disableAddonSet(setName)
    for k,v in pairs(gamSets[setName]) do
        disableAddOn(v)
    end
    ReloadUI()
end

local function enableAddonSet(setName)
    for k,v in pairs(gamSets[setName]) do
        EnableAddOn(v)
    end
    ReloadUI()
end

local function list(setName)
    print("GAM: Addons in set \"" .. setName .. "\"" )
    for k,v in pairs(gamSets[setName]) do
        print("  ", v)
    end
end

local function deleteAddonFromSet(setName,addonName)
    for k,v  in pairs(gamSets[setName]) do
        if v == addonName then
            table.remove(gamSets[setName],k)
        end
    end
    print("GAM: Removed \"" .. addonName .. "\" from \"" .. setName )
end

local function deleteAddonSet(setName)
    gamSets[setName] = nil
    print("GAM: Deleted \"" .. setName .. "\"")
end

local function addAddonToSet(setName, addonName)
    table.insert(gamSets[setName], addonName)
    print("GAM: Added the addon, \"" .. addonName .. "\", to the set, \"" .. setName .. "\"")
end

local function listSets()
    print("GAM: Sets are:")
    for k,v in pairs(gamSets) do
        print("  ", k)
    end
end

local function createAddonSet(addonSetName)
    gamSets[addonSetName] = {}
    print("GAM: Created addon set \"" ..addonSetName .. "\"")
end

local function processArgs(argMsg)
    local args =  {}
    local i = 1
    for v in string.gmatch(argMsg, "%a+") do
        args[i] = v
        i = i + 1
    end
    if args[3] ~= nil then
        local name, title, notes,loadable,reason,security,newVersion =  GetAddOnInfo(addOn)
        if reason == "MISSING" then
            print("GAM: Invalid Addon Name provided")
        return
        end
    end
    return args[1], args[2], args[3]
end

local function gam(msg)
    if gamSets == nil then
        gamSets = {}
    end
    local cmd, setName, addOn = processArgs(msg)
    if cmd == "create" then
        createAddonSet(setName)
    elseif cmd == "delete" then
        deleteAddonSet(setName)
    elseif cmd == "add" then
        addAddonToSet(setName, addOn)
    elseif cmd == "remove" then
        deleteAddonFromSet(setName,addOn)
    elseif cmd == "enable" then
        enableAddonSet(setName)
    elseif cmd == "disable" then
        disableAddonSet(setName)
    elseif cmd:lower() == "listsets" then
        listSets()
    elseif cmd:lower() == "list" then
        list(setName)
    else 
        print("Invalid GAM command please try again")
    end
end
    
SLASH_GAM1 = '/gam'
SlashCmdList["GAM"] = gam