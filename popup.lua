Popup = Core.class(Sprite)

function Popup:init(status)	
	music:off()
	
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
	imgPopup2:setPosition((screenWidth-imgPopup2:getWidth())/2, (screenHeight-imgPopup2:getHeight())/2)
	
	imgPopup:addEventListener(Event.MOUSE_UP, self.restartGame, self)
	imgPopup2:addEventListener(Event.MOUSE_UP, self.restartGame, self)

	self:addChild(self.shape)
	if status == "win" then
		self:addChild(imgPopup)
		sounds:play("win")
	else
		self:addChild(imgPopup2)
		sounds:play("lose")
	end
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

function Popup:restartGame(event)
	if imgPopup:hitTestPoint(event.x, event.y) or imgPopup2:hitTestPoint(event.x, event.y) then
		gotoScene("menu", SceneManager.flip)
	end
end