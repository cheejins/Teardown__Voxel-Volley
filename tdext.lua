---@meta _

---@param command string
function Command(command, ...) end

---@param quat quaternion_t
---@return string
function QuatStr(quat) end

---@param xAxis vector_t
---@param zAxis vector_t
---@return quaternion_t
function QuatAlignXZ(xAxis, zAxis) end

---@param transform transform_t
---@return string
function TransformStr(transform) end

---@param vector vector_t
---@return string
function VecStr(vector) end

---@param file string
---@return boolean
function HasFile(file) end

---@param shape number
---@param point vector_t
---@param size number
function AddSnow(shape, point, size) end

---@param flags string List of flags separated by spaces (known flags: normalup, flat)
function ParticleOrientation(flags) end

---No Description
--- 
--- ---
--- Example
---```lua
---name = UiTextInput(name, 200, 14)
---```
---@param text string Current text
---@param w number Width
---@param h number Height
---@param focus boolean Usage in game code suggests this parameter should be set to true for 1 frame to request focus
---@return string test Potentially altered text
function UiTextInput(text, w, h, focus) end

---@return number x
---@return number y
function UiGetRelativePos() end

function DisableAllLights() end

---@param displayMode number 0=fullscreen 1=windowed 2=borderless
function GetDisplayResolutionCount(displayMode) end

---@param displayMode number 0=fullscreen 1=windowed 2=borderless
---@param index number 0 to GetDisplayResolutionCount(displayMode) - 1
function GetDisplayResolution(displayMode, index) end

---@param strength number
function ShakeCamera(strength) end

---@param a number
---@param b number
---@return number
function math.mod(a, b) end

function init() end

---@param dt number
function tick(dt) end

---@param dt number
function update(dt) end

---@param dt number
function draw(dt) end

function handleCommand(command) end
