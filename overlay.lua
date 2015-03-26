Overlay = Core.class(Sprite)

function Overlay:init()	
	self.bgColor = 0x000000
	self.opacity = 0.8
	
	-- draw overlay
	self.shape = Shape.new()
	self.shape:setFillStyle(Shape.SOLID, self.bgColor, self.opacity)
	self.shape:beginPath()
	
	-- -100 instead of 0 to accomodate wider screen width in letterbox layout
	self.shape:moveTo(-5,-100)
	self.shape:lineTo(screenWidth+100, -100)
	self.shape:lineTo(screenWidth+100, screenHeight+100)
	self.shape:lineTo(-100, screenHeight+100)
	self.shape:lineTo(-100, -100)
	self.shape:endPath()
	self.shape:setPosition(0, 0)
	
	self.shape:addEventListener(Event.MOUSE_DOWN, self.disableTouch, self)
	self.shape:addEventListener(Event.MOUSE_UP, self.disableTouch, self)
	
	self:addChild(self.shape)
end

function Overlay:disableTouch(event)
	if self.shape:hitTestPoint(event.x, event.y) then
		event:stopPropagation()
	end
end