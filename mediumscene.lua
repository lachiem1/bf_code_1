--mediumscene.lua

local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")
local widget = require( "widget" ) 

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
    }

-- local function scrollListener(event)
-- local phase = event.phase
-- local direction = event.direction

-- --scrollView limits
--    if event.limitReached then
--       if "up" == direction then
--       print("top reached")
--       elseif "down" == direction then
--       print("bottom reached")
--    end
--       end
-- return true
-- end

-- local scrollView = widget.newScrollView
-- {
-- left = 0,
-- top = 0,
-- width = display.contentWidth,
-- height = 850,
-- topPadding =10, 
-- bottomPadding = 90,
-- horizontalScrollDisabled = true,
-- verticalScrollDisabled = false,
-- hideBackground = true,
-- listener = scrollListener
-- }

function onMedTap( event )
 if (event.numTaps == 2 ) then
 print( "The object was double-tapped." )
 storyboard.gotoScene("hardscene", options)
 return true;
 elseif (event.numTaps == 1 ) then
 print("The object was tapped once.")
 end
 end

function scene:createScene( event )
    local group = self.view

local triangle = display.newImage("triangle.jpeg")
triangle.x = display.contentCenterX
triangle.y = display.contentCenterY - 25
triangle:scale(0.3,0.3)
group:insert(triangle)
-- scrollView:insert( triangle )

function triangle:touch( event )
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
      self.x = display.contentCenterX
     
    end
   
   end
 
-- return true so Corona knows that the touch event was handled properly
 return true

end
triangle:addEventListener( "touch", triangle )

local greencircle = display.newCircle(0, 0, 10)
  greencircle:setFillColor(0,255,0)
  greencircle.x = 20
  greencircle.y = display.contentCenterY + 65
  group:insert(greencircle)
  -- scrollView:insert(greencircle)

local bluecircle = display.newCircle(0, 0, 10)
  bluecircle:setFillColor(0,0,255)
  bluecircle.x = 20
  bluecircle.y = display.contentCenterY + 95
  group:insert(bluecircle)
  -- scrollView:insert(bluecircle)

local redcircle = display.newCircle(0, 0, 10)
  redcircle:setFillColor(255,0,0)
  redcircle.x = 20
  redcircle.y = display.contentCenterY + 125
  group:insert(redcircle)
  -- scrollView:insert(redcircle)

local greenrect = display.newRect(0, 0, 5, 65)
  greenrect:setFillColor(0,255,0)
  greenrect.x = display.contentWidth - 70
  greenrect.y = display.contentCenterY + 95
  group:insert(greenrect)
  -- scrollView:insert(greenrect)

local bluerect = display.newRect(0, 0, 5, 65)
  bluerect:setFillColor(0,0,255)
  bluerect.x = display.contentWidth - 55
  bluerect.y = display.contentCenterY + 95
  group:insert(bluerect)
  -- scrollView:insert(bluerect)

local redrect = display.newRect(0, 0, 5, 65)
  redrect:setFillColor(255,0,0)
  redrect.x = display.contentWidth - 40
  redrect.y = display.contentCenterY + 95
  group:insert(redrect)
  -- scrollView:insert(redrect)

local up1 = display.newText("+1",0,0,native.systemFontBold, 20)
up1:setFillColor(0,255,0)
up1.x = 40
up1.y = display.contentCenterY + 210
group:insert(up1)
-- scrollView:insert(up1)

local down1 = display.newText("-1",0,0,native.systemFontBold, 20)
down1:setFillColor(255,0,0)
down1.x = display.contentWidth - 45
down1.y = display.contentCenterY + 210
group:insert(down1)
-- scrollView:insert(down1)

local myText = [[Medium is a step up from easy. Move triangle left and right by dragging it. 




Try and hit the bubbles into the zone with the matching colour. This time there are 3 colours. 





+1 point for every bubble hit into the right zone, -1 point for every bubble hit into the wrong zone.




You have 60 seconds to score as high as you can. Good luck!]]

local options = {
   text = myText,
   x = display.contentCenterX,
   y = 350,
   fontSize = 15,
  width = 312,
   height = 00,
   align = "center"
}

local textBox = display.newText( options )
textBox:setFillColor( 255, 255, 255 )
group:insert(textBox)
-- scrollView:insert(textBox)

local medTxt = display.newText("Medium",0,0,native.systemFontBold, 35)
medTxt:setFillColor(255,255,255)
medTxt.x = display.contentCenterX
medTxt.y = 50
group:insert(medTxt)
-- scrollView:insert(medTxt)

local instTxt = display.newText("Double tap for next screen",0,0,native.systemFontBold, 18)
instTxt:setFillColor(255,255,255)
instTxt.x = display.contentCenterX
instTxt.y = 100
group:insert(instTxt)
-- scrollView:insert(instTxt)

-- group:insert(scrollView)

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view

Runtime:addEventListener("tap", onMedTap)

end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view

storyboard.removeScene("mediumscene")

end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view 
   
end
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
scene:addEventListener( "createScene", scene )
scene:addEventListener( "enterScene", scene )
scene:addEventListener( "exitScene", scene )
scene:addEventListener( "destroyScene", scene )
---------------------------------------------------------------------------------



return scene