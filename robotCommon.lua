local robotCommon = {}

local robot = require("robot")
local vec3 = require("vector3")

--North(1):-Z, East(2):+X, South(3):+Z, West(4):-X
--todo: robots dont move after swinging so it just mines the block and try to move on another axis
--todo: robots cannot find alternate route and will be stuck if there is only one axis of movement left but that axis is blocked while clearPath is false
function robotCommon.move(Vector3_current, Vector3_destination, currentFacing, bool_clearPath)
    local Vector3_toMove = vec3.vector3Minus(Vector3_destination, Vector3_current)
    local failed = 0
    while(math.abs(Vector3_toMove[1]) > 0 or math.abs(Vector3_toMove[2]) > 0 or math.abs(Vector3_toMove[3]) > 0) do
        for i = 1, math.abs(Vector3_toMove[1]) do
            if(Vector3_toMove[1] < 0) then
                currentFacing = robotCommon.pointTo(currentFacing,4)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swing()) then
                            failed = failed + 1
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[1] = Vector3_toMove[1] + 1
                    failed = 0
                end
            else
                currentFacing = robotCommon.pointTo(currentFacing,2)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swing()) then
                            failed = failed + 1
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[1] = Vector3_toMove[1] - 1
                    failed = 0
                end
            end
        end
    
        for j = 1, math.abs(Vector3_toMove[2]) do
            if(Vector3_toMove[2] < 0) then
                if (robot.down() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swingDown()) then
                            failed = failed + 1
                            break
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[2] = Vector3_toMove[2] + 1
                    failed = 0
                end
            else
                if (robot.up() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swingUp()) then
                            failed = failed + 1
                            break
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[2] = Vector3_toMove[2] - 1
                    failed = 0
                end
            end
        end
    
        for k = 1, math.abs(Vector3_toMove[3]) do
            if(Vector3_toMove[3] < 0) then
                currentFacing = robotCommon.pointTo(currentFacing,1)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swing()) then
                            failed = failed + 1
                            break
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[3] = Vector3_toMove[3] + 1
                    failed = 0
                end
            else
                currentFacing = robotCommon.pointTo(currentFacing,3)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        if(not robot.swing()) then
                            failed = failed + 1
                            break
                        end
                    else
                        failed = failed + 1
                        break
                    end
                else
                    Vector3_toMove[3] = Vector3_toMove[3] - 1
                    failed = 0
                end
            end
        end
        if (failed > 2) then
            break
        end
    end    
    return vec3.vector3Minus(Vector3_destination, Vector3_toMove),currentFacing
end

function robotCommon.pointTo(currentFacing,targetFacing)
    if (targetFacing - currentFacing == -3) then
        robot.turnRight()
        return targetFacing
    elseif(targetFacing - currentFacing == 3) then
        robot.turnLeft()
        return targetFacing
    elseif(targetFacing - currentFacing > 0) then
        for l = 1, targetFacing - currentFacing do
            robot.turnRight()
        end
        return targetFacing
    else
        for m = 1, math.abs(targetFacing - currentFacing) do
            robot.turnLeft()
        end
        return targetFacing
    end
end

function robotCommon.turn(String_direction,currentFacing)
    if(String_direction == "r") then
        robot.turnRight()
        currentFacing = currentFacing + 1
        if(currentFacing > 4) then
            currentFacing = 1
        end
        return currentFacing
    elseif(String_direction == "l") then
        robot.turnLeft()
        currentFacing = currentFacing - 1
        if(currentFacing < 1) then
            currentFacing = 4
        end
        return currentFacing
    else
        error("Invalid Args passed to turn()")
    end
end
--North(1):-Z, East(2):+X, South(3):+Z, West(4):-X
function tryForward(Vector3_current,currentFacing)
    if(robot.forward()) then
        if(currentFacing == 1) then
            Vector3_current[3] = Vector3_current[3] - 1
        elseif(currentFacing == 2) then
            Vector3_current[1] = Vector3_current[1] + 1
        elseif(currentFacing == 3) then
            Vector3_current[3] = Vector3_current[3] + 1
        else
            Vector3_current[1] = Vector3_current[1] - 1
        end
    end
    return Vector3_current
end

function tryBackward(Vector3_current,currentFacing)
    if(robot.back()) then
        if(currentFacing == 1) then
            Vector3_current[3] = Vector3_current[3] + 1
        elseif(currentFacing == 2) then
            Vector3_current[1] = Vector3_current[1] - 1
        elseif(currentFacing == 3) then
            Vector3_current[3] = Vector3_current[3] - 1
        else
            Vector3_current[1] = Vector3_current[1] + 1
        end
    end
    return Vector3_current
end

function robotCommon.getCoord()
    local f = io.open("/home/data/coords", "r")

    if(f) then
        local Vector3_current = {tonumber(f:read("*l")),tonumber(f:read("*l")),tonumber(f:read("*l"))}
        local facing = tonumber(f:read())
        f:close()
        return Vector3_current,facing
    else
        print("Error: f is nil in getCoord()")
    end
end

function robotCommon.storeCoord(Vector3_current,facing)
    local f = io.open("/home/data/coords", "w")

    if(f) then
        f:write(Vector3_current[1] .. "\n" .. Vector3_current[2] .. "\n" .. Vector3_current[3] .. "\n" .. facing)
        f:close()
        return true
    else
        print("f is nil in storeCoord()")
        return false
    end
end


return robotCommon