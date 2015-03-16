Menu = Core.class(Sprite)

function Menu:init()
	music:off()
	
	imgLogo:setPosition((screenWidth-imgLogo:getWidth())/2, 30)
	btnStart = Button.new(imgStart, imgStart)
	btnAbout = Button.new(imgAbout, imgAbout)
	btnStart:setPosition((screenWidth-imgStart:getWidth())/2, (screenHeight-imgStart:getHeight())/2)
	
	local about_dy = 0
	local about_dx = 0
	if dy > 0 then
		about_dy = dy
	end
	if dx > 0 then
		about_dx = dx
	end
		
	btnAbout:setPosition(screenWidth-40 + about_dx, screenHeight-40 + about_dy)
	
	btnStart:addEventListener("click", self.startGame, self)
	
	self:addChild(imgLogo)
	self:addChild(btnStart)
	self:addChild(btnAbout)
end

function Menu:startGame(event)
	gotoScene("puzzle", SceneManager.fade, {rows=4, cols=4})
end