Tile  = Core.class(Sprite)

function Tile:init(game, row, col, width)
	self.game = game
	self.width = width
	self.height = width
	self.row = row
	self.col = col
	self.canMoveUp = false
	self.canMoveRight = false
	self.canMoveDown = false
	self.canMoveLeft = false
	self.isFocus = false
	
	-- add tile-bg
	local background = Shape.new()
	background:setLineStyle(1, 0xffffff)
	background:setFillStyle(Shape.SOLID, 0xff0000, 0.5)
	background:beginPath()
	background:moveTo(0, 0)
	background:lineTo(self.width, 0)
	background:lineTo(self.width, self.width)
	background:lineTo(0, self.width)
	background:closePath()
	background:endPath()
	background:setX(0)
	background:setY(0)
	self:addChild(background)
	
	-- set the first position once initialized.
	local initialX = self.col * width
	local initialY = self.row * width
	self:setPosition(initialX, initialY)
	
	-- add Number
	self.number = TextField.new(nil, counter)
	self.number:setPosition(10 , 20)
	self:addChild(self.number)
	
	self.U = TextField.new(nil, "")
	self.U:setPosition(10 , 30)
	self:addChild(self.U)
	
	self.R = TextField.new(nil, "")
	self.R:setPosition(10 , 40)
	self:addChild(self.R)
	
	self.B = TextField.new(nil, "")
	self.B:setPosition(10 , 50)
	self:addChild(self.B)
	
	self.L = TextField.new(nil, "")
	self.L:setPosition(10 , 60)
	self:addChild(self.L)
	
	-- Tile event listeners
	self:addEventListener(Event.MOUSE_DOWN, self.onTouchDown, self)
	self:addEventListener(Event.MOUSE_MOVE, self.onDrag, self)
	self:addEventListener(Event.MOUSE_UP, self.onTouchUp, self)
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function Tile:getWidth()
	return self.width
end

function Tile:getHeight()
	return self.height
end

function Tile:onTouchDown(event)
	if self:hitTestPoint(event.x, event.y) then
		self.isFocus = true
		self.x0 = event.x
		self.y0 = event.y
		event:stopPropagation()
	end
end

function Tile:onDrag(event)
	if self.isFocus then
		local dx = event.x - self.x0
		local dy = event.y - self.y0
		
		if self.canMoveUp then
			local newY = self:getY() + dy
			local newRow = self.row-1
			if newY <= self.row*self.width and newY >= newRow * self.width then
				self:setX(self:getX())
				self:setY(newY)
			end
		end
		
		if self.canMoveRight then
			local newX = self:getX() + dx
			local newCol = self.col+1
			if newX >= self.col*self.width and newX <= newCol * self.width then 
				self:setX(newX)
				self:setY(self:getY())
			end
		end
		
		if self.canMoveDown then
			local newY = self:getY() + dy
			local newRow = self.row+1
			if newY >= self.row*self.width and newY <= newRow * self.width then 
				self:setX(self:getX())
				self:setY(newY)
			end
		end
		
		if self.canMoveLeft then
			local newX = self:getX() + dx
			local newCol = self.col-1
			if newX <= self.col*self.width and newX >= newCol * self.width then 
				self:setX(newX)
				self:setY(self:getY())
			end
		end
		
		self.x0 = event.x
		self.y0 = event.y
		event:stopPropagation()
	end
end

function Tile:onTouchUp(event)
	if self.isFocus then
		self.isFocus = false
		
		if self.canMoveUp then
			if self:getY() < self.row*self.height then
				local oldRow = self.row
				local newRow = self.row - 1
				self.row = newRow
				self.game.tiles[newRow][self.col] = self
				self.game.tiles[oldRow][self.col] = nil
				
				self:setY(newRow*self.height)
				self.game:setMovementFlags()
			end
		end
		
		if self.canMoveRight then
			if self:getX() > self.col*self.width then
				local oldCol = self.col
				local newCol = self.col + 1
				self.col = newCol
				self.game.tiles[self.row][newCol] = self
				self.game.tiles[self.row][oldCol] = nil
				
				self:setX(newCol*self.width)
				self.game:setMovementFlags()
			end
		end
		
		if self.canMoveDown then
			if self:getY() > self.row*self.height then
				local oldRow = self.row
				local newRow = self.row + 1
				self.row = newRow
				self.game.tiles[newRow][self.col] = self
				self.game.tiles[oldRow][self.col] = nil
				
				self:setY(newRow*self.height)
				self.game:setMovementFlags()
			end
		end
		
		if self.canMoveLeft then
			if self:getX() < self.col*self.width then
				local oldCol = self.col
				local newCol = self.col - 1
				self.col = newCol
				self.game.tiles[self.row][newCol] = self
				self.game.tiles[self.row][oldCol] = nil
				
				self:setX(newCol*self.width)
				self.game:setMovementFlags()
			end
		end
		
		event:stopPropagation()
	end
end

function Tile:onEnterFrame(event)
	self.U:setText("U: "..tostring(self.canMoveUp))
	self.R:setText("R: "..tostring(self.canMoveRight))
	self.B:setText("B: "..tostring(self.canMoveDown))
	self.L:setText("L: "..tostring(self.canMoveLeft))
end