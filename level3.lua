--level3-------------
-----------------------------------------------------------

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")

-- include Corona's "widget" library
local widget = require "widget"

------------------------------------       
local physics = require( "physics" )
physics.start()

physics.setGravity(0,9)

local reloadingText

local greenCollisionFilter = { categoryBits = 2, maskBits = 3 } 

local blueCollisionFilter = { categoryBits = 2, maskBits = 5 }

local redCollisionFilter =  { categoryBits = 2, maskBits = 5 }

local whiteCollisionFilter =  { categoryBits = 2, maskBits = 5 }

local greenZoneCollisionFilter = { categoryBits = 4, maskBits = 2 } 

local blueZoneCollisionFilter = { categoryBits = 4, maskBits = 2 } 

local redZoneCollisionFilter = { categoryBits = 4, maskBits = 2 }

local greenBody = { ( {density=2.0, friction=0.5, bounce=0.5}), filter = greenCollisionFilter }

local blueBody = { ( {density=2.0, friction=0.5, bounce=0.5}) ,filter = blueCollisionFilter }

local redBody = { ( {density=2.0, friction=0.5, bounce=0.5}) ,filter = redCollisionFilter }

local wBody = { ({density=2.0, friction=0.5, bounce=0.5}), filter = whiteCollisionFilter }

local greenRectBody = { filter=greenZoneCollisionFilter }

local blueRectBody = { filter=blueZoneCollisionFilter }

local bottomRect = { filter=redZoneCollisionFilter }

local lives = {}

local numofLives = 3

local maxLives = 3

mydata.level = 3

mydata.score = 0 

local wsquare

local scoreTxt

local maxXValue = display.contentWidth + 20

local minXValue = - 20

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
  }

local options2 =
    {
    effect = "fade",
    time = 5,
  isModal = true
  }

local function spinImage (event)
  transition.to( wsquare, { rotation = wsquare.rotation-360, time=1500, onComplete=spinImage} )
end

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
      	mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
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
      	mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    end
  end
end

local function rcircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "rcircle" and event.other.type == "bluewall" then
     mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
    timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    elseif event.target.type == "rcircle" and event.other.type == "greenwall" then
    mydata.score = mydata.score - 1;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      elseif event.target.type == "rcircle" and event.other.type == "bottom" then
      mydata.score = mydata.score + 1;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    end
  end
end

local function wsquareCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "wsquare" and event.other.type == "bluewall" then
    timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
    elseif event.target.type == "wsquare" and event.other.type == "greenwall" then
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      elseif event.target.type == "wsquare" and event.other.type == "bottom" then
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      elseif event.target.type == "wsquare" and event.other.type == "rect" then
       timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end) 
      mydata.score = mydata.score - 5;
      scoreTxt.text = "" .. mydata.score
      display.remove(lives[numofLives])
      numofLives = numofLives - 1
      print(numofLives)
      if numofLives <= 0 then
    storyboard.showOverlay("gameover", options)
    physics.pause()
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr5)
    timer.cancel(tmr6) 

    return true
end
    end
  end
end

function checkYValueG(self)
  if self.y < -2000 then
  self:removeSelf()
  self = nil
  print("gcircle removed")
  end
end

function checkYValueB( self )
  if self.y < -2000 then
    self:removeSelf()
    self = nil
    print("bcircle removed")
  end
end
   
function checkYValueR( self )
  if self.y < -2000 then
  self:removeSelf()
  self = nil
  print("rcircle removed")
  end
end


local function checkRectXValue( self )
  if self.x > maxXValue then
  self.x =  maxXValue
    elseif self.x < minXValue then
    self.x = minXValue
  end
end 

local function onmyButtonRelease()

    storyboard.showOverlay( "pausemenu", options )
    timer.pause(tmr1)
    timer.pause(tmr2)
    timer.pause(tmr5)
    timer.pause(tmr6)
    physics.pause()

    return true -- indicates successful touch
end

function scene:overlayBegan( event )
  print( "Showing overlay: " .. event.sceneName )
end

function scene:overlayEnded( event )
  print( "Overlay removed: " .. event.sceneName )
