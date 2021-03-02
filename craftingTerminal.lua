--network message:

local recipes = {} --(Recipe)recipe["ItemName"] = {slot1, slot2, slot3, slot4, slot5, slot6, slot7, slot8, slot9}
local nameList = {} --{nameList["Item translated name"] = {untranslated name:damage}}
local nameListKeys = {} --{Item translated name}
local masterCrafter --master crafter's network hostname

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

function craftSlotIndexToInternIndex(craftSlot)
    if(craftSlot == 1 or craftSlot == 2 or craftSlot == 3) then
        return craftSlot
    elseif(craftSlot == 4 or craftSlot == 5 or craftSlot == 6) then
        return craftSlot + 1
    else
        return craftSlot + 2
    end
end






print("Initializing autocrafting terminal...")

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

--TODO:broadcast network message to all robots and allow the user to select master crafter


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