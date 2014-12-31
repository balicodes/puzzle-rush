Menu = Core.class(Sprite)

function Menu:init()
	imgLogo:setPosition((screenWidth-imgLogo:getWidth())/2, 30)
	btnStart = Button.new(imgStart0, imgStart1)
	btnAbout = Button.new(imgAbout0, imgAbout1)
	btnStart:setPosition((screenWidth-imgStart0:getWidth())/2, (screenHeight-imgStart0:getHeight())/2)
	btnAbout:setPosition((screenWidth-imgAbout0:getWidth())/2, (screenHeight-imgStart0:getHeight())-10)
	
	btnStart:addEventListener("click", self.startGame, self)
	
	self:addChild(imgBackground)
	self:addChild(imgLogo)
	self:addChild(btnStart)
	self:addChild(btnAbout)
end

function Menu:startGame(event)
	gotoScene("puzzle", SceneManager.fade, {rows=4, cols=4})
end