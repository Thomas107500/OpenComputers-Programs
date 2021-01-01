local fs = require("filesystem")
local commonlib = require("common")

print("Initializing robot...")
local x = commonlib.input("Please input the current X coordinate: ")
local y = commonlib.input("Please input the current Y coordinate: ")
local z = commonlib.input("Please input the current Z coordinate: ")
local facing = commonlib.input("Please input the current facing(1:north,2:east,3:south,4:west): ")

function init() 
    fs.makeDirectory("/home/data/coords.lua")
    local file = io.open("/home/data/coords.lua","w")
    file.write(x.. "\n" .. y .. "\n" .. z .."\n" .. facing)
    file.close()
end

local status, err = pcall(init())

if(status) then
    print("Initialization Complete...")
else
    print("An error occurred: ".. err)
end