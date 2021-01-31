local fs = require("filesystem")
local component = require("component")
local shell = require("shell")

local args,options = shell.parse(...)

print("Running library installer for robots...")

if (not component.isAvailable("internet")) then
    print("An internet card is required for this program to function...")
    return nil
end

print("Checking for missing files on /usr/lib directory...")

if(not fs.exists("/usr/lib/robotCommon.lua") or options.u) then
    
    print("Downloading robotCommon.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotCommon.lua /usr/lib/robotCommon.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/lib/vector3.lua") or options.u) then
    print("Downloading vector3.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/vector3.lua /usr/lib/vector3.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/lib/common.lua") or options.u) then
    print("Downloading common.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/common.lua /usr/lib/common.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/lib/queue.lua") or options.u) then
    print("Downloading queue.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/queue.lua /usr/lib/queue.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

print("Process Completed...")