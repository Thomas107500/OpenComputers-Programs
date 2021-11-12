--Super primative strip mine script
--Please make sure: 
--1.slot one is non valuable blocks
--2.robot have enough energy for its journey
--3.robot have enoguh pickaxe durability
--4.there is a block above where you want it to stop when it starts to mine(Solution implemented!)
--5.the top of each strip and strip + 1(length) need to have medium for drop off


local commonlib = require("common")
local robot = require("robot")
local robotcommon = require("robotCommon")

local Vector3_current,facing = robotcommon.getCoord()

local maxYcoord = tonumber(commonlib.input("Please input Y coordinate of drop off: "))
local length = tonumber(commonlib.input("Please input length of the area: "))
local coordY = maxYcoord

robot.select(1)

for i = 1, length do
    while(robot.swingDown() or not robot.detectDown()) do
        if(robot.down()) then
            coordY = coordY - 1
        end
    end
    while(coordY < maxYcoord) do
        if(not robot.up()) then
            robot.place()
        else
            coordY = coordY + 1
        end
    end

    for i = 2,16 do
        robot.select(i)
        while(robot.count(i) ~= 0) do
            robot.dropUp()
        end
    end
    robot.select(1)
    print("Starting another strip...")
    if (not robot.forward()) then
        robot.turnLeft()
        robot.place()
        robot.turnRight()
        robot.forward()
    end
end