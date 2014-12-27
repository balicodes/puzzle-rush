Puzzle = Core.class()

function Puzzle:init(rows, cols)
	-- Initialize the puzzle Arena
	local arena = Arena.new()
	arena:setPosition(arena:getArenaX(), arena:getArenaY())

	self.cols = cols
	self.rows = rows
	local blockWidth = arena:getWidth()/self.cols;
	
	-- A tiles array to store all tiles instance
	self.tiles = {}

	-- Generate puzzle tiles
	counter = 0
	for row=0, self.rows-1 do
		self.tiles[row] = {}
		
		for col=0, cols-1 do
			if row ~= self.rows-1 or col ~= cols-1 then
				local tile = Tile.new(self, row, col, blockWidth)
				self.tiles[row][col] = tile
				arena:addChild(tile)
				counter = counter + 1
			else
				self.tiles[row][col] = nil
			end
		end
	end
	
	-- set movement flags.
	self:setMovementFlags()
	
	-- add puzzle arena to stage.
	stage:addChild(arena)
end

function Puzzle:setMovementFlags()
	for row=0, self.rows-1 do
		for col=0, self.cols-1 do
			if self.tiles[row][col] ~= nil then
				local tile = self.tiles[row][col]

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
end

-- Start Game
Puzzle.new(4, 4)