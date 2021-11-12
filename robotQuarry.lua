-- Prerequisit:
-- Robot with max hover upgrade,inventory controller
-- Robot facing output chest on starts
-- Robot front chest is output,bottom is broken tools output,top is new tool
-- TODO: Crude Implmentation, definitely need refactor
local component = require("component")
local robotcommon = require("robotCommon")
local vec3 = require("vector3")
local commonlib = require("common")
local robot = require("robot")
local computer = require("computer")
local inventory = component.inventory_controller

-- Note: point start is the starting point of mining not for drop off
-- Prerequisit: make sure robots is able to access to dropoff on the surface, else it will disrupt pathing(non fatal)

local width = tonumber(commonlib.input("Please enter the width of mining area: "))
local length = tonumber(commonlib.input("Please enter the length of the mining area: "))

local Vector3_current, currentFacing = robotcommon.getCoord()

local Vector3_dropOff = Vector3_current
local Vector3_start = Vector3_dropOff
local dropOffFacing = currentFacing

local Vector3_checkPoint

-- todo:for now robot drop off after mining every strip which is not efficient


function getPowerPercent()
    return (computer.energy() / computer.maxEnergy()) * 100
end

function mineLayer()
    local k = 1
    while (k <= length) do
        for l = 1, length - (k - 1) do
            Vector3_current, currentFacing = robotcommon.tryForward(Vector3_current, currentFacing, true)
        end

        currentFacing = robotcommon.turn("r", currentFacing)

        Vector3_checkPoint = Vector3_current

        local full = 0
        for i = 2, 16 do
            robot.select(i)
            if (robot.count(i) ~= 0) then
                full = full + 1
            end
        end
        if (full >= 11 or getPowerPercent() < 20) then
            Vector3_current, currentFacing = robotcommon.move(Vector3_current, Vector3_dropOff, currentFacing, false)
            robotcommon.pointTo(currentFacing, dropOffFacing)
            for i = 2, 16 do
                robot.select(i)
                while (robot.count(i) ~= 0) do
                    robot.drop()
                end
            end
            robot.select(1)
            if (robot.durability() < 0.2 or robot.durability() == nil) then
                robot.select(1)
                inventory.equip()
                robot.dropDown()
                robot.suckUp()
            end
            while (getPowerPercent() < 20) do
                os.sleep(30)
            end
            Vector3_current, currentFacing = robotcommon.move(Vector3_current, Vector3_checkPoint, currentFacing, false)
        end

        if (k < length) then
            for j = 1, width - k do
                Vector3_current, currentFacing = robotcommon.tryForward(Vector3_current, currentFacing, true)
            end
            currentFacing = robotcommon.turn("r", currentFacing)
        end

        k = k + 1
    end
    print("Layer Completed...")
end


while (Vector3_start[2] > 2) do
    Vector3_start[2] = Vector3_start[2] - 1
    print("startX: ".. Vector3_start[1] .. "startY: " .. Vector3_start[2] .. "startZ: " .. Vector3_start[3])
    Vector3_current, currentFacing = robotcommon.move(Vector3_current, Vector3_start, currentFacing, true)
    currentFacing = robotcommon.turn("r", currentFacing)
    currentFacing = robotcommon.turn("r", currentFacing)
    mineLayer() 
end
print("Operation Completed...")
Vector3_current, currentFacing = robotcommon.move(Vector3_current, Vector3_dropOff, currentFacing, false)
    for i = 2, 16 do
        robot.select(i)
        while (robot.count(i) ~= 0) do
            robot.drop()
        end
    end
    robot.select(1)
    if (robot.durability() < 0.2 or robot.durability() == nil) then
        robot.select(1)
        inventory.equip()
        currentFacing = robotcommon.turn("l", currentFacing)
        robot.drop()
        currentFacing = robotcommon.turn("r", currentFacing)
        robot.suckUp()
    end
robotcommon.storeCoord(Vector3_current,currentFacing)
