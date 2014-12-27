Arena = Core.class(Sprite)

function Arena:init()
	self.screenWidth = application:getContentWidth()
	self.screenHeight = application:getContentHeight()
	
	self.arenaWidth = self.screenWidth * 0.9
	
	if self.screenWidth > self.screenHeight then
		self.arenaWidth = self.screenHeight
	end
	
	self:addEventListener(Event.ENTER_FRAME, self.renderTiles, self)
end

function Arena:getWidth()
	return self.arenaWidth
end

function Arena:getArenaX()
	return (self.screenWidth - self.arenaWidth)/2
end

function Arena:getArenaY()
	return (self.screenWidth - self.arenaWidth)/2
end

function Arena:renderTiles(event)
	
end