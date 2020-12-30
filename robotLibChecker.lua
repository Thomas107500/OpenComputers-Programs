local fs = require("filesystem")
local component = require("component")
local counter = 0

print("Running library checker for robots...")

print("Checking for missing files on /home/robotlib directory...")

if(not fs.exists("/home/robotlib/robotCommon.lua")) then
    print("Missing robotCommon.lua...")
    counter = counter + 1
end
    print("Total of ".. counter .. " missing file detected!")