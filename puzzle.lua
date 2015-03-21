Puzzle = Core.class(Sprite)

function Puzzle:init(params)
	music:on(1)
	self.finish = false
	
	local toolbar_y = 0
	if dy > 0 then
		toolbar_y = -dy
	end
	
	local font = TTFont.new("fonts/KatahdinRound.otf", 40, true)
	
	local timeout = TextField.new(font, "Timeout!")
	timeout:setPosition(20, 45+toolbar_y)
	timeout:setTextColor(0xffffff)
	
	local minutes = TextField.new(font, "{m}")
	minutes:setPosition(20, 45+toolbar_y)
	minutes:setTextColor(0xffffff)
	
	local seconds = TextField.new(font, ": {s}")
	seconds:setPosition(55, 45+toolbar_y)
	seconds:setTextColor(0xffffff)
	
	self.cd = nil
	self.countdown_config  = {
		--time to specific timestamp
		--time = 1639324800
		
		--or provide time left
		year = 0,
		month = 0,
		week = 0,
		day = 0,
		hour = 0,
		min = 0,
		sec = params.time,
		
		--textfields where to output countdown
		label_sec = seconds,
		label_min = minutes,
		--label_hour = hours,
		--label_day = days,
		--label_week = weeks,
		--label_month = months,
		--label_year = years,
		
		--TextField to show when countdown ended
		label_end = timeout,
		--hide ended units
		hide_zeros = false,
		--use leading zeros for hours, minutes and seconds
		leading_zeros = true,
		--callback function on countdown end
		onend = function() if not finish then self:addChild(Popup.new("lose"))end end,
		--callback function on each coutndown step
		--provides seconds left till end of countdown
		onstep = function(seconds) --sounds:play("tick") 
		end
	}

	self.btnReload = Button.new(imgReload, imgReload, 2)
	self.btnReload:setPosition(dx + screenWidth - self.btnReload:getWidth() - 15, -dy + 10)
	self.btnReload:addEventListener("click", self.onReload, self)

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
	--self:addChild(toolbar)
	self:addChild(self.btnReload)
	self:addChild(self.arena)
	self:createTimer()
	
	-- shuffle on first load
	self:shuffleTiles()
	
	self:addEventListener(Event.ENTER_FRAME, self.onEnterFrame, self)
end

function Puzzle:shuffleTiles()
	self.finish = false
	
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

function Puzzle:createTimer()
	if self.cd == nil then
		self.cd = Countdown.new(self.countdown_config)
	else
		self.cd:stop()
		self:removeChild(self.cd)
		self.cd = Countdown.new(self.countdown_config)
	end
	self:addChild(self.cd)
end

function Puzzle:onReload(event)
		self:shuffleTiles()
		self:createTimer()
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
	end
end

function Puzzle:onEnterFrame(event)
	if self.finish then
		self:addChild(Popup.new("win"))
		self.finish = false
	end
end