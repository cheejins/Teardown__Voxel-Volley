--[[FORMATTING]]
do
    ---(String Format Number) return a rounded number as a string.
    function sfn(numberToFormat, dec)
        if numberToFormat then
            return string.format("%.".. (tostring(dec or 2)) .."f", numberToFormat)
        else
            return numberToFormat
        end
    end

    ---(String Format Time) Returns the time rounded to decimal as a string.
    function sfnTime(dec) return sfn(' '..GetTime(), dec or 2) end

    ---(String Format Commas) Returns a number formatted with commas as a string.
    function sfnCommas(dec)
        return tostring(math.floor(dec)):reverse():gsub("(%d%d%d)","%1,"):gsub(",(%-?)$","%1"):reverse()
        -- https://stackoverflow.com/questions/10989788/format-integer-in-lua
    end

    ---(String Format Int) Returns a number formatted as an integer.
    function sfnInt(n)
        local s = tostring(n)
        local int = ''
        for i = 1, string.len(s) do
            local c = string.sub(s, i, i)
            if c == '.' then
                return int
            else
                int = int .. c
            end
        end
    end

    function sfnPadZeroes(n, pad) return string.format('%0' .. tostring(pad or 2) .. 'd', n) end

    function ternary ( cond , T , F ) if cond then return T else return F end end

    ---A helper function to print a table's contents.
    ---@param tbl table @The table to print.
    ---@param depth number @The depth of sub-tables to traverse through and print.
    ---@param n number @Do NOT manually set this. This controls formatting through recursion.
    ---@param ignore_types table table of data types to ignore.
    function PrintTable(tbl, depth, n, ignore_types)
        n = n or 0;
        depth = depth or 10;

        if (depth == 0) then
            print(string.rep(' ', n) .. "...");
            return;
        end

        if (n == 0) then
            print(" ");
        end

        for key, value in pairs(tbl) do
            if (key and type(key) == "number" or type(key) == "string") then
                key = string.format("%s", key);

                if (type(value) == "table") then
                    if (next(value)) then
                        print(string.rep(' ', n) .. key .. " = {");
                        PrintTable(value, depth - 1, n + 4);
                        print(string.rep(' ', n) .. "},");
                    else
                        print(string.rep(' ', n) .. key .. " = {},");
                    end
                else
                    if (type(value) == "string") then
                        value = string.format("\"%s\"", value);
                    else
                        value = tostring(value);
                    end

                    print(string.rep(' ', n) .. key .. " = " .. value .. ",");
                end
            end
        end

        if (n == 0) then
            print(" ");
        end
    end

end


function string_append(s, str, separator)
    return s .. (separator or " ") .. str
end

function string_enclose(s, str_left, str_right)
    return str_left .. s .. (str_right or str_left)
end


function IsStringInteger(data)
    for i = 1, #data do

        byte = string.byte(string.sub(data, i, i))

        if not (byte >= 48 and byte <= 57) then
            return false
        end

    end
    return true
end


-- Source: https://rosettacode.org/
function map(f, a, ...) if a then return f(a), map(f, ...) end end

-- Source: https://rosettacode.org/
function incr(k) return function(a) return k > a and a or a+1 end end

-- Source: https://rosettacode.org/
function combs(m, n)
  if m * n == 0 then return {{}} end
  local ret, old = {}, combs(m-1, n-1)
  for i = 1, n do
    for k, v in ipairs(old) do ret[#ret+1] = {i, map(incr(i), unpack(v))} end
  end
  return ret
end

-- Run a global function once and never again. Useful for init stuff.
function RunOnce(func)

    __RUN_ONCE__ = __RUN_ONCE__ or {}

    if not __RUN_ONCE__[func] then
        _G[func]()
        __RUN_ONCE__[func] = true
    end

end


function TableContainsValue(tb, val)
	for index, value in ipairs(tb) do
		if value == val then
			return index, value
		end
	end
end

---comment
---@param tb table table to check
---@param value any Check if value is in tb.
function TableInsertUnique(tb, value)
    if not TableContainsValue(tb, value) then
        table.insert(tb, value)
    end
end


function string_pad(str1, pad)
    local format = "%-" .. (pad or 20) .. "s"
    return string.format(format, str1)
end


-- Add random value to number within range of number +/- width.
---@param number number
---@param width number Example, RandomSpread(10, 5) maximum range = 5 to 15.
---@return number number number with spread applied.
---@return number spread spread value independant of number.
function RandomSpread(number, width)
    local spread = (((math.random()-0.5)*2) * width)
    return number + spread, spread
end


-- Add random value to number within range of number.
---@param number number
---@param spread_percentage number 0.0 to 0.1
---@return number number number with spread applied.
---@return number spread spread value independant of number.
function RandomSpreadPercent(number, spread_percentage)
    local spread = ((math.random()-0.5)*2) * (number*(spread_percentage or 1))
    return number + spread, spread
end


function RandomSpreadPercent25(number)
    return RandomSpreadPercent(number, 0.25)
end

function RandomSpreadPercent50(number)
    return RandomSpreadPercent(number, 0.5)
end

function RandomSpreadPercent75(number)
    return RandomSpreadPercent(number, 0.75)
end

--[[
-- Add random value to number within range of number.
---@param number number
---@param spread_percentage number 0.0 to 0.1
---@return number number number with spread applied.
function RandomSpreadPercent(number, spread_percentage, iterations)
    local n = number
    for i = 1, iterations or 1 do
        n = ((math.random()-0.5)*2) * (n*(spread_percentage or 1))
    end
    return n
end


function RandomSpreadPercent25(number, iterations)
    return RandomSpreadPercent(number, 0.25, iterations)
end

function RandomSpreadPercent50(number, iterations)
    return RandomSpreadPercent(number, 0.5, iterations)
end

function RandomSpreadPercent75(number, iterations)
    return RandomSpreadPercent(number, 0.75, iterations)
end
]]


-- Source: Open Ai
function string_contains(str, substring)
    local pattern = substring:gsub("[%^%$%(%)%%%.%[%]%*%+%-%?]", "%%%1")
    local _, endIndex = string.find(str, pattern)
    return endIndex ~= nil
end
