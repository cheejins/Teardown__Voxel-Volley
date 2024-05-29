--[[MATH]]
do

    -- If n is less than zero, return a small number.
    function GTZero(n) if n <= 0 then return 1/math.huge end return n end

    -- Return a positive non-zero number if n == 0.
    function NZero(n) if n == 0 then return 1/math.huge end return n end

    ---Return a random number.
    function Random(min, max) return math.random(min, max - 1) + math.random() end

    ---Contrain a number between two numbers.
    function Clamp(value, min, max)
        if value < min then value = min end
        if value > max then value = max end
        return value
    end

    ---Oscillate a value between 0 and 1 based on time.
    ---@param time number Seconds to complete a oscillation period.
    function Oscillate(time)
        local a = ((-1/2) * math.cos(2 * math.pi * GetTime()/(time or 1))) + 0.5
        return a
    end

    ---Linear interpolation between two values.
    function Lerp(a,b,t) return a + (b-a) * 0.5 * t end

    ---Round a number to n decimals.
    function Round(x, n)
        n = 10 ^ (n or 0)
        x = x * n
        if x >= 0 then x = math.floor(x + 0.5) else x = math.ceil(x - 0.5) end
        return x / n
    end

    ---Approach a value at a specified rate.
    function ApproachValue(value, target, rate)
        if value >= target then

            if value - rate < target then
                return target
            else
                return value - rate
            end

        elseif value < target then

            if value + rate > target then
                return target
            else
                return value + rate
            end

        end
    end

end

function avg(a, b)
    return (a+b)/2
end
function slope(x1, y1, x2, y2)
    return (y2-y1)/(x2-x1)
end
function hyp(x, y) --- Return hypotenuse.
    return math.sqrt(x^2 + y^2)
end


--[[QUERY]]
do
    ---comment
    ---@param tr table -- Source transform.
    ---@param distance number -- Max raycast distance. Default is 300.
    ---@param rad number -- Raycst radius.
    ---@param rejectBodies table -- Table of bodies to reject.
    ---@param rejectShapes table -- Table of shapes to reject.
    ---@param returnNil boolean -- If true, return nil if no raycast hit. If false, return the end point of the raycast based on the transfom and distance.
    ---@return boolean h
    ---@return table p
    ---@return table s
    ---@return table b
    ---@return number d
    ---@return number n
    function RaycastFromTransform(tr, distance, rad, rejectBodies, rejectShapes, returnNil, rejectTransparent)

        if distance == nil then distance = 300 end

        if rejectBodies ~= nil then for i = 1, #rejectBodies do QueryRejectBody(rejectBodies[i]) end end
        if rejectShapes ~= nil then for i = 1, #rejectShapes do QueryRejectShape(rejectShapes[i]) end end

        local direction = QuatToDir(tr.rot)
        local h, d, n, s = QueryRaycast(tr.pos, direction, distance, rad, rejectTransparent)
        local p = TransformToParentPoint(tr, Vec(0, 0, -d))
        local b = GetShapeBody(s)

        if h then
            return h, p, s, b, d, n
        elseif not returnNil then
            p = TransformToParentPoint(tr, Vec(0, 0, -distance))
            return false, p, nil, nil, nil, nil
        end

    end

end


--[[BOOLEAN]]
function boolflip(bool) return not bool end


function clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end

function toboolean(str)
    local bool = false
    if str == "true" then
        bool = true
    end
    return bool
end

function CompressRange(val, lower, upper)
    return (val-lower) / (upper-lower)
end

function GetInterval(frequency)
    if GetTime() % frequency > 0.5 then
        return 1
    end
    return 0
end

function lerp(a,b,r)
	return a*(1-r)+b*r
end


---Forms a bell curve to fade a number within a range.
---@param x number The input number you want to fade.
---@param mean number The peak of the bell curve (where you want the maximum fading to occur).
---@param stddev number The standard deviation which controls the width of the bell curve.
function gaussian_fade(x, mean, stddev)
    local pi = math.pi
    local e = math.exp
    local sqrt = math.sqrt

    return (1 / (stddev * sqrt(2 * pi))) * e(-0.5 * ((x - mean) / stddev)^2)
end