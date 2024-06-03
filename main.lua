--[[
#include "main/TDSU/tdsu.lua"
#include "main/Automatic.lua"
#include "main/scripts/projectile_prefabs.lua"
]]

REG = { ModData = "savegame.mod.data.mod" }

function init()

    -- Holds all reg primitive values (magic tables are not iterable)
    ModData = util.structured_table(REG.ModData)

    -- init camera
    CameraTr = GetCameraTransform()
    CameraEnabled = true
    MouseX = 0
    MouseY = 0
    MouseXTarget = 0
    MouseYTarget = 0
    ZoomOut = 30
    ZoomOutTarget = 30

    -- init map bounds
    MouseLimitsX = { -25, 150 }
    MouseLimitsY = { 2, 10 }
    CameraBounds = {
        Vec(0, MouseLimitsY[1], MouseLimitsX[1]),
        Vec(0, MouseLimitsY[2], MouseLimitsX[2])}

    -- init slingshot
    ChargeMode = false
    ChargeVec = Vec()
    ChargeMouseX = 0
    ChargeMouseY = 0
    ChargeVelScaleMax = 7.5
    WatchProjectile = false

    -- init shot
    NewShot = true
    ShotFinished = false

    print()
    print("--------[ ANGRY VOXELS ]--------")
    print("             v0.01")
    print("--------------------------------")

    Vehicle = FindVehicle("", true)

    -- nocull scene
    for index, body in ipairs(FindBodies("", true)) do SetTag(body, "nocull") end

end

function tick()

    if InputPressed("r") then CameraEnabled = not CameraEnabled end

    -- Check whether to load new projectile.
    if not NewShot and ShotFinished then
        local randomPrefab = GetRandomArrayValue(ProjectilePrefabs)
        local entities = Spawn(randomPrefab, Transform(Vec(), QuatEuler(0, 180, 0)))
        for index, e in ipairs(entities) do
            if GetEntityType(e) == "vehicle" then
                Vehicle = e
                break
            end
        end
        NewShot = true
        ShotFinished = false
    end
    VehicleBody = GetVehicleBody(Vehicle)
    VehicleTr = GetBodyTransform(VehicleBody)


    local deleteBodies = {}
    AllBodies = FindBodies("", true)
    for _, b in ipairs(AllBodies) do

        -- find debris
        if b ~= GetToolBody() and b ~= GetWorldBody() and GetBodyVehicle(b) == 0 and GetBodyMass(b) < 100 then
            table.insert(deleteBodies, b)
            DrawBodyOutline(b, 1, 0, 0, 1)
        else
            -- keep body on XY plane.
            local bodyTr = GetBodyTransform(b)
            bodyTr.pos[1] = clamp(bodyTr.pos[1], -0.5, 0.5)

            -- prevent body from rotating on y axis
            local bodyRot = GetBodyTransform(b).rot
            bodyRot = Vec(GetQuatEuler(bodyRot))
            DebugWatch("bodyRot", bodyRot)

            SetBodyAngularVelocity(b, AutoVecSubsituteY(GetBodyAngularVelocity(b), 0))
            SetBodyVelocity(b, AutoVecSubsituteX(GetBodyVelocity(b), 0))

            SetBodyTransform(b, bodyTr) -- apply new body transform
        end

    end
    for index, db in ipairs(deleteBodies) do Delete(db) end -- delete small debris bodies.

    -- Zoom in and out.
    ZoomOutTarget = ZoomOut - (InputValue("mousewheel") * 100)
    ZoomOut = lerp(ZoomOut, ZoomOutTarget, 0.1)
    ZoomOut = clamp(ZoomOut, 30, 150)

    -- drag free camera view.
    if not InputDown("lmb") and not InputDown("rmb") and not InputDown("mmb") then

        MouseXTarget = MouseX + (InputValue("mousedx")/2)
        MouseYTarget = MouseY - (InputValue("mousedy")/2)

        MouseX = lerp(MouseX, MouseXTarget, 0.1)
        MouseY = lerp(MouseY, MouseYTarget, 0.1)

        MouseX = clamp(MouseX, MouseLimitsX[1], MouseLimitsX[2])
        MouseY = clamp(MouseY, MouseLimitsY[1], MouseLimitsY[2])

    end

    -- Release slingshot when mouse is released.
    if ChargeMode and InputReleased("lmb") then

        ChargeMode = false
        ShotFinished = false
        NewShot = false
        WatchProjectile = true

        ChargeMouseX = 0
        ChargeMouseY = 0

        SetBodyVelocity(VehicleBody, VecScale(ChargeVec, -ChargeVelScaleMax))
        ChargeVec = Vec()

    -- Charge slingshot while mouse is down.
    elseif InputDown("lmb") then

        ChargeMode = true -- charge mode will now hold until released.
        ShotFinished = false
        WatchProjectile = true

        local chargeVecPre = VecCopy(ChargeVec)
        chargeVecPre[3] = chargeVecPre[3] + (InputValue("mousedx")/50)
        chargeVecPre[2] = chargeVecPre[2] - (InputValue("mousedy")/50)

        ChargeVec[3] = chargeVecPre[3]
        ChargeVec[2] = chargeVecPre[2]

        -- prevent charger spin locking
        if VecLength(chargeVecPre) >= ChargeVelScaleMax then
            ChargeVec = VecScale(VecNormalize(ChargeVec), ChargeVelScaleMax)
        end

        DrawDot(Vec(), 1,1, 1,1,1, 1)
        DebugLine(Vec(0, 0.025, 0), VecAdd(ChargeVec, Vec(0, 0.025, 0)), 1,1,1, 1)
        DebugLine(Vec(), VecScale(VecNormalize(ChargeVec), ChargeVelScaleMax), 1,0,0, 1)
        DebugLine(Vec(0, -0.025, 0), VecAdd(ChargeVec, Vec(0, -0.025, 0)), 1,1,1, 1)

    end


    local projectileIsMoving = VecLength(GetBodyVelocity(VehicleBody)) > 0.5


    if WatchProjectile and projectileIsMoving then
        CameraTr = Transform(Vec(-ZoomOut, 0, 0), QuatEuler(0, -90, 0))
        CameraTr.pos = VecAdd(CameraTr.pos, VehicleTr.pos)
    else
        CameraTr = Transform(Vec(-ZoomOut, MouseY, MouseX), QuatEuler(0, -90, 0))
    end

    -- Shot has ended.
    if not NewShot and not ChargeMode and not projectileIsMoving then
        WatchProjectile = false
        ShotFinished = true
    end


    if CameraEnabled then
        SetCameraTransform(CameraTr)
        SetCameraFov(30)
    end


    -- Debug
    DebugWatch("mousedx", InputValue("mousedx"))
    DebugWatch("mousedy", InputValue("mousedy"))
    DebugWatch("MouseX", MouseX)
    DebugWatch("MouseY", MouseY)
    DebugWatch("ChargeMode", ChargeMode)
    DebugWatch("ChargeVec", ChargeVec)
    DebugWatch("VehicleVel", GetBodyVelocity(VehicleBody))
    DebugWatch("projectileIsMoving", projectileIsMoving)
    DebugWatch("WatchProjectile", WatchProjectile)
    DebugWatch("ShotFinished", ShotFinished)

    DrawDot(Vec(), Vec(0, -1, 0), 0.5, 0.5, 0.5, 0.5)
    DrawBodyOutline(VehicleBody, 0.5, 0.5, 0.5, 0.5)
    AabbDraw(CameraBounds[1], CameraBounds[2], 1,1,0, 0.5)

end
