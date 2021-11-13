local fs = require("filesystem")
local component = require("component")
local shell = require("shell")

local args,options = shell.parse(...)

if (not component.isAvailable("internet")) then
    print("An internet card is required for this program to function...")
    return nil
end

print("Checking for missing files on /usr/lib directory...")

if(not fs.exists("/usr/lib/vector3.lua") or options.u) then
    print("Downloading vector3.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/lib/vector3.lua /usr/lib/vector3.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/lib/common.lua") or options.u) then
    print("Downloading common.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/lib/common.lua /usr/lib/common.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/lib/queue.lua") or options.u) then
    print("Downloading queue.lua...")
    fs.makeDirectory("/usr/lib")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/lib/queue.lua /usr/lib/queue.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

print("Computer library installation completed...")
print("Do you want to install robot based libraries? y/N")
local input = io.read()
local result = false

while true do
    if input == "y" then
        result = true
        break
    elseif input == "n" or input == "" then
        result = false
        break
    else
        print("Invalid input, please only input y/n")
    end
end

if(result) then
    print("Checking for missing robot based library on /usr/lib directory...")

    if(not fs.exists("/usr/lib/robotCommon.lua") or options.u) then
    
        print("Downloading robotCommon.lua...")
        fs.makeDirectory("/usr/lib")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/lib/robotCommon.lua /usr/lib/robotCommon.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/usr/lib/navigation.lua") or options.u) then
    
        print("Downloading navigation.lua...")
        fs.makeDirectory("/usr/lib")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/lib/navigation.lua /usr/lib/navigation.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    print("Checking for missing robot utility script on /home directory...")
    
    if(not fs.exists("/home/getCoords.lua") or options.u) then
    
        print("Downloading getCoords.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/getCoords.lua /home/getCoords.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/home/chunkLoader.lua") or options.u) then
    
        print("Downloading chunkLoader.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/chunkLoader.lua /home/chunkLoader.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/home/robotInit.lua") or options.u) then
    
        print("Downloading robotInit.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/robotInit.lua /home/robotInit.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/home/exploreNav.lua") or options.u) then
    
        print("Downloading exploreNav.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/exploreNav.lua /home/exploreNav.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/home/gotoNav.lua") or options.u) then
    
        print("Downloading gotoNav.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/gotoNav.lua /home/gotoNav.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end

    if(not fs.exists("/home/goto.lua") or options.u) then
    
        print("Downloading goto.lua...")
        local status, err = shell.execute("wget -f https://raw.githubusercontent.com/Thomas107500/OpenComputers-Programs/master/robotUtil/gotoNav.lua /home/goto.lua")
        if(status == false) then
            print("An error occurred during download: " .. err)
        end
    end
end

print("Installation Complete...")