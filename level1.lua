--level1.lua

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")

-- include Corona's "widget" library
local widget = require "widget"
--local score = require( "score" )


--------------------------------------------
local physics = require( "physics" )
physics.start()

physics.setGravity(0,10)

local reloadingText

--local pileUp = false

local greenCollisionFilter = { categoryBits = 2, maskBits = 3 } 
-- 

local blueCollisionFilter = { categoryBits = 2, maskBits = 5 } 

local greenZoneCollisionFilter = { categoryBits = 4, maskBits = 2 } 
-- 

local blueZoneCollisionFilter = { categoryBits = 4, maskBits = 2 } 
-- 

local greenBody = { ( {density=2.0, friction=0.5, bounce=0.5}), filter = greenCollisionFilter }

local blueBody = { ( {density=2.0, friction=0.5, bounce=0.5}) ,filter = blueCollisionFilter }

local greenRectBody = { filter=greenZoneCollisionFilter }

local blueRectBody = { filter=blueZoneCollisionFilter }

--local score = 0
mydata.level = 1

mydata.score = 0

local scoreTxt

local timeLeft = 60

local maxXValue = display.contentWidth + 20

local minXValue = - 20

--local pauseBtn
  
  ------ Your code here ------
local function decreaseTime()
 timeLeft = timeLeft - 1
 counterText.text = "".. timeLeft
end

tmr4 = timer.performWithDelay(1000, decreaseTime, 60)



local function gcircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "gcircle" and event.other.type == "greenwall" then
     mydata.score = mydata.score + 1;
      scoreTxt.text = "" .. mydata.score
     timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    elseif event.target.type == "gcircle" and event.other.type == "bluewall" then
      mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      elseif event.target.type == "gcircle" and event.other.type == "bottom" then
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    end
  end
end

local function bcircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "bcircle" and event.other.type == "bluewall" then
     mydata.score = mydata.score + 1;
      scoreTxt.text = "" .. mydata.score
    timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    elseif event.target.type == "bcircle" and event.other.type == "greenwall" then
    mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      elseif event.target.type == "bcircle" and event.other.type == "bottom" then
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    end
  end
end

local function checkRectXValue( self )
  if self.x > maxXValue then
  self.x =  maxXValue
    elseif self.x < minXValue then
    self.x = minXValue
  end
end 

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
  }
local function onmyButtonRelease()

    storyboard.showOverlay( "pausemenu", options )
    timer.pause(tmr1)
    timer.pause(tmr2)
    timer.pause(tmr3)
    timer.pause(tmr4)
    physics.pause()

    return true -- indicates successful touch
end

local function gameOver(event)
  storyboard.showOverlay("gameover", options)
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr3)
    timer.cancel(tmr4)
    physics.stop()
    return true
end

tmr3 = timer.performWithDelay(62000, gameOver, 1)
--timer.performWithDelay(96000, gameOver, 1)


function scene:overlayBegan( event )

   print( "Showing overlay: " .. event.sceneName )
end

 function scene:overlayEnded( event )

    print( "Overlay removed: " .. event.sceneName )
end


function scene:createScene( event )
  local group = self.view

local function spawnGreenCircle()
  local gcircle = display.newCircle(0, 0, 10)
  gcircle:setFillColor(0,255,0)
  gcircle.x = math.random(0, display.contentWidth-40)
  gcircle.y = math.random(-750, -50)
  physics.addBody(gcircle, greenBody)
  gcircle.collision = gcircleCollision
  gcircle:addEventListener("collision", gcircle)
  gcircle.type = "gcircle"
  gcircle.myName = gcircle
  group:insert(gcircle)
end

local function spawnBlueCircle()
local bcircle = display.newCircle(0, 0, 10)
bcircle.x = math.random(0, display.contentWidth-40)
bcircle.y = math.random(-750, -50)
bcircle:setFillColor(0,0,255)
physics.addBody(bcircle, blueBody)
bcircle.collision = bcircleCollision
bcircle:addEventListener("collision", bcircle)
bcircle.type = "bcircle"
bcircle.myName = bcircle
group:insert(bcircle)
end

