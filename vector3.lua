local vector3 = {}

local commonlib = require("common")

function vector3.new(x,y,z)
    return {x,y,z}
end
    
function vector3.getMagnitude(Vector3_vector)
    local result = math.sqrt(Vector3_vector[1]^2 + Vector3_vector[2]^2 + Vector3_vector[3]^2)
    return result
end

function vector3.getUnitVector(Vector3_vector)
    local Vector3_result = vector3.vector3ScalarDiv(Vector3_vector, vector3.getMagnitude(Vector3_vector))
    return Vector3_result
end


function vector3.vector3Add(Vector3_vector1,Vector3_vector2)
    local Vector3_sum = {Vector3_vector1[1] + Vector3_vector2[1], Vector3_vector1[2] + Vector3_vector2[2], Vector3_vector1[3] + Vector3_vector2[3]}
    return Vector3_sum
end

function vector3.vector3Minus(Vector3_vector1,Vector3_vector2)
    local Vector3_diff = {Vector3_vector1[1] - Vector3_vector2[1], Vector3_vector1[2] - Vector3_vector2[2], Vector3_vector1[3] - Vector3_vector2[3]}
    return Vector3_diff
end

function vector3.vector3ScalarMul(Vector3_vector1,Number_num)
    local Vector3_prod = {Vector3_vector1[1]*Number_num, Vector3_vector1[2]*Number_num, Vector3_vector1[3]*Number_num}
    return Vector3_prod
end

function vector3.vector3ScalarDiv(Vector3_vector1,Number_num)
    local Vector3_quot = {Vector3_vector1[1]/Number_num, Vector3_vector1[2]/Number_num, Vector3_vector1[3]/Number_num}
    return Vector3_quot
end

function vector3.vec3Input(String_prompt)
    local Vector3_result
    print(String_prompt)
    Vector3_result = {tonumber(commonlib.input("X: ")),tonumber(commonlib.input("Y: ")),tonumber(commonlib.input("Z: "))}
    return Vector3_result
end

function vector3.vector3Abs(Vector3_vector)
    local Vector3_result = {math.abs(Vector3_vector[1]), math.abs(Vector3_vector[2]), math.abs(Vector3_vector[3])}
    return Vector3_result
end

return vector3