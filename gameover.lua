--gameover (overlay)

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")

-- include Corona's "widget" library
local widget = require "widget"

local loadsave = require("loadsave")

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
  }

local replayText

local menuText

local function replay( event )
	storyboard.gotoScene("reloading", {time = 250, effect = "fade"} )
  physics.stop()
  if mydata.level == 1 then
  timer.cancel(tmr1)
  timer.cancel(tmr2)
  timer.cancel(tmr3)
  timer.cancel(tmr4) 
  elseif mydata.level == 2 then
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr3)
    timer.cancel(tmr4) 
    timer.cancel(tmr5)
  elseif mydata.level == 3 then
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr5)
    timer.cancel(tmr6)
  elseif mydata.level == 4 then
    timer.cancel(countdownTmr)
    timer.cancel(ballTmr)
    timer.cancel(tmr3)
  end
  
    return true
end

local function menu( event )
  storyboard.gotoScene("menu", options )
  physics.stop()
  if mydata.level == 1 then
  timer.cancel(tmr1)
  timer.cancel(tmr2)
  timer.cancel(tmr3) 
  timer.cancel(tmr4)
  elseif mydata.level == 2 then
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr3) 
    timer.cancel(tmr4)
    timer.cancel(tmr5)
  elseif mydata.level == 3 then
   timer.cancel(tmr1)
   timer.cancel(tmr2) 
   timer.cancel(tmr5)
   timer.cancel(tmr6) 
  elseif mydata.level == 4 then
    timer.cancel(countdownTmr)
    timer.cancel(ballTmr)
    timer.cancel(tmr3)
  end
    return true
end


function scene:createScene( event )
  local group = self.view

replayText = display.newText("Replay Game",0,0,native.systemFontBold, 20)
  replayText.x = display.contentCenterX 
  replayText.y = display.contentCenterY - 80
  replayText:setFillColor(0,255,255)
  replayText:addEventListener("touch", replay)
  group:insert(replayText)
 
menuText = display.newText("Menu",0,0,native.systemFontBold, 20)
  menuText.x = display.contentCenterX 
  menuText.y = display.contentCenterY - 40
  menuText:setFillColor(0,255,255)
  menuText:addEventListener("touch", menu)
  group:insert(menuText)

finalScore = display.newText("Your score is: ".. mydata.score,0,0,native.systemFont, 20)
  finalScore.x = display.contentCenterX 
  finalScore.y = display.contentCenterY - 120
  finalScore:setFillColor(255,255,0)
  group:insert(finalScore)

mySettings = loadTable("mySettings.json")

   -- populate it with values as necessary
   saveTable(mySettings, "mySettings.json")

 
if mydata.level == 1 then
     highscore1 = mySettings.highScore1
    if(highscore1 == nil)then
        highscore1 = mydata.score
        mySettings.highScore1 = highscore1
    end
    if(highscore1 < mydata.score)then
        highscore1 = mydata.score
        mySettings.highScore1 = highscore1
        print ("highscore1 beaten")
    end

elseif mydata.level == 2 then
 highscore2 = mySettings.highScore2
    if(highscore2 == nil)then
        highscore2 = mydata.score
        mySettings.highScore2 = highscore2
    end
    if(highscore2 < mydata.score)then
        highscore2 = mydata.score
        mySettings.highScore2 = highscore2
        print ("highscore2 beaten")
    end  
elseif mydata.level == 3 then
 highscore3 = mySettings.highScore3
    if(highscore3 == nil)then
        highscore3 = mydata.score
        mySettings.highScore3 = highscore3
    end
    if(highscore3 < mydata.score)then
        highscore3 = mydata.score
        mySettings.highScore3 = highscore3
        print ("highscore3 beaten")
    end  
elseif mydata.level == 4 then
highscore4 = mySettings.highScore4
    if(highscore4 == nil)then
        highscore4 = mydata.score
        mySettings.highScore4 = highscore4
    end
    if(highscore4 < mydata.score)then
        highscore4 = mydata.score
        mySettings.highScore4 = highscore4
        print ("highscore4 beaten")
    end  
end

if mydata.level == 1 then
  hs1Txt = display.newText("Your highscore is: ".. highscore1, 0, 0, native.systemFont, 20 )
  hs1Txt.x = display.contentCenterX  
  hs1Txt.y = display.contentCenterY - 220
  hs1Txt:setFillColor(255,255,0)
  group:insert(hs1Txt)
 saveTable(mySettings, "mySettings.json")

elseif mydata.level == 2 then
  hs2Txt = display.newText("Your highscore is: ".. highscore2, 0, 0, native.systemFont, 20 )
  hs2Txt.x = display.contentCenterX  
  hs2Txt.y = display.contentCenterY - 220
  hs2Txt:setFillColor(255,255,0)
  group:insert(hs2Txt)
 saveTable(mySettings, "mySettings.json")

elseif mydata.level == 3 then
  hs3Txt = display.newText("Your highscore is: ".. highscore3, 0, 0, native.systemFont, 20 )
  hs3Txt.x = display.contentCenterX  
  hs3Txt.y = display.contentCenterY - 220
  hs3Txt:setFillColor(255,255,0)
  group:insert(hs3Txt)
 saveTable(mySettings, "mySettings.json")

 elseif mydata.level == 4 then
  hs4Txt = display.newText("Your highscore is: ".. highscore4, 0, 0, native.systemFont, 20 )
  hs4Txt.x = display.contentCenterX  
  hs4Txt.y = display.contentCenterY - 220
  hs4Txt:setFillColor(255,255,0)
  group:insert(hs4Txt)
 saveTable(mySettings, "mySettings.json")

end

end
function scene:enterScene( event )
  local group = self.view
  -- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
physics.stop()
  if mydata.level == 1 then
  timer.cancel(tmr1)
  timer.cancel(tmr2)
  timer.cancel(tmr3) 
  timer.cancel(tmr4)
  elseif mydata.level == 2 then
    timer.cancel(tmr1)
    timer.cancel(tmr2)
    timer.cancel(tmr3) 
    timer.cancel(tmr4)
    timer.cancel(tmr5)
  elseif mydata.level == 3 then
   timer.cancel(tmr1)
   timer.cancel(tmr2) 
   timer.cancel(tmr5)
   timer.cancel(tmr6) 
  elseif mydata.level == 4 then
   timer.cancel(countdownTmr)
   timer.cancel(ballTmr) 
   timer.cancel(tmr3)
  
return true
  end
  
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
  local group = self.view
  -- INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
mydata.score = 0

end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
  local group = self.view
  
  
  end


--scene:addEventListener( "overlayEnded" )

--scene:addEventListener( "overlayBegan" )
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

