Toolbar  = Core.class(Sprite)

function Toolbar:init(game)
	self.game = game
	
	self.btnReload = Button.new(imgReload, imgReload, 2)
	self.btnReload:setPosition(self:getWidth()-imgReload:getWidth()-12, self:getHeight()-imgReload:getHeight()-12)
	self.btnReload:addEventListener("click", self.reloadGame, self)
	
	self.btnPause = Button.new(imgPause, imgPause, 2)
	self.btnPause:setPosition(self.btnReload:getX()-50, self:getHeight()-imgPause:getHeight()-16)
	self.btnPause:addEventListener("click", self.toggleGame, self)
	
	self.btnPlay = Button.new(imgPlay, imgPlay, 2)
	self.btnPlay:setPosition(self.btnPause:getX(), self.btnPause:getY())
	self.btnPlay:addEventListener("click", self.toggleGame, self)
	
	local font = TTFont.new("fonts/KatahdinRound.otf", 20, true)
	
	local TxtTime = TextField.new(font, "")
	TxtTime:setPosition(10, self:getHeight()-TxtTime:getHeight()-22)
	TxtTime:setTextColor(0xffffff)
	
	self.timer = Stopwatch.new({
		label = TxtTime,
		format = "{m}:{s}",
		timeout = "00:05", -- stop game after 1 hour.
		onTimeout = function(t)
			self.game:gameTimeout(t)
		end
	})
	self.timer:start()
	
	self:addChild(imgToolbg)
	self:addChild(self.btnReload)
	self:addChild(self.btnPause)
	self:addChild(self.timer)
end

function Toolbar:getWidth()
	return imgToolbg:getWidth()
end

function Toolbar:getHeight()
	return imgToolbg:getHeight()
end

function Toolbar:reloadGame(event)
	self.game:onReload()
	self.timer:reset()
	self.timer:start()
end

function Toolbar:stopAction(event)
	self.timer:stop()
end

function Toolbar:toggleGame(event)
	if self.timer:isRunning() then
		self.timer:stop()
		self:removeChild(self.btnPause)
		self:addChild(self.btnPlay)
		self.game.pause = true
	else
		self.timer:start()
		self:removeChild(self.btnPlay)
		self:addChild(self.btnPause)
		self.game.pause = false
	end
end