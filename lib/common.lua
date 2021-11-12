local common = {}

function common.input(String_prompt)
    io.write(String_prompt)
    local result = io.read()
    return result
end

function common.boolInput(String_prompt)
    io.write(String_prompt)
    local input = io.read()
    while true do
        if input == "y" then
            return true
        elseif input == "n" then
            return false
        else
            print("Invalid input, please only input y/n")
        end
    end
end

return common