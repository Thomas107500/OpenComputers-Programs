--Requirement to use: Internet Card
--startX=0&startY=0&startZ=0&endX=0&endY=0&endZ=2

local navigation = {}

local internet = require("internet")
local robotcommon = require("robotCommon")
local robot = require("robot")

function navigation.getPath(Vector3_current,Vector3_destination)
    local result = internet.request(string.format("https://ocwebapi.thomas107500.repl.co/api/map/getPath?startX=%d&startY=%d&startZ=%d&endX=%d&endY=%d&endZ=%d",Vector3_current[1],Vector3_current[2],Vector3_current[3],Vector3_destination[1],Vector3_destination[2],Vector3_destination[3]))
    local content = ""
    local strTable = {}
    local pathVectors = {}
    local blockVector = {}
    
    for chunk in result do content = content..chunk end
    print(content)
    
    for str in string.gmatch(content, "([^"..",".."]+)") do
        table.insert(strTable, str)
    end

    for i=1,#strTable,5 do
        table.insert(blockVector, tonumber(strTable[i]))
        table.insert(blockVector, tonumber(strTable[i+1]))
        table.insert(blockVector, tonumber(strTable[i+2]))
        
        table.insert(pathVectors, blockVector)
        blockVector = {}
    end
    
    return pathVectors
end

local function updateDB(Vector3_current)
    local content = ""
    local result = internet.request(string.format("https://ocwebapi.thomas107500.repl.co/api/map/store?X=%d&Y=%d&Z=%d&Block=%s&Hardness=%d",Vector3_current[1],Vector3_current[2],Vector3_current[3],"minecraft:air",0))
    for chunk in result do content = content..chunk end
    if(content == "Saved") then
        print("Coords updated")
    else
        print("Failed")
    end
end

--f:forward, b:backward, r:right, l:left, u:up, d:down
function navigation.exploreMove(String_direction)
    
    local Vector3_current,facing = robotcommon.getCoord()
    
    if(String_direction == "f") then
        Vector3_current,facing = robotcommon.tryForward(Vector3_current,facing,false)
    elseif(String_direction == "b") then
        Vector3_current,facing = robotcommon.tryBackward(Vector3_current,facing)
    elseif(String_direction == "l") then
        facing = robotcommon.turn("l",facing)
        Vector3_current,facing = robotcommon.tryForward(Vector3_current,facing,false)
    elseif(String_direction == "r") then
        facing = robotcommon.turn("r",facing)
        Vector3_current,facing = robotcommon.tryForward(Vector3_current,facing,false)
    elseif(String_direction == "u") then
        Vector3_current,facing = robotcommon.tryUpward(Vector3_current,facing)
    elseif(String_direction == "d") then
        Vector3_current,facing = robotcommon.tryDownward(Vector3_current,facing)
    end
    
    updateDB(Vector3_current)
    return Vector3_current,facing
end

--local result = internet.request("https://ocwebapi.thomas107500.repl.co/api/map/getPath?startX=0&startY=0&startZ=0&endX=0&endY=0&endZ=2")
-- Print the body of the HTTP response result
--local code, message, header = getmetatable(result)
--local content = ""
--for chunk in result do content = content..chunk end
--print(content)


return navigation