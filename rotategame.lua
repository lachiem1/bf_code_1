--rotategame.lua

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()
local widget = require "widget"

local physics = require "physics"
local mydata = require "mydata"

physics.start() 
physics.setGravity(0,4)
-- physics.setDrawMode("hybrid")

local timeLeft = 60

local wsquare 

local numOfTaps = 0

mydata.level = 4

mydata.score = 0

local redSide = false

local blueSide = false

local greenSide = false

local whiteSide = false

local scoreTxt

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

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
  }

local function spinImage (event)
transition.to( wsquare, { rotation = wsquare.rotation-360, time=1500, onComplete=spinImage} )
end

function greenCircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "gcircle" and event.other.type == "lineBody" then
      if greenSide == true then
      mydata.score = mydata.score + 2;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
        else 
        mydata.score = mydata.score - 1;
        scoreTxt.text = "" .. mydata.score
        timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      end
    end
  end
end

function blueCircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "bcircle" and event.other.type == "lineBody" then
      if blueSide == true then
      mydata.score = mydata.score + 2;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
        else 
        mydata.score = mydata.score - 1;
        scoreTxt.text = "" .. mydata.score
        timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      end
    end
  end
end

function redCircleCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "rcircle" and event.other.type == "lineBody" then
      if redSide == true then
      mydata.score = mydata.score + 2;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
        else 
        mydata.score = mydata.score - 1;
        scoreTxt.text = "" .. mydata.score
        timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      end
    end
  end
end

function whiteSquareCollision( self, event )
  if event.phase == "began" then
    if event.target.type == "wsquare" and event.other.type == "lineBody" then
      if whiteSide == true then
      mydata.score = mydata.score + 2;
      scoreTxt.text = "" .. mydata.score
      timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
        else 
        mydata.score = mydata.score - 1;
        scoreTxt.text = "" .. mydata.score
        timer.performWithDelay(0, function()  event.target:removeSelf(); event.target = nil; end)
      end
    end
  end
end

function redTapsHandler()
  if numOfTaps == 0 then redSide = true
    --print("redside up")
    elseif numOfTaps == 4 then redSide = true
    numOfTaps = 0
    -- print("redside up, reset")
      elseif numOfTaps == -4 then redSide = true
      numOfTaps = 0
      --print("redside up, reset")
        else redSide = false
  end
end

function blueTapsHandler()
  if numOfTaps == 3 then blueSide = true
  --print("blueside up")
    elseif numOfTaps == -1 then blueSide = true
    ---print("blue up")
      else blueSide = false
  end
end

function greenTapsHandler()
  if numOfTaps == 2 then greenSide = true
  --print("greenside up")
    elseif numOfTaps == -2 then greenSide = true
    --print("green up")
      else greenSide = false
  end
end

function whiteTapsHandler()
  if numOfTaps == 1 then whiteSide = true 
  --print("white up")
    elseif numOfTaps == -3 then whiteSide = true
    --print("white up")
      else whiteSide = false
  end
end

function onLeftTouch(event)
  if event.phase == "began" then
      lineBody.rotation = lineBody.rotation - 90
      print("rotated successfully")
      numOfTaps = numOfTaps + 1
      print("numOfTaps = "..numOfTaps)
  end
end

function onRightTouch(event)
	if event.phase == "began" then
      lineBody.rotation = lineBody.rotation + 90
      print("rotated successfully")
      numOfTaps = numOfTaps - 1
      print("numOfTaps = "..numOfTaps)
  end
end

local function decreaseTime()
 timeLeft = timeLeft - 1
 counterText.text = "".. timeLeft
end

countdownTmr = timer.performWithDelay(1000, decreaseTime, 60)

function randomBallSelector()
numGen = math.random(1,4)
  if numGen == 1 then
  gcircle = display.newCircle(0, 0, 10)
  gcircle:setFillColor(0,255,0)
  gcircle.x = display.contentCenterX
  gcircle.y = math.random(-1150, -250)
  physics.addBody(gcircle, greenBody)
  gcircle.collision = greenCircleCollision
  gcircle:addEventListener("collision", gcircle)
  gcircle.type = "gcircle"
  gcircle.myName = gcircle
  balls:insert(gcircle)
    elseif numGen == 2 then
    bcircle = display.newCircle(0, 0, 10)
    bcircle.x = display.contentCenterX
    bcircle.y = math.random(-1150, -250)
    bcircle:setFillColor(0,0,255)
    physics.addBody(bcircle, blueBody)
    bcircle.collision = blueCircleCollision
    bcircle.enterFrame = checkYValueB
    bcircle:addEventListener("collision", bcircle)
    bcircle.type = "bcircle"
    bcircle.myName = bcircle
    balls:insert(bcircle)
      elseif numGen == 3 then
      rcircle = display.newCircle(0, 0, 10)
      rcircle.x = display.contentCenterX
      rcircle.y = math.random(-1150, -250)
      rcircle:setFillColor(255,0,0)
      physics.addBody(rcircle, redBody)
      rcircle.collision = redCircleCollision
      rcircle:addEventListener("collision", rcircle)
      rcircle.type = "rcircle"
      rcircle.myName = rcircle
      balls:insert(rcircle)
        elseif numGen == 4 then
        wsquare = display.newRect(0, 0, 20, 20)
        wsquare.x = display.contentCenterX
        wsquare.y = math.random(-1150, -250)
        wsquare:setFillColor(255,255,255)
        physics.addBody(wsquare, wBody)
        wsquare.collision = whiteSquareCollision
        wsquare:addEventListener("collision", wsquare)
        wsquare.type = "wsquare"
        wsquare.myName = wsquare
        transition.to( wsquare, { rotation = wsquare.rotation-360, time=1500, onComplete=spinImage} )
        balls:insert(wsquare)
  end 
end

ballTmr = timer.performWithDelay(math.random(2600,2900), randomBallSelector, 0)

local function onmyButtonRelease()
    storyboard.showOverlay( "pausemenu", options )
    timer.pause(countdownTmr)
    timer.pause(ballTmr)
    timer.pause(tmr3)
    physics.pause()
    return true -- indicates successful touch
end

local function gameOver(event)
  storyboard.showOverlay("gameover", options)
    timer.cancel(countdownTmr)
    timer.cancel(ballTmr)
    timer.cancel(tmr3)
    physics.stop()
    return true
end

tmr3 = timer.performWithDelay(62000, gameOver, 1)

function scene:createScene( event )
	local group = self.view

balls = display.newGroup()
group:insert(balls)

lineBody = display.newImageRect("rect.png", 100,100)
lineBody.anchorX = 0.5
lineBody.anchorY = 0.5
lineBody.x = display.contentCenterX
lineBody.y = display.contentHeight - 60
lineBody.rotation = 0
-- lineBody:addEventListener( "touch", onTouch )
physics.addBody( lineBody, "static", { density=2.0, friction=0.5, bounce=0.5 } )
lineBody.type = "lineBody"
group:insert(lineBody)

rightArrow = display.newImageRect("backButton.png", 50, 50)
rightArrow.anchorX = 0.5
rightArrow.anchorY = 0.5
rightArrow.x = display.contentWidth - 45
rightArrow.y = display.contentHeight - 60
rightArrow:addEventListener("touch", onLeftTouch)
group:insert(rightArrow)

leftArrow = display.newImageRect("backButton.png", 50, 50)
leftArrow.anchorX = 0.5
leftArrow.anchorY = 0.5
leftArrow.x = 45       --display.contentWidth 
leftArrow.y = display.contentHeight - 60
leftArrow.rotation = 180
leftArrow:addEventListener("touch", onRightTouch)
group:insert(leftArrow)

counterText = display.newText(timeLeft, 0,0, native.systemFontBold, 24)
counterText.x = 30
counterText.y = 20 
counterText:setFillColor(255,255,255,10)
counterText.alpha = 0.75
group:insert(counterText)

scoreTxt = display.newText(mydata.score, 0, 0, native.systemFontBold, 120 )  
scoreTxt.x = display.viewableContentWidth / 2  
scoreTxt.y = display.viewableContentHeight / 2  
scoreTxt:setFillColor( 255, 255, 255, 10 )
scoreTxt.alpha = 0.6 
group:insert(scoreTxt) 

local myButton = widget.newButton{
        defaultFile="pauseButton.png",
        overFile="pauseButton.png",
        width=40, height=40,
        onRelease = onmyButtonRelease    -- event listener function
    }
  myButton.x = 280
  myButton.y = 30
  group:insert(myButton)

end

function scene:enterScene( event )
	local group = self.view

--lineBody.enterFrame = tapsHandler
Runtime:addEventListener("enterFrame", redTapsHandler)

Runtime:addEventListener("enterFrame", blueTapsHandler)

Runtime:addEventListener("enterFrame", greenTapsHandler)

Runtime:addEventListener("enterFrame", whiteTapsHandler)

end

function scene:exitScene( event )
	local group = self.view
physics.stop()	
end

function scene:destroyScene( event )
	local group = self.view

 if myButton then
    myButton:removeSelf()
    myButton = nil
  end
  
end

scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )

return scene