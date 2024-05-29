---Clone a table without any links to the original.
function DeepCopy(tb_orig)
	local orig_type = type(tb_orig)
	local copy
	if orig_type == 'table' then
		copy = {}
		for orig_key, orig_value in next, tb_orig, nil do
			copy[DeepCopy(orig_key)] = DeepCopy(orig_value)
		end
		setmetatable(copy, DeepCopy(getmetatable(tb_orig)))
	else -- number, string, boolean, etc
		copy = tb_orig
	end
	return copy
end

function GetTableSize(tb)
	local s = 0 for _,_ in pairs(tb) do s = s + 1 end return s
end



---Get a random index of a table (not the value).
function GetRandomIndex(tb)
	local i = math.random(1, #tb)
	return i, tb[i]
end

---Get a random index of a table (not the value).
function GetRandomArrayValue(tb)
	local i = math.random(1, #tb)
	return tb[i]
end

---( WARNING - Might be slow for tables that have a lot of keys. )
---Get a random key of a table (not the value).
function GetRandomKey(tb)

	local keys = {}

	for key, _ in pairs(tb) do table.insert(keys, key) end

	return GetRandomArrayValue(keys)

end

---@param tb any
---@return any value
---@return string key
function GetRandomPairsValue(tb)
	local key = GetRandomKey(tb)
	return tb[key], key
end


---Get the next index of a table (not the value). Loop to first index if on the last index.
function GetTableNextIndex(tb, i)
	if i + 1 > #tb then
		return 1
	else
		return i + 1
	end
end

---Get the previous index of a table (not the value). Loop to first index if on the last index.
function GetTablePreviousIndex(tb, i)
	if i - 1 <= 0 then
		return #tb
	else
		return i - 1
	end
end

function GetArrayLastValue(tb) return tb[#tb] end

function TableRemoveUniqueValue(tb, unique_value)
	for i, v in ipairs(tb) do
		if v == unique_value then
			table.remove(tb, i)
			return
		end
	end
end


---Swap 2 values in a table.
function TableSwapValue(tb, i1, i2)
	local temp = DeepCopy(tb[i1])
	tb[i1] = tb[i2]
	tb[i2] = temp
	return tb
end

function GetTableKeys(tb)
	local keys = {}
	for key, value in pairs(tb) do
		table.insert(keys, key)
	end
	return keys
end

function TableContainsDuplicates(tb)

	local vals = {}

	for index, value in ipairs(tb) do

		if TableContainsValue(vals, value) then
			return true
		else
			table.insert(vals, value)
		end

	end

	return false

end

function TableContainsValue(tb, val)
	for index, value in ipairs(tb) do
		if value == val then
			return index, value
		end
	end
end


function PairsContainsValue(tb, val)
	for index, value in pairs(tb) do
		if value == val then
			return index, value
		end
	end
end



---Checks if a table index contains a valid nested-table. If not, create a nested-table and insert value at new key in new nested-table.
---@param tb table Parent table.
---@param tb_key string Parent table's key to contain nested table.
---@param nested_key string (Optional) Key to add value in nested table at: tb[tb_key]
---@param nested_val any (Optional) Value to add in nested table at: tb[tb_key][nested_key]
---@return table nested_table -- The nested table at: tb[tb_key]
function BuildNestedTable(tb, tb_key, nested_key, nested_val)

	-- Create a nested-table if none exists.
	if tb[tb_key] == nil then tb[tb_key] = {} end

	-- Add value to valid nested-table.
	if nested_key and nested_val then tb[tb_key][nested_key] = nested_val end

	return tb[tb_key]

end

---@param tb table Parent table
---@param keys table Numerical table of strings to build nested tables up to.
function BuildNestedTables(tb, keys)

	local focus_tb = tb

	for i = 1, #keys do
		local key = keys[i]
		local nested_tb = BuildNestedTable(focus_tb, key)
		focus_tb = nested_tb
	end

end


function GetAllElementArrangements(tb)
    local result = {}
    for k, v in ipairs(combs(#tb, #tb)) do
        local r = {}
        for index, value in ipairs(v) do
            table.insert(r, tb[value])
        end
        table.insert(result, r)
    end
    return result
end


---A table with interconnected keys (mesh topology) which can quickly find a value by any order of chain of keys.
---It is recommended to keep total key depth less than 3 for performance.
---@param keys_list table Indexed table of strings to created self references to.
function BuildSelfReferencingTable(keys_list)

	local tb = {}

	local tb_keys = GetAllElementArrangements(keys_list)

	for index, keys in ipairs(tb_keys) do
		BuildNestedTables(tb, keys)
	end

	return tb

end

function InsertIntoSelfReferencingTable(tb, tb_attributes, tb_values)

	--[[ tb_attributes

		1 = {
			1 = "tech",
			2 = "class",
			3 = "faction",
		},
		2 = {
			1 = "tech",
			2 = "faction",
			3 = "class",
		},
		3 = {
			1 = "class",
			2 = "tech",
			3 = "faction",
		},
		4 = {
			1 = "class",
			2 = "faction",
			3 = "tech",
		},
		5 = {
			1 = "faction",
			2 = "tech",
			3 = "class",
		},
		6 = {
			1 = "faction",
			2 = "class",
			3 = "tech",
		},

	]]

	local attribute_arragements = GetAllElementArrangements(GetTableKeys(tb_attributes))

	for _, attributes in pairs(attribute_arragements) do -- For each table of combo keys

		local tb_to_insert = tb
		local last_combo_key = nil

		for _, attribute_key in pairs(attributes) do -- Iterate through keys until the table to insert into is reached.
			tb_to_insert = tb_to_insert[attribute_key]
			-- tb_to_insert = tb_to_insert[tb_values[attribute_key]]
			-- print(attribute_key, tb_values[attribute_key])
		end

		-- if tb_to_insert then

		-- 	-- Create a nested-table if none exists.
		-- 	if tb_to_insert[tb_attributes[last_combo_key]] == nil then
		-- 		tb_to_insert[tb_attributes[last_combo_key]] = {}
		-- 	end

		-- 	-- Add value to valid nested-table.
		-- 	table.insert(tb_to_insert[tb_attributes[last_combo_key]], tb_values)

		-- 	-- BuildNestedTable(tb_to_insert, last_combo_key, tb_data[last_combo_key], value)

		-- else

		-- 	print("ERROR: SELF REFERENCING TABLE KEY NOT FOUND. THIS IS NOT GOOD. THIS IS, A MATTER OF FACT, REALLY BAD.")

		-- end

	end

end


function GetNestedTable(keys, base_table)
	local tb_output = base_table
	for i, key in ipairs(keys) do
	  tb_output = tb_output[key]
	end
	return tb_output
end



-- Source: https://stackoverflow.com/questions/35572435/how-do-you-do-the-fisher-yates-shuffle-in-lua
function TableShuffleInPlace(t)
    for i = #t, 2, -1 do
        local j = math.random(i)
        t[i], t[j] = t[j], t[i]
    end
end

-- Source: https://stackoverflow.com/questions/35572435/how-do-you-do-the-fisher-yates-shuffle-in-lua
function Shuffle(t)
    local s = {}
    for i = 1, #t do s[i] = t[i] end
    for i = #t, 2, -1 do
        local j = math.random(i)
        s[i], s[j] = s[j], s[i]
    end
    return s
end

---Return a table of the same values.
---@param value any
function ReturnValues(value, count, return_table)
	local t = {}
	for i = 1, count do table.insert(t, value) end
	return ternary(return_table, t, unpack(t))
end