tmr1 = timer.performWithDelay(1000, spawnGreenCircle, 0)  

tmr2 = timer.performWithDelay(1000, spawnBlueCircle, 0) 

local greenrect = display.newRect(4.5,0,8,1000)
greenrect:setFillColor(0,255,0)
physics.addBody( greenrect, "static", { density=3.0, friction=0.4, bounce=0.8 } )
greenrect.type = "greenwall"
greenrect.myName = greenrect
greenrect:addEventListener("collision", greenrect)
group:insert(greenrect)

local bluerect = display.newRect(316,0,8,1000)
bluerect:setFillColor(0,0,255)
physics.addBody( bluerect, "static", { density=3.0, friction=0.4, bounce=0.8 } )
bluerect.myName = bluezone
bluerect.type = "bluewall"
bluerect.myName = bluerect
bluerect:addEventListener("collision", bluerect)
group:insert(bluerect)

local bottomrect = display.newRect(100,476,600,8)
bottomrect:setFillColor(0,0,0)
bottomrect:addEventListener( "collision", bottomrect )
bottomrect.myName = ground
bottomrect.type = "bottom"
bottomrect.myName = bottomrect
physics.addBody(bottomrect, "static", { density=3.0, friction=0.4, bounce=0.8 })
--if pileUp then physics.addBody( bottomrect, "static", { density=3.0, friction=0.5, bounce=1 } )
--end
group:insert(bottomrect)
  
scoreTxt = display.newText(mydata.score, 0, 0, native.systemFontBold, 120 )  
scoreTxt.x = display.viewableContentWidth / 2  
scoreTxt.y = display.viewableContentHeight / 2  
scoreTxt:setFillColor( 255, 255, 255, 10 )
scoreTxt.alpha = 0.6 
group:insert(scoreTxt) 

counterText = display.newText(timeLeft, 0,0, native.systemFontBold, 24)
counterText.x = 30
counterText.y = 20 
counterText:setFillColor(255,255,255,10)
counterText.alpha = 0.75
group:insert(counterText)

rect = display.newRect(0,0, 100, 100)
rect.x = display.contentWidth * 0.5; rect.y = display.contentHeight
rect:setFillColor(255,255,255)
rect.rotation = 45
physics.addBody( rect, "static", {density=5.0, friction=0.5, bounce=2.75})
rect.myName = bouncepad
group:insert( rect ) 

local myButton = widget.newButton{
        --label="Play Now",
        --labelColor = { default={0}, over={128} },
        defaultFile="pauseButton.png",
        overFile="pauseButton.png",
        width=40, height=40,
        onRelease = onmyButtonRelease    -- event listener function
    }
  myButton.x = 280
  myButton.y = 30
  group:insert(myButton)

 function rect:touch( event )
  if event.phase == "began" then
     --first we set the focus on the object
    display.getCurrentStage():setFocus( self, event.id )
    self.isFocus = true
 
    -- then we store the original x and y position
  self.markX = self.x
  -- not needed      self.markY = self.y
 
  elseif self.isFocus then
 
    if event.phase == "moved" then
      -- then drag our object
     self.x = event.x - event.xStart + self.markX
--not needed      self.y = event.y - event.yStart + self.markY
   elseif event.phase == "ended" or event.phase == "cancelled" then
      -- we end the movement by removing the focus from the object
     display.getCurrentStage():setFocus( self, nil )
      self.isFocus = false
     
    end
   
   end
 
-- return true so Corona knows that the touch event was handled properly
 return true

end


-- add an event listener to circle to allow it to be dragged
rect:addEventListener( "touch", rect )

end



function scene:enterScene( event )
  local group = self.view
  
rect.enterFrame = checkRectXValue
Runtime:addEventListener("enterFrame", rect)

physics.start()

end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
  -- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)


end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
  local group = self.view
  
  if myButton then
    myButton:removeSelf()
    myButton = nil
  end

end


scene:addEventListener( "overlayEnded" )

 scene:addEventListener( "overlayBegan" )
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





