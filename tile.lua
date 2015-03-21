Tile  = Core.class(Sprite)

function Tile:init(game, row, col, width, number)
	self.number = number
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
	self.sound = nil
	
	-- add tile-bg
	local background = Bitmap.new(Texture.new("graphics/tile.png", true))
	background:setScale(self.width/150, self.width/150)
	background:setPosition(0, 0)
	
	local font_size
	local font_pos_offset = 6 --to adjust number position
	if self.game.rows == 4 then
		font_size = 45
		font_pos_offset = 5
	elseif self.game.rows == 5 then
		font_size = 30
	else --6x6
		font_size = 25
	end

	local font = TTFont.new("fonts/KatahdinRound.otf", font_size, true)
	local num = TextField.new(font, number)
	num:setPosition((self.width-num:getWidth())/2, self.width-num:getHeight()/2-font_pos_offset)
	num:setTextColor(0xffffff)
	
	self:addChild(background)
	self:addChild(num)
	
	-- set the first position once initialized.
	local initialX = self.col * width
	local initialY = self.row * width
	self:setPosition(initialX, initialY)
	
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
	if self:hitTestPoint(event.x, event.y) then

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
		end
	else
		self:updatePosition()
	end
end

function Tile:updatePosition()
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
	end
end

function Tile:onTouchUp(event)
	if self:hitTestPoint(event.x, event.y) then
		self:updatePosition()
		event:stopPropagation()
	end
end

function Tile:onEnterFrame(event)
end