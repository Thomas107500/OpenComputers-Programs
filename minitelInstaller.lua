local fs = require("filesystem")
local component = require("component")
local shell = require("shell")

local args,options = shell.parse(...)

if (not component.isAvailable("internet")) then
    print("An internet card is required for this program to function...")
    return nil
end

print("Checking for minitel library on /etc/rc.d directory...")

if(not fs.exists("/etc/rc.d/minitel.lua") or options.u) then
    print("Downloading minitel.lua...")
    fs.makeDirectory("/etc/rc.d")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/ShadowKatStudios/OC-Minitel/master/OpenOS/etc/rc.d/minitel.lua /etc/rc.d/minitel.lua ")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

print("Checking for minitel-util on /usr/bin directory...")

if(not fs.exists("/usr/bin/ping.lua") or options.u) then
    print("Downloading ping.lua...")
    fs.makeDirectory("/usr/bin")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/ShadowKatStudios/OC-Minitel/master/util/OpenOS/usr/bin/ping.lua /usr/bin/ping.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

if(not fs.exists("/usr/bin/mtcfg.lua") or options.u) then
    print("Downloading mtcfg.lua...")
    fs.makeDirectory("/usr/bin")
    local status, err = shell.execute("wget -f https://raw.githubusercontent.com/ShadowKatStudios/OC-Minitel/master/util/OpenOS/usr/bin/mtcfg.lua /usr/bin/mtcfg.lua")
    if(status == false) then
        print("An error occurred during download: " .. err)
    end
end

shell.execute("rc minitel enable")
shell.execute("mtcfg --firstrun")

print("Installation Complete...")