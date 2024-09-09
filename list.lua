---@class List
local List = {}

---@param item any
function List:Push(item) end

---@return any
function List:Pop() end

---@return integer
---@diagnostic disable-next-line: missing-return
function List:Length() end

---@param ... any
---@return List
function List.New(...)
    local arr = {}
    local len = 0
    if ... ~= nil then
        arr = ...
        len = #...
    end

    ---@param t table
    ---@param identLevel integer?
    ---@return string
    local function formatTable(t, identLevel)
        ---@param str string
        ---@param amount integer
        ---@return unknown
        local function repStr(str, amount)
            if amount < 1 then
                return ""
            elseif amount == 1 then
                return str
            end

            local out = ""
            for _ = 1, amount do
                out = out .. str
            end
            return out
        end

        if identLevel == nil then
            identLevel = 0
        end

        if len == 0 then
            return "{}"
        end

        local str = ""
        if identLevel <= 1 then
            str = "{\n"
        end

        for i = 1, #t do
            if type(t[i]) == "table" then
                str = str .. repStr(' ', identLevel) .. formatTable(t[i], identLevel + 1) .. "\n"
            else
                str = str .. repStr(' ', identLevel) .. tostring(i) .. ": " .. tostring(t[i]) .. "\n"
            end
        end

        return str .. "}"
    end

    ---@return string
    function List:__tostring()
        if len == 0 then
            return "{}"
        end
        return formatTable(arr, 1)
    end

    ---@param i integer
    ---@return any | nil
    function List:__index(i)
        if i < len then
            return nil
        end
        return arr[i]
    end

    ---@return integer
    function List:__len()
        return len
    end

    local ls = setmetatable({}, List)

    ---@param item any
    function ls:Push(item)
        len = len + 1
        arr[len] = item
    end

    ---@return any
    function ls:Pop()
        local _item = arr[len]
        arr[len] = nil
        len = len - 1
        return _item
    end

    ---@return integer
    function ls:Length()
        return len
    end

    return ls
end

return List
