--reloading------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")

-- include Corona's "widget" library
local widget = require "widget"



local reloadingText

--------------------------------------------
local function restartLvl(target)
physics.start()
if mydata.level == 1 then
storyboard.removeScene("level1")
storyboard.gotoScene("level1", {time = 300, effect = "fade"} )
elseif mydata.level == 2 then
storyboard.removeScene("level2")
storyboard.gotoScene("level2", {time = 300, effect = "fade"})
elseif mydata.level == 3 then
storyboard.removeScene("level3")
storyboard.gotoScene("level3", {time = 300, effect = "fade"})
elseif mydata.level == 4 then
storyboard.removeScene("rotategame")
storyboard.gotoScene("rotategame", {time = 300, effect = "fade"})
end
end

function scene:createScene( event )
  local group = self.view
  
local greenrect = display.newRect(4.5,0,8,1000)
greenrect:setFillColor(0,255,0)
greenrect.type = "greenwall"
greenrect.myName = greenrect
greenrect:addEventListener("collision", greenrect)
group:insert(greenrect)



local bluerect = display.newRect(316,0,8,1000)
bluerect:setFillColor(0,0,255)
bluerect.myName = bluezone
bluerect.type = "bluewall"
bluerect.myName = bluerect
bluerect:addEventListener("collision", bluerect)
group:insert(bluerect)


local bottomrect = display.newRect(100,476,600,8)
if mydata.level == 1 then
bottomrect:setFillColor(0,0,0)
elseif mydata.level == 2 or 3 then
bottomrect:setFillColor(255,0,0)
end
bottomrect:addEventListener( "touch", bottomrect )
bottomrect.myName = ground
bottomrect.type = "wall"
bottomrect.myName = bottomrect
group:insert(bottomrect)

reloadingText = display.newText("Restarting...",0,0,native.systemFontBold, 20)
reloadingText:setFillColor(255,255,255)
reloadingText.x = display.contentCenterX
reloadingText.y = display.contentCenterY
group:insert(reloadingText)
 
end



function scene:enterScene( event )
  local group = self.view
  
  -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
reloadingText.alpha = 1.0
transition.to(reloadingText, {time = 500, alpha = 0.0, onComplete = restartLvl} )
  
  

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
  
  -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
  
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
  local group = self.view
  

  end


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
-- END OF YOUR IMPLEMENTATION
-----------------------------------------------------------------------------------------


-----------------------------------------------------------------------------------------

return scene
  -- display a background image





