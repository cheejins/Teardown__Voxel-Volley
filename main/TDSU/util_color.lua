--[[DEBUG COLOR]]

-- .2,.2,.8

UiColors = {

    white = Vec(1,1,1),
    grey  = Vec(0.5,0.5,0.5),
    black = Vec(0,0,0),

    red    = Vec(1,0,0),
    green  = Vec(0,1,0),
    blue   = Vec(0,0,1),
    yellow = Vec(1,1,0),

    purple = Vec(1,0,1),
    orange = Vec(1,0.5,0),
    pink   = Vec(1,0.75,0.75),
    auqua  = Vec(0,0.75,0.75),

}


---Return r,g,b values of a Color sub-table.
---@param color1 table Color from Colors table.
---@param color2 table Color from Colors table.
---@param blend number Blend between color 1 and color 2. Between 0.0 and 1.0. 
function GetColor(color1, color2, blend)

    if color2 then
        return VecLerp(color1, color2, blend or 0.5)
    else
        return unpack(color1)
    end

end

function GetColorLight(color, blend)
    return GetColor(color, UiColors.white, blend or 0.5)
end

function GetColorDark(color, blend)
    return GetColor(color, UiColors.black, blend or 0.25)
end
