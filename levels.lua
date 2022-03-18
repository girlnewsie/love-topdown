Level = {}

function Level:load()
    self.levels = {
    [[
    WxWW
    WxxW
    WWWW
    ]],
    [[
    WxWW
    WxxW
    WWWW
    ]],
    }
    Level.current = 1
    self:createMap(self.current)
end


function Level:createMap(current)
    map = {
        data = {},
    }
    local mapString = self.levels[current]
    local mapWidth = mapString:find("/n") + 1
    local mapHeight = 0
    local x,y = 1,1
    for t in mapString:gmatch('.') do
        if t == "W" then
            table.insert( map.data, true)
        elseif t == "x" then
            table.insert( map.data, false)
        elseif t == "/n" then
            mapHeight = mapHeight + 1
            x = 0
            y = y + 1
        end
        x = x + 1
    end

    map.width = mapWidth
    map.height = mapHeight

end

function Level:drawMap()
    love.graphics.print('Level '..Level.current, 20, 20)
    for y=1,map.height do
        for x=1,map.width do
          local tile = map.data[(y-1)*map.width+x]
          if tile then
            love.graphics.setColor(1,1,1,1)
            if tile == "goal" then
              love.graphics.setColor(1,0,0,1)
            end
            love.graphics.rectangle('fill', x * 20, y * 20, 16, 16)
            love.graphics.print('TILE!', x * 20, x * 20)
          else
            love.graphics.setColor(1,0,0,1)
            love.graphics.rectangle('fill', x * 20, y * 20, 16, 16)
          end
        end
    end
end