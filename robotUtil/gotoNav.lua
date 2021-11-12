local robotcommon = require("robotCommon")
local commonlib = require("common")
local navigation = require("navigation")

local Vector3_current,facing = robotcommon.getCoord()
local Vector3_dest = {tonumber(commonlib.input("X: ")),tonumber(commonlib.input("Y: ")),tonumber(commonlib.input("Z: "))}

local pathVectors = navigation.getPath(Vector3_current,Vector3_dest)

print(#pathVectors[1])
--for i=1,#pathVectors do
--    print("X: ".. pathVectors[i][1].." Y: "..pathVectors[i][2] .." Z: ".. pathVectors[i][3])
--end
for i=1,#pathVectors do
    print("X: ".. pathVectors[i][1].." Y: "..pathVectors[i][2] .." Z: ".. pathVectors[i][3])
    Vector3_current,facing = robotcommon.move(Vector3_current,pathVectors[i],facing,false)
end

robotcommon.storeCoord(Vector3_current,facing)