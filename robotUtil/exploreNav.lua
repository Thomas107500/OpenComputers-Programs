local robotcommon = require("robotCommon")
local commonlib = require("common")
local navigation = require("navigation")

local Vector3_current,facing = robotcommon.getCoord()

while true do
    local input = commonlib.input("Please enter f, b, l, r or exit to exit: ")
    if input == "exit" then
        break
    else
        navigation.exploreMove(input)
    end
end

robotcommon.storeCoord(Vector3_current,facing)