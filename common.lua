local common = {}

function common.input(String_prompt)
    io.write(String_prompt)
    local result = io.read()
    io.write("\n")
    return result
end

return common