local vector3 = {}

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

return vector3