--[[
#include "main/TDSU/tdsu.lua"
#include "main/Automatic.lua"
#include "main/scripts/projectile_prefabs.lua"
]]

REG = { ModData = "savegame.mod.data.mod" }

function init()

    ModData = util.structured_table(REG.ModData)

    MouseX = 0
    MouseY = 0
    MouseXTarget = 0
    MouseYTarget = 0

    ZoomOut = 30
    ZoomOutTarget = 30

    print()
    print("--------[ ANGRY VOXELS ]--------")
    print("             v0.01")
    print("--------------------------------")

    for index, body in ipairs(FindBodies("", true)) do
        SetTag(body, "nocull")
    end

    CameraTr = GetCameraTransform()

    Vehicle = FindVehicle("", true)
    SetBodyTransform(Vehicle, Transform())

    ChargeMode = false
    ChargeVec = Vec()
    ChargeMouseX = 0
    ChargeMouseY = 0
    ChargeVelScaleMax = 7.5
    WatchProjectile = false

    NewShot = true
    ShotFinished = false

    -- TB_AllBodiesStartTransforms = {}
    -- AllBodiesStart = FindBodies("", true)
    -- for _, b in ipairs(AllBodies) do
    --     TB_AllBodiesStartTransforms[b] = GetBodyTransform(b)
    -- end

end

function tick()

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
            bodyTr = GetBodyTransform(b)
            bodyTr.pos[1] = clamp(bodyTr.pos[1], -1, 1)

            -- prevent body from rotating on y axis
            -- local bodyEuler = AutoVecSubsituteY(Vec(GetQuatEuler(bodyTr.rot)), 0)
            -- local bodyRotTarget = QuatEuler(unpack(bodyEuler))
            -- ConstrainOrientation(b, 0, bodyTr.rot, bodyRotTarget, nil, GetBodyMass(b)/2)

            -- prevent body from spinning
            SetBodyAngularVelocity(b, AutoVecSubsituteY(GetBodyAngularVelocity(b), 0))

            -- apply new body transform
            SetBodyTransform(b, bodyTr)
        end

    end
    for index, db in ipairs(deleteBodies) do -- delete debris bodies.
        Delete(db)
    end

    -- Zoom in and out.
    ZoomOutTarget = ZoomOut - (InputValue("mousewheel") * 100)
    ZoomOut = lerp(ZoomOut, ZoomOutTarget, 0.1)
    ZoomOut = clamp(ZoomOut, 30, 150)

    -- Drag free camera view.
    if InputDown("rmb") or InputDown("mmb") then

        MouseXTarget = MouseX - (InputValue("mousedx")/2)
        MouseYTarget = MouseY + (InputValue("mousedy")/2)

        MouseX = lerp(MouseX, MouseXTarget, 0.1)
        MouseY = lerp(MouseY, MouseYTarget, 0.1)

        MouseY = clamp(MouseY, 0, 10)
        MouseX = clamp(MouseX, -50, 150)

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

        if VecLength(chargeVecPre) < ChargeVelScaleMax then
            ChargeVec[3] = chargeVecPre[3]
            ChargeVec[2] = chargeVecPre[2]
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


    SetCameraTransform(CameraTr)
    SetCameraFov(30)


    -- Debug
    DrawDot(Vec(), Vec(0, -1, 0), 0.5, 0.5, 0.5, 0.5)
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
    DrawBodyOutline(VehicleBody, 0.5, 0.5, 0.5, 0.5)

end
