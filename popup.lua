Popup = Core.class(Overlay)

function Popup:init(status)
	music:off()
	
	-- center popup
	imgPopup:setPosition((screenWidth-imgPopup:getWidth())/2, (screenHeight-imgPopup:getHeight())/2)
	imgPopup2:setPosition((screenWidth-imgPopup2:getWidth())/2, (screenHeight-imgPopup2:getHeight())/2)
	
	imgPopup:addEventListener(Event.MOUSE_UP, self.restartGame, self)
	imgPopup2:addEventListener(Event.MOUSE_UP, self.restartGame, self)

	if status == "win" then
		self:addChild(imgPopup)
		sounds:play("win")
	else
		self:addChild(imgPopup2)
		sounds:play("lose")
	end
end

function Popup:toHome(event)
	if imgBack2:hitTestPoint(event.x, event.y) then
		gotoScene("menu", SceneManager.moveFromLeft)
	end
end

function Popup:restartGame(event)
	if imgPopup:hitTestPoint(event.x, event.y) or imgPopup2:hitTestPoint(event.x, event.y) then
		gotoScene("menu", SceneManager.moveFromLeft)
	end
end