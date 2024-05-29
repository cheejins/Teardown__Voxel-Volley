_Entity_Transform_Functions = {
    { name = "shape"   , func = _G["GetShapeWorldTransform"] },
    { name = "body"    , func = _G["GetBodyTransform"] },
    { name = "light"   , func = _G["GetLightTransform"] },
    { name = "vehicle" , func = _G["GetVehicleTransform"] },
    { name = "location", func = _G["GetLocationTransform"] },
    { name = "trigger" , func = _G["GetTriggerTransform"] },
}

--[[TIMERS]]
do

    function TimerCreateSeconds(seconds, zeroStart)

        local timer = { rpm = seconds }

        if zeroStart then timer.time = 0 else timer.time = seconds end

        return timer

    end

    function TimerCreateRPM(rpm, zeroStart)

        local timer = { rpm = rpm }

        if zeroStart then timer.time = 0 else timer.time = 60 / rpm end

        return timer

    end

    ---Run a timer and a table of functions.
    ---@param timer table -- = {time, rpm}
    ---@param funcs_and_args table -- Table of functions that are called when time = 0. functions = {{func = func, args = {args}}}
    ---@param runTime boolean -- Decrement time when calling this function.
    function TimerRunTimer(timer, funcs_and_args, runTime)
        if timer.time <= 0 then
            TimerResetTime(timer)

            for i = 1, #funcs_and_args do
                funcs_and_args[i]()
            end

        elseif runTime then
            TimerRunTime(timer)
        end
    end

    -- Runs the timer without resetting it.
    function TimerRunTime(timer, auto_reset_time, multiplier)
        if timer.time > 0 then
            timer.time = timer.time - (GetTimeStep() * (multiplier or 1))
        elseif auto_reset_time then
            TimerResetTime(timer)
        end
    end

    -- Set time left to 0.
    function TimerEndTime(timer)
        timer.time = 0
    end

    -- Reset time to start (60/rpm).
    function TimerResetTime(timer, extraTime)
        timer.time = timer.rpm
        timer.time = timer.time + (extraTime or 0)
    end

    function TimerConsumed(timer)
        return timer.time <= 0
    end

    -- 0.0. to 1.0. Checks how far the timer has progressed.
    function TimerGetProgress(timer)
        return timer.time / timer.rpm
    end

end


-- function CheckExplosions(cmd)

--     words = splitString(cmd, " ")
--     if #words == 5 then
--         if words[1] == "explosion" then

--             local strength = tonumber(words[2])
--             local x = tonumber(words[3])
--             local y = tonumber(words[4])
--             local z = tonumber(words[5])

--             -- DebugPrint('explosion: ')
--             -- DebugPrint('strength: ' .. strength)
--             -- DebugPrint('x: ' .. x)
--             -- DebugPrint('y: ' .. y)
--             -- DebugPrint('z: ' .. z)
--             -- DebugPrint('')

--         end
--     end

--     if #words == 8 then
--         if words[1] == "shot" then

--             local strength = tonumber(words[2])
--             local x = tonumber(words[3])
--             local y = tonumber(words[4])
--             local z = tonumber(words[5])
--             local dx = tonumber(words[6])
--             local dy = tonumber(words[7])
--             local dz = tonumber(words[8])

--             -- DebugPrint('shot: ')
--             -- DebugPrint('strength: ' .. strength)
--             -- DebugPrint('x: ' .. x)
--             -- DebugPrint('y: ' .. y)
--             -- DebugPrint('z: ' .. z)
--             -- DebugPrint('dx: ' .. dx)
--             -- DebugPrint('dy: ' .. dy)
--             -- DebugPrint('dz: ' .. dz)
--             -- DebugPrint('')

--         end
--     end

-- end


-- function AimSteerVehicle()

--     local v = GetPlayerVehicle()
--     if v ~= 0 then AimSteerVehicle(v) end

--     local vTr = GetVehicleTransform(v)
--     local camFwd = TransformToParentPoint(GetCameraTransform(), Vec(0, 0, -1))

--     local pos = TransformToLocalPoint(vTr, camFwd)
--     local steer = pos[1] / 10

--     DriveVehicle(v, 0, steer, false)

-- end


-- Find entities of a specific type (shape, body etc...) with the relevant id tag.
function MatchEntityIds(entity_table, tag_id, id)

    local e = {}

    for _, entity in ipairs(entity_table) do

        -- Check if the entity tag value has the correct id
        if GetTagValue(entity, tag_id) == id then
            table.insert(e, entity)
        end

    end

    if #e >= 1 then
        return e
    end

end


-- Check if the entity tag value has the correct id
function ExtractAllEntitiesByTag(entities, tag)

    local e = {}

    for _, entity in ipairs(entities) do
        if HasTag(entity, tag) then
            table.insert(e, entity)
        end
    end

    if #e >= 1 then
        return e
    end

end

-- Finds and returns a tagged entity from a table of entities.
function ExtractEntityByTag(entities, tag)

    for _, entity in ipairs(entities) do
        if HasTag(entity, tag) then
            return entity
        end
    end

    print("Entity: " .. tag .. " not found.")

end

---Automatically matches the entity type and returns
---@param entity any
---@return table transform
---@return string type
function GetEntityTransform(entity)

    local entity_type = GetEntityType(entity)

    for _, value in ipairs(_Entity_Transform_Functions) do
        if entity_type == value.name then
            return value.func(entity), entity_type
        end
    end

    print("ERROR: GetEntityTransform()", "No entity matches found.")

end

---@param bodies table
function RejectAllBodies(bodies) for i=1, #bodies do QueryRejectBody(bodies[i]) end end

---@param shapes table
function RejectAllShapes(shapes) for i=1, #shapes do QueryRejectShape(shapes[i]) end end


function IsTickInterval(TICK, ticksPerSecond)
    return TICK % (60 * ticksPerSecond) == 0
end

--todo fix
-- function IsTimeInterval(ticksPerMinute, offset)
--     return GetTime*60 % (ticksPerMinute) == 0
-- end

function truncateToGround(pos, rejectBodies)
	RejectAllBodies(rejectBodies or {})
	QueryRejectVehicle(GetPlayerVehicle())
	local hit, dist = QueryRaycast(pos, Vec(0, -1, 0), 5, 0.2)
	if hit then
		return VecAdd(pos, Vec(0, -dist, 0))
	end
	return false
end