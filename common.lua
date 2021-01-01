local common = {}

function common.input(String_prompt)
    io.write(String_prompt)
    local result = io.read()
    return result
end

return common