--controls.lua
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

-- include Corona's "widget" library
local widget = require "widget"

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
    }

local function onControlsBackBtnRelease()
   -- go to level1.lua scene
   storyboard.gotoScene( "menu", "fade", 250 )

   return true -- indicates successful touch
end

function easyOverlay(event)
  if event.phase == "ended" then
  storyboard.gotoScene("easyoverlay", options)
  print("showing easy overlay")
  end
end


function scene:createScene( event )
   local group = self.view
----pictures and shapes for instructions
local instructionsTxt = display.newText("Instructions",0,0,native.systemFontBold, 20)
instructionsTxt.x = display.contentCenterX
instructionsTxt.y = 150
instructionsTxt:setFillColor(255,255,255)
instructionsTxt:addEventListener("touch", easyOverlay)
group:insert(instructionsTxt)

local controlsLogo = display.newImageRect( "controls.png", 200, 42 )
   controlsLogo.x = display.contentWidth * 0.5
   controlsLogo.y = 72
   group:insert(controlsLogo)

local controlsBackBtn = widget.newButton{
      --labelColor = { default={255}, over={128} },
      defaultFile="backButton.png",
      overFile="backButton.png",
      width=40, height=40,
      onRelease = onControlsBackBtnRelease -- event listener function
   }
   controlsBackBtn.x = display.contentWidth - 35
   controlsBackBtn.y = display.contentHeight -35
   group:insert(controlsBackBtn)

end
-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
   local group = self.view
   
   -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
   
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
   local group = self.view
   storyboard.removeScene("controls")
   -- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
   local group = self.view
   if controlsBackBtn then
      controlsBackBtn.removeSelf()
      controlsBackBtn = nil
   end

   if instructionsTxt then
      instructionsTxt.removeSelf()
      instructionsTxt = nil
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



