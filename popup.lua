Popup = Core.class(Sprite)

function Popup:init()	
	-- draw overlay
	self.shape = Shape.new()
	self.shape:setFillStyle(Shape.SOLID, 0xffffff, 0.5)
	self.shape:beginPath()
	-- -100 instead of 0 to accomodate wider screen width in letterbox layout
	self.shape:moveTo(-100,-100)
	self.shape:lineTo(screenWidth+100, -100)
	self.shape:lineTo(screenWidth+100, screenHeight)
	self.shape:lineTo(-100, screenHeight)
	self.shape:lineTo(-100, -100)
	self.shape:endPath()
	self.shape:setPosition(0, 0)
	
	self.shape:addEventListener(Event.MOUSE_DOWN, self.disableTouch, self)
	self.shape:addEventListener(Event.MOUSE_UP, self.disableTouch, self)
	
	-- center popup
	imgPopup:setPosition((screenWidth-imgPopup:getWidth())/2, (screenHeight-imgPopup:getHeight())/2)
	imgBack2:setPosition(imgPopup:getX() + 25, imgPopup:getY()+imgPopup:getHeight() - imgBack2:getHeight()-10)
	imgBack2:addEventListener(Event.MOUSE_UP, self.toHome, self)
	
	imgPlayagain:setPosition(imgPopup:getX() + imgPopup:getWidth() - imgPlayagain:getWidth() - 25,
							 imgPopup:getY()+imgPopup:getHeight() - imgPlayagain:getHeight()-25)
	imgPlayagain:addEventListener(Event.MOUSE_UP, self.playAgain, self)

	self:addChild(self.shape)
	self:addChild(imgPopup)
	self:addChild(imgBack2)
	self:addChild(imgPlayagain)
end

function Popup:disableTouch(event)
	if self.shape:hitTestPoint(event.x, event.y) then
		event:stopPropagation()
	end
end

function Popup:toHome(event)
	if imgBack2:hitTestPoint(event.x, event.y) then
		gotoScene("menu", SceneManager.fade)
	end
end

function Popup:playAgain(event)
	if imgPlayagain:hitTestPoint(event.x, event.y) then
		gotoScene("puzzle", SceneManager.fade, {rows=4, cols=4})
	end
end