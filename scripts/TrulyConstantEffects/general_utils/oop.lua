---Inheritance wrapper
---@param parent table
---@return table
function Extend(parent)
    local child = {}
    setmetatable(child,{__index = parent})
    return child
end