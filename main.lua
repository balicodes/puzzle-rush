local sceneManager = SceneManager.new({
	["puzzle"] = Puzzle
})

function gotoScene(name, transition, data)
	if not data then
		data = {}
	end
	sceneManager:changeScene(name, 1, transition, easing.linier, {userData=data})
end

gotoScene("puzzle", SceneManager.fade, {rows=4, cols=4})

stage:addChild(sceneManager)