-- Cameras = {}


function camera_create(x, y, zoom, zoom_lim_in, zoom_lim_out)

	local camera = {
		cameraX       = x or 0,
		cameraY       = y or 0,
		zoom          = zoom or 2,
		zoom_lim_in   = zoom_lim_in, -- zoom limit
		zoom_lim_out  = zoom_lim_out, -- zoom limit
	}

	return camera

end

function camera_manage(cam, pos, extra_height)

	local mx, my = InputValue("mousedx"), InputValue("mousedy")

	cam.cameraX = cam.cameraX - mx / 10
	cam.cameraY = cam.cameraY - my / 10
	cam.cameraY = clamp(cam.cameraY, -90, 90)

	local cameraRot = QuatEuler(cam.cameraY, cam.cameraX, 0)
	local cameraT = Transform(pos, cameraRot)

	cam.zoom = cam.zoom - InputValue("mousewheel")
	cam.zoom = clamp(cam.zoom, cam.zoom_lim_in or 2, cam.zoom_lim_out or 20)

	local cameraPos = TransformToParentPoint(cameraT, Vec(0, (extra_height or 0) + cam.zoom/10, cam.zoom))
	local camera = Transform(VecLerp(cameraPos, GetCameraTransform().pos, 0.5), cameraRot)

	SetCameraTransform(camera)

end


function GetCrosshairWorldPos(rejectBodies)

    local crosshairTr = getCrosshairTr()
    -- rejectAllBodies(rejectBodies)
    local crosshairHit, crosshairHitPos = RaycastFromTransform(crosshairTr, 200)
    if crosshairHit then
        return crosshairHitPos
    else
        return nil
    end

end

function GetCrosshairCameraTr(pos, x, y)

    pos = pos or GetCameraTransform()

    local crosshairDir = UiPixelToWorld(x or UiCenter(), y or UiMiddle())
    local crosshairQuat = DirToQuat(crosshairDir)
    local crosshairTr = Transform(GetCameraTransform().pos, crosshairQuat)

    return crosshairTr

end