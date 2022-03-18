Player = {}

function Player:load()
    -- starting position
    self.x = 50
    self.y = 50
	self.direction = "down"

	-- sprite
	self.width = 16
	self.height = 16
	self.sprite = love.graphics.newImage('assets/player.png')
	self.spriteSheet = love.graphics.newImage('assets/player.png')
	self.grid = anim8.newGrid(self.width,self.height, self.spriteSheet:getWidth(), self.spriteSheet:getHeight())
	-- sprite animations
	self.animations = {}
	self.animations.down = anim8.newAnimation(self.grid('1-4',1), 0.2 )
	self.animations.right = anim8.newAnimation(self.grid('1-4',2), 0.2 )
	self.animations.left = anim8.newAnimation(self.grid('1-4',3), 0.2 )
	self.animations.up = anim8.newAnimation(self.grid('1-4',4), 0.2 )
	self.anim = self.animations.right

	-- sprite physics
	self.physics = {}
    self.physics.body = love.physics.newBody(World,self.x, self.y + 4, "dynamic")
    self.physics.body:setFixedRotation(true)
    self.physics.shape = love.physics.newRectangleShape(self.width,self.height)
    self.physics.fixture = love.physics.newFixture(self.physics.body, self.physics.shape)


    -- stats
    self.health = {
        current = 3,
        max = 3,
    }
	self.speed = 1
	self.moveSpeed = self.speed
	self.runSpeed = 2
	self.power = 1

	-- status
	self.isMoving = false


end

function Player:update(dt)
	self.isMoving = false
	self.isRunning = false
	if love.keyboard.isDown('left') then
		self.direction = "left"
		self:movement("left")
	end
	if love.keyboard.isDown('right') then
		self.direction = "right"
		self:movement("right")
	end
	if love.keyboard.isDown('up') then
		self.direction = "up"
		self:movement("up")
	end
	if love.keyboard.isDown('down') then
		self.direction = "down"
		self:movement("down")
	end
	if self.isMoving == false then
		self.anim:gotoFrame(1)
	end

	self.anim:update(dt)
end

function Player:draw()
	local scaleX = 2
	self.anim:draw(self.spriteSheet, self.x, self.y, nil, scaleX, scaleX)
    love.graphics.setColor(1,1,1)
end

function Player:movement(direction)
	self.isMoving = true
	if love.keyboard.isDown('lshift', 'rshift') then
		self:run()
	else
		self.moveSpeed = self.speed
	end
	if  direction == "left" then
		self.anim = self.animations.left
		self.x = self.x - self.moveSpeed
	elseif direction == "right" then
		self.anim = self.animations.right
		self.x = self.x + self.moveSpeed
	elseif direction == "up" then
		self.anim = self.animations.up
		self.y = self.y - self.moveSpeed
	elseif direction == "down" then
		self.anim = self.animations.down
		self.y = self.y + self.moveSpeed
	else
		self.isMoving = false
	end
end

function Player:run()
	self.isRunning = true
	self.moveSpeed = self.speed * self.runSpeed
end