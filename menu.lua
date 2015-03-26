Menu = Core.class(Sprite)

function Menu:init()
	music:off()
	
	imgLogo:setPosition((screenWidth-imgLogo:getWidth())/2, 50)
	
	btnStart44 = Button.new(imgStart44, imgStart44, 2)
	btnStart55 = Button.new(imgStart55, imgStart55, 2)
	btnStart66 = Button.new(imgStart66, imgStart66, 2)
	
	imgMenutitle:setPosition((screenWidth-imgMenutitle:getWidth())/2, (screenHeight-imgMenutitle:getHeight())/2 - 30)
	imgDeveloper:setPosition((screenWidth-imgDeveloper:getWidth())/2, screenHeight-imgDeveloper:getHeight()+ dy -10)
	
	btnStart44:setPosition((screenWidth-imgStart44:getWidth())/2, imgMenutitle:getY() + imgMenutitle:getHeight() + 20)
	btnStart55:setPosition((screenWidth-imgStart55:getWidth())/2, btnStart44:getY() + imgStart55:getHeight() + 10)
	btnStart66:setPosition((screenWidth-imgStart66:getWidth())/2, btnStart55:getY() + imgStart66:getHeight() + 10)
	
	btnStart44:addEventListener("click", self.startGame44, self)
	btnStart55:addEventListener("click", self.startGame55, self)
	btnStart66:addEventListener("click", self.startGame66, self)
	
	self:addChild(imgLogo)
	self:addChild(imgMenutitle)
	self:addChild(imgDeveloper)
	self:addChild(btnStart44)
	self:addChild(btnStart55)
	self:addChild(btnStart66)
end

function Menu:startGame44(event)
	gotoScene("puzzle", SceneManager.moveFromRight, {rows=4, cols=4, time=60})
end

function Menu:startGame55(event)
	gotoScene("puzzle", SceneManager.moveFromRight, {rows=5, cols=5, time=60})
end

function Menu:startGame66(event)
	gotoScene("puzzle", SceneManager.moveFromRight, {rows=6, cols=6, time=60})
end