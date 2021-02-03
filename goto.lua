local robotcommon = require("robotCommon")
local commonlib = require("common")

local Vector3_current,facing = robotcommon.getCoord()
local Vector3_dest = {tonumber(commonlib.input("X: ")),tonumber(commonlib.input("Y: ")),tonumber(commonlib.input("Z: "))}

Vector3_current,facing = robotcommon.move(Vector3_current,Vector3_dest,facing,false)
robotcommon.storeCoord(Vector3_current,facing)