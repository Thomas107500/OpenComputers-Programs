local chunkloader = require("component").chunkloader
local term = require("term")

while true do
    term.clear()
    print("Chunkloader Status: "..tostring(chunkloader.isActive()))
    print("Command: enable, disable. exit")
    io.write("> ")
    local input = io.read()
    
    if(input == "enable") then
        local result = chunkloader.setActive(true)
        if result then
            print("Chunkloader successfully enabled!")
        else
            print("Chunkloader failed to be be enabled...")
        end
    elseif(input == "disable") then
        local result = chunkloader.setActive(false)
        if result then
            print("Chunkloader successfully disabled!")
        else
            print("Chunkloader failed to be be disabled...")
        end
    elseif(input == "exit") then
        os.exit()
    end
end

