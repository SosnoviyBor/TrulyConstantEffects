function TableIsEmpty(list)
    if list == nil then
        return true
    end
    return next(list) == nil
end


function TableSize(list)
    if TableIsEmpty(list) then
        return 0
    end

    local size = 0
    for _ in pairs(list) do
        size = size + 1
    end
    return size
end


function PrintTable(list)
    if not TableIsEmpty(list) then
        for k, v in pairs(list) do
            print("> key: "..tostring(k).." | value: "..tostring(v))
        end
        print("")
    else
        print("Provided "..tostring(list).." was empty")
    end
end


function CopyTable(list)
    return {table.unpack(list)}
end