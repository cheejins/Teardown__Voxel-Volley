---@meta _

---@class vector_t
---@field [1] number
---@field [2] number
---@field [3] number

---@class quaternion_t
---@field [1] number
---@field [2] number
---@field [3] number
---@field [4] number

---@class transform_t
---@field pos vector_t
---@field rot quaternion_t

---@class entity_handle: integer
---@class body_handle: entity_handle
---@class shape_handle: entity_handle
---@class location_handle: entity_handle
---@class joint_handle: entity_handle
---@class light_handle: entity_handle
---@class trigger_handle: entity_handle
---@class screen_handle: entity_handle
---@class vehicle_handle: entity_handle

---@class sound_handle: integer
---@class loop_handle: integer

---@class sprite_handle: integer

---No Description
--- 
--- ---
--- Example
---```lua
-----Retrieve blinkcount parameter, or set to 5 if omitted
---parameterBlinkCount = GetIntParam("blinkcount", 5)
---```
---@param name string Parameter name
---@param default number Default parameter value
---@return number value Parameter value
function GetIntParam(name, default) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Retrieve speed parameter, or set to 10.0 if omitted
---parameterSpeed = GetFloatParam("speed", 10.0)
---```
---@param name string Parameter name
---@param default number Default parameter value
---@return number value Parameter value
function GetFloatParam(name, default) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Retrieve playsound parameter, or false if omitted
---parameterPlaySound = GetBoolParam("playsound", false)
---```
---@param name string Parameter name
---@param default boolean Default parameter value
---@return boolean value Parameter value
function GetBoolParam(name, default) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Retrieve mode parameter, or "idle" if omitted
---parameterMode = GetSrtingParam("mode", "idle")
---```
---@param name string Parameter name
---@param default string Default parameter value
---@return string value Parameter value
function GetStringParam(name, default) end

---No Description
--- 
--- ---
--- Example
---```lua
---local v = GetVersion()
-----v is "0.5.0"
---```
---@return string version Dot separated string of current version of the game
function GetVersion() end

---No Description
--- 
--- ---
--- Example
---```lua
---if HasVersion("0.6.0") then
---	--conditional code that only works on 0.6.0 or above
---else
---	--legacy code that works on earlier versions
---end
---```
---@param version string Reference version
---@return boolean match True if current version is at least provided one
function HasVersion(version) end

---Returns running time of this script. If called from update, this returns the simulated time, otherwise it returns wall time.
--- 
--- ---
--- Example
---```lua
---local t = GetTime()
---```
---@return number time The time in seconds since level was started
function GetTime() end

---Returns timestep of the last frame. If called from update, this returns the simulation time step, which is always one 60th of a second (0.0166667). If called from tick or draw it returns the actual time since last frame.
--- 
--- ---
--- Example
---```lua
---local dt = GetTimeStep()
---```
---@return number dt The timestep in seconds
function GetTimeStep() end

---No Description
--- 
--- ---
--- Example
---```lua
---name = InputLastPressedKey()
---```
---@return string name Name of last pressed key, empty if no key is pressed
function InputLastPressedKey() end

---No Description
--- 
--- ---
--- Example
---```lua
---if InputPressed("interact") then
---	...
---end
---```
---@param input string The input identifier
---@return boolean pressed True if input was pressed during last frame
function InputPressed(input) end

---No Description
--- 
--- ---
--- Example
---```lua
---if InputReleased("interact") then
---	...
---end
---```
---@param input string The input identifier
---@return boolean pressed True if input was released during last frame
function InputReleased(input) end

---No Description
--- 
--- ---
--- Example
---```lua
---if InputDown("interact") then
---...
---end
---```
---@param input string The input identifier
---@return boolean pressed True if input is currently held down
function InputDown(input) end

---No Description
--- 
--- ---
--- Example
---```lua
---scrollPos = scrollPos + InputValue("mousewheel")
---```
---@param input string The input identifier
---@return number value Depends on input type
function InputValue(input) end

---Set value of a number variable in the global context with an optional transition. If a transition is provided the value will animate from current value to the new value during the transition time. Transition can be one of the following:
---
---| Transition | Description|
---|-|-|
---|linear|Linear transition|
---|cosine|Slow at beginning and end|
---|easein|Slow at beginning|
---|easeout|Slow at end|
---|bounce|Bounce and overshoot new value|
--- ---
--- Example
---```lua
---myValue = 0
---SetValue("myValue", 1, "linear", 0.5)
---
---This will change the value of myValue from 0 to 1 in a linear fasion over 0.5 seconds
---```
---@param variable string Name of number variable in the global context
---@param value number The new value
---@param transition? string Transition type. See description.
---@param time? number Transition time (seconds)
function SetValue(variable, value, transition, time) end

---Calling this function will add a button on the bottom bar or in the main pause menu (center of the screen) when the game is paused. A primary button will be placed in the main pause menu if this function is called from a playable mod. There can be only one primary button. Use this as a way to bring up mod settings or other user interfaces while the game is running. Call this function every frame from the tick function for as long as the pause menu button should still be visible.
--- 
--- ---
--- Example
---```lua
---function tick()
---
---    -- Primary button will be placed in the main pause menu
---	if PauseMenuButton("Back to Hub", true) then
---		StartLevel("hub", "MOD/hub.xml")
---	end
---	
---	-- Button will be placed in the bottom bar of the pause menu
---	if PauseMenuButton("MyMod Settings") then
---		visible = true
---	end
---end
---
---function draw()
---	if visible then
---		UiMakeInteractive()
---		...
---	end
---end
---```
---@param title string Text on button
---@param primary? boolean Primary button
---@return boolean clicked True if clicked, false otherwise
function PauseMenuButton(title, primary) end

---Start a level
--- 
--- ---
--- Example
---```lua
-----Start level with no active layers
---StartLevel("level1", "MOD/level1.xml")
---
-----Start level with two layers
---StartLevel("level1", "MOD/level1.xml", "vehicles targets")
---```
---@param mission string An identifier of your choice
---@param path string Path to level XML file
---@param layers? string Active layers. Default is no layers.
---@param passThrough? boolean If set, loading screen will have no text and music will keep playing
function StartLevel(mission, path, layers, passThrough) end

---Set paused state of the game
--- 
--- ---
--- Example
---```lua
-----Pause game and bring up pause menu on HUD
---SetPaused(true)
---```
---@param paused boolean True if game should be paused
function SetPaused(paused) end

---Restart level
--- 
--- ---
--- Example
---```lua
---if shouldRestart then
---Restart()
---end
---```
function Restart() end

---Go to main menu
--- 
--- ---
--- Example
---```lua
---if shouldExitLevel then
---Menu()
---end
---```
function Menu() end

---Remove registry node, including all child nodes.
--- 
--- ---
--- Example
---```lua
-----If the registry looks like this:
-----	score
-----		levels
-----			level1 = 5
-----			level2 = 4
---
---ClearKey("score.levels")
---
-----Afterwards, the registry will look like this:
-----	score
---```
---@param key string Registry key to clear
function ClearKey(key) end

---List all child keys of a registry node.
--- 
--- ---
--- Example
---```lua
-----If the registry looks like this:
-----	score
-----		levels
-----			level1 = 5
-----			level2 = 4
---
---local list = ListKeys("score.levels")
---for i=1, #list do
---	print(list[i])
---end
---
-----This will output:
-----level1
-----level2
---```
---@param parent string The parent registry key
---@return string[] children Indexed table of strings with child keys
function ListKeys(parent) end

---Returns true if the registry contains a certain key
--- 
--- ---
--- Example
---```lua
---local foo = HasKey("score.levels")
---```
---@param key string Registry key
---@return boolean exists True if key exists
function HasKey(key) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetInt("score.levels.level1", 4)
---```
---@param key string Registry key
---@param value number Desired value
function SetInt(key, value) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = GetInt("score.levels.level1")
---```
---@param key string Registry key
---@return number value Integer value of registry node or zero if not found
function GetInt(key) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetFloat("level.time", 22.3)
---```
---@param key string Registry key
---@param value number Desired value
function SetFloat(key, value) end

---No Description
--- 
--- ---
--- Example
---```lua
---local time = GetFloat("level.time")
---```
---@param key string Registry key
---@return number value Float value of registry node or zero if not found
function GetFloat(key) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetBool("level.robots.enabled", true)
---```
---@param key string Registry key
---@param value boolean Desired value
function SetBool(key, value) end

---No Description
--- 
--- ---
--- Example
---```lua
---local isRobotsEnabled = GetBool("level.robots.enabled")
---```
---@param key string Registry key
---@return boolean value Boolean value of registry node or false if not found
function GetBool(key) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetString("level.name", "foo")
---```
---@param key string Registry key
---@param value string Desired value
function SetString(key, value) end

---No Description
--- 
--- ---
--- Example
---```lua
---local name = GetString("level.name")
---```
---@param key string Registry key
---@return string value String value of registry node or "" if not found
function GetString(key) end

---Create new vector and optionally initializes it to the provided values. A Vec is equivalent to a regular lua table with three numbers.
--- 
--- ---
--- Example
---```lua
-----These are equivalent
---local a1 = Vec()
---local a2 = {0, 0, 0}
---
-----These are equivalent
---local b1 = Vec(0, 1, 0)
---local b2 = {0, 1, 0}
---```
---@param x? number X value
---@param y? number Y value
---@param z? number Z value
---@return vector_t vec New vector
function Vec(x, y, z) end

---Vectors should never be assigned like regular numbers. Since they are implemented with lua tables assignment means two references pointing to the same data. Use this function instead.
--- 
--- ---
--- Example
---```lua
-----Do this to assign a vector
---local right1 = Vec(1, 2, 3)
---local right2 = VecCopy(right1)
---
-----Never do this unless you REALLY know what you're doing
---local wrong1 = Vec(1, 2, 3)
---local wrong2 = wrong1
---```
---@param org vector_t A vector
---@return vector_t new Copy of org vector
function VecCopy(org) end

---No Description
--- 
--- ---
--- Example
---```lua
---local v = Vec(1,1,0)
---local l = VecLength(v)
---
-----l now equals 1.41421356
---```
---@param vec vector_t A vector
---@return number length Length (magnitude) of the vector
function VecLength(vec) end

---If the input vector is of zero length, the function returns {0,0,1}
--- 
--- ---
--- Example
---```lua
---local v = Vec(0,3,0)
---local n = VecNormalize(v)
---
-----n now equals {0,1,0}
---```
---@param vec vector_t A vector
---@return vector_t norm A vector of length 1.0
function VecNormalize(vec) end

---No Description
--- 
--- ---
--- Example
---```lua
---local v = Vec(1,2,3)
---local n = VecScale(v, 2)
---
-----n now equals {2,4,6}
---```
---@param vec vector_t A vector
---@param scale number A scale factor
---@return vector_t norm A scaled version of input vector
function VecScale(vec, scale) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = Vec(1,2,3)
---local b = Vec(3,0,0)
---local c = VecAdd(a, b)
---
-----c now equals {4,2,3}
---```
---@param a vector_t Vector
---@param b vector_t Vector
---@return vector_t c New vector with sum of a and b
function VecAdd(a, b) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = Vec(1,2,3)
---local b = Vec(3,0,0)
---local c = VecSub(a, b)
---
-----c now equals {-2,2,3}
---```
---@param a vector_t Vector
---@param b vector_t Vector
---@return vector_t c New vector representing a-b
function VecSub(a, b) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = Vec(1,2,3)
---local b = Vec(3,1,0)
---local c = VecDot(a, b)
---
-----c now equals 5
---```
---@param a vector_t Vector
---@param b vector_t Vector
---@return number c Dot product of a and b
function VecDot(a, b) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = Vec(1,0,0)
---local b = Vec(0,1,0)
---local c = VecCross(a, b)
---
-----c now equals {0,0,1}
---```
---@param a vector_t Vector
---@param b vector_t Vector
---@return vector_t c Cross product of a and b (also called vector product)
function VecCross(a, b) end

---No Description
--- 
--- ---
--- Example
---```lua
---local a = Vec(2,0,0)
---local b = Vec(0,4,2)
---local t = 0.5
---
-----These two are equivalent
---local c1 = VecLerp(a, b, t)
---lcoal c2 = VecAdd(VecScale(a, 1-t), VecScale(b, t))
---
-----c1 and c2 now equals {1, 2, 1}
---```
---@param a vector_t Vector
---@param b vector_t Vector
---@param t number fraction (usually between 0.0 and 1.0)
---@return vector_t c Linearly interpolated vector between a and b, using t
function VecLerp(a, b, t) end

---Create new quaternion and optionally initializes it to the provided values. Do not attempt to initialize a quaternion with raw values unless you know what you are doing. Use QuatEuler or QuatAxisAngle instead. If no arguments are given, a unit quaternion will be created: {0, 0, 0, 1}. A quaternion is equivalent to a regular lua table with four numbers.
--- 
--- ---
--- Example
---```lua
-----These are equivalent
---local a1 = Quat()
---local a2 = {0, 0, 0, 1}
---```
---@param x? number X value
---@param y? number Y value
---@param z? number Z value
---@param w? number W value
---@return quaternion_t quat New quaternion
function Quat(x, y, z, w) end

---Quaternions should never be assigned like regular numbers. Since they are implemented with lua tables assignment means two references pointing to the same data. Use this function instead.
--- 
--- ---
--- Example
---```lua
-----Do this to assign a quaternion
---local right1 = QuatEuler(0, 90, 0)
---local right2 = QuatCopy(right1)
---
-----Never do this unless you REALLY know what you're doing
---local wrong1 = QuatEuler(0, 90, 0)
---local wrong2 = wrong1
---```
---@param org quaternion_t Quaternion
---@return quaternion_t new Copy of org quaternion
function QuatCopy(org) end

---Create a quaternion representing a rotation around a specific axis
--- 
--- ---
--- Example
---```lua
-----Create quaternion representing rotation 30 degrees around Y axis
---local q = QuatAxisAngle(Vec(0,1,0), 30)
---```
---@param axis vector_t Rotation axis, unit vector
---@param angle number Rotation angle in degrees
---@return quaternion_t quat New quaternion
function QuatAxisAngle(axis, angle) end

---Create quaternion using euler angle notation. The order of applied rotations uses the "NASA standard aeroplane" model:
---
---* Rotation around Y axis (yaw or heading)
---* Rotation around Z axis (pitch or attitude)
---* Rotation around X axis (roll or bank)
--- ---
--- Example
---```lua
-----Create quaternion representing rotation 30 degrees around Y axis and 25 degrees around Z axis
---local q = QuatEuler(0, 30, 25)
---```
---@param x number Angle around X axis in degrees, sometimes also called roll or bank
---@param y number Angle around Y axis in degrees, sometimes also called yaw or heading
---@param z number Angle around Z axis in degrees, sometimes also called pitch or attitude
---@return quaternion_t quat New quaternion
function QuatEuler(x, y, z) end

---Return euler angles from quaternion. The order of rotations uses the "NASA standard aeroplane" model:
---
---* Rotation around Y axis (yaw or heading)
---* Rotation around Z axis (pitch or attitude)
---* Rotation around X axis (roll or bank)
--- ---
--- Example
---```lua
-----Return euler angles from quaternion q
---rx, ry, rz = GetQuatEuler(q)
---```
---@param quat quaternion_t Quaternion
---@return number x Angle around X axis in degrees, sometimes also called roll or bank
---@return number y Angle around Y axis in degrees, sometimes also called yaw or heading
---@return number z Angle around Z axis in degrees, sometimes also called pitch or attitude
function GetQuatEuler(quat) end

---Create a quaternion pointing the negative Z axis (forward) towards a specific point, keeping the Y axis upwards. This is very useful for creating camera transforms.
--- 
--- ---
--- Example
---```lua
---local eye = Vec(0, 10, 0)
---local target = Vec(0, 1, 5)
---local rot = QuatLookAt(eye, target)
---SetCameraTransform(Transform(eye, rot))
---```
---@param eye vector_t Vector representing the camera location
---@param target vector_t Vector representing the point to look at
---@return quaternion_t quat New quaternion
function QuatLookAt(eye, target) end

---Spherical, linear interpolation between a and b, using t. This is very useful for animating between two rotations.
--- 
--- ---
--- Example
---```lua
---local a = QuatEuler(0, 10, 0)
---local b = QuatEuler(0, 0, 45)
---
-----Create quaternion half way between a and b
---local q = QuatSlerp(a, b, 0.5)
---```
---@param a quaternion_t Quaternion
---@param b quaternion_t Quaternion
---@param t number fraction (usually between 0.0 and 1.0)
---@return quaternion_t c New quaternion
function QuatSlerp(a, b, t) end

---Rotate one quaternion with another quaternion. This is mathematically equivalent to c = a * b using quaternion multiplication.
--- 
--- ---
--- Example
---```lua
---local a = QuatEuler(0, 10, 0)
---local b = QuatEuler(0, 0, 45)
---local q = QuatRotateQuat(a, b)
---
-----q now represents a rotation first 10 degrees around
-----the Y axis and then 45 degrees around the Z axis.
---```
---@param a quaternion_t Quaternion
---@param b quaternion_t Quaternion
---@return quaternion_t c New quaternion
function QuatRotateQuat(a, b) end

---Rotate a vector by a quaternion
--- 
--- ---
--- Example
---```lua
---local q = QuatEuler(0, 10, 0)
---local v = Vec(1, 0, 0)
---local r = QuatRotateVec(q, v)
---
-----r is now vector a rotated 10 degrees around the Y axis
---```
---@param a quaternion_t Quaternion
---@param vec vector_t Vector
---@return vector_t vec Rotated vector
function QuatRotateVec(a, vec) end

---A transform is a regular lua table with two entries: pos and rot, a vector and quaternion representing transform position and rotation.
--- 
--- ---
--- Example
---```lua
-----Create transform located at {0, 0, 0} with no rotation
---local t1 = Transform()
---
-----Create transform located at {10, 0, 0} with no rotation
---local t2 = Transform(Vec(10, 0,0))
---
-----Create transform located at {10, 0, 0}, rotated 45 degrees around Y axis
---local t2 = Transform(Vec(10, 0,0), QuatEuler(0, 45, 0))
---```
---@param pos? vector_t Vector representing transform position
---@param rot? quaternion_t Quaternion representing transform rotation
---@return transform_t transform New transform
function Transform(pos, rot) end

---Transforms should never be assigned like regular numbers. Since they are implemented with lua tables assignment means two references pointing to the same data. Use this function instead.
--- 
--- ---
--- Example
---```lua
-----Do this to assign a quaternion
---local right1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
---local right2 = TransformCopy(right1)
---
-----Never do this unless you REALLY know what you're doing
---local wrong1 = Transform(Vec(1,0,0), QuatEuler(0, 90, 0))
---local wrong2 = wrong1
---```
---@param org transform_t Transform
---@return transform_t new Copy of org transform
function TransformCopy(org) end

---Transform child transform out of the parent transform. This is the opposite of TransformToLocalTransform.
--- 
--- ---
--- Example
---```lua
---local b = GetBodyTransform(body)
---local s = GetShapeLocalTransform(shape)
---
-----b represents the location of body in world space
-----s represents the location of shape in body space
---
---local w = TransformToParentTransform(b, s)
---
-----w now represents the location of shape in world space
---```
---@param parent transform_t Transform
---@param child transform_t Transform
---@return transform_t transform New transform
function TransformToParentTransform(parent, child) end

---Transform one transform into the local space of another transform. This is the opposite of TransformToParentTransform.
--- 
--- ---
--- Example
---```lua
---local b = GetBodyTransform(body)
---local w = GetShapeWorldTransform(shape)
---
-----b represents the location of body in world space
-----w represents the location of shape in world space
---
---local s = TransformToLocalTransform(b, w)
---
-----s now represents the location of shape in body space.
---```
---@param parent transform_t Transform
---@param child transform_t Transform
---@return transform_t transform New transform
function TransformToLocalTransform(parent, child) end

---Transfom vector v out of transform t only considering rotation.
--- 
--- ---
--- Example
---```lua
---local t = GetBodyTransform(body)
---local localUp = Vec(0, 1, 0)
---local up = TransformToParentVec(t, localUp)
---
-----up now represents the local body up direction in world space
---```
---@param t transform_t Transform
---@param v vector_t Vector
---@return vector_t r Transformed vector
function TransformToParentVec(t, v) end

---Transfom vector v into transform t only considering rotation.
--- 
--- ---
--- Example
---```lua
---local t = GetBodyTransform(body)
---local worldUp = Vec(0, 1, 0)
---local up = TransformToLocalVec(t, worldUp)
---
-----up now represents the world up direction in local body space
---```
---@param t transform_t Transform
---@param v vector_t Vector
---@return vector_t r Transformed vector
function TransformToLocalVec(t, v) end

---Transfom position p out of transform t.
--- 
--- ---
--- Example
---```lua
---local t = GetBodyTransform(body)
---local bodyPoint = Vec(0, 0, -1)
---local p = TransformToParentPoint(t, bodyPoint)
---
-----p now represents the local body point {0, 0, -1 } in world space
---```
---@param t transform_t Transform
---@param p vector_t Vector representing position
---@return vector_t r Transformed position
function TransformToParentPoint(t, p) end

---Transfom position p into transform t.
--- 
--- ---
--- Example
---```lua
---local t = GetBodyTransform(body)
---local worldOrigo = Vec(0, 0, 0)
---local p = TransformToLocalPoint(t, worldOrigo)
---
-----p now represents the position of world origo in local body space
---```
---@param t transform_t Transform
---@param p vector_t Vector representing position
---@return vector_t r Transformed position
function TransformToLocalPoint(t, p) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Add "special" tag to an entity
---SetTag(handle, "special")
---
-----Add "team" tag to an entity and give it value "red"
---SetTag(handle, "team", "red")
---```
---@param handle entity_handle Entity handle
---@param tag string Tag name
---@param value? string Tag value
function SetTag(handle, tag, value) end

---Remove tag from an entity. If the tag had a value it is removed too.
--- 
--- ---
--- Example
---```lua
---RemoveTag(handle, "special")
---```
---@param handle entity_handle Entity handle
---@param tag string Tag name
function RemoveTag(handle, tag) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetTag(handle, "special")
---local hasSpecial = HasTag(handle, "special") 
----- hasSpecial will be true
---```
---@param handle entity_handle Entity handle
---@param tag string Tag name
---@return boolean exists Returns true if entity has tag
function HasTag(handle, tag) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetTag(handle, "special")
---value = GetTagValue(handle, "special")
----- value will be ""
---
---SetTag(handle, "special", "foo")
---value = GetTagValue(handle, "special")
----- value will be "foo"
---```
---@param handle entity_handle Entity handle
---@param tag string Tag name
---@return string value Returns the tag value, if any. Empty string otherwise.
function GetTagValue(handle, tag) end

---No Description
--- 
--- ---
--- Example
---```lua
-----List all tags and their tag values for a particular entity
---local tags = ListTags(handle)
---for i=1, #tags do
---	DebugPrint(tags[i] .. " " .. GetTagValue(handle, tags[i]))
---end
---```
---@param handle entity_handle Entity handle
---@return table tags Indexed table of tags on entity
function ListTags(handle) end

---All entities can have an associated description. For bodies and shapes this can be provided through the editor. This function retrieves that description.
--- 
--- ---
--- Example
---```lua
---local desc = GetDescription(body)
---```
---@param handle entity_handle Entity handle
---@return string description The description string
function GetDescription(handle) end

---All entities can have an associated description. The description for bodies and shapes will show up on the HUD when looking at them.
--- 
--- ---
--- Example
---```lua
---SetDescription(body, "Target object")
---```
---@param handle entity_handle Entity handle
---@param description string The description string
function SetDescription(handle, description) end

---Remove an entity from the scene. All entities owned by this entity will also be removed.
--- 
--- ---
--- Example
---```lua
---Delete(body)
-----All shapes associated with body will also be removed
---```
---@param handle entity_handle Entity handle
function Delete(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---valid = IsHandleValid(body)
---
-----valid is true if body still exists
---
---Delete(body)
---valid = IsHandleValid(body)
---
-----valid will now be false
---```
---@param handle entity_handle Entity handle
---@return boolean exists Returns true if the entity pointed to by handle still exists
function IsHandleValid(handle) end

