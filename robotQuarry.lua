local robotcommon = require("robotCommon")
local vec3 = require("vector3")
local commonlib = require("common")
local robot = require("robot")

--Note: point start is the starting point of mining not for drop off
--Prerequisit: make sure robots is able to access to dropoff on the surface, else it will disrupt pathing(non fatal)

local Vector3_start = vec3.vec3Input("Please enter coordinate of the starting point(closer to the robot):")
local Vector3_end = vec3.vec3Input("Please enter coordinate of the ending point(further from the robot):")

local Vector3_current, currentFacing = robotcommon.getCoord()

local Vector3_dropOff = Vector3_current

--todo:for now robot drop off after mining every strip which is not efficient

local function getBottom(Vector3_vec3)
    Vector3_vec3[2] = 1
    return Vector3_vec3
end

local Vector3_toMove = vec3.vector3Minus(Vector3_end, Vector3_start)

for i = 0, vec3.getMagnitude(Vector3_toMove) - 1 do
    local Vector3_next = vec3.vector3Add(Vector3_start, vec3.vector3ScalarMul(vec3.getUnitVector(Vector3_toMove),i))
    
    Vector3_current,currentFacing = robotcommon.move(Vector3_current, Vector3_next,currentFacing, false)
    Vector3_current,currentFacing = robotcommon.move(Vector3_current, getBottom(Vector3_next),currentFacing, true)
    Vector3_current,currentFacing = robotcommon.move(Vector3_current, getBottom(Vector3_start),currentFacing, true)
    Vector3_current,currentFacing = robotcommon.move(Vector3_current, Vector3_dropOff,currentFacing, true)
    for i = 2,16 do
        robot.select(i)
        while(robot.count(i) ~= 0) do
            robot.dropUp()
        end
    end
    robot.select(1)
end

robotcommon.storeCoord(Vector3_current, currentFacing)