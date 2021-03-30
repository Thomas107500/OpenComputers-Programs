local stack = {}

function stack.push(Stack_stack,value)
    table.insert(Stack_stack, 1, value)
end

function stack.pop(Stack_stack)
    local top = Stack_stack[1]
    table.remove(Stack_stack,1)
    return top
end

function stack.top(Stack_stack)
    return Stack_stack[1]
end

function stack.isEmpty(Stack_stack)
    if (#Stack_stack > 0) then
        return true
    else
        return false
    end
end

return stack