Arena = Core.class(Sprite)

function Arena:init()
	self.screenWidth = application:getContentWidth()
	self.screenHeight = application:getContentHeight()
	
	self.arenaWidth = self.screenWidth * 0.9
	
	if self.screenWidth > self.screenHeight then
		self.arenaWidth = self.screenHeight * 0.9
	end
end

function Arena:getWidth()
	return self.arenaWidth
end

function Arena:getArenaX()
	if self.screenWidth > self.screenHeight then
		return (self.screenWidth - self.arenaWidth)/2
	else
		return (self.screenWidth - self.arenaWidth)/2
	end
end

function Arena:getArenaY()
	if self.screenWidth > self.screenHeight then
		return (self.screenHeight - self.arenaWidth)/2
	else
		return (self.screenWidth - self.arenaWidth)/2
	end
end