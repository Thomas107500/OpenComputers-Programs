local robotcommon = require("robotCommon")
local commonlib = require("common")
local navigation = require("navigation")

local Vector3_current,facing = robotcommon.getCoord()
--Change this string to update the correct table in OCAPI
local worldString = ""

while true do
    local input = commonlib.input("Please enter f, b, l, r, u, d or exit to exit: ")
    if input == "exit" then
        break
    else
        Vector3_current,facing = navigation.exploreMove(worldString,input)
    end
end

robotcommon.storeCoord(Vector3_current,facing)