end

  function spawnGreenCircle()
  gcircle = display.newCircle(0, 0, 10)
  gcircle:setFillColor(0,255,0)
  gcircle.x = math.random(0, display.contentWidth-40)
  gcircle.y = math.random(-1150, -50)
  physics.addBody(gcircle, greenBody)
  gcircle.collision = gcircleCollision
  gcircle.enterFrame = checkYValueG
  gcircle:addEventListener("collision", gcircle)
  gcircle:addEventListener("enterFrame", gcircle)
  gcircle.type = "gcircle"
  gcircle.myName = gcircle
  balls:insert(gcircle)
  end

function spawnBlueCircle()
bcircle = display.newCircle(0, 0, 10)
bcircle.x = math.random(0, display.contentWidth-40)
bcircle.y = math.random(-1150, -50)
bcircle:setFillColor(0,0,255)
physics.addBody(bcircle, blueBody)
bcircle.collision = bcircleCollision
bcircle.enterFrame = checkYValueB
bcircle:addEventListener("collision", bcircle)
bcircle:addEventListener("enterFrame", bcircle)
bcircle.type = "bcircle"
bcircle.myName = bcircle
balls:insert(bcircle)
end

function spawnRedCircle()
rcircle = display.newCircle(0, 0, 10)
rcircle.x = math.random(0, display.contentWidth-40)
rcircle.y = math.random(-1150, -50)
rcircle:setFillColor(255,0,0)
physics.addBody(rcircle, redBody)
rcircle.collision = rcircleCollision
rcircle.enterFrame = checkYValueR
rcircle:addEventListener("collision", rcircle)
rcircle:addEventListener("enterFrame", rcircle)
rcircle.type = "rcircle"
rcircle.myName = rcircle
balls:insert(rcircle)
end

function spawnWhiteSquare()
wsquare = display.newRect(0, 0, 20, 20)
wsquare.x = math.random(0, display.contentWidth-40)
wsquare.y = math.random(-1150, -50)
wsquare:setFillColor(255,255,255)
physics.addBody(wsquare, wBody)
wsquare.collision = wsquareCollision
wsquare:addEventListener("collision", wsquare)
wsquare.type = "wsquare"
wsquare.myName = wsquare
transition.to( wsquare, { rotation = wsquare.rotation-360, time=1500, onComplete=spinImage} )
balls:insert(wsquare)
end



tmr1 = timer.performWithDelay(2000, spawnGreenCircle, 0)  

tmr2 = timer.performWithDelay(2000, spawnBlueCircle, 0) 

tmr5 = timer.performWithDelay(2000, spawnRedCircle, 0) 

tmr6 = timer.performWithDelay(math.random(3000, 4500), spawnWhiteSquare, 0) 

function scene:createScene( event )
  local group = self.view
 
for i = 1, numofLives do
lives[i] = display.newRect(0, 0, 15, 15)
lives[i].x = i*30 - 10
lives[i].y = 25
lives[i]:setFillColor(255,255,0)
group:insert(lives[i])
end

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
bottomrect:setFillColor(255,0,0)
bottomrect:addEventListener( "collision", bottomrect )
bottomrect.myName = ground
bottomrect.type = "bottom"
bottomrect.myName = bottomrect
physics.addBody(bottomrect, "static", { density=3.0, friction=0.4, bounce=0.8 })
group:insert(bottomrect)
  
scoreTxt = display.newText(mydata.score, 0, 0, native.systemFontBold, 120 )  
scoreTxt.x = display.viewableContentWidth / 2  
scoreTxt.y = display.viewableContentHeight / 2  
scoreTxt:setFillColor( 255, 255, 255, 10 )
scoreTxt.alpha = 0.6 
group:insert(scoreTxt) 

balls = display.newGroup()
group:insert(balls)

rect = display.newRect(0,0, 100, 100)
rect.x = display.contentWidth * 0.5; rect.y = 480
rect:setFillColor(255,255,255)
rect.rotation = 45
physics.addBody( rect, "static", {density=5.0, friction=0.5, bounce=2.75})
rect.myName = bouncepad
rect.type = "rect"
group:insert( rect ) 

local myButton = widget.newButton{
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
  -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
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
saveTable(myTable, "savedInfo.json")
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
return scene


