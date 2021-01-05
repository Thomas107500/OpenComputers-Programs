local robotCommon = {}

local robot = require("robot")
local vec3 = require("vector3")

--North:-Z, East:+X, South:+Z, West:-X
function robotCommon.move(Vector3_destination, Vector3_current, currentFacing, bool_clearPath)
    local Vector3_toMove = vec3.vector3Minus(Vector3_destination, Vector3_current)
    --print("toMove: ".. "X:" .. Vector3_toMove[1] .. "Y:" .. Vector3_toMove[1] .. "Z:" .. Vector3_toMove[1])
    --print("currentCoord: ".. "X:" .. Vector3_current[1] .. "Y:" .. Vector3_current[1] .. "Z:" .. Vector3_current[1])
    while(math.abs(Vector3_toMove[1]) > 0 and math.abs(Vector3_toMove[2]) > 0 and math.abs(Vector3_toMove[3]) > 0) do
        for i = 1, math.abs(Vector3_toMove[1]) do
            if(Vector3_toMove[1] < 0) then
                currentFacing = robotCommon.pointTo(currentFacing,4)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        robot.swing()
                    else
                        break
                    end
                else
                    Vector3_toMove[1] = Vector3_toMove[1] + 1
                end
            else
                currentFacing = robotCommon.pointTo(currentFacing,2)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        robot.swing()
                    else
                        break
                    end
                else
                    Vector3_toMove[1] = Vector3_toMove[1] - 1
                end
            end
        end
    
        for j = 1, math.abs(Vector3_toMove[2]) do
            if(Vector3_toMove[2] < 0) then
                if (robot.down() == nil) then
                    if(bool_clearPath) then
                        robot.swingDown()
                    else
                        break
                    end
                else
                    Vector3_toMove[2] = Vector3_toMove[2] + 1
                end
            else
                if (robot.up() == nil) then
                    if(bool_clearPath) then
                        robot.swingUp()
                    else
                        break
                    end
                else
                    Vector3_toMove[2] = Vector3_toMove[2] - 1
                end
            end
        end
    
        for k = 1, math.abs(Vector3_toMove[3]) do
            if(Vector3_toMove[3] < 0) then
                currentFacing = robotCommon.pointTo(currentFacing,1)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        robot.swing()
                    else
                        break
                    end
                else
                    Vector3_toMove[3] = Vector3_toMove[3] + 1
                end
            else
                currentFacing = robotCommon.pointTo(currentFacing,3)
                if (robot.forward() == nil) then
                    if(bool_clearPath) then
                        robot.swing()
                    else
                        break
                    end
                else
                    Vector3_toMove[3] = Vector3_toMove[3] - 1
                end
            end
        end
    end    
    return Vector3_destination,currentFacing
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
        error("Invalid Args")
        return false
    end
end

function robotCommon.getCoord()
    local f
    local status,value = pcall(function() f = io.open("/home/data/coords", "r") end)

    if(status) then
        local Vector3_current = {tonumber(f:read("*l")),tonumber(f:read("*l")),tonumber(f:read("*l"))}
        local facing = tonumber(f:read())
        f:close()
        return Vector3_current,facing
    else
        print("An error occurred when calling getCoord: ".. value)
    end
end

function robotCommon.storeCoord(Vector3_current,facing)
    local f
    local status,value = pcall(function() f = io.open("/home/data/coords", "w") end)

    if(status) then
        f:write(Vector3_current[1] .. "\n" .. Vector3_current[2] .. "\n" .. Vector3_current[3] .. "\n" .. facing)
        f:close()
        return true
    else
        print("An error occurred when calling storeCoord: ".. value)
        return false
    end
end

return robotCommon