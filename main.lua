local function searchAddons(pattern)
    print("GAM: Searching for \"" .. pattern .. "\"")
    for i= 1, GetNumAddOns() do
        local addonName =  select(1, GetAddOnInfo(i))
        if string.match(addonName:lower(), pattern) ~= nil then
            print(addonName)
        end
    end
end

local function disableAddonSet(setName)
    for k,v in pairs(gamSets[setName]) do
        DisableAddOn(v)
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

local function addAddonToSet(setName, pattern)
    local nothingAdded = true
    for i= 1, GetNumAddOns() do
        local addonName =  select(1, GetAddOnInfo(i))
        if string.match(addonName:lower(), pattern) ~= nil then
            table.insert(gamSets[setName], addonName)
            nothingAdded = false
            print("GAM: Added the addon, \"" .. addonName .. "\", to the set, \"" .. setName .. "\"")
        end
    end
    if nothingAdded then
        print("GAM: No matching addons found, nothing added.")
    end
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
    for v in string.gmatch(argMsg, "%S+") do
        args[i] = v
        i = i + 1
    end
    return args[1], args[2], args[3]
end

local function gam(msg)
    if gamSets == nil then
        gamSets = {}
    end
    local cmd, name, addOn = processArgs(msg)
    if cmd == "create" then
        createAddonSet(name)
    elseif cmd:lower() == "delete" then
        deleteAddonSet(name)
    elseif cmd:lower() == "add" then
        addAddonToSet(name, addOn)
    elseif cmd:lower() == "remove" then
        deleteAddonFromSet(name,addOn)
    elseif cmd:lower() == "enable" then
        enableAddonSet(name)
    elseif cmd:lower() == "disable" then
        disableAddonSet(name)
    elseif cmd:lower() == "listsets" then
        listSets()
    elseif cmd:lower() == "list" then
        list(name)
    elseif cmd:lower() == "search" then
        searchAddons(name)
    else 
        print("Invalid GAM command please try again")
    end
end
    
SLASH_GAM1 = '/gam'
SlashCmdList["GAM"] = gam