local robotcommon = require("robotCommon")
local commonlib = require("common")

local Vector3_current,facing = robotcommon.getCoord()
print("X: " .. Vector3_current[1])
print("Y: " .. Vector3_current[2])
print("Z: " .. Vector3_current[3])
print("Facing: " .. facing)