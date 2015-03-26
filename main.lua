application:setBackgroundColor(0x2b0000)

screenWidth = application:getContentWidth()
screenHeight = application:getContentHeight()

-- Loads graphics
imgBg = Bitmap.new(Texture.new("graphics/bg.png", true))
imgLogo = Bitmap.new(Texture.new("graphics/logo.png", true))
imgDeveloper = Bitmap.new(Texture.new("graphics/developer.png", true))
imgMenutitle = Bitmap.new(Texture.new("graphics/menutitle.png", true))
imgStart44 = Bitmap.new(Texture.new("graphics/start44.png", true))
imgStart55 = Bitmap.new(Texture.new("graphics/start55.png", true))
imgStart66 = Bitmap.new(Texture.new("graphics/start66.png", true))
imgPopup = Bitmap.new(Texture.new("graphics/popup.png", true))
imgPopup2 = Bitmap.new(Texture.new("graphics/popup2.png", true))

imgToolbg = Bitmap.new(Texture.new("graphics/toolbar.png", true))
imgReload = Bitmap.new(Texture.new("graphics/reload.png", true))
imgPlay = Bitmap.new(Texture.new("graphics/play.png", true))
imgPause = Bitmap.new(Texture.new("graphics/pause.png", true))
imgResume = Bitmap.new(Texture.new("graphics/resume.png", true))
imgBackmenu = Bitmap.new(Texture.new("graphics/backmenu.png", true))

-- Loads sounds
music = Music.new("sounds/music.mp3")

sounds = Sounds.new()
sounds:add("tick", "sounds/tick.wav")
sounds:add("win", "sounds/win.wav")
sounds:add("lose", "sounds/lose.wav")
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

-- add background
imgBg:setPosition((screenWidth-imgBg:getWidth())/2, (screenHeight-imgBg:getHeight())/2)
stage:addChild(imgBg)

stage:addChild(sceneManager)
stage:addEventListener(Event.KEY_DOWN, function()
	if event.keyCode == KeyCode.BACK then
		application:exit()
	end
end)