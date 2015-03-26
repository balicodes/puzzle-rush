Paused = Core.class(Overlay)

function Paused:init(game)
	music:off()
	self.game = game
	
	local totalMenuHeight = imgResume:getHeight() * 2 + 10 -- 2 buttons with 10px gap
	local menuY = (screenHeight-totalMenuHeight) / 2
	local menuX = (screenWidth-imgResume:getWidth()) / 2
	
	self.btnResume = Button.new(imgResume, imgResume, 2)
	self.btnResume:setPosition(menuX, menuY)
	self.btnResume:addEventListener("click", self.resumeGame, self)
	
	self.btnBackmenu = Button.new(imgBackmenu, imgBackmenu, 2)
	self.btnBackmenu:setPosition(menuX, self.btnResume:getY() + self.btnResume:getHeight()+ 10)
	self.btnBackmenu:addEventListener("click", self.backToMenu, self)
	
	self:addChild(self.btnResume)
	self:addChild(self.btnBackmenu)
end

function Paused:backToMenu(event)
	gotoScene("menu", SceneManager.moveFromLeft)
end

function Paused:resumeGame(event)
	self.game:removeChild(self)
	self.game.toolbar:toggleGame()
end