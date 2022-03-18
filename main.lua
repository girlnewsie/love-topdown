local STI = require('libraries/Simple-Tiled-Implementation/sti')
local Sound = require('sound')

anim8 = require('libraries/anim8/anim8')
require('player')
require('gui')
require('levels')
love.graphics.setDefaultFilter('nearest', 'nearest')

function love.load()
    Map = STI('maps/field_1.lua', {'box2d'})
    World = love.physics.newWorld(0,0)
    Map:box2d_init(World)
    gameVolume = 0

    Player:load()
    Sound:init('test', 'sfx/player_get_coin.ogg', 'static')
    sounds = {}
    sounds.music = love.audio.newSource('music/debt.mp3','stream')
    sounds.music:setLooping(true)
    musicSpeed = Player.moveSpeed
    Level:load()
end

function love.update(dt)
    World:update(dt)
    Player:update(dt)
    Sound:update()
    gameVolume = gameVolume + .01
    sounds.music:setVolume(.5 * gameVolume)
end

function love.draw()
    -- Map:draw(0,0,2,2)
    love.graphics.push()
    love.graphics.scale(2,2)

    Player:draw()
    Level:drawMap()
    love.graphics.pop()
    love.graphics.print(mapString, 50, 50)
    sounds.music:play()
end

function love.keypressed(key)
    local music = true
    if key == "a" then
        Sound:play('test', 'sfx', 1, 0.3, false)
    end
    
    if key == "s" then
        if music == true then
            sounds.music:stop()
            music = false
        else
            sounds.music:play()
            music = true
        end
    end
end
