--levelselect-----------------
---------------------------------------------------------------------------------------------------------------------------------------------
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

-----------------------------------------------------------------------------------------------------
local function onLevelsBackBtnRelease()
   -- go to level1.lua scene
   storyboard.gotoScene( "menu", "fade", 250 )
   
   return true -- indicates successful touch
end

local function lev1( event )
  -- if event.phase == "ended" then
  storyboard.gotoScene("level1", "fade", 250 )
  
    return true
  -- end
end

local function lev2( event )
  -- if event.phase == "ended" then
  storyboard.gotoScene("level2", "fade", 250 )
  
    return true
  -- end
end

local function lev3( event )
  -- if event.phase == "ended" then
  storyboard.gotoScene("level3", "fade", 250 )

    return true
  -- end
end

local function lev4( event )
  -- if event.phase == "ended" then
  storyboard.gotoScene("rotategame", "fade", 250 )

    return true
  -- end
end

local function scrollListener(event)
local phase = event.phase
local direction = event.direction

--scrollView limits
   if event.limitReached then
      if "up" == direction then
      print("top reached")
      elseif "down" == direction then
      print("bottom reached")
   end
      end
return true
end

local scrollView = widget.newScrollView
{
left = 0,
top = 0,
width = display.contentWidth,
height = display.viewableContentHeight,
topPadding =10, 
bottomPadding = 100,
horizontalScrollDisabled = true,
verticalScrollDisabled = false,
hideBackground = true,
listener = scrollListener,
}

-----------------------------------------------------------------------------------------------------
function scene:createScene( event )
	local group = self.view
local level1Buttton = display.newRect(0,0,100,100)
level1Buttton.x = display.contentCenterX
level1Buttton.y = 170
level1Buttton:setFillColor(255,255,255)
level1Buttton.touch = lev1
level1Buttton:addEventListener("touch", lev1)
group:insert(level1Buttton)
scrollView:insert(level1Buttton)

local level2Buttton = display.newRect(0,0,100,100)
level2Buttton.x = display.contentCenterX
level2Buttton.y = 310
level2Buttton:setFillColor(255,255,255)
level2Buttton.touch = lev2
level2Buttton:addEventListener("touch", lev2)
group:insert(level2Buttton)
scrollView:insert(level2Buttton)

local level3Buttton = display.newRect(0,0,100,100)
level3Buttton.x = display.contentCenterX
level3Buttton.y = 450
level3Buttton:setFillColor(255,255,255)
level3Buttton.touch = lev3
level3Buttton:addEventListener("touch", lev3)
group:insert(level3Buttton)
scrollView:insert(level3Buttton)

local level4Buttton = display.newRect(0,0,100,100)
level4Buttton.x = display.contentCenterX
level4Buttton.y = 590
level4Buttton:setFillColor(255,255,255)
level4Buttton.touch = lev4
level4Buttton:addEventListener("touch", lev4)
group:insert(level4Buttton)
scrollView:insert(level4Buttton)

local level1Text = display.newText("Easy",0,0,native.systemFontBold, 20)
level1Text.x = display.contentCenterX
level1Text.y = 140
level1Text:setFillColor(0,0,0)
group:insert(level1Text)
scrollView:insert(level1Text)
mySettings = loadTable("mySettings.json")
highscore1 = mySettings.highScore1

highscore2 = mySettings.highScore2

highscore3 = mySettings.highScore3

highscore4 = mySettings.highScore4

local lev1hsTxt = display.newText("Your 'Easy' highscore is: " .. highscore1, 0,0,native.systemFontBold, 18 )
lev1hsTxt.x = display.contentCenterX
lev1hsTxt.y = 240
lev1hsTxt:setFillColor(255,255,255)
group:insert(lev1hsTxt)
scrollView:insert(lev1hsTxt)

local lev2hsTxt = display.newText("Your 'Medium' highscore is: " .. highscore2, 0,0,native.systemFontBold, 18 )
lev2hsTxt.x = display.contentCenterX
lev2hsTxt.y = 380
lev2hsTxt:setFillColor(255,255,255)
group:insert(lev2hsTxt)
scrollView:insert(lev2hsTxt)

local lev3hsTxt = display.newText("Your 'Hard' highscore is: " .. highscore3, 0,0,native.systemFontBold, 18 )
lev3hsTxt.x = display.contentCenterX
lev3hsTxt.y = 520
lev3hsTxt:setFillColor(255,255,255)
group:insert(lev3hsTxt)
scrollView:insert(lev3hsTxt)

local lev4hsTxt = display.newText("Your 'Rotation' highscore is: " .. highscore4, 0,0,native.systemFontBold, 18 )
lev4hsTxt.x = display.contentCenterX
lev4hsTxt.y = 660
lev4hsTxt:setFillColor(255,255,255)
group:insert(lev4hsTxt)
scrollView:insert(lev4hsTxt)

local level2Text = display.newText("Medium",0,0,native.systemFontBold, 20)
level2Text.x = display.contentCenterX
level2Text.y = 280
level2Text:setFillColor(0,0,0)
group:insert(level2Text)
scrollView:insert(level2Text)

local level3Text = display.newText("Hard",0,0,native.systemFontBold, 20)
level3Text.x = display.contentCenterX
level3Text.y = 420
level3Text:setFillColor(0,0,0)
group:insert(level3Text)
scrollView:insert(level3Text)

local level4Text = display.newText("Rotation",0,0,native.systemFontBold, 20)
level4Text.x = display.contentCenterX
level4Text.y = 560
level4Text:setFillColor(0,0,0)
group:insert(level4Text)
scrollView:insert(level4Text)

-------- balls to show what each level has in it
local greencircle1 = display.newCircle(0, 0, 10)
greencircle1:setFillColor(0,255,0)
greencircle1.x = display.contentCenterX - 20
greencircle1.y = 180
group:insert(greencircle1)
scrollView:insert(greencircle1)

local bluecircle1 = display.newCircle(0, 0, 10)
bluecircle1:setFillColor(0,0,255)
bluecircle1.x = display.contentCenterX + 20
bluecircle1.y = 180
group:insert(bluecircle1)
scrollView:insert(bluecircle1)

local greencircle2 = display.newCircle(0, 0, 10)
greencircle2:setFillColor(0,255,0)
greencircle2.x = display.contentCenterX - 20
greencircle2.y = 320
group:insert(greencircle2)
scrollView:insert(greencircle2)

local bluecircle2 = display.newCircle(0, 0, 10)
bluecircle2:setFillColor(0,0,255)
bluecircle2.x = display.contentCenterX + 20
bluecircle2.y = 320
group:insert(bluecircle2)
scrollView:insert(bluecircle2)

local redcircle1 = display.newCircle(0, 0, 10)
redcircle1:setFillColor(255,0,0)
redcircle1.x = display.contentCenterX 
redcircle1.y = 345
group:insert(redcircle1)
scrollView:insert(redcircle1)

local greencircle3 = display.newCircle(0, 0, 10)
greencircle3:setFillColor(0,255,0)
greencircle3.x = display.contentCenterX - 20
greencircle3.y = 460
group:insert(greencircle3)
scrollView:insert(greencircle3)

local bluecircle3 = display.newCircle(0, 0, 10)
bluecircle3:setFillColor(0,0,255)
bluecircle3.x = display.contentCenterX + 20
bluecircle3.y = 460
group:insert(bluecircle3)
scrollView:insert(bluecircle3)

local redcircle2 = display.newCircle(0, 0, 10)
redcircle2:setFillColor(255,0,0)
redcircle2.x = display.contentCenterX 
redcircle2.y = 485
group:insert(redcircle2)
scrollView:insert(redcircle2)

local rotationPic = display.newImageRect("rect.png", 50, 50)
rotationPic.x = display.contentCenterX 
rotationPic.y = 605
rotationPic:setStrokeColor(0,0,0)
rotationPic.strokeWidth = 2
group:insert(rotationPic)
scrollView:insert(rotationPic)

local levelsBackBtn = widget.newButton{
      --labelColor = { default={255}, over={128} },
      defaultFile="backButton.png",
      overFile="backButton.png",
      width=40, height=40,
      onRelease = onLevelsBackBtnRelease -- event listener function
   }
   levelsBackBtn.x = display.contentWidth - 25
   levelsBackBtn.y = 710
   group:insert(levelsBackBtn)
   scrollView:insert(levelsBackBtn)

   local levelsText = display.newImageRect( "levelsText.png", 170, 42 )
  levelsText.x = display.contentWidth * 0.5
  levelsText.y = 72
  group:insert(levelsText)
  scrollView:insert(levelsText)  
--------------------------
group:insert(scrollView)
end

function scene:enterScene( event )
	local group = self.view
	
	-- INSERT code here (e.g. start timers, load audio, start listeners, etc.)
	
end

-- Called when scene is about to move offscreen:
function scene:exitScene( event )
	local group = self.view
  storyboard.removeScene("levelselect")
	-- INSERT code here (e.g. stop timers, remove listenets, unload sounds, etc.)
end

-- If scene's view is removed, scene:destroyScene() will be called just prior to:
function scene:destroyScene( event )
	local group = self.view
	if levelsBackBtn then
	levelsBackBtn.removeSelf()
	levelsBackBtn = nil
	end

  if level1Buttton then
  level1Buttton.removeSelf()
  level1Buttton = nil
  end

  if level2Buttton then
  level2Buttton.removeSelf()
  level2Buttton = nil
  end

  if level3Buttton then
  level3Buttton.removeSelf()
  level3Buttton = nil
  end

  if level4Buttton then
  level4Buttton.removeSelf()
  level4Buttton = nil
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