---Returns the type name of provided entity, for example "body", "shape", "light", etc.
--- 
--- ---
--- Example
---```lua
---local t = GetEntityType(e)
---if t == "body" then
---	--e is a body handle
---end
---```
---@param handle entity_handle Entity handle
---@return string type Type name of the provided entity
function GetEntityType(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for a body tagged "target" in script scope
---local target = FindBody("target")
---
-----Search for a body tagged "escape" in entire scene
---local escape = FindBody("escape", true)
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return body_handle handle Handle to first body with specified tag or zero if not found
function FindBody(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for bodies tagged "target" in script scope
---local targets = FindBodies("target")
---for i=1, #targets do
---	local target = targets[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return body_handle[] list Indexed table with handles to all bodies with specified tag
function FindBodies(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = GetBodyTransform(body)
---```
---@param handle body_handle Body handle
---@return transform_t transform Transform of the body
function GetBodyTransform(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Move a body 1 meter upwards
---local t = GetBodyTransform(body)
---t.pos = VecAdd(t.pos, Vec(0, 1, 0))
---SetBodyTransform(body, t)
---```
---@param handle body_handle Body handle
---@param transform transform_t Desired transform
function SetBodyTransform(handle, transform) end

---No Description
--- 
--- ---
--- Example
---```lua
---local mass = GetBodyMass(body)
---```
---@param handle body_handle Body handle
---@return number mass Body mass. Static bodies always return zero mass.
function GetBodyMass(handle) end

---Check if body is dynamic. Note that something that was created static may become dynamic due to destruction.
--- 
--- ---
--- Example
---```lua
---local dynamic = IsBodyDynamic(body)
---```
---@param handle body_handle Body handle
---@return boolean dynamic Return true if body is dynamic
function IsBodyDynamic(handle) end

---Change the dynamic state of a body. There is very limited use for this function. In most situations you should leave it up to the engine to decide. Use with caution.
--- 
--- ---
--- Example
---```lua
---SetBodyDynamic(body, false)
---```
---@param handle body_handle Body handle
---@param dynamic boolean True for dynamic. False for static.
function SetBodyDynamic(handle, dynamic) end

---This can be used for animating bodies with preserved physical interaction, but in most cases you are better off with a motorized joint instead.
--- 
--- ---
--- Example
---```lua
---local vel = Vec(2,0,0)
---SetBodyVelocity(body, vel)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@param velocity vector_t Vector with linear velocity
function SetBodyVelocity(handle, velocity) end

---No Description
--- 
--- ---
--- Example
---```lua
---local linVel = GetBodyVelocity(body)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@return vector_t velocity Linear velocity as vector
function GetBodyVelocity(handle) end

---Return the velocity on a body taking both linear and angular velocity into account.
--- 
--- ---
--- Example
---```lua
---local vel = GetBodyVelocityAtPos(body, pos)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@param pos vector_t World space point as vector
---@return vector_t velocity Linear velocity on body at pos as vector
function GetBodyVelocityAtPos(handle, pos) end

---This can be used for animating bodies with preserved physical interaction, but in most cases you are better off with a motorized joint instead.
--- 
--- ---
--- Example
---```lua
---local angVel = Vec(2,0,0)
---SetBodyAngularVelocity(body, angVel)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@param angVel vector_t Vector with angular velocity
function SetBodyAngularVelocity(handle, angVel) end

---No Description
--- 
--- ---
--- Example
---```lua
---local angVel = GetBodyAngularVelocity(body)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@return vector_t angVel Angular velocity as vector
function GetBodyAngularVelocity(handle) end

---Check if body is body is currently simulated. For performance reasons, bodies that don't move are taken out of the simulation. This function can be used to query the active state of a specific body. Only dynamic bodies can be active.
--- 
--- ---
--- Example
---```lua
---if IsBodyActive(body) then
---	...
---end
---```
---@param handle body_handle Body handle
---@return boolean active Return true if body is active
function IsBodyActive(handle) end

---This function makes it possible to manually activate and deactivate bodies to include or exclude in simulation. The engine normally handles this automatically, so use with care.
--- 
--- ---
--- Example
---```lua
-----Wake up body
---SetBodyActive(body, true)
---
-----Put body to sleep
---SetBodyActive(body, false)
---```
---@param handle body_handle Body handle
---@param active boolean Set to tru if body should be active (simulated)
function SetBodyActive(handle, active) end

---Apply impulse to dynamic body at position (give body a push).
--- 
--- ---
--- Example
---```lua
---local pos = Vec(0,1,0)
---local imp = Vec(0,0,10)
---ApplyBodyImpulse(body, pos, imp)
---```
---@param handle body_handle Body handle (should be a dynamic body)
---@param position vector_t World space position as vector
---@param impulse vector_t World space impulse as vector
function ApplyBodyImpulse(handle, position, impulse) end

---Return handles to all shapes owned by a body
--- 
--- ---
--- Example
---```lua
---local shapes = GetBodyShapes(body)
---for i=1,#shapes do
---	local shape = shapes[i]
---end
---```
---@param handle body_handle Body handle
---@return shape_handle[] list Indexed table of shape handles
function GetBodyShapes(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local vehicle = GetBodyVehicle(body)
---```
---@param body body_handle Body handle
---@return vehicle_handle handle Get parent vehicle for body, or zero if not part of vehicle
function GetBodyVehicle(body) end

---Return the world space, axis-aligned bounding box for a body.
--- 
--- ---
--- Example
---```lua
---local min, max = GetBodyBounds(body)
---local boundsSize = VecSub(max, min)
---local center = VecLerp(min, max, 0.5)
---```
---@param handle body_handle Body handle
---@return vector_t min Vector representing the AABB lower bound
---@return vector_t max Vector representing the AABB upper bound
function GetBodyBounds(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Visualize center of mass on for body
---local com = GetBodyCenterOfMass(body)
---local worldPoint = TransformToParentPoint(GetBodyTransform(body), com)
---DebugCross(worldPoint)
---```
---@param handle body_handle Body handle
---@return vector_t point Vector representing local center of mass in body space
function GetBodyCenterOfMass(handle) end

---This will check if a body is currently visible in the camera frustum and not occluded by other objects.
--- 
--- ---
--- Example
---```lua
---if IsBodyVisible(body, 25) then
---	--Body is within 25 meters visible to the camera
---end
---```
---@param handle body_handle Body handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent? boolean See through transparent materials. Default false.
---@return boolean visible Return true if body is visible
function IsBodyVisible(handle, maxDist, rejectTransparent) end

---Determine if any shape of a body has been broken.
--- 
--- ---
--- Example
---```lua
---local broken = IsBodyBroken(body)
---```
---@param handle body_handle Body handle
---@return boolean broken Return true if body is broken
function IsBodyBroken(handle) end

---Determine if a body is in any way connected to a static object, either by being static itself or be being directly or indirectly jointed to something static.
--- 
--- ---
--- Example
---```lua
---local connectedToStatic = IsBodyJointedToStatic(body)
---```
---@param handle body_handle Body handle
---@return boolean result Return true if body is in any way connected to a static body
function IsBodyJointedToStatic(handle) end

---Render next frame with an outline around specified body. If no color is given, a white outline will be drawn.
--- 
--- ---
--- Example
---```lua
-----Draw white outline at 50% transparency
---DrawBodyOutline(body, 0.5)
---
-----Draw green outline, fully opaque
---DrawBodyOutline(body, 0, 1, 0, 1)
---```
---@param handle body_handle Body handle
---@param r? number Red
---@param g? number Green
---@param b? number Blue
---@param a number Alpha
function DrawBodyOutline(handle, r, g, b, a) end

---Flash the appearance of a body when rendering this frame. This is used for valuables in the game.
--- 
--- ---
--- Example
---```lua
---DrawBodyHighlight(body, 0.5)
---```
---@param handle body_handle Body handle
---@param amount number Amount
function DrawBodyHighlight(handle, amount) end

---This will return the closest point of a specific body
--- 
--- ---
--- Example
---```lua
---local hit, p, n, s = GetBodyClosestPoint(body, Vec(0, 5, 0))
---if hit then
---	--Point p of shape s is closest
---end
---```
---@param body body_handle Body handle
---@param origin vector_t World space point
---@return boolean hit True if a point was found
---@return vector_t point World space closest point
---@return vector_t normal World space normal at closest point
---@return shape_handle shape Handle to closest shape
function GetBodyClosestPoint(body, origin) end

---This will tell the physics solver to constrain the velocity between two bodies. The physics solver will try to reach the desired goal, while not applying an impulse bigger than the min and max values. This function should only be used from the update callback.
--- 
--- ---
--- Example
---```lua
-----Constrain the velocity between bodies A and B so that the relative velocity 
-----along the X axis at point (0, 5, 0) is always 3 m/s
---ConstrainVelocity(a, b, Vec(0, 5, 0), Vec(1, 0, 0), 3)
---```
---@param bodyA body_handle First body handle (zero for static)
---@param bodyB body_handle Second body handle (zero for static)
---@param point vector_t World space point
---@param dir vector_t World space direction
---@param relVel number Desired relative velocity along the provided direction
---@param min? number Minimum impulse (default: -infinity)
---@param max? number Maximum impulse (default: infinity)
function ConstrainVelocity(bodyA, bodyB, point, dir, relVel, min, max) end

---This will tell the physics solver to constrain the angular velocity between two bodies. The physics solver will try to reach the desired goal, while not applying an angular impulse bigger than the min and max values. This function should only be used from the update callback.
--- 
--- ---
--- Example
---```lua
-----Constrain the angular velocity between bodies A and B so that the relative angular velocity
-----along the Y axis is always 3 rad/s
---ConstrainAngularVelocity(a, b, Vec(1, 0, 0), 3)
---```
---@param bodyA body_handle First body handle (zero for static)
---@param bodyB body_handle Second body handle (zero for static)
---@param dir vector_t World space direction
---@param relAngVel number Desired relative angular velocity along the provided direction
---@param min? number Minimum angular impulse (default: -infinity)
---@param max? number Maximum angular impulse (default: infinity)
function ConstrainAngularVelocity(bodyA, bodyB, dir, relAngVel, min, max) end

---This is a helper function that uses ConstrainVelocity to constrain a point on one body to a point on another body while not affecting the bodies more than the provided maximum relative velocity and maximum impulse. In other words: physically push on the bodies so that pointA and pointB are aligned in world space. This is useful for physically animating objects. This function should only be used from the update callback.
--- 
--- ---
--- Example
---```lua
-----Constrain the origo of body a to an animated point in the world
---local worldPos = Vec(0, 3+math.sin(GetTime()), 0)
---ConstrainPosition(a, 0, GetBodyTransform(a).pos, worldPos)
---
-----Constrain the origo of body a to the origo of body b (like a ball joint)
---ConstrainPosition(a, b, GetBodyTransform(a).pos, GetBodyTransform(b).pos)
---```
---@param bodyA body_handle First body handle (zero for static)
---@param bodyB body_handle Second body handle (zero for static)
---@param pointA vector_t World space point for first body
---@param pointB vector_t World space point for second body
---@param maxVel? number Maximum relative velocity (default: infinite)
---@param maxImpulse? number Maximum impulse (default: infinite)
function ConstrainPosition(bodyA, bodyB, pointA, pointB, maxVel, maxImpulse) end

---This is the angular counterpart to ConstrainPosition, a helper function that uses ConstrainAngularVelocity to constrain the orientation of one body to the orientation on another body while not affecting the bodies more than the provided maximum relative angular velocity and maximum angular impulse. In other words: physically rotate the bodies so that quatA and quatB are aligned in world space. This is useful for physically animating objects. This function should only be used from the update callback.
--- 
--- ---
--- Example
---```lua
-----Constrain the orietation of body a to an upright orientation in the world
---ConstrainOrientation(a, 0, GetBodyTransform(a).rot, Quat())
---
-----Constrain the orientation of body a to the orientation of body b
---ConstrainOrientation(a, b, GetBodyTransform(a).rot, GetBodyTransform(b).rot)
---```
---@param bodyA body_handle First body handle (zero for static)
---@param bodyB body_handle Second body handle (zero for static)
---@param quatA quaternion_t World space orientation for first body
---@param quatB quaternion_t World space orientation for second body
---@param maxAngVel? number Maximum relative angular velocity (default: infinite)
---@param maxAngImpulse? number Maximum angular impulse (default: infinite)
function ConstrainOrientation(bodyA, bodyB, quatA, quatB, maxAngVel, maxAngImpulse) end

---Every scene in Teardown has an implicit static world body that contains all shapes that are not explicitly assigned a body in the editor.
--- 
--- ---
--- Example
---```lua
---local w = GetWorldBody()
---```
---@return body_handle body Handle to the static world body
function GetWorldBody() end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for a shape tagged "mybox" in script scope
---local target = FindShape("mybox")
---
-----Search for a shape tagged "laserturret" in entire scene
---local escape = FindShape("laserturret", true)
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return shape_handle handle Handle to first shape with specified tag or zero if not found
function FindShape(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for shapes tagged "alarmbox" in script scope
---local shapes = FindShapes("alarmbox")
---for i=1, #shapes do
---	local shape = shapes[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return shape_handle[] list Indexed table with handles to all shapes with specified tag
function FindShapes(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Shape transform in body local space
---local shapeTransform = GetShapeLocalTransform(shape)
---
-----Body transform in world space
---local bodyTransform = GetBodyTransform(GetShapeBody(shape))
---
-----Shape transform in world space
---local worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
---```
---@param handle shape_handle Shape handle
---@return transform_t transform Return shape transform in body space
function GetShapeLocalTransform(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local transform = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
---SetShapeLocalTransform(shape, transform)
---```
---@param handle shape_handle Shape handle
---@param transform transform_t Shape transform in body space
function SetShapeLocalTransform(handle, transform) end

---This is a convenience function, transforming the shape out of body space
--- 
--- ---
--- Example
---```lua
---local worldTransform = GetShapeWorldTransform(shape)
---
-----This is equivalent to
---local shapeTransform = GetShapeLocalTransform(shape)
---local bodyTransform = GetBodyTransform(GetShapeBody(shape))
---worldTranform = TransformToParentTransform(bodyTransform, shapeTransform)
---```
---@param handle shape_handle Shape handle
---@return transform_t transform Return shape transform in world space
function GetShapeWorldTransform(handle) end

---Get handle to the body this shape is owned by. A shape is always owned by a body, but can be transfered to a new body during destruction.
--- 
--- ---
--- Example
---```lua
---local body = GetShapeBody(shape)
---```
---@param handle shape_handle Shape handle
---@return body_handle handle Body handle
function GetShapeBody(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local hinges = GetShapeJoints(door)
---for i=1, #hinges do
---	local joint = hinges[i]
---	...
---end
---```
---@param shape shape_handle Shape handle
---@return joint_handle[] list Indexed table with joints connected to shape
function GetShapeJoints(shape) end

---No Description
--- 
--- ---
--- Example
---```lua
---local lights = GetShapeLights(shape)
---for i=1, #lights do
---	local light = lights[i]
---	...
---end
---```
---@param shape shape_handle Shape handle
---@return light_handle[] list Indexed table of lights owned by shape
function GetShapeLights(shape) end

---Return the world space, axis-aligned bounding box for a shape.
--- 
--- ---
--- Example
---```lua
---local min, max = GetShapeBounds(shape)
---local boundsSize = VecSub(max, min)
---local center = VecLerp(min, max, 0.5)
---```
---@param handle shape_handle Shape handle
---@return vector_t min Vector representing the AABB lower bound
---@return vector_t max Vector representing the AABB upper bound
function GetShapeBounds(handle) end

---Scale emissiveness for shape. If the shape has light sources attached, their intensity will be scaled by the same amount.
--- 
--- ---
--- Example
---```lua
-----Pulsate emissiveness and light intensity for shape
---local scale = math.sin(GetTime())*0.5 + 0.5
---SetShapeEmissiveScale(shape, scale)
---```
---@param handle shape_handle Shape handle
---@param scale number Scale factor for emissiveness
function SetShapeEmissiveScale(handle, scale) end

---Return material properties for a particular voxel
--- 
--- ---
--- Example
---```lua
---local hit, dist, normal, shape = QueryRaycast(pos, dir, 10)
---if hit then
---	local hitPoint = VecAdd(pos, VecScale(dir, dist))
---	local mat = GetShapeMaterialAtPosition(shape, hitPoint)
---	DebugPrint("Raycast hit voxel made out of " .. mat)
---end
---```
---@param handle shape_handle Shape handle
---@param pos vector_t Position in world space
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@return number entry Palette entry for voxel (zero if empty)
function GetShapeMaterialAtPosition(handle, pos) end

---Return material properties for a particular voxel in the voxel grid indexed by integer values. The first index is zero (not one, as opposed to a lot of lua related things)
--- 
--- ---
--- Example
---```lua
---local mat = GetShapeMaterialAtIndex(shape, 0, 0, 0)
---DebugPrint("The voxel closest to origo is of material: " .. mat)
---```
---@param handle shape_handle Shape handle
---@param x number X integer coordinate
---@param y number Y integer coordinate
---@param z number Z integer coordinate
---@return string type Material type
---@return number r Red
---@return number g Green
---@return number b Blue
---@return number a Alpha
---@return number entry Palette entry for voxel (zero if empty)
function GetShapeMaterialAtIndex(handle, x, y, z) end

---Return the size of a shape in voxels
--- 
--- ---
--- Example
---```lua
---local x, y, z = GetShapeSize(shape)
---```
---@param handle shape_handle Shape handle
---@return number xsize Size in voxels along x axis
---@return number ysize Size in voxels along y axis
---@return number zsize Size in voxels along z axis
---@return number scale The size of one voxel in meters (with default scale it is 0.1)
function GetShapeSize(handle) end

---Return the number of voxels in a shape, not including empty space
--- 
--- ---
--- Example
---```lua
---local voxelCount = GetShapeVoxelCount(shape)
---```
---@param handle shape_handle Shape handle
---@return number count Number of voxels in shape
function GetShapeVoxelCount(handle) end

---This will check if a shape is currently visible in the camera frustum and not occluded by other objects.
--- 
--- ---
--- Example
---```lua
---if IsShapeVisible(shape, 25) then
---	--Shape is within 25 meters visible to the camera
---end
---```
---@param handle shape_handle Shape handle
---@param maxDist number Maximum visible distance
---@param rejectTransparent? boolean See through transparent materials. Default false.
---@return boolean visible Return true if shape is visible
function IsShapeVisible(handle, maxDist, rejectTransparent) end

---Determine if shape has been broken. Note that a shape can be transfered to another body during destruction, but might still not be considered broken if all voxels are intact.
--- 
--- ---
--- Example
---```lua
---local broken = IsShapeBroken(shape)
---```
---@param handle shape_handle Shape handle
---@return boolean broken Return true if shape is broken
function IsShapeBroken(handle) end

---Render next frame with an outline around specified shape. If no color is given, a white outline will be drawn.
--- 
--- ---
--- Example
---```lua
-----Draw white outline at 50% transparency
---DrawShapeOutline(shape, 0.5)
---
-----Draw green outline, fully opaque
---DrawShapeOutline(shape, 0, 1, 0, 1)
---```
---@param handle shape_handle Shape handle
---@param r? number Red
---@param g? number Green
---@param b? number Blue
---@param a number Alpha
function DrawShapeOutline(handle, r, g, b, a) end

---Flash the appearance of a shape when rendering this frame.
--- 
--- ---
--- Example
---```lua
---DrawShapeHighlight(shape, 0.5)
---```
---@param handle shape_handle Shape handle
---@param amount number Amount
function DrawShapeHighlight(handle, amount) end

---This is used to filter out collisions with other shapes. Each shape can be given a layer bitmask (8 bits, 0-255) along with a mask (also 8 bits). The layer of one object must be in the mask of the other object and vice versa for the collision to be valid. The default layer for all objects is 1 and the default mask is 255 (collide with all layers).
--- 
--- ---
--- Example
---```lua
-----This will put shapes a and b in layer 2 and disable collisions with
-----object shapes in layers 2, preventing any collisions between the two.
---SetShapeCollisionFilter(a, 2, 255-2)
---SetShapeCollisionFilter(b, 2, 255-2)
---
-----This will put shapes c and d in layer 4 and allow collisions with other
-----shapes in layer 4, but ignore all other collisions with the rest of the world.
---SetShapeCollisionFilter(c, 4, 4)
---SetShapeCollisionFilter(d, 4, 4)
---```
---@param handle shape_handle Shape handle
---@param layer number Layer bits (0-255)
---@param mask number Mask bits (0-255)
function SetShapeCollisionFilter(handle, layer, mask) end

---Create new, empty shape on existing body using the palette of a reference shape. The reference shape can be any existingf shape in the scene or an external vox file. The size of the new shape will be 1x1x1.
---@param body body_handle Body handle
---@param transform transform_t Shape transform in body space
---@param refShape number Handle to reference shape or path to vox file
---@return shape_handle newShape Handle of new shape
function CreateShape(body, transform, refShape) end

---Fill a voxel shape with zeroes, thus removing all voxels.
---@param shape shape_handle Shape handle
function ClearShape(shape) end

---Resize an existing shape. The new coordinates are expressed in the existing shape coordinate frame, so you can provide negative values. The existing content is preserved, but may be cropped if needed. The local shape transform will be moved automatically with an offset vector to preserve the original content in body space. This offset vector is returned in shape local space.
---@param shape shape_handle Shape handle
---@param xmi number Lower X coordinate
---@param ymi number Lower Y coordinate
---@param zmi number Lower Z coordinate
---@param xma number Upper X coordinate
---@param yma number Upper Y coordinate
---@param zma number Upper Z coordinate
---@return vector_t offset Offset vector in shape local space
function ResizeShape(shape, xmi, ymi, zmi, xma, yma, zma) end

---Move existing shape to a new body, optionally providing a new local transform.
---@param shape shape_handle Shape handle
---@param body body_handle Body handle
---@param transform? transform_t New local shape transform. Default is existing local transform.
function SetShapeBody(shape, body, transform) end

---Copy voxel content from source shape to destination shape. If destination shape has a different size, it will be resized to match the source shape.
---@param src shape_handle Source shape handle
---@param dst shape_handle Destination shape handle
function CopyShapeContent(src, dst) end

---Copy the palette from source shape to destination shape.
---@param src shape_handle Source shape handle
---@param dst shape_handle Destination shape handle
function CopyShapePalette(src, dst) end

---Return list of material entries, each entry is a material index that can be provided to GetShapeMaterial or used as brush for populating a shape.
---@param shape shape_handle Shape handle
---@return table entries Palette material entries
function GetShapePalette(shape) end

---Return material properties for specific matirial entry.
---@param shape shape_handle Shape handle
---@param entry number Material entry
---@return string type Type
---@return number red Red value
---@return number green Green value
---@return number blue Blue value
---@return number alpha Alpha value
---@return number reflectivity Range 0 to 1
---@return number shininess Range 0 to 1
---@return number metallic Range 0 to 1
---@return number emissive Range 0 to 32
function GetShapeMaterial(shape, entry) end

---Set material index to be used for following calls to DrawShapeLine and DrawShapeBox and ExtrudeShape. An optional brush vox file and subobject can be used and provided instead of material index, in which case the content of the brush will be used and repeated. Use material index zero to remove of voxels.
---@param type string One of "sphere", "cube" or "noise"
---@param size number Size of brush in voxels (must be in range 1 to 16)
---@param index or Material index or path to brush vox file
---@param object? string Optional object in brush vox file if brush vox file is used
function SetBrush(type, size, index, object) end

---Draw voxelized line between (x0,y0,z0) and (x1,y1,z1) into shape using the material set up with SetBrush. Paint mode will only change material of existing voxels (where the current material index is non-zero). noOverwrite mode will only fill in voxels if the space isn't already accupied by another shape in the scene.
---@param shape number Handle to shape
---@param x0 number Start X coordinate
---@param y0 number Start Y coordinate
---@param z0 number Start Z coordinate
---@param x1 number End X coordinate
---@param y1 number End Y coordinate
---@param z1 number End Z coordinate
---@param paint? boolean Paint mode. Default is false.
---@param noOverwrite? boolean Only fill in voxels if space isn't already occupied. Default is false.
function DrawShapeLine(shape, x0, y0, z0, x1, y1, z1, paint, noOverwrite) end

---Draw box between (x0,y0,z0) and (x1,y1,z1) into shape using the material set up with SetBrush.
---@param shape number Handle to shape
---@param x0 number Start X coordinate
---@param y0 number Start Y coordinate
---@param z0 number Start Z coordinate
---@param x1 number End X coordinate
---@param y1 number End Y coordinate
---@param z1 number End Z coordinate
function DrawShapeBox(shape, x0, y0, z0, x1, y1, z1) end

---Extrude region of shape. The extruded region will be filled in with the material set up with SetBrush. The mode parameter sepcifies how the region is determined. Exact mode selects region of voxels that exactly match the input voxel at input coordinate. Material mode selects region that has the same material type as the input voxel. Geometry mode selects any connected voxel in the same plane as the input voxel.
---@param shape number Handle to shape
---@param x number X coordinate to extrude
---@param y number Y coordinate to extrude
---@param z number Z coordinate to extrude
---@param dx number X component of extrude direction, should be -1, 0 or 1
---@param dy number Y component of extrude direction, should be -1, 0 or 1
---@param dz number Z component of extrude direction, should be -1, 0 or 1
---@param steps number Length of extrusion in voxels
---@param mode string Extrusion mode, one of "exact", "material", "geometry". Default is "exact"
function ExtrudeShape(shape, x, y, z, dx, dy, dz, steps, mode) end

---Trim away empty regions of shape, thus potentially making it smaller. If the size of the shape changes, the shape will be automatically moved to preserve the shape content in body space. The offset vector for this translation is returned in shape local space.
---@param shape number Source handle
---@return vector_t offset Offset vector in shape local space
function TrimShape(shape) end

---Split up a shape into multiple shapes based on connectivity. If the removeResidual flag is used, small disconnected chunks will be removed during this process to reduce the number of newly created shapes.
---@param shape number Source handle
---@param removeResidual boolean Remove residual shapes (default false)
---@return shape_handle[] newShapes List of shape handles created
function SplitShape(shape, removeResidual) end

---Try to merge shape with a nearby, matching shape. For a merge to happen, the shapes need to be aligned to the same rotation and touching. If the provided shape was merged into another shape, that shape may be resized to fit the merged content. If shape was merged, the handle to the other shape is returned, otherwise the input handle is returned.
---@param shape number Input shape
---@return number shape Shape handle after merge
function MergeShape(shape) end

---This will return the closest point of a specific shape
--- 
--- ---
--- Example
---```lua
---local hit, p, n = GetShapeClosestPoint(s, Vec(0, 5, 0))
---if hit then
---	--Point p of shape s is closest to (0,5,0)
---end
---```
---@param shape shape_handle Shape handle
---@param origin vector_t World space point
---@return boolean hit True if a point was found
---@return vector_t point World space closest point
---@return vector_t normal World space normal at closest point
function GetShapeClosestPoint(shape, origin) end

---This will check if two shapes has physical overlap
--- 
--- ---
--- Example
---```lua
---local touch = IsShapeTouching(a, b)
---if hit then
---	--Shapes are touching or overlapping
---end
---```
---@param a shape_handle Handle to first shape
---@param b shape_handle Handle to second shape
---@return boolean touching True is shapes a and b are touching each other
function IsShapeTouching(a, b) end

---No Description
--- 
--- ---
--- Example
---```lua
---local loc = FindLocation("start")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return location_handle handle Handle to first location with specified tag or zero if not found
function FindLocation(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for locations tagged "waypoint" in script scope
---local locations = FindLocations("waypoint")
---for i=1, #locs do
---	local locs = locations[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return location_handle[] list Indexed table with handles to all locations with specified tag
function FindLocations(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = GetLocationTransform(loc)
---```
---@param handle location_handle Location handle
---@return transform_t transform Transform of the location
function GetLocationTransform(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local joint = FindJoint("doorhinge")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return joint_handle handle Handle to first joint with specified tag or zero if not found
function FindJoint(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for locations tagged "doorhinge" in script scope
---local hinges = FindJoints("doorhinge")
---for i=1, #hinges do
---	local joint = hinges[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return joint_handle[] list Indexed table with handles to all joints with specified tag
function FindJoints(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
---local broken = IsJointBroken(joint)
---```
---@param joint joint_handle Joint handle
---@return boolean broken True if joint is broken
function IsJointBroken(joint) end

---Joint type is one of the following: "ball", "hinge", "prismatic" or "rope". An empty string is returned if joint handle is invalid.
--- 
--- ---
--- Example
---```lua
---if GetJointType(joint) == "rope" then
---	--Joint is rope
---end
---```
---@param joint joint_handle Joint handle
---@return string type Joint type
function GetJointType(joint) end

---A joint is always connected to two shapes. Use this function if you know one shape and want to find the other one.
--- 
--- ---
--- Example
---```lua
-----joint is connected to a and b
---
---otherShape = GetJointOtherShape(joint, a)
-----otherShape is now b
---
---otherShape = GetJointOtherShape(joint, b)
-----otherShape is now a
---```
---@param joint joint_handle Joint handle
---@param shape shape_handle Shape handle
---@return shape_handle other Other shape handle
function GetJointOtherShape(joint, shape) end

---Get shapes connected to the joint.
--- 
--- ---
--- Example
---```lua
----- Check to see if joint chain is still connected to vehicle main body
----- If not then disable motors
---
---local mainBody = GetVehicleBody(vehicle)
---local shapes = GetJointShapes(joint)
---
---local connected = false
---for i=1,#shapes do
---
---	local body = GetShapeBody(shapes[i])
---
---	if body == mainBody then
---		connected = true
---	end
---
---end
---
---if connected then
---	SetJointMotor(joint, 0.5)
---else
---	SetJointMotor(joint, 0.0)
---end
---```
---@param joint joint_handle Joint handle
---@return shape_handle[] shapes Shape handles
function GetJointShapes(joint) end

---Set joint motor target velocity. If joint is of type hinge, velocity is given in radians per second angular velocity. If joint type is prismatic joint velocity is given in meters per second. Calling this function will override and void any previous call to SetJointMotorTarget.
--- 
--- ---
--- Example
---```lua
-----Set motor speed to 0.5 radians per second
---SetJointMotor(hinge, 0.5)
---```
---@param joint joint_handle Joint handle
---@param velocity number Desired velocity
---@param strength? number Desired strength. Default is infinite. Zero to disable.
function SetJointMotor(joint, velocity, strength) end

---If a joint has a motor target, it will try to maintain its relative movement. This is very useful for elevators or other animated, jointed mechanisms. If joint is of type hinge, target is an angle in degrees (-180 to 180) and velocity is given in radians per second. If joint type is prismatic, target is given in meters and velocity is given in meters per second. Setting a motor target will override any previous call to SetJointMotor.
--- 
--- ---
--- Example
---```lua
-----Make joint reach a 45 degree angle, going at a maximum of 3 radians per second
---SetJointMotorTarget(hinge, 45, 3)
---```
---@param joint joint_handle Joint handle
---@param target number Desired movement target
---@param maxVel? number Maximum velocity to reach target. Default is infinite.
---@param strength? number Desired strength. Default is infinite. Zero to disable.
function SetJointMotorTarget(joint, target, maxVel, strength) end

---Return joint limits for hinge or prismatic joint. Returns angle or distance depending on joint type.
--- 
--- ---
--- Example
---```lua
---local min, max = GetJointLimits(hinge)
---```
---@param joint joint_handle Joint handle
---@return number min Minimum joint limit (angle or distance)
---@return number max Maximum joint limit (angle or distance)
function GetJointLimits(joint) end

---Return the current position or angle or the joint, measured in same way as joint limits.
--- 
--- ---
--- Example
---```lua
---local current = GetJointMovement(hinge)
---```
---@param joint joint_handle Joint handle
---@return number movement Current joint position or angle
function GetJointMovement(joint) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Draw outline for all bodies in jointed structure
---local all = GetJointedBodies(body)
---for i=1,#all do
---	DrawBodyOutline(all[i], 0.5)
---end
---```
---@param body body_handle Body handle (must be dynamic)
---@return body_handle[] bodies Handles to all dynamic bodies in the jointed structure. The input handle will also be included.
function GetJointedBodies(body) end

---Detach joint from shape. If joint is not connected to shape, nothing happens.
--- 
--- ---
--- Example
---```lua
---DetachJointFromShape(hinge, door)
---```
---@param joint joint_handle Joint handle
---@param shape shape_handle Shape handle
function DetachJointFromShape(joint, shape) end

---No Description
--- 
--- ---
--- Example
---```lua
---local light = FindLight("main")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return light_handle handle Handle to first light with specified tag or zero if not found
function FindLight(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Search for lights tagged "main" in script scope
---local lights = FindLights("main")
---for i=1, #lights do
---	local light = lights[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return light_handle[] list Indexed table with handles to all lights with specified tag
function FindLights(tag, global) end

---If light is owned by a shape, the emissive scale of that shape will be set to 0.0 when light is disabled and 1.0 when light is enabled.
--- 
--- ---
--- Example
---```lua
---SetLightEnabled(light, false)
---```
---@param handle light_handle Light handle
---@param enabled boolean Set to true if light should be enabled
function SetLightEnabled(handle, enabled) end

---This will only set the color tint of the light. Use SetLightIntensity for brightness. Setting the light color will not affect the emissive color of a parent shape.
--- 
--- ---
--- Example
---```lua
-----Set light color to yellow
---SetLightColor(light, 1, 1, 0)
---```
---@param handle light_handle Light handle
---@param r number Red value
---@param g number Green value
---@param b number Blue value
function SetLightColor(handle, r, g, b) end

---If the shape is owned by a shape you most likely want to use SetShapeEmissiveScale instead, which will affect both the emissiveness of the shape and the brightness of the light at the same time.
--- 
--- ---
--- Example
---```lua
-----Pulsate light
---SetLightIntensity(light, math.sin(GetTime())*0.5 + 1.0)
---```
---@param handle light_handle Light handle
---@param intensity number Desired intensity of the light
function SetLightIntensity(handle, intensity) end

---Lights that are owned by a dynamic shape are automatcially moved with that shape
--- 
--- ---
--- Example
---```lua
---local pos = GetLightTransform(light).pos
---```
---@param handle light_handle Light handle
---@return transform_t transform World space light transform
function GetLightTransform(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local shape = GetLightShape(light)
---```
---@param handle light_handle Light handle
---@return shape_handle handle Shape handle or zero if not attached to shape
function GetLightShape(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---if IsLightActive(light) then
---	--Do something
---end
---```
---@param handle light_handle Light handle
---@return boolean active True if light is currently emitting light
function IsLightActive(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local point = Vec(0, 10, 0)
---local affected = IsPointAffectedByLight(light, point)
---```
---@param handle light_handle Light handle
---@param point vector_t World space point as vector
---@return boolean affected Return true if point is in light cone and range
function IsPointAffectedByLight(handle, point) end

---No Description
--- 
--- ---
--- Example
---```lua
---local goal = FindTrigger("goal")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return trigger_handle handle Handle to first trigger with specified tag or zero if not found
function FindTrigger(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Find triggers tagged "toxic" in script scope
---local triggers = FindTriggers("toxic")
---for i=1, #triggers do
---	local trigger = triggers[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return trigger_handle[] list Indexed table with handles to all triggers with specified tag
function FindTriggers(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = GetTriggerTransform(trigger)
---```
---@param handle trigger_handle Trigger handle
---@return transform_t transform Current trigger transform in world space
function GetTriggerTransform(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = Transform(Vec(0, 1, 0), QuatEuler(0, 90, 0))
---SetTriggerTransform(trigger, t)
---```
---@param handle trigger_handle Trigger handle
---@param transform transform_t Desired trigger transform in world space
function SetTriggerTransform(handle, transform) end

---Return the lower and upper points in world space of the trigger axis aligned bounding box
--- 
--- ---
--- Example
---```lua
---local mi, ma = GetTriggerBounds(trigger)
---local list = QueryAabbShapes(mi, ma)
---```
---@param handle trigger_handle Trigger handle
---@return vector_t min Lower point of trigger bounds in world space
---@return vector_t max Upper point of trigger bounds in world space
function GetTriggerBounds(handle) end

---This function will only check the center point of the body
--- 
--- ---
--- Example
---```lua
---if IsBodyInTrigger(trigger, body) then
---	...
---end
---```
---@param trigger trigger_handle Trigger handle
---@param body body_handle Body handle
---@return boolean inside True if body is in trigger volume
function IsBodyInTrigger(trigger, body) end

---This function will only check origo of vehicle
--- 
--- ---
--- Example
---```lua
---if IsVehicleInTrigger(trigger, vehicle) then
---	...
---end
---```
---@param trigger trigger_handle Trigger handle
---@param vehicle vehicle_handle Vehicle handle
---@return boolean inside True if vehicle is in trigger volume
function IsVehicleInTrigger(trigger, vehicle) end

---This function will only check the center point of the shape
--- 
--- ---
--- Example
---```lua
---if IsShapeInTrigger(trigger, shape) then
---	...
---end
---```
---@param trigger trigger_handle Trigger handle
---@param shape shape_handle Shape handle
---@return boolean inside True if shape is in trigger volume
function IsShapeInTrigger(trigger, shape) end

---No Description
--- 
--- ---
--- Example
---```lua
---local p = Vec(0, 10, 0)
---if IsPointInTrigger(trigger, p) then
---	...
---end
---```
---@param trigger trigger_handle Trigger handle
---@param point vector_t Word space point as vector
---@return boolean inside True if point is in trigger volume
function IsPointInTrigger(trigger, point) end

---This function will check if trigger is empty. If trigger contains any part of a body it will return false and the highest point as second return value.
--- 
--- ---
--- Example
---```lua
---local empty, highPoint = IsTriggerEmpty(trigger)
---if not empty then
---	--highPoint[2] is the tallest point in trigger
---end
---```
---@param handle trigger_handle Trigger handle
---@param demolision? boolean If true, small debris and vehicles are ignored
---@return boolean empty True if trigger is empty
---@return vector_t maxpoint World space point of highest point (largest Y coordinate) if not empty
function IsTriggerEmpty(handle, demolision) end

---Get distance to the surface of trigger volume. Will return negative distance if inside.
--- 
--- ---
--- Example
---```lua
---local p = Vec(0, 10, 0)
---local dist = GetTriggerDistance(trigger, p)
---```
---@param trigger trigger_handle Trigger handle
---@param point vector_t Word space point as vector
---@return number distance Positive if point is outside, negative if inside
function GetTriggerDistance(trigger, point) end

---Return closest point in trigger volume. Will return the input point itself if inside trigger or closest point on surface of trigger if outside.
--- 
--- ---
--- Example
---```lua
---local p = Vec(0, 10, 0)
---local closest = GetTriggerClosestPoint(trigger, p)
---```
---@param trigger trigger_handle Trigger handle
---@param point vector_t Word space point as vector
---@return vector_t closest Closest point in trigger as vector
function GetTriggerClosestPoint(trigger, point) end

---No Description
--- 
--- ---
--- Example
---```lua
---local screen = FindTrigger("tv")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return screen_handle handle Handle to first screen with specified tag or zero if not found
function FindScreen(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Find screens tagged "tv" in script scope
---local screens = FindScreens("tv")
---for i=1, #screens do
---	local screen = screens[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return screen_handle[] list Indexed table with handles to all screens with specified tag
function FindScreens(tag, global) end

---Enable or disable screen
--- 
--- ---
--- Example
---```lua
---SetScreenEnabled(screen, true)
---```
---@param screen screen_handle Screen handle
---@param enabled boolean True if screen should be enabled
function SetScreenEnabled(screen, enabled) end

---No Description
--- 
--- ---
--- Example
---```lua
---local b = IsScreenEnabled(screen)
---```
---@param screen screen_handle Screen handle
---@return boolean enabled True if screen is enabled
function IsScreenEnabled(screen) end

---Return handle to the parent shape of a screen
--- 
--- ---
--- Example
---```lua
---local shape = GetScreenShape(screen)
---```
---@param screen screen_handle Screen handle
---@return shape_handle shape Shape handle or zero if none
function GetScreenShape(screen) end

---No Description
--- 
--- ---
--- Example
---```lua
---local vehicle = FindVehicle("mycar")
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return vehicle_handle handle Handle to first vehicle with specified tag or zero if not found
function FindVehicle(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Find all vehicles in level tagged "boat"
---local boats = FindVehicles("boat")
---for i=1, #boats do
---	local boat = boats[i]
---	...
---end
---```
---@param tag? string Tag name
---@param global? boolean Search in entire scene
---@return vehicle_handle[] list Indexed table with handles to all vehicles with specified tag
function FindVehicles(tag, global) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = GetVehicleTransform(vehicle)
---```
---@param vehicle vehicle_handle Vehicle handle
---@return transform_t transform Transform of vehicle
function GetVehicleTransform(vehicle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local body = GetVehicleBody(vehicle)
---if IsBodyBroken(body) then
-----Vehicle body is broken
---end
---```
---@param vehicle vehicle_handle Vehicle handle
---@return body_handle body Main body of vehicle
function GetVehicleBody(vehicle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local health = GetVehicleHealth(vehicle)
---```
---@param vehicle vehicle_handle Vehicle handle
---@return number health Vehicle health (zero to one)
function GetVehicleHealth(vehicle) end

---No Description
--- 
--- ---
--- Example
---```lua
---local driverPos = GetVehicleDriverPos(vehicle)
---local t = GetVehicleTransform(vehicle)
---local worldPos = TransformToParentPoint(t, driverPos)
---```
---@param vehicle vehicle_handle Vehicle handle
---@return vector_t pos Driver position as vector in vehicle space
function GetVehicleDriverPos(vehicle) end

---This function applies input to vehicles, allowing for autonomous driving. The vehicle will be turned on automatically and turned off when no longer called. Call this from the tick function, not update.
--- 
--- ---
--- Example
---```lua
---function tick()
---	--Drive mycar forwards
---	local v = FindVehicle("mycar")
---	DriveVehicle(v, 1, 0, false)
---end
---```
---@param vehicle vehicle_handle Vehicle handle
---@param drive number Reverse/forward control -1 to 1
---@param steering number Left/right control -1 to 1
---@param handbrake boolean Handbrake control
function DriveVehicle(vehicle, drive, steering, handbrake) end

---Return center point of player. This function is deprecated. Use GetPlayerTransform instead.
--- 
--- ---
--- Example
---```lua
---local p = GetPlayerPos()
---
-----This is equivalent to
---p = VecAdd(GetPlayerTransform().pos, Vec(0,1,0))
---```
---@return vector_t position Player center position
function GetPlayerPos() end

---The player transform is located at the bottom of the player. The player transform considers heading (looking left and right). Forward is along negative Z axis. Player pitch (looking up and down) does not affect player transform unless includePitch is set to true. If you want the transform of the eye, use GetPlayerCameraTransform() instead.
--- 
--- ---
--- Example
---```lua
---local t = GetPlayerTransform()
---```
---@param includePitch? boolean Include the player pitch (look up/down) in transform
---@return transform_t transform Current player transform
function GetPlayerTransform(includePitch) end

---Instantly teleport the player to desired transform. Unless includePitch is set to true, up/down look angle will be set to zero during this process. Player velocity will be reset to zero.
--- 
--- ---
--- Example
---```lua
---local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
---SetPlayerTransform(t)
---```
---@param transform transform_t Desired player transform
---@param includePitch? boolean Set player pitch (look up/down) as well
function SetPlayerTransform(transform, includePitch) end

---Make the ground act as a conveyor belt, pushing the player even if ground shape is static.
--- 
--- ---
--- Example
---```lua
---SetPlayerGroundVelocity(Vec(2,0,0))
---```
---@param vel vector_t Desired ground velocity
function SetPlayerGroundVelocity(vel) end

---The player camera transform is usually the same as what you get from GetCameraTransform, but if you have set a camera transform manually with SetCameraTransform, you can retrieve the standard player camera transform with this function.
--- 
--- ---
--- Example
---```lua
---local t = GetPlayerCameraTransform()
---```
---@return transform_t transform Current player camera transform
function GetPlayerCameraTransform() end

---Call this function continously to apply a camera offset. Can be used for camera effects such as shake and wobble.
--- 
--- ---
--- Example
---```lua
---local t = Transform(Vec(), QuatAxisAngle(Vec(1, 0, 0), math.sin(time*3.0) * 3.0))
---SetPlayerCameraOffsetTransform(t)
---```
---@param transform transform_t Desired player camera offset transform
function SetPlayerCameraOffsetTransform(transform) end

---Call this function during init to alter the player spawn transform.
--- 
--- ---
--- Example
---```lua
---local t = Transform(Vec(10, 0, 0), QuatEuler(0, 90, 0))
---SetPlayerSpawnTransform(t)
---```
---@param transform transform_t Desired player spawn transform
function SetPlayerSpawnTransform(transform) end

---No Description
--- 
--- ---
--- Example
---```lua
---local vel = GetPlayerVelocity()
---```
---@return vector_t velocity Player velocity in world space as vector
function GetPlayerVelocity() end

---Drive specified vehicle.
--- 
--- ---
--- Example
---```lua
---local car = FindVehicle("mycar")
---SetPlayerVehicle(car)
---```
---@param vehicle vehicle_handle Handle to vehicle or zero to not drive.
function SetPlayerVehicle(vehicle) end

---No Description
--- 
--- ---
--- Example
---```lua
---SetPlayerVelocity(Vec(0, 5, 0))
---```
---@param velocity vector_t Player velocity in world space as vector
function SetPlayerVelocity(velocity) end

---No Description
--- 
--- ---
--- Example
---```lua
---local vehicle = GetPlayerVehicle()
---if vehicle ~= 0 then
---	...
---end
---```
---@return vehicle_handle handle Current vehicle handle, or zero if not in vehicle
function GetPlayerVehicle() end

---No Description
--- 
--- ---
--- Example
---```lua
---local shape = GetPlayerGrabShape()
---if shape ~= 0 then
---	...
---end
---```
---@return shape_handle handle Handle to grabbed shape or zero if not grabbing.
function GetPlayerGrabShape() end

---No Description
--- 
--- ---
--- Example
---```lua
---local body = GetPlayerGrabBody()
---if body ~= 0 then
---	...
---end
---```
---@return body_handle handle Handle to grabbed body or zero if not grabbing.
function GetPlayerGrabBody() end

---Release what the player is currently holding
--- 
--- ---
--- Example
---```lua
---ReleasePlayerGrab()
---```
function ReleasePlayerGrab() end

---No Description
--- 
--- ---
--- Example
---```lua
---local shape = GetPlayerPickShape()
---if shape ~= 0 then
---	...
---end
---```
---@return shape_handle handle Handle to picked shape or zero if nothing is picked
function GetPlayerPickShape() end

---No Description
--- 
--- ---
--- Example
---```lua
---local body = GetPlayerPickBody()
---if body ~= 0 then
---	...
---end
---```
---@return body_handle handle Handle to picked body or zero if nothing is picked
function GetPlayerPickBody() end

---Interactable shapes has to be tagged with "interact". The engine determines which interactable shape is currently interactable.
--- 
--- ---
--- Example
---```lua
---local shape = GetPlayerInteractShape()
---if shape ~= 0 then
---	...
---end
---```
---@return shape_handle handle Handle to interactable shape or zero
function GetPlayerInteractShape() end

---Interactable shapes has to be tagged with "interact". The engine determines which interactable body is currently interactable.
--- 
--- ---
--- Example
---```lua
---local body = GetPlayerInteractBody()
---if body ~= 0 then
---	...
---end
---```
---@return body_handle handle Handle to interactable body or zero
function GetPlayerInteractBody() end

---Set the screen the player should interact with. For the screen to feature a mouse pointer and receieve input, the screen also needs to have interactive property.
--- 
--- ---
--- Example
---```lua
-----Interact with screen
---SetPlayerScreen(screen)
---
-----Do not interact with screen
---SetPlayerScreen(0)
---```
---@param handle number Handle to screen or zero for no screen
function SetPlayerScreen(handle) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Interact with screen
---local screen = GetPlayerScreen()
---```
---@return screen_handle handle Handle to interacted screen or zero if none
function GetPlayerScreen() end

---No Description
--- 
--- ---
--- Example
---```lua
---SetPlayerHealth(0.5)
---```
---@param health number Set player health (between zero and one)
function SetPlayerHealth(health) end

---No Description
--- 
--- ---
--- Example
---```lua
---local health = GetPlayerHealth()
---```
---@return number health Current player health
function GetPlayerHealth() end

---Respawn player at spawn position without modifying the scene
--- 
--- ---
--- Example
---```lua
---RespawnPlayer()
---```
function RespawnPlayer() end

---Register a custom tool that will show up in the player inventory and can be selected with scroll wheel. Do this only once per tool. You also need to enable the tool in the registry before it can be used.
--- 
--- ---
--- Example
---```lua
---function init()
---	RegisterTool("lasergun", "Laser Gun", "MOD/vox/lasergun.vox")
---	SetBool("game.tool.lasergun.enabled", true)
---end
---
---function tick()
---	if GetString("game.player.tool") == "lasergun" then
---		--Tool is selected. Tool logic goes here.
---	end
---end
---```
---@param id string Tool unique identifier
---@param name string Tool name to show in hud
---@param file string Path to vox file
---@param group? number Tool group for this tool (1-6) Default is 6.
function RegisterTool(id, name, file, group) end

---Return body handle of the visible tool. You can use this to retrieve tool shapes and animate them, change emissiveness, etc. Do not attempt to set the tool body transform, since it is controlled by the engine. Use SetToolTranform for that.
--- 
--- ---
--- Example
---```lua
---local toolBody = GetToolBody()
---if toolBody~=0 then
---	...
---end
---```
---@return body_handle handle Handle to currently visible tool body or zero if none
function GetToolBody() end

---Apply an additional transform on the visible tool body. This can be used to create tool animations. You need to set this every frame from the tick function. The optional sway parameter control the amount of tool swaying when walking. Set to zero to disable completely.
--- 
--- ---
--- Example
---```lua
-----Offset the tool half a meter to the right
---local offset = Transform(Vec(0.5, 0, 0))
---SetToolTransform(offset)
---```
---@param transform transform_t Tool body transform
---@param sway? number Tool sway amount. Default is 1.0.
function SetToolTransform(transform, sway) end

---No Description
--- 
--- ---
--- Example
---```lua
---local snd = LoadSound("beep.ogg")
---```
---@param path string Path to ogg sound file
---@param nominalDistance? number The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return sound_handle handle Sound handle
function LoadSound(path, nominalDistance) end

---No Description
--- 
--- ---
--- Example
---```lua
---local loop = LoadLoop("siren.ogg")
---```
---@param path string Path to ogg sound file
---@param nominalDistance? number The distance in meters this sound is recorded at. Affects attenuation, default is 10.0
---@return loop_handle handle Loop handle
function LoadLoop(path, nominalDistance) end

---No Description
--- 
--- ---
--- Example
---```lua
---function init()
---	snd = LoadSound("beep.ogg")
---end
---
---function tick()
---	if trigSound then
---		local pos = Vec(100, 0, 0)
---		PlaySound(snd, pos, 0.5)
---	end
---end
---
---If you have a list of sound files and you add a sequence number, starting from zero, at the end of each filename like below,
---then each time you call PlaySound it will pick a random sound from that list and play that sound.
---
---"example-sound0.ogg"
---"example-sound1.ogg"
---"example-sound2.ogg"
---"example-sound3.ogg"
---...
---
---function init()
---	--Load sound serie, OBS no ".ogg" or sequence number in filename
---	snd = LoadSound("example-sound")
---end
---
---Plays a random sound from the loaded sound series
---function tick()
---	if trigSound then
---		local pos = Vec(100, 0, 0)
---		PlaySound(snd, pos, 0.5)
---	end
---end
---```
---@param handle sound_handle Sound handle
---@param pos? vector_t World position as vector. Default is player position.
---@param volume? number Playback volume. Default is 1.0
function PlaySound(handle, pos, volume) end

---Call this function continuously to play loop
--- 
--- ---
--- Example
---```lua
---function init()
---	loop = LoadLoop("siren.ogg")
---end
---
---function tick()
---	local pos = Vec(100, 0, 0)
---	PlayLoop(loop, pos, 0.5)
---end
---```
---@param handle loop_handle Loop handle
---@param pos? vector_t World position as vector. Default is player position.
---@param volume? number Playback volume. Default is 1.0
function PlayLoop(handle, pos, volume) end

---No Description
--- 
--- ---
--- Example
---```lua
---PlayMusic("MOD/music/background.ogg")
---```
---@param path string Music path
function PlayMusic(path) end

---No Description
--- 
--- ---
--- Example
---```lua
---StopMusic()
---```
function StopMusic() end

---No Description
--- 
--- ---
--- Example
---```lua
---function init()
---	arrow = LoadSprite("arrow.png")
---end
---```
---@param path string Path to sprite. Must be PNG or JPG format.
---@return sprite_handle handle Sprite handle
function LoadSprite(path) end

---Draw sprite in world at next frame. Call this function from the tick callback.
--- 
--- ---
--- Example
---```lua
---function init()
---	arrow = LoadSprite("arrow.png")
---end
---
---function tick()
---	--Draw sprite using transform
---	--Size is two meters in width and height
---	--Color is white, fully opaue
---	local t = Transform(Vec(0, 10, 0), QuatEuler(0, GetTime(), 0))
---	DrawSprite(arrow, t, 2, 2, 1, 1, 1, 1)
---end
---```
---@param handle sprite_handle Sprite handle
---@param transform transform_t Transform
---@param width number Width in meters
---@param height number Height in meters
---@param r? number Red color. Default 1.0.
---@param g? number Green color. Default 1.0.
---@param b? number Blue color. Default 1.0.
---@param a? number Alpha. Default 1.0.
---@param depthTest? boolean Depth test enabled. Default false.
---@param additive? boolean Additive blending enabled. Default false.
function DrawSprite(handle, transform, width, height, r, g, b, a, depthTest, additive) end

---Set required layers for next query. Available layers are:
---
---| Layer | Description|
---|-|-|
---|physical|have a physical representation|
---|dynamic|part of a dynamic body|
---|static|part of a static body|
---|large|above debris threshold|
---|small|below debris threshold|
---|visible|only hit visible shapes|
--- ---
--- Example
---```lua
-----Raycast dynamic, physical objects above debris threshold, but not specific vehicle
---QueryRequire("physical dynamic large")
---QueryRejectVehicle(vehicle)
---QueryRaycast(...)
---```
---@param layers string Space separate list of layers
function QueryRequire(layers) end

---Exclude vehicle from the next query
--- 
--- ---
--- Example
---```lua
-----Do not include vehicle in next raycast
---QueryRejectVehicle(vehicle)
---QueryRaycast(...)
---```
---@param vehicle vehicle_handle Vehicle handle
function QueryRejectVehicle(vehicle) end

---Exclude body from the next query
--- 
--- ---
--- Example
---```lua
-----Do not include body in next raycast
---QueryRejectBody(body)
---QueryRaycast(...)
---```
---@param body body_handle Body handle
function QueryRejectBody(body) end

---Exclude shape from the next query
--- 
--- ---
--- Example
---```lua
-----Do not include shape in next raycast
---QueryRejectShape(shape)
---QueryRaycast(...)
---```
---@param shape shape_handle Shape handle
function QueryRejectShape(shape) end

---This will perform a raycast or spherecast (if radius is more than zero) query. If you want to set up a filter for the query you need to do so before every call to this function.
--- 
--- ---
--- Example
---```lua
-----Raycast from a high point straight downwards, excluding a specific vehicle
---QueryRejectVehicle(vehicle)
---local hit, d = QueryRaycast(Vec(0, 100, 0), Vec(0, -1, 0), 100)
---if hit then
---	...hit something at distance d
---end
---```
---@param origin vector_t Raycast origin as world space vector
---@param direction vector_t Unit length raycast direction as world space vector
---@param maxDist number Raycast maximum distance. Keep this as low as possible for good performance.
---@param radius? number Raycast thickness. Default zero.
---@param rejectTransparent? boolean Raycast through transparent materials. Default false.
---@return boolean hit True if raycast hit something
---@return number dist Hit distance from origin
---@return vector_t normal World space normal at hit point
---@return shape_handle shape Handle to hit shape
function QueryRaycast(origin, direction, maxDist, radius, rejectTransparent) end

---This will query the closest point to all shapes in the world. If you want to set up a filter for the query you need to do so before every call to this function.
--- 
--- ---
--- Example
---```lua
-----Find closest point within 10 meters of {0, 5, 0}, excluding any point on myVehicle
---QueryRejectVehicle(myVehicle)
---local hit, p, n, s = QueryClosestPoint(Vec(0, 5, 0), 10)
---if hit then
---	--Point p of shape s is closest
---end
---```
---@param origin vector_t World space point
---@param maxDist number Maximum distance. Keep this as low as possible for good performance.
---@return boolean hit True if a point was found
---@return vector_t point World space closest point
---@return vector_t normal World space normal at closest point
---@return shape_handle shape Handle to closest shape
function QueryClosestPoint(origin, maxDist) end

---Return all shapes within the provided world space, axis-aligned bounding box
--- 
--- ---
--- Example
---```lua
---local list = QueryAabbShapes(Vec(0, 0, 0), Vec(10, 10, 10))
---for i=1, #list do
---	local shape = list[i]
---	..
---end
---```
---@param min vector_t Aabb minimum point
---@param max vector_t Aabb maximum point
---@return shape_handle[] list Indexed table with handles to all shapes in the aabb
function QueryAabbShapes(min, max) end

---Return all bodies within the provided world space, axis-aligned bounding box
--- 
--- ---
--- Example
---```lua
---local list = QueryAabbBodies(Vec(0, 0, 0), Vec(10, 10, 10))
---for i=1, #list do
---	local body = list[i]
---	..
---end
---```
---@param min vector_t Aabb minimum point
---@param max vector_t Aabb maximum point
---@return body_handle[] list Indexed table with handles to all bodies in the aabb
function QueryAabbBodies(min, max) end

---Initiate path planning query. The result will run asynchronously as long as GetPathState retuns "busy". An ongoing path query can be aborted with AbortPath. The path planning query will use the currently set up query filter, just like the other query functions.
--- 
--- ---
--- Example
---```lua
---QueryPath(Vec(-10, 0, 0), Vec(10, 0, 0))
---```
---@param start vector_t World space start point
---@param end_ vector_t World space target point
---@param maxDist? number Maximum path length before giving up. Default is infinite.
---@param targetRadius? number Maximum allowed distance to target in meters. Default is 2.0
function QueryPath(start, end_, maxDist, targetRadius) end

---Abort current path query, regardless of what state it is currently in. This is a way to save computing resources if the result of the current query is no longer of interest.
--- 
--- ---
--- Example
---```lua
---AbortPath()
---```
function AbortPath() end

---Return the current state of the last path planning query.
---
---| State | Description|
---|-|-|
---|idle|No recent query|
---|busy|Busy computing. No path found yet.|
---|fail|Failed to find path. You can still get the resulting path (even though it won't reach the target).|
---|done|Path planning completed and a path was found. Get it with GetPathLength and GetPathPoint)|
--- ---
--- Example
---```lua
---local s = GetPathState()
---if s == "done" then
---	DoSomething()
---end
---```
---@return string state Current path planning state
function GetPathState() end

---Return the path length of the most recently computed path query. Note that the result can often be retrieved even if the path query failed. If the target point couldn't be reached, the path endpoint will be the point closest to the target.
--- 
--- ---
--- Example
---```lua
---local l = GetPathLength()
---```
---@return number length Length of last path planning result (in meters)
function GetPathLength() end

---Return a point along the path for the most recently computed path query. Note that the result can often be retrieved even if the path query failed. If the target point couldn't be reached, the path endpoint will be the point closest to the target.
--- 
--- ---
--- Example
---```lua
---local d = 0
---local l = GetPathLength()
---while d < l do
---	DebugCross(GetPathPoint(d))
---	d = d + 0.5
---end
---```
---@param dist number The distance along path. Should be between zero and result from GetPathLength()
---@return vector_t point The path point dist meters along the path
function GetPathPoint(dist) end

---No Description
--- 
--- ---
--- Example
---```lua
---local vol, pos = GetLastSound()
---```
---@return number volume Volume of loudest sound played last frame
---@return vector_t position World position of loudest sound played last frame
function GetLastSound() end

---No Description
--- 
--- ---
--- Example
---```lua
---local wet, d = IsPointInWater(Vec(10, 0, 0))
---if wet then
---	...point d meters into water
---end
---```
---@param point vector_t World point as vector
---@return boolean inWater True if point is in water
---@return number depth Depth of point into water, or zero if not in water
function IsPointInWater(point) end

---Get the wind velocity at provided point. The wind will be determined by wind property of the environment, but it varies with position procedurally.
--- 
--- ---
--- Example
---```lua
---local v = GetWindVelocity(Vec(0, 10, 0))
---```
---@param point vector_t World point as vector
---@return vector_t vel Wind at provided position
function GetWindVelocity(point) end

---Reset to default particle state, which is a plain, white particle of radius 0.5. Collision is enabled and it alpha animates from 1 to 0.
--- 
--- ---
--- Example
---```lua
---ParticleReset()
---```
function ParticleReset() end

---Set type of particle
--- 
--- ---
--- Example
---```lua
---ParticleType("smoke")
---```
---@param type string Type of particle. Can be "smoke" or "plain".
function ParticleType(type) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Smoke particle
---ParticleTile(0)
---
-----Fire particle
---ParticleTile(5)
---```
---@param type integer Tile in the particle texture atlas (0-15)
function ParticleTile(type) end

---Set particle color to either constant (three arguments) or linear interpolation (six arguments)
--- 
--- ---
--- Example
---```lua
-----Constant red
---ParticleColor(1,0,0)
---
-----Animating from yellow to red
---ParticleColor(1,1,0, 1,0,0)
---```
---@param r0 number Red value
---@param g0 number Green value
---@param b0 number Blue value
---@param r1? number Red value at end
---@param g1? number Green value at end
---@param b1? number Blue value at end
function ParticleColor(r0, g0, b0, r1, g1, b1) end

---Set the particle radius. Max radius for smoke particles is 1.0.
--- 
--- ---
--- Example
---```lua
-----Constant radius 0.4 meters
---ParticleRadius(0.4)
---
-----Interpolate from small to large
---ParticleRadius(0.1, 0.7)
---```
---@param r0 number Radius
---@param r1? number End radius
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleRadius(r0, r1, interpolation, fadein, fadeout) end

---Set the particle alpha (opacity).
--- 
--- ---
--- Example
---```lua
-----Interpolate from opaque to transparent
---ParticleAlpha(1.0, 0.0)
---```
---@param a0 number Alpha (0.0 - 1.0)
---@param a1? number End alpha (0.0 - 1.0)
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleAlpha(a0, a1, interpolation, fadein, fadeout) end

---Set particle gravity. It will be applied along the world Y axis. A negative value will move the particle downwards.
--- 
--- ---
--- Example
---```lua
-----Move particles slowly upwards
---ParticleGravity(2)
---```
---@param g0 number Gravity
---@param g1? number End gravity
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleGravity(g0, g1, interpolation, fadein, fadeout) end

---Particle drag will slow down fast moving particles. It's implemented slightly different for smoke and plain particles. Drag must be positive, and usually look good between zero and one.
--- 
--- ---
--- Example
---```lua
-----Slow down fast moving particles
---ParticleDrag(0.5)
---```
---@param d0 number Drag
---@param d1? number End drag
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleDrag(d0, d1, interpolation, fadein, fadeout) end

---Draw particle as emissive (glow in the dark). This is useful for fire and embers.
--- 
--- ---
--- Example
---```lua
-----Highly emissive at start, not emissive at end
---ParticleEmissive(5, 0)
---```
---@param d0 number Emissive
---@param d1? number End emissive
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleEmissive(d0, d1, interpolation, fadein, fadeout) end

---Makes the particle rotate. Positive values is counter-clockwise rotation.
--- 
--- ---
--- Example
---```lua
-----Rotate fast at start and slow at end
---ParticleRotation(10, 1)
---```
---@param r0 number Rotation speed in radians per second.
---@param r1? number End rotation speed in radians per second.
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleRotation(r0, r1, interpolation, fadein, fadeout) end

---Stretch particle along with velocity. 0.0 means no stretching. 1.0 stretches with the particle motion over one frame. Larger values stretches the particle even more.
--- 
--- ---
--- Example
---```lua
-----Stretch particle along direction of motion
---ParticleStretch(1.0)
---```
---@param s0 number Stretch
---@param s1? number End stretch
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleStretch(s0, s1, interpolation, fadein, fadeout) end

---Make particle stick when in contact with objects. This can be used for friction.
--- 
--- ---
--- Example
---```lua
-----Make particles stick to objects
---ParticleSticky(0.5)
---```
---@param s0 number Sticky (0.0 - 1.0)
---@param s1? number End sticky (0.0 - 1.0)
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleSticky(s0, s1, interpolation, fadein, fadeout) end

---Control particle collisions. A value of zero means that collisions are ignored. One means full collision. It is sometimes useful to animate this value from zero to one in order to not collide with objects around the emitter.
--- 
--- ---
--- Example
---```lua
-----Disable collisions
---ParticleCollide(0)
---
-----Enable collisions over time
---ParticleCollide(0, 1)
---
-----Ramp up collisions very quickly, only skipping the first 5% of lifetime
---ParticleCollide(1, 1, "constant", 0.05)
---```
---@param c0 number Collide (0.0 - 1.0)
---@param c1? number End collide (0.0 - 1.0)
---@param interpolation? string Interpolation method: linear, smooth, easein, easeout or constant. Default is linear.
---@param fadein? number Fade in between t=0 and t=fadein. Default is zero.
---@param fadeout? number Fade out between t=fadeout and t=1. Default is one.
function ParticleCollide(c0, c1, interpolation, fadein, fadeout) end

---Set particle bitmask. The value 256 means fire extinguishing particles and is currently the only flag in use. There might be support for custom flags and queries in the future.
--- 
--- ---
--- Example
---```lua
-----Fire extinguishing particle
---ParticleFlags(256)
---SpawnParticle(...)
---```
---@param bitmask number Particle flags (bitmask 0-65535)
function ParticleFlags(bitmask) end

---Spawn particle using the previously set up particle state. You can call this multiple times using the same particle state, but with different position, velocity and lifetime. You can also modify individual properties in the particle state in between calls to to this function.
--- 
--- ---
--- Example
---```lua
---ParticleReset()
---ParticleType("smoke")
---ParticleColor(0.7, 0.6, 0.5)
-----Spawn particle at world origo with upwards velocity and a lifetime of ten seconds
---SpawnParticle(Vec(0, 0, 0), Vec(0, 1, 0), 10.0)
---```
---@param pos vector_t World space point as vector
---@param velocity vector_t World space velocity as vector
---@param lifetime number Particle lifetime in seconds
function SpawnParticle(pos, velocity, lifetime) end

---The first argument can be either a prefab XML file in your mod folder or a string with XML content. It is also possible to spawn prefabs from other mods, by using the mod id followed by colon, followed by the prefab path. Spawning prefabs from other mods should be used with causion since the referenced mod might not be installed.
--- 
--- ---
--- Example
---```lua
---Spawn("MOD/prefab/mycar.xml", Transform(Vec(0, 5, 0)))
---Spawn("<voxbox size='10 10 10' prop='true' material='wood'/>", Transform(Vec(0, 10, 0)))
---```
---@param xml string File name or xml string
---@param transform transform_t Spawn transform
---@param allowStatic? boolean Allow spawning static shapes and bodies (default false)
---@param jointExisting? boolean Allow joints to connect to existing scene geometry (default false)
---@return entity_handle[] entities Indexed table with handles to all spawned entities
function Spawn(xml, transform, allowStatic, jointExisting) end

---Fire projectile. Type can be one of "bullet", "rocket", "gun" or "shotgun". For backwards compatilbility, type also accept a number, where 1 is same as "rocket" and anything else "bullet" Note that this function will only spawn the projectile, not make any sound Also note that "bullet" and "rocket" are the only projectiles that can hurt the player.
--- 
--- ---
--- Example
---```lua
---Shoot(Vec(0, 10, 0), Vec(0, 0, 1), "shotgun")
---```
---@param origin vector_t Origin in world space as vector
---@param direction vector_t Unit length direction as world space vector
---@param type? string Shot type, see description, default is "bullet"
---@param strength? number Strength scaling, default is 1.0
---@param maxDist? number Maximum distance, default is 100.0
function Shoot(origin, direction, type, strength, maxDist) end

---Tint the color of objects within radius to either black or yellow.
--- 
--- ---
--- Example
---```lua
---Paint(Vec(0, 10, 0), 0.5, "spraycan")
---```
---@param origin vector_t Origin in world space as vector
---@param radius number Affected radius, in range 0.0 to 5.0
---@param type? string Paint type. Can be "explosion" or "spraycan". Default is spraycan.
---@param probability? number Dithering probability between zero and one, default is 1.0
function Paint(origin, radius, type, probability) end

---Make a hole in the environment. Radius is given in meters. Soft materials: glass, foliage, dirt, wood, plaster and plastic. Medium materials: concrete, brick and weak metal. Hard materials: hard metal and hard masonry.
--- 
--- ---
--- Example
---```lua
---MakeHole(pos, 1.2, 1.0)
---```
---@param position vector_t Hole center point
---@param r0 number Hole radius for soft materials
---@param r1? number Hole radius for medium materials. May not be bigger than r0. Default zero.
---@param r2? number Hole radius for hard materials. May not be bigger than r1. Default zero.
---@param silent? boolean Make hole without playing any break sounds.
---@return number count Number of voxels that was cut out. This will be zero if there were no changes to any shape.
function MakeHole(position, r0, r1, r2, silent) end

---No Description
--- 
--- ---
--- Example
---```lua
---Explosion(Vec(0, 10, 0), 1)
---```
---@param pos vector_t Position in world space as vector
---@param size number Explosion size from 0.5 to 4.0
function Explosion(pos, size) end

---No Description
--- 
--- ---
--- Example
---```lua
---SpawnFire(Vec(0, 10, 0))
---```
---@param pos vector_t Position in world space as vector
function SpawnFire(pos) end

---No Description
--- 
--- ---
--- Example
---```lua
---local c = GetFireCount()
---```
---@return number count Number of active fires in level
function GetFireCount() end

---No Description
--- 
--- ---
--- Example
---```lua
---local hit, pos = QueryClosestFire(GetPlayerTransform().pos, 5.0)
---if hit then
---	--There is a fire within 5 meters to the player. Mark it with a debug cross.
---	DebugCross(pos)
---end
---```
---@param origin vector_t World space position as vector
---@param maxDist number Maximum search distance
---@return boolean hit A fire was found within search distance
---@return vector_t pos Position of closest fire
function QueryClosestFire(origin, maxDist) end

---No Description
--- 
--- ---
--- Example
---```lua
---local count = QueryAabbFireCount(Vec(0,0,0), Vec(10,10,10))
---```
---@param min vector_t Aabb minimum point
---@param max vector_t Aabb maximum point
---@return number count Number of active fires in bounding box
function QueryAabbFireCount(min, max) end

---No Description
--- 
--- ---
--- Example
---```lua
---local removedCount= RemoveAabbFires(Vec(0,0,0), Vec(10,10,10))
---```
---@param min vector_t Aabb minimum point
---@param max vector_t Aabb maximum point
---@return number count Number of fires removed
function RemoveAabbFires(min, max) end

---No Description
--- 
--- ---
--- Example
---```lua
---local t = GetCameraTransform()
---```
---@return transform_t transform Current camera transform
function GetCameraTransform() end

---Override current camera transform for this frame. Call continuously to keep overriding.
--- 
--- ---
--- Example
---```lua
---SetCameraTransform(Transform(Vec(0, 10, 0), QuatEuler(0, 90, 0)))
---```
---@param transform transform_t Desired camera transform
---@param fov? number Optional horizontal field of view in degrees (default: 90)
function SetCameraTransform(transform, fov) end

---Override field of view for the next frame for all camera modes, except when explicitly set in SetCameraTransform
--- 
--- ---
--- Example
---```lua
---function tick()
---	SetCameraFov(60)
---end
---```
---@param degrees number Horizontal field of view in degrees (10-170)
function SetCameraFov(degrees) end

---Override depth of field for the next frame for all camera modes. Depth of field will be used even if turned off in options.
--- 
--- ---
--- Example
---```lua
-----Set depth of field to 10 meters
---SetCameraDof(10)
---```
---@param distance number Depth of field distance
---@param amount? number Optional amount of blur (default 1.0)
function SetCameraDof(distance, amount) end

---Add a temporary point light to the world for this frame. Call continuously for a steady light.
--- 
--- ---
--- Example
---```lua
-----Pulsating, yellow light above world origo
---local intensity = 3 + math.sin(GetTime())
---PointLight(Vec(0, 5, 0), 1, 1, 0, intensity)
---```
---@param pos vector_t World space light position
---@param r number Red
---@param g number Green
---@param b number Blue
---@param intensity? number Intensity. Default is 1.0.
function PointLight(pos, r, g, b, intensity) end

---Experimental. Scale time in order to make a slow-motion effect. Audio will also be affected. Note that this will affect physics behavior and is not intended for gameplay purposes. Calling this function will slow down time for the next frame only. Call every frame from tick function to get steady slow-motion.
--- 
--- ---
--- Example
---```lua
-----Slow down time when holding down a key
---if InputDown('t') then
---SetTimeScale(0.2)
---end
---```
---@param scale number Time scale 0.1 to 1.0
function SetTimeScale(scale) end

---Reset the environment properties to default. This is often useful before setting up a custom environment.
--- 
--- ---
--- Example
---```lua
---SetEnvironmentDefault()
---```
function SetEnvironmentDefault() end

---This function is used for manipulating the environment properties. The available properties are exactly the same as in the editor, except for "snowonground" which is not currently supported.
--- 
--- ---
--- Example
---```lua
---SetEnvironmentProperty("skybox", "cloudy.dds")
---SetEnvironmentProperty("rain", 0.7)
---SetEnvironmentProperty("fogcolor", 0.5, 0.5, 0.8)
---SetEnvironmentProperty("nightlight", false)
---```
---@param name string Property name
---@param value0 any Property value (type depends on property)
---@param value1? any Extra property value (only some properties)
---@param value2? any Extra property value (only some properties)
---@param value3? any Extra property value (only some properties)
function SetEnvironmentProperty(name, value0, value1, value2, value3) end

---This function is used for querying the current environment properties. The available properties are exactly the same as in the editor.
--- 
--- ---
--- Example
---```lua
---local skyboxPath = GetEnvironmentProperty("skybox")
---local rainValue = GetEnvironmentProperty("rain")
---local r,g,b = GetEnvironmentProperty("fogcolor")
---local enabled = GetEnvironmentProperty("nightlight")
---```
---@param name string Property name
---@return any value0 Property value (type depends on property)
---@return any value1 Property value (only some properties)
---@return any value2 Property value (only some properties)
---@return any value3 Property value (only some properties)
---@return any value4 Property value (only some properties)
function GetEnvironmentProperty(name) end

---Reset the post processing properties to default.
--- 
--- ---
--- Example
---```lua
---SetPostProcessingDefault()
---```
function SetPostProcessingDefault() end

---This function is used for manipulating the post processing properties. The available properties are exactly the same as in the editor.
--- 
--- ---
--- Example
---```lua
-----Sepia post processing
---SetPostProcessingProperty("saturation", 0.4)
---SetPostProcessingProperty("colorbalance", 1.3, 1.0, 0.7)
---```
---@param name string Property name
---@param value0 number Property value
---@param value1? number Extra property value (only some properties)
---@param value2? number Extra property value (only some properties)
function SetPostProcessingProperty(name, value0, value1, value2) end

---This function is used for querying the current post processing properties. The available properties are exactly the same as in the editor.
--- 
--- ---
--- Example
---```lua
---local saturation = GetPostProcessingProperty("saturation")
---local r,g,b = GetPostProcessingProperty("colorbalance")
---```
---@param name string Property name
---@return number value0 Property value
---@return number value1 Property value (only some properties)
---@return number value2 Property value (only some properties)
function GetPostProcessingProperty(name) end

---Draw a 3D line. In contrast to DebugLine, it will not show behind objects. Default color is white.
--- 
--- ---
--- Example
---```lua
-----Draw white debug line
---DrawLine(Vec(0, 0, 0), Vec(-10, 5, -10))
---
-----Draw red debug line
---DrawLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
---```
---@param p0 vector_t World space point as vector
---@param p1 vector_t World space point as vector
---@param r? number Red
---@param g? number Green
---@param b? number Blue
---@param a? number Alpha
function DrawLine(p0, p1, r, g, b, a) end

---Draw a 3D debug overlay line in the world. Default color is white.
--- 
--- ---
--- Example
---```lua
-----Draw white debug line
---DebugLine(Vec(0, 0, 0), Vec(-10, 5, -10))
---
-----Draw red debug line
---DebugLine(Vec(0, 0, 0), Vec(10, 5, 10), 1, 0, 0)
---```
---@param p0 vector_t World space point as vector
---@param p1 vector_t World space point as vector
---@param r? number Red
---@param g? number Green
---@param b? number Blue
---@param a? number Alpha
function DebugLine(p0, p1, r, g, b, a) end

---Draw a debug cross in the world to highlight a location. Default color is white.
--- 
--- ---
--- Example
---```lua
---DebugCross(Vec(10, 5, 5))
---```
---@param p0 vector_t World space point as vector
---@param r? number Red
---@param g? number Green
---@param b? number Blue
---@param a? number Alpha
function DebugCross(p0, r, g, b, a) end

---Show a named valued on screen for debug purposes. Up to 32 values can be shown simultaneously. Values updated the current frame are drawn opaque. Old values are drawn transparent in white.
---
---The function will also recognize vectors, quaternions and transforms as second argument and convert them to strings automatically.
--- 
--- ---
--- Example
---```lua
---local t = 5
---DebugWatch("time", t)
---```
---@param name string Name
---@param value string Value
function DebugWatch(name, value) end

---Display message on screen. The last 20 lines are displayed.
--- 
--- ---
--- Example
---```lua
---DebugPrint("time")
---```
---@param message string Message to display
function DebugPrint(message) end

---Calling this function will disable game input, bring up the mouse pointer and allow Ui interaction with the calling script without pausing the game. This can be useful to make interactive user interfaces from scripts while the game is running. Call this continuously every frame as long as Ui interaction is desired.
--- 
--- ---
--- Example
---```lua
---UiMakeInteractive()
---```
function UiMakeInteractive() end

---Push state onto stack. This is used in combination with UiPop to remember a state and restore to that state later.
--- 
--- ---
--- Example
---```lua
---UiColor(1,0,0)
---UiText("Red")
---UiPush()
---	UiColor(0,1,0)
---	UiText("Green")
---UiPop()
---UiText("Red")
---```
function UiPush() end

---Pop state from stack and make it the current one. This is used in combination with UiPush to remember a previous state and go back to it later.
--- 
--- ---
--- Example
---```lua
---UiColor(1,0,0)
---UiText("Red")
---UiPush()
---	UiColor(0,1,0)
---	UiText("Green")
---UiPop()
---UiText("Red")
---```
function UiPop() end

---No Description
--- 
--- ---
--- Example
---```lua
---local w = UiWidth()
---```
---@return number width Width of draw context
function UiWidth() end

---No Description
--- 
--- ---
--- Example
---```lua
---local h = UiHeight()
---```
---@return number height Height of draw context
function UiHeight() end

---No Description
--- 
--- ---
--- Example
---```lua
---local c = UiCenter()
-----Same as 
---local c = UiWidth()/2
---```
---@return number center Half width of draw context
function UiCenter() end

---No Description
--- 
--- ---
--- Example
---```lua
---local m = UiMiddle()
-----Same as
---local m = UiHeight()/2
---```
---@return number middle Half height of draw context
function UiMiddle() end

---No Description
--- 
--- ---
--- Example
---```lua
-----Set color yellow
---UiColor(1,1,0)
---```
---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a? number Alpha channel. Default 1.0
function UiColor(r, g, b, a) end

---Color filter, multiplied to all future colors in this scope
--- 
--- ---
--- Example
---```lua
---UiPush()
---	--Draw menu in transparent, yellow color tint
---	UiColorFilter(1, 1, 0, 0.5)
---	drawMenu()
---UiPop()
---```
---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a? number Alpha channel. Default 1.0
function UiColorFilter(r, g, b, a) end

---Translate cursor
--- 
--- ---
--- Example
---```lua
---UiPush()
---	UiTranslate(100, 0)
---	UiText("Indented")
---UiPop()
---```
---@param x number X component
---@param y? number Y component
function UiTranslate(x, y) end

---Rotate cursor
--- 
--- ---
--- Example
---```lua
---UiPush()
---	UiRotate(45)
---	UiText("Rotated")
---UiPop()
---```
---@param angle number Angle in degrees, counter clockwise
function UiRotate(angle) end

---Scale cursor either uniformly (one argument) or non-uniformly (two arguments)
--- 
--- ---
--- Example
---```lua
---UiPush()
---	UiScale(2)
---	UiText("Double size")
---UiPop()
---```
---@param x number X component
---@param y? number Y component. Default value is x.
function UiScale(x, y) end

---Set up new bounds. Calls to UiWidth, UiHeight, UiCenter and UiMiddle will operate in the context of the window size. If clip is set to true, contents of window will be clipped to bounds (only works properly for non-rotated windows).
--- 
--- ---
--- Example
---```lua
---UiPush()
---	UiWindow(400, 200)
---	local w = UiWidth()
---	--w is now 400
---UiPop()
---```
---@param width number Window width
---@param height number Window height
---@param clip? boolean Clip content outside window. Default is false.
---@param inherit? boolean Inherit current clip region (for nested clip regions)
function UiWindow(width, height, clip, inherit) end

---Return a safe drawing area that will always be visible regardless of display aspect ratio. The safe drawing area will always be 1920 by 1080 in size. This is useful for setting up a fixed size UI.
--- 
--- ---
--- Example
---```lua
---function draw()
---	local x0, y0, x1, y1 = UiSafeMargins()
---	UiTranslate(x0, y0)
---	UiWindow(x1-x0, y1-y0, true)
---	--The drawing area is now 1920 by 1080 in the center of screen
---	drawMenu()
---end
---```
---@return number x0 Left
---@return number y0 Top
---@return number x1 Right
---@return number y1 Bottom
function UiSafeMargins() end

---The alignment determines how content is aligned with respect to the cursor.
---
---| Alignment | Description|
---|-|-|
---|left|Horizontally align to the left|
---|right|Horizontally align to the right|
---|center|Horizontally align to the center|
---|top|Vertically align to the top|
---|bottom|Veritcally align to the bottom|
---|middle|Vertically align to the middle|
--- ---
--- Example
---```lua
---UiAlign("left")
---UiText("Aligned left at baseline")
---
---UiAlign("center middle")
---UiText("Fully centered")
---```
---@param alignment string Alignment keywords
function UiAlign(alignment) end

---Disable input for everything, except what's between UiModalBegin and UiModalEnd (or if modal state is popped)
--- 
--- ---
--- Example
---```lua
---UiModalBegin()
---if UiTextButton("Okay") then
---	--All other interactive ui elements except this one are disabled
---end
---UiModalEnd()
---
-----This is also okay
---UiPush()
---	UiModalBegin()
---	if UiTextButton("Okay") then
---		--All other interactive ui elements except this one are disabled
---	end
---UiPop()
-----No longer modal
---```
function UiModalBegin() end

---Disable input for everything, except what's between UiModalBegin and UiModalEnd Calling this function is optional. Modality is part of the current state and will be lost if modal state is popped.
--- 
--- ---
--- Example
---```lua
---UiModalBegin()
---if UiTextButton("Okay") then
---	--All other interactive ui elements except this one are disabled
---end
---UiModalEnd()
---```
function UiModalEnd() end

---Disable input
--- 
--- ---
--- Example
---```lua
---UiPush()
---	UiDisableInput()
---	if UiTextButton("Okay") then
---		--Will never happen
---	end
---UiPop()
---```
function UiDisableInput() end

---Enable input that has been previously disabled
--- 
--- ---
--- Example
---```lua
---UiDisableInput()
---if UiTextButton("Okay") then
---	--Will never happen
---end
---
---UiEnableInput()
---if UiTextButton("Okay") then
---	--This can happen
---end
---```
function UiEnableInput() end

---This function will check current state receives input. This is the case if input is not explicitly disabled with (with UiDisableInput) and no other state is currently modal (with UiModalBegin). Input functions and UI elements already do this check internally, but it can sometimes be useful to read the input state manually to trigger things in the UI.
--- 
--- ---
--- Example
---```lua
---if UiReceivesInput() then
---	highlightItemAtMousePointer()
---end
---```
---@return boolean receives True if current context receives input
function UiReceivesInput() end

---Get mouse pointer position relative to the cursor
--- 
--- ---
--- Example
---```lua
---local x, y = UiGetMousePos()
---```
---@return number x X coordinate
---@return number y Y coordinate
function UiGetMousePos() end

---Check if mouse pointer is within rectangle. Note that this function respects alignment.
--- 
--- ---
--- Example
---```lua
---if UiIsMouseInRect(100, 100) then
---	-- mouse pointer is in rectangle
---end
---```
---@param w number Width
---@param h number Height
---@return boolean inside True if mouse pointer is within rectangle
function UiIsMouseInRect(w, h) end

---Convert world space position to user interface X and Y coordinate relative to the cursor. The distance is in meters and positive if in front of camera, negative otherwise.
--- 
--- ---
--- Example
---```lua
---local x, y, dist = UiWorldToPixel(point)
---if dist > 0 then
---UiTranslate(x, y)
---UiText("Label")
---end
---```
---@param point vector_t 3D world position as vector
---@return number x X coordinate
---@return number y Y coordinate
---@return number distance Distance to point
function UiWorldToPixel(point) end

---Convert X and Y UI coordinate to a world direction, as seen from current camera. This can be used to raycast into the scene from the mouse pointer position.
--- 
--- ---
--- Example
---```lua
---UiMakeInteractive()
---local x, y = UiGetMousePos()
---local dir = UiPixelToWorld(x, y)
---local pos = GetCameraTransform().pos
---local hit, dist = QueryRaycast(pos, dir, 100)
---if hit then
---	DebugPrint("hit distance: " .. dist)
---end
---```
---@param x number X coordinate
---@param y number Y coordinate
---@return vector_t direction 3D world direction as vector
function UiPixelToWorld(x, y) end

---Perform a gaussian blur on current screen content
--- 
--- ---
--- Example
---```lua
---UiBlur(1.0)
---drawMenu()
---```
---@param amount number Blur amount (0.0 to 1.0)
function UiBlur(amount) end

---No Description
--- 
--- ---
--- Example
---```lua
---UiFont("bold.ttf", 24)
---UiText("Hello")
---```
---@param path string Path to TTF font file
---@param size number Font size (10 to 100)
function UiFont(path, size) end

---No Description
--- 
--- ---
--- Example
---```lua
---local h = UiFontHeight()
---```
---@return number size Font size
function UiFontHeight() end

---No Description
--- 
--- ---
--- Example
---```lua
---UiFont("bold.ttf", 24)
---UiText("Hello")
---
---...
---
-----Automatically advance cursor
---UiText("First line", true)
---UiText("Second line", true)
---```
---@param text string Print text at cursor location
---@param move? boolean Automatically move cursor vertically. Default false.
---@param maxChars? number 
---@return number w Width of text
---@return number h Height of text
---@return number x End x-position of text. Only valid when "advance cursor" is false
---@return number y End y-position of text. Only valid when "advance cursor" is false
function UiText(text, move, maxChars) end

---No Description
--- 
--- ---
--- Example
---```lua
---local w, h = UiGetTextSize("Some text")
---```
---@param text string A text string
---@return number w Width of text
---@return number h Height of text
function UiGetTextSize(text) end

---No Description
--- 
--- ---
--- Example
---```lua
---UiWordWrap(200)
---UiText("Some really long text that will get wrapped into several lines")
---```
---@param width number Maximum width of text
function UiWordWrap(width) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Black outline, standard thickness
---UiTextOutline(0,0,0,1)
---UiText("Text with outline")
---```
---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number Alpha channel
---@param thickness? number Outline thickness. Default is 0.1
function UiTextOutline(r, g, b, a, thickness) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Black drop shadow, 50% transparent, distance 2
---UiTextShadow(0, 0, 0, 0.5, 2.0)
---UiText("Text with drop shadow")
---```
---@param r number Red channel
---@param g number Green channel
---@param b number Blue channel
---@param a number Alpha channel
---@param distance? number Shadow distance. Default is 1.0
---@param blur? number Shadow blur. Default is 0.5
function UiTextShadow(r, g, b, a, distance, blur) end

---Draw solid rectangle at cursor position
--- 
--- ---
--- Example
---```lua
-----Draw full-screen black rectangle
---UiColor(0, 0, 0)
---UiRect(UiWidth(), UiHeight())
---
-----Draw smaller, red, rotating rectangle in center of screen
---UiPush()
---	UiColor(1, 0, 0)
---	UiTranslate(UiCenter(), UiMiddle())
---	UiRotate(GetTime())
---	UiAlign("center middle")
---	UiRect(100, 100)
---UiPop()
---```
---@param w number Width
---@param h number Height
function UiRect(w, h) end

---Draw image at cursor position. If x0, y0, x1, y1 is provided a cropped version will be drawn in that coordinate range.
--- 
--- ---
--- Example
---```lua
-----Draw image in center of screen
---UiPush()
---	UiTranslate(UiCenter(), UiMiddle())
---	UiAlign("center middle")
---	UiImage("test.png")
---UiPop()
---```
---@param path string Path to image (PNG or JPG format)
---@param x0? number Lower x coordinate (default is 0)
---@param y0? number Lower y coordinate (default is 0)
---@param x1? number Upper x coordinate (default is image width)
---@param y1? number Upper y coordinate (default is image height)
---@return number w Width of drawn image
---@return number h Height of drawn image
function UiImage(path, x0, y0, x1, y1) end

---Get image size
--- 
--- ---
--- Example
---```lua
---local w,h = UiGetImageSize("test.png")
---```
---@param path string Path to image (PNG or JPG format)
---@return number w Image width
---@return number h Image height
function UiGetImageSize(path) end

---Draw 9-slice image at cursor position. Width should be at least 2*borderWidth. Height should be at least 2*borderHeight.
--- 
--- ---
--- Example
---```lua
---UiImageBox("menu-frame.png", 200, 200, 10, 10)
---```
---@param path string Path to image (PNG or JPG format)
---@param width number Width
---@param height number Height
---@param borderWidth number Border width
---@param borderHeight number Border height
function UiImageBox(path, width, height, borderWidth, borderHeight) end

---UI sounds are not affected by acoustics simulation. Use LoadSound / PlaySound for that.
--- 
--- ---
--- Example
---```lua
---UiSound("click.ogg")
---```
---@param path string Path to sound file (OGG format)
---@param volume? number Playback volume. Default 1.0
---@param pitch? number Playback pitch. Default 1.0
---@param pan? number Playback stereo panning (-1.0 to 1.0). Default 0.0.
function UiSound(path, volume, pitch, pan) end

---Call this continuously to keep playing loop. UI sounds are not affected by acoustics simulation. Use LoadLoop / PlayLoop for that.
--- 
--- ---
--- Example
---```lua
---if animating then
---	UiSoundLoop("screech.ogg")
---end
---```
---@param path string Path to looping sound file (OGG format)
---@param volume? number Playback volume. Default 1.0
function UiSoundLoop(path, volume) end

---Mute game audio and optionally music for the next frame. Call continuously to stay muted.
--- 
--- ---
--- Example
---```lua
---if menuOpen then
---	UiMute(1.0)
---end
---```
---@param amount number Mute by this amount (0.0 to 1.0)
---@param music? boolean Mute music as well
function UiMute(amount, music) end

---Set up 9-slice image to be used as background for buttons.
--- 
--- ---
--- Example
---```lua
---UiButtonImageBox("button-9slice.png", 10, 10)
---if UiTextButton("Test") then
---	...
---end
---```
---@param path string Path to image (PNG or JPG format)
---@param borderWidth number Border width
---@param borderHeight number Border height
---@param r? number Red multiply. Default 1.0
---@param g? number Green multiply. Default 1.0
---@param b? number Blue multiply. Default 1.0
---@param a? number Alpha channel. Default 1.0
function UiButtonImageBox(path, borderWidth, borderHeight, r, g, b, a) end

---Button color filter when hovering mouse pointer.
--- 
--- ---
--- Example
---```lua
---UiButtonHoverColor(1, 0, 0)
---if UiTextButton("Test") then
---	...
---end
---```
---@param r number Red multiply
---@param g number Green multiply
---@param b number Blue multiply
---@param a? number Alpha channel. Default 1.0
function UiButtonHoverColor(r, g, b, a) end

---Button color filter when pressing down.
--- 
--- ---
--- Example
---```lua
---UiButtonPressColor(0, 1, 0)
---if UiTextButton("Test") then
---	...
---end
---```
---@param r number Red multiply
---@param g number Green multiply
---@param b number Blue multiply
---@param a? number Alpha channel. Default 1.0
function UiButtonPressColor(r, g, b, a) end

---The button offset when being pressed
--- 
--- ---
--- Example
---```lua
---UiButtonPressDistance(4)
---if UiTextButton("Test") then
---	...
---end
---```
---@param dist number Press distance
function UiButtonPressDist(dist) end

---No Description
--- 
--- ---
--- Example
---```lua
---if UiTextButton("Test") then
---	...
---end
---```
---@param text string Text on button
---@param w? number Button width
---@param h? number Button height
---@return boolean pressed True if user clicked button
function UiTextButton(text, w, h) end

---No Description
--- 
--- ---
--- Example
---```lua
---if UiImageButton("image.png") then
---	...
---end
---```
---@param path number Image path (PNG or JPG file)
---@return boolean pressed True if user clicked button
function UiImageButton(path) end

---No Description
--- 
--- ---
--- Example
---```lua
---if UiBlankButton(30, 30) then
---	...
---end
---```
---@param w number Button width
---@param h number Button height
---@return boolean pressed True if user clicked button
function UiBlankButton(w, h) end

---No Description
--- 
--- ---
--- Example
---```lua
---value = UiSlider("dot.png", "x", value, 0, 100)
---```
---@param path number Image path (PNG or JPG file)
---@param axis string Drag axis, must be "x" or "y"
---@param current number Current value
---@param min number Minimum value
---@param max number Maximum value
---@return number value New value, same as current if not changed
---@return boolean done True if user is finished changing (released slider)
function UiSlider(path, axis, current, min, max) end

---No Description
--- 
--- ---
--- Example
---```lua
-----Turn off screen running current script
---screen = UiGetScreen()
---SetScreenEnabled(screen, false)
---```
---@return screen_handle handle Handle to the screen running this script or zero if none.
function UiGetScreen() end