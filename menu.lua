------------------------------------------------------------------------------------------------------------------------------------------------------------
--menu.lua--
------------
------------------------------------------------------------------------------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"
local mydata = require("mydata")
local loadsave = require("loadsave")


--------------------------------------------

-- forward declarations and other locals

-- 'onRelease' event listener for playBtn
local function onPlayBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "levelselect", "fade", 500 )
	storyboard.removeScene("menu")
	return true	-- indicates successful touch
end


local function onControlsBtnRelease()
	
	-- go to level1.lua scene
	storyboard.gotoScene( "controls", "fade", 500 )
	storyboard.removeScene("menu")
	return true	-- indicates successful touch
end

-- Called when the scene's view does not exist:
function scene:createScene( event )
	local group = self.view

	-- create a widget button (which will loads level1.lua on release)
	local playBtn = widget.newButton{
		label="Play Now",
		labelColor = { default={255}, over={128} },
		defaultFile="roundButton.png",
		overFile="roundButton.png",
		width=154, height=40,
		onRelease = onPlayBtnRelease	-- event listener function
	}
	playBtn.x = display.contentWidth*0.5
	playBtn.y = display.contentHeight - 125

	local controlsBtn = widget.newButton{
		label="Controls",
		labelColor = { default={255}, over={128} },
		defaultFile="roundButton.png",
		overFile="roundButton.png",
		width=154, height=40,
		onRelease = onControlsBtnRelease	-- event listener function
	}
	controlsBtn.x = display.contentWidth*0.5
	controlsBtn.y = display.contentHeight - 75



	-- display a background image
	-- local background = display.newImageRect( "flurrybg.png", display.contentWidth, display.contentHeight )
	-- background.anchorX = 0
	-- background.anchorY = 0
	-- background.x, background.y = 0, 0
	
	
	
	-- create/position logo/title image on upper-half of the screen
	local titleLogo = display.newImageRect( "bubbleFlurry.png", 264, 42 )
	titleLogo.x = display.contentWidth * 0.5
	titleLogo.y = 72
	

	local bubbleLogo = display.newImage("bubbleLogo.png")
	bubbleLogo.x = display.contentCenterX
	bubbleLogo.y = 180                                                        --210     
	bubbleLogo:scale(0.8,0.8)
	group:insert(bubbleLogo)
	group:insert(titleLogo)
	group:insert( playBtn )
	group:insert(controlsBtn)

end
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	storyboard.removeScene("level1")
	storyboard.removeScene("level2")
	storyboard.removeScene("level3")
	storyboard.removeScene("rotategame")
	-- Runtime:addEventListener( "system", onSystemEvent )
	
mySettings = loadTable("mySettings.json")
	if mySettings == nil then
   -- create the table
   mySettings = {}
   mySettings.highScore1 = 0
   mySettings.highScore2 = 0
   mySettings.highScore3 = 0
   mySettings.highScore4 = 0

saveTable(mySettings, "mySettings.json")
end

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
	storyboard.removeScene("menu")
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
	
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	
	if playBtn then
		playBtn:removeSelf()	-- widgets must be manually removed
		playBtn = nil
	end
	if controlsBtn then
		controlsBtn:removeSelf()
		controlsBtn = nil
	end

end

	

	-----------------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------

-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched whenever before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

-----------------------------------------------------------------------------------------

return scene
	-- display a background image
	
	
	
	
	
	


