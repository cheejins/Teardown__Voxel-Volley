--[[QUAT]]
do

    -- Quat to normalized dir.
    function QuatToDir(quat) return VecNormalize(TransformToParentPoint(Transform(Vec(0,0,0), quat), Vec(0,0,-1))) end

    -- Normalized dir to quat.
    function DirToQuat(dir) return QuatLookAt(Vec(0,0,0), dir) end

    -- Normalized dir of two positions.
    function DirLookAt(eye, target) return VecNormalize(VecSub(target, eye)) end

    -- Angle between two vectors.
    function VecAngle(a, b) return math.deg(math.acos(VecDot(a, b) / (VecLength(a) * VecLength(b)))) end

    -- Angle between two vectors.
    function QuatAngle(a,b)
        av = QuatToDir(a)
        bv = QuatToDir(b)
        local c = {av[1], av[2], av[3]}
        local d = {bv[1], bv[2], bv[3]}
        return math.deg(math.acos(VecDot(c, d) / (VecLength(c) * VecLength(d))))
    end

    function QuatLookUp() return DirToQuat(Vec(0, 1, 0)) end -- Quat facing world-up.
    function QuatLookDown() return DirToQuat(Vec(0, -1, 0)) end -- Quat facing world-down.

    function QuatTrLookUp(tr) return QuatLookAt(tr.pos, TransformToParentPoint(tr, Vec(0,1,0))) end -- Quat look above tr.
    function QuatTrLookDown(tr) return QuatLookAt(tr.pos, TransformToParentPoint(tr, Vec(0,-1,0))) end -- Quat look below tr.
    function QuatTrLookLeft(tr) return QuatLookAt(tr.pos, TransformToParentPoint(tr, Vec(-1,0,0))) end -- Quat look left of tr.
    function QuatTrLookRight(tr) return QuatLookAt(tr.pos, TransformToParentPoint(tr, Vec(1,0,0))) end -- Quat look right of tr.
    function QuatTrLookBack(tr) return QuatLookAt(tr.pos, TransformToParentPoint(tr, Vec(0,0,1))) end -- Quat look behind tr.

end


function IsAngleValid(origin, pos1, pos2, max_angle)
    return VecAngle(DirLookAt(origin, pos1), DirLookAt(origin, pos2)) < max_angle
end


--Source: Laz
--Shows how different 2 directions are. 100 if pointing in opposite directions
function QuatDiff(QuatA, QuatB)
    local VecA = QuatRotateVec(QuatA,Vec(0,0,-50))
    local VecB = QuatRotateVec(QuatB,Vec(0,0,-50))
    return VecLength(VecSub(VecA, VecB))
end




-- Source: OpenAi
function quat_to_dir(q)
    local dir_x = 2 * (q[1] * q[3] - q[4] * q[2])
    local dir_y = 2 * (q[2] * q[3] + q[4] * q[1])
    local dir_z = 1 - 2 * (q[1] * q[1] + q[2] * q[2])
    local magnitude = math.sqrt(dir_x * dir_x + dir_y * dir_y + dir_z * dir_z)
    return Vec(dir_x / magnitude, dir_y / magnitude, dir_z / magnitude)
end


-- Source: OpenAi
function dir_to_quat(dir)
    dir = VecNormalize(dir)
    local angle = math.acos(dir[3])
    local axis = VecNormalize(Vec(-dir[2], dir[1], 0))
    local s = math.sin(angle/2)
    local c = math.cos(angle/2)
    return Quat(c, axis[1]*s, axis[2]*s, axis[3]*s)
end


-- Source: OpenAi
function euler_to_dir(euler)
    local dir = VecNormalize(Vec(
        math.sin(euler[2]) * math.cos(euler[1]),
        math.sin(euler[1]),
        math.cos(euler[2]) * math.cos(euler[1])))
    return dir
end


-- Source: OpenAi
function dir_to_euler(dir)
    return Vec(math.asin(dir.y), math.atan2(dir.x, dir.z), 0)
end


-- Source: OpenAi
function vec_angle(v1, v2)
    local dotProduct = VecDot(v1, v2)
    local mag1 = VecLength(v1)
    local mag2 = VecLength(v2)
    local cosAngle = dotProduct / (mag1 * mag2)
    local angle = math.acos(cosAngle)
    return angle
end


-- Source: OpenAi
function quat_angle(q1, q2)
    local dir1 = quat_to_dir(q1)
    local dir2 = quat_to_dir(q2)
    local cosAngle = VecDot(dir1, dir2) / (VecLength(dir1) * VecLength(dir2))
    local angle = math.acos(cosAngle)
    return angle
end


--- Create a transform from two vectors.
---@param v1 any
---@param v2 any
---@return table tr Transform
function vecs_to_tr(v1, v2) return Transform(VecSub(v1, v2), QuatLookAt(v1, v2)) end
