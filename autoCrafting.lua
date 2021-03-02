--Prerequisit:
--1. robot with crafting and inventory controller upgrade
--2. a storage medium in front of the robot
--3. robot need to face the ingredient chest
        






local component = require("component")
local crafter = component.crafting
local inventory = component.inventory_controller
local fs = require("filesystem")
local serialization = require("serialization")
local commonlib = require("common")
local robot = require("robot")
local side = require("sides")

--ingredient chest is currently hardcoded to be north(front)
local recipes = {} --(Recipe)recipe["ItemName"] = {slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9}
local nameList = {} --{nameList["Item translated name"] = {untranslated name:damage}}
local nameListKeys ={} --{Item translated name}
local args,options = shell.parse(...)


function createRecipe()
    
    commonlib.input("Please place the recipe in the crafting grid and press enter to continue")
    
    local recipe = {}
    local stack
    
    for n=1,9 do
        stack = inventory.getStackInInternalSlot(craftSlotIndexToInternIndex(n))
        if (stack ~= nil) then
            table.insert(recipe, stack["name"]..":"..stack["damage"])
        else
            table.insert(recipe, "nil")
        end
    end
    
    robot.select(8)
    if(crafter.craft(1)) then
        stack = inventory.getStackInInternalSlot(8)
        recipes[stack["name"]..":"..stack["damage"]] = recipe
        nameList[stack["label"]] = stack["name"]..":"..stack["damage"]
        table.insert(nameListKeys, stack["label"])
        
        local f = io.open("/home/data/recipe", "w")
    
        if(f) then
            f:write(serialization.serialize(recipes) .. "\n")
            f:write(serialization.serialize(nameList))
            f:close()
            print("Recipe Created...\n")
        else
            print("Error: Unable to open and write to /home/data/recipe")
        end
    else
        print("Unable to craft the specify recipe...")
    end
end

function craftFunction()
    local selection = 0
    local tmpList = {}
    repeat
        local searchStr = commonlib.input("Item Name Search: ")
        tmpList = {}
        local counter = 1
        for key,value in pairs(nameList) do
            if(string.find(key,searchStr,1,true) ~= nil or string.find(key:lower(),searchStr,1,true) ~= nil) then
                print("["..counter.."] "..key..": "..value)
                table.insert(tmpList,value)
                counter = counter + 1
            end
        end
        selection = tonumber(commonlib.input("Selection(-1 for cancel): "))
    until(selection ~=-1)
   craft(tmpList[selection])
   print("Crafting Completed...\n")
end

function craft(itemName)
    local recipe = recipes[itemName]
    local found
    
    for l=1,9 do
        robot.select(craftSlotIndexToInternIndex(l))
        if(robot.count() > 0) then
            for m=1,robot.count() do
                robot.drop(1)
            end
        end
    end

    for j=1,9 do
        found = false
        print("Getting ingredient for slot ".. j)
        for k=1,inventory.getInventorySize(side.front) do
            local stack = inventory.getStackInSlot(side.front, k)
            if (stack ~= nil) then
                if(stack["name"]..":"..stack["damage"] == recipe[j]) then
                    robot.select(craftSlotIndexToInternIndex(j))
                    inventory.suckFromSlot(side.front, k, 1)
                    found = true
                    break
                elseif(recipe[j] == "nil") then
                    found = true
                    break
                end
            end
        end
        if(not found) then
            print("Unable to locate ".. recipe[j]..", attempting to craft it")
            craft(recipe[j])
            while (robot.count() > 0) do
                robot.drop(1)
            end
            craft(itemName)
            break
        end
    end
    robot.select(8)
    crafter.craft(1)
end

function craftSlotIndexToInternIndex(craftSlot)
    if(craftSlot == 1 or craftSlot == 2 or craftSlot == 3) then
        return craftSlot
    elseif(craftSlot == 4 or craftSlot == 5 or craftSlot == 6) then
        return craftSlot + 1
    else
        return craftSlot + 2
    end
end




print("Initializing autocrafting system...")
if(options == "remote")
    --TODO: remote mode,take orders from server
else
    if(fs.exists("/home/data/recipe")) then
    
        print("reading stored record...")
        local f = io.open("/home/data/recipe", "r")

        if(f) then
            recipes = serialization.unserialize(f:read("*l"))
            nameList = serialization.unserialize(f:read())
            f:close()
        else
            print("Error: Unable to open /home/data/recipe")
        end
    else
        print("Creating necessary files...")
        fs.makeDirectory("/home/data")
        local f = io.open("/home/data/recipe", "w")
        f:close()
    end

while true do
    local command = commonlib.input("> ")
    if(command == "create") then
        createRecipe()
    elseif (command == "craft") then
        craftFunction()
    elseif (command == "exit") then
        print("stoping execution...")
        os.exit()
    end
end






