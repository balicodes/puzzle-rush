Puzzle = Core.class(Sprite)

function Puzzle:init(params)
	music:on(1)
	self.finish = false
	self.win = false
	self.pause = false
	
	local toolbar_y = 0
	if dy > 0 then
		toolbar_y = -dy
	end
	
	self.toolbar = Toolbar.new(self)
	self.toolbar:setPosition((screenWidth-self.toolbar:getWidth())/2, 10+toolbar_y)

	-- Initialize the puzzle Arena
	self.arena = Arena.new()
	self.arena:setPosition(self.arena:getArenaX(), self.arena:getArenaY())

	self.cols = params.cols
	self.rows = params.rows
	self.blockWidth = self.arena:getWidth()/self.cols;
	
	self.correctNumbers = {}
	self.numbers = {}
	for i=1, (self.cols*self.rows)-1 do
		self.correctNumbers[i] = i
		self.numbers[i] = i
	end
	self.tiles = {}

	-- add actors to the puzzle
	self:addChild(self.toolbar)
	self:addChild(self.arena)
	
	-- shuffle on first load
	self:shuffleTiles()
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function Puzzle:shuffleTiles()
	self.finish = false
	self.win = false
	
	-- clear tiles array
	self.tiles = {}
	
	-- clear arena
	for i = self.arena:getNumChildren(), 1, -1 do
		self.arena:removeChildAt(i)
	end
	
	-- shuffle number
	math.randomseed(os.time())
    local rand = math.random 
    local iterations = #self.numbers
    local j
    
    for i = iterations, 2, -1 do
        j = rand(i)
        self.numbers[i], self.numbers[j] = self.numbers[j], self.numbers[i]
    end
	
	-- Generate puzzle tiles
	local counter = 1
	for row=0, self.rows-1 do
		self.tiles[row] = {}
		
		for col=0, self.cols-1 do
			if row ~= self.rows-1 or col ~= self.cols-1 then
				local tile = Tile.new(self, row, col, self.blockWidth, self.numbers[counter])
				self.tiles[row][col] = tile
				self.arena:addChild(tile)
				counter = counter + 1
			else
				self.tiles[row][col] = nil
			end
		end
	end
	
	-- set movement flags.
	self:setMovementFlags()
end

function Puzzle:onReload(event)
		self:shuffleTiles()
end

function Puzzle:compareNumbers(newNumbers)
	-- compare length
	if #self.correctNumbers ~= #newNumbers then return false end
	
	-- compare content
	for i=1, #newNumbers do
		if newNumbers[i] ~= self.correctNumbers[i] then return false end
	end
	return true
end

function Puzzle:setMovementFlags()
	local newNumbers = {}
	local index = 1
	
	for row=0, self.rows-1 do
		for col=0, self.cols-1 do

			if self.tiles[row][col] ~= nil then
				local tile = self.tiles[row][col]
				
				newNumbers[index] = tile.number
				index = index + 1
				
				-- can move top?
				tile.canMoveUp = false
				if row-1 >= 0 then
					if self.tiles[row-1][col] == nil then
						tile.canMoveUp = true
					end
				end
				
				-- can move right?
				tile.canMoveRight = false
				if col+1 <= self.cols-1 then
					if self.tiles[row][col+1] == nil then
						tile.canMoveRight = true
					end
				end
				
				-- can move down?
				tile.canMoveDown = false
				if row+1 <= self.rows-1 then
					if self.tiles[row+1][col] == nil then
						tile.canMoveDown = true
					end
				end
				
				-- can move left?
				tile.canMoveLeft = false
				if col-1 >= 0 then
					if self.tiles[row][col-1] == nil then
						tile.canMoveLeft = true
					end
				end
			end
			
		end
	end
	
	-- check if new formation are correct
	if self:compareNumbers(newNumbers) then
		self.finish = true
		self.win = true
	end
end

function Puzzle:gameTimeout()
	self.finish = true
	self.win = false
end

function Puzzle:onEnterFrame(event)
	if self.pause then
		self:addChild(Paused.new(self))
		self.pause = false
	end
	
	if self.finish and self.win then
		self:addChild(Popup.new("win"))
		self.finish = false
		self.toolbar:stopAction()
	end
	
	if self.finish and not self.win then
		self:addChild(Popup.new("lose"))
		self.finish = false
		self.toolbar:stopAction()
	end
end