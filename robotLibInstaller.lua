local fs = require("filesystem")
local component = require("component")
local shell = require("shell")

print("Running library installer for robots...")

if (not component.exists("internet")) then
    print("An internet card is required for this program to function...")
    return nil
end

print("Checking for missing files on /home/robotlib directory...")

if(not fs.exists("/home/robotlib/robotCommon.lua")) then
    
    print("Missing robotCommon.lua...")
    fs.makeDirectory("/home/robotlib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotCommon.lua /home/robotlib/robotCommon.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end

elseif(not fs.exists("/home/robotlib/vector3.lua")) then
    print("Missing vector3.lua...")
    fs.makeDirectory("/home/robotlib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/vector3.lua /home/robotlib/vector3.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
elseif(not fs.exists("/home/robotlib/common.lua")) then
    print("Missing common.lua...")
    fs.makeDirectory("/home/robotlib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/common.lua /home/robotlib/common.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end