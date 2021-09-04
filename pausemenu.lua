--pausemenu (overlay)
------------------------------------------------------------------------------------------------------------------------------------------------------------
local storyboard = require( "storyboard" )
local scene = storyboard.newScene()

local mydata = require("mydata")
local widget = require( "widget" )

local reloadingText 

local options =
    {
    effect = "fade",
    time = 100,
  isModal = true
  }

local function onResumeBtnRelease( ... )
    -- body
    storyboard.hideOverlay( "pausemenu", options )
    physics.start()
    if mydata.level == 1 then
    timer.resume(tmr1)
    timer.resume(tmr2)    
    timer.resume(tmr3)
    timer.resume(tmr4)
    elseif mydata.level == 2 then
    timer.resume(tmr1)
    timer.resume(tmr2)    
    timer.resume(tmr3)
    timer.resume(tmr4)
    timer.resume(tmr5)
    elseif mydata.level == 3 then
    timer.resume(tmr1)
    timer.resume(tmr2)    
    timer.resume(tmr6) 
    elseif mydata.level == 4 then
    timer.resume(countdownTmr)
    timer.resume(ballTmr)
    timer.resume(tmr3)
    
    return true -- indicates successful touch
    end
end


local function onMenuBtnRelease( ... )
    -- body
    
    storyboard.gotoScene( "menu", options )
    storyboard.removeScene("level2", options)
    -- timer.cancel(tmr3)
    -- timer.cancel(tmr4)
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
    timer.cancel(tmr6)
    elseif mydata.level == 4 then
    timer.cancel(countdownTmr)    
    timer.cancel(ballTmr)
    timer.cancel(tmr3)
    end
    return true -- indicates successful touch
end

local function onRestartBtnRelease( event )
    if event.phase == "ended" then
    storyboard.gotoScene("reloading", {time = 250, effect = "fade"} ) 
    -- timer.cancel(tmr3)
    -- timer.cancel(tmr4)
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
    timer.cancel(tmr6)
    elseif mydata.level == 4 then
    timer.cancel(countdownTmr)    
    timer.cancel(ballTmr) 
    timer.cancel(tmr3)
    end
    end
    return true -- indicates successful touch   
end


-- Main function - MUST return a display.newGroup()

    function scene:createScene( event )
    local group = self.view
    ------ Your code here ------
    local pauseMenu = display.newImage("pauseMenu.png")
    pauseMenu.x = display.contentWidth/2 +0.55
    pauseMenu.y = 35
    pauseMenu.alpha = 0.875
    pauseMenu:scale(1.01, 0.3)
    group:insert(pauseMenu)

    
local resumeBtn = widget.newButton{
        --label="Play Now",
        --labelColor = { default={0}, over={128} },
        defaultFile="playBtn.png",
        overFile="playBtn.png",
        width=40, height=40,
        onRelease = onResumeBtnRelease
    }
    resumeBtn.x = 40
    resumeBtn.y = 30
    group:insert(resumeBtn)

local menuBtn = widget.newButton{
        --label="Play Now",
        --labelColor = { default={0}, over={128} },
        defaultFile="menuBtn.png",
        overFile="menuBtn.png",
        width=40, height=40,
        onRelease = onMenuBtnRelease
    }
    menuBtn.x = display.contentWidth/2
    menuBtn.y = 30
    group:insert(menuBtn)

local restartBtn = widget.newButton{
        --label="Play Now",
        --labelColor = { default={0}, over={128} },
       defaultFile="replayBtn.png",     -- @@@@@@ dont change
        overFile="replayBtn.png",           -- two got swapped around in photoshop, leave as is!!!@@@@@@@@@@@
        width=40, height=40,
        onRelease = onRestartBtnRelease  
    }
    restartBtn.x = 280
    restartBtn.y = 30
    group:insert(restartBtn)

end

-- Called immediately after scene has moved onscreen:
function scene:enterScene( event )
    local group = self.view
    
    -----------------------------------------------------------------------------
        
    --  INSERT code here (e.g. start timers, load audio, start listeners, etc.)
    
    -----------------------------------------------------------------------------
    
end


-- Called when scene is about to move offscreen:
function scene:exitScene( event )
    local group = self.view
    
    -----------------------------------------------------------------------------
    
    --  INSERT code here (e.g. stop timers, remove listeners, unload sounds, etc.)
    
    -----------------------------------------------------------------------------
    mydata.score = 0
    
end


-- Called prior to the removal of scene's "view" (display group)
function scene:destroyScene( event )
    local group = self.view 
    -----------------------------------------------------------------------------
    
    --  INSERT code here (e.g. remove listeners, widgets, save state, etc.)
    
    -----------------------------------------------------------------------------
    
    if resumeBtn then
    resumeBtn:removeSelf()   -- widgets must be manually removed
    resumeBtn = nil
    end
    
    if restartBtn then
    restartBtn:removeSelf() -- widgets must be manually removed
    restartBtn = nil
    end

    if menuBtn then
    menuBtn:removeSelf()
    menuBtn = nil
    end


end
---------------------------------------------------------------------------------
-- END OF YOUR IMPLEMENTATION
---------------------------------------------------------------------------------
--scene:addEventListener( "overlayEnded" )

--scene:addEventListener( "overlayBegan" )
-- "createScene" event is dispatched if scene's view does not exist
scene:addEventListener( "createScene", scene )

-- "enterScene" event is dispatched whenever scene transition has finished
scene:addEventListener( "enterScene", scene )

-- "exitScene" event is dispatched before next scene's transition begins
scene:addEventListener( "exitScene", scene )

-- "destroyScene" event is dispatched before view is unloaded, which can be
-- automatically unloaded in low memory situations, or explicitly via a call to
-- storyboard.purgeScene() or storyboard.removeScene().
scene:addEventListener( "destroyScene", scene )

---------------------------------------------------------------------------------



return scene





