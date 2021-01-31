local queue = {}

function queue.push(Queue_queue,value)
    table.insert(Queue_queue, 1, value)
end

function queue.pop(Queue_queue)
    local front = Queue_queue[#Queue_queue]
    table.remove(Queue_queue,#Queue_queue)
    return front
end

function queue.front(Queue_queue)
    return Queue_queue[#Queue_queue]
end

function queue.isEmpty(Queue_queue)
    if (#Queue_queue > 0) then
        return true
    else
        return false
    end
end

return queue