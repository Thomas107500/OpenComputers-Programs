--currently routes are hardcoded:
--input: from north to south(not the case anymore :P)



local side = require("sides")
local component =  require("component")
local shell = require("shell")
local fs = require("filesystem")
local serialization = require("serialization")
local commonlib = require("common")

local transposers = {} --address of all transposers
local chests = {} --{{address of transposer,side}}
local chestContent = {} --{{slot 1 item,slot 2 item}}
local routes = {} --{a string of route to chest including itself}
local interfaceChestIndex


local args,options = shell.parse(...)



function discoverNode(nodeEntranceIndex)
    for m=1,#chests do
        if(chests[m][1] == chests[nodeEntranceIndex][1]) then
            if (routes[m] == nil) then
                routes[m] = nodeEntranceIndex
            end
            
            local sourceMaxSize = component.invoke(chests[nodeEntranceIndex][1],"getInventorySize",chests[nodeEntranceIndex][2])
            local destMaxSize = component.invoke(chests[m][1],"getInventorySize",chests[m][2])
            component.invoke(chests[m][1],"transferItem",chests[nodeEntranceIndex][2],chests[m][2],1,sourceMaxSize,destMaxSize)
            for n=1,#chests do
                if(not (chests[n][1] == chests[m][1]) and routes[n] == nil and compareFinalSlotStackSize(n,m)) then
                    routes[n] = nodeEntranceIndex
                    discoverNode(n)
                end
            end
            component.invoke(chests[m][1],"transferItem",chests[m][2],chests[nodeEntranceIndex][2],1,destMaxSize,sourceMaxSize)
        end
    end
end

function compareFinalSlotStackSize(chest1Index,chest2Index)
    local finalSlot1 = component.invoke(chests[chest1Index][1],"getInventorySize",chests[chest1Index][2])
    local finalSlot2 = component.invoke(chests[chest2Index][1],"getInventorySize",chests[chest1Index][2])
    local finalSlotCount1 = component.invoke(chests[chest1Index][1],"getSlotStackSize",chests[chest1Index][2],finalSlot1)
    local finalSlotCount2 = component.invoke(chests[chest2Index][1],"getSlotStackSize",chests[chest2Index][2],finalSlot2)
    if (finalSlotCount1 == finalSlotCount2) then
        return true
    else
        return false
    end
end

function transferTo(sourceSlot,targetSlot,targetChest)

end



print("Initializing Storage System...")

print("Searching for transposers on the network...")
for address, componentType in component.list() do
    if componentType == "transposer" then
        table.insert(transposers, address)
    end
end
print("Found ".. #transposers .. " transposers")

--if(not fs.exists("/home/data/storage")) then
--    print("Creating necessary files...")
--    fs.makeDirectory("/home/data")
--    local f = io.open("/home/data/storage", "w")
--    f:write(serialization.serialize() .. "\n" .. y .. "\n" .. z .."\n" .. facing)
--    f:close()
--else
--    local f = io.open("/home/data/storage", "r")
--    chests = serialization.unserialize(f:read("*l"))
--    chestContent = serialization.unserialize(f:read("*l"))
--    routes = serialization.unserialize(f:read())
--end

--fill table: chests
for i=1,#transposers do
    for j=0,5 do
        if(component.invoke(transposers[i],"getInventorySize",j) ~= nil) then
            table.insert(chests,{transposers[i],j})
        end
    end
end

--fill table chestContent
for k=1,#chests do
    table.insert(chestContent,component.invoke(chests[k][1],"getAllStacks",chests[k][2]).getAll())
end

--stop the program from running before enter is pressed
commonlib.input("Please place an item in the bottom right slot of the chest you wish to act as the interface and press enter to continue")

--locate interface chest
for l=1,#chests do
    local maxSize = component.invoke(chests[l][1],"getInventorySize",chests[l][2])
    if(component.invoke(chests[l][1],"getSlotStackSize",chests[l][2],maxSize) > 0) then
        interfaceChestIndex = l
        routes[l] = l
    end
end

--discover routes recursively
print("Discovering routes to chests... This could take a minute")
discoverNode(interfaceChestIndex)


print("Initialization Complete...")

--debug:print table chests
--for p=1,#chests do
--    for q=1,#chests[p] do
--        print(chests[p][q])
--    end
--end

--debug:interfaceChestIndex
--print("interfaceChestIndex: ".. interfaceChestIndex)

--debug:print routes
--for o=1,#routes do
--    print(routes[o])
--end

while true do
    local command = commonlib.input("> ")
    if (command == "store") then
        
    elseif (command == "exit") then
        os.exit()
end


--function storeItem()

--end


--component.invoke(transposers[1],"transferItem",side.north, side.south, 1, 1, 5)
--component.invoke(transposers[1],"getInventorySize",side.north)


