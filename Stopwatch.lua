Stopwatch = Core.class(Sprite)

function Stopwatch:init(config)
	self.running = false
	self.timer = Timer.new(1000)
	self.timer:addEventListener(Event.TIMER, self.update, self)
	self.seconds = 0
	self.minutes = 0
	self.hours = 0
	
	self.conf = {
		label = nil,
		format = "{h}:{m}:{s}",
		timeout = nil,
		onTimeout = nil
	}
	
	--overrides default conf with provided config.
	if config then
		for key, value in pairs(config) do
			self.conf[key] = value
		end
	end
	
	self:addChild(self.conf.label)
end

function Stopwatch:isRunning()
	return self.running
end

function Stopwatch:start()
	if not self.running then
		self.running = true
		self.timer:start()
	end
end

function Stopwatch:reset()
	if self.running then
		self.running = false
		self.seconds = 0
		self.minutes = 0
		self.hours = 0
		self.timer:reset()
	end
end

function Stopwatch:stop()
	if self.running then
		self.running = false
		self.timer:stop()
	end
end

function Stopwatch:update(event)
	self.seconds = self.seconds + 1
	
	if self.seconds == 60 then
		self.seconds = 0
		self.minutes = self.minutes + 1
	end
	
	if self.minutes == 60 then
		self.minutes = 0
		self.hours = self.hours + 1
	end
	
	-- add zero leading if needed.
	local s
	local m
	local h
	
	if self.seconds < 10 then
		s = "0"..self.seconds
	else
		s = self.seconds
	end
	
	if self.minutes < 10 then
		m = "0"..self.minutes
	else
		m = self.minutes
	end
	
	if self.hours < 10 then
		h = "0"..self.hours
	else
		h = self.hours
	end
	
	local txt = self.conf.format:gsub("{h}", h)
	txt = txt:gsub("{m}", m)
	txt = txt:gsub("{s}", s)
	
	self.conf.label:setText(txt)
	
	-- check for timeout
	if self.conf.timeout and self.conf.onTimeout then
		if txt == self.conf.timeout then
			self.conf.onTimeout(txt)
		end
	end
end