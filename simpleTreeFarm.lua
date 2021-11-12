local robot = require("robot")

local inventory = require("component").inventory_controller

--configure this for desired rows
local row = 10
local failed = 0
while (true) do
    for i=1,row do
        robot.select(1)
        robot.forward()
        
        --check left side
        robot.turnLeft()
        if robot.compare() then
            robot.swing()
            robot.forward()
            while(robot.compareUp()) do
                robot.swingUp()
                robot.up()
            end    
            while(not robot.detectDown()) do
                robot.down()
            end
            robot.back()
            robot.select(2)
            robot.place()
        end
        robot.turnRight()
        
        --check right side
        robot.turnRight()
        robot.select(1)
        if robot.compare() then
            robot.swing()
            robot.forward()
            while(robot.compareUp()) do
                robot.swingUp()
                robot.up()
            end    
            while(not robot.detectDown()) do
                robot.down()
            end
            robot.back()
            robot.select(2)
            robot.place()
        end
        robot.turnLeft()
    
    
    end

    for i=1,row do
        robot.back()
    end

    --refill sappling
    robot.turnLeft()
    robot.select(2)
    while(robot.count(2) < 64 and failed < 4) do
        if(not robot.suck(1)) then
            failed = failed + 1
        end
    end
    failed = 0
    
    --dropoff logs
    if(robot.count(1) > 1) then
        robot.select(1)
        while(robot.count(1) ~= 1) do
            robot.dropUp(1)
        end
    end
    for j=4,16 do
        while(robot.count(j) > 0) do
            robot.select(j)
            robot.dropUp()
        end
    end

    robot.turnRight()
    robot.turnRight()
    if(robot.durability() < 0.2 or robot.durability() == nil) then
        robot.select(3)
        inventory.equip()
        robot.dropDown()
        robot.suck()
    end
    robot.turnLeft()
    os.sleep(300)
end
