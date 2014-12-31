screenWidth = application:getContentWidth()
screenHeight = application:getContentHeight()

-- Loads all graphics
imgBackground = Bitmap.new(Texture.new("graphics/home-bg.png"))
imgLogo = Bitmap.new(Texture.new("graphics/logo.png"))
imgStart0 = Bitmap.new(Texture.new("graphics/start-0.png"))
imgStart1 = Bitmap.new(Texture.new("graphics/start-1.png"))
imgAbout0 = Bitmap.new(Texture.new("graphics/about-0.png"))
imgAbout1 = Bitmap.new(Texture.new("graphics/about-1.png"))

-- Register scenes
local sceneManager = SceneManager.new({
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