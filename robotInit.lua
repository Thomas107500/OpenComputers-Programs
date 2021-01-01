local fs = require("filesystem")
local commonlib = require("common")

print("Initializing robot...")
local x = commonlib.input("Please input the current X coordinate: ")
local y = commonlib.input("Please input the current Y coordinate: ")
local z = commonlib.input("Please input the current Z coordinate: ")
local facing = commonlib.input("Please input the current facing(1:north,2:east,3:south,4:west): ")

function init() 
    local f
    fs.makeDirectory("/home/data/coords.lua")
    local status, err = pcall(function() f = io.open("/home/data/coords.lua","w") end)
    if (status) then
        f.write(x.. "\n" .. y .. "\n" .. z .."\n" .. facing)
        f.close()
    else
        print("An error occurred when writing: ".. err)
    end
end

local status, err = pcall(init())

if(status) then
    print("Initialization Complete...")
else
    print("An error occurred: ".. err)
end