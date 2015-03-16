application:setBackgroundColor(0xffffff)

screenWidth = application:getContentWidth()
screenHeight = application:getContentHeight()

-- Loads graphics
imgLogo = Bitmap.new(Texture.new("graphics/logo.png", true))
imgStart = Bitmap.new(Texture.new("graphics/start.png", true))
imgAbout = Bitmap.new(Texture.new("graphics/about.png", true))
imgBack = Bitmap.new(Texture.new("graphics/back.png", true))
imgPopup = Bitmap.new(Texture.new("graphics/popup.png", true))
imgBack2 = Bitmap.new(Texture.new("graphics/back2.png", true))
imgPlayagain = Bitmap.new(Texture.new("graphics/playagain.png", true))

-- Loads sounds
music = Music.new("sounds/music.mp3")

sounds = Sounds.new()
sounds:add("swipe", "sounds/swipe.wav")
sounds:on()

-- absolute x and y position
dx = application:getLogicalTranslateX() / application:getLogicalScaleX()
dy = application:getLogicalTranslateY() / application:getLogicalScaleY()
	
-- Register scenes
sceneManager = SceneManager.new({
	["menu"] = Menu,
	["puzzle"] = Puzzle
})

function gotoScene(name, transition, data)
	if not data then
		data = {}
	end
	sceneManager:changeScene(name, 0.2, transition, easing.linier, {userData=data})
end

-- set first scenne to main menu
gotoScene("menu", SceneManager.fade)

stage:addChild(sceneManager)
stage:addEventListener(Event.KEY_DOWN, function()
	if event.keyCode == KeyCode.BACK then
		application:exit()
	end
end)