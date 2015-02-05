local pg = {}

local recursive = function (dir,tab)
    local items = love.filesystem.getDirectoryItems(dir)
    for i = 1, #items do
        if love.filesystem.isFile(dir..items[i]) then
            local name = items[i]:match'(%a+)%.lua$'
            if name then
                tab[name] = require (dir:gsub("[\\/]","%.")..name)
            end
        else --We assume is a directory, you could check though
            tab[items[i]]={}
            recursive(dir..items[i].."/",tab[items[i]])
        end
    end
end

local path = ... .. "."
recursive(path:gsub("%.","[\\/]"),pg)

return pg