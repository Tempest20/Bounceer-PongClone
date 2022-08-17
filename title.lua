local composer = require( "composer" )
 
local scene = composer.newScene()
 
-- -----------------------------------------------------------------------------------
-- Code outside of the scene event functions below will only be executed ONCE unless
-- the scene is removed entirely (not recycled) via "composer.removeScene()"
-- -----------------------------------------------------------------------------------

local bg
local title
local button
local buttonText

local function changeScenes()
    composer.gotoScene("pong", {effect = "slideUp", time = 1500})
end

-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- magic number hell
    bg = display.setDefault( "background" , {0, 0, 0});

    title = display.newText( "Bounceer", display.contentCenterX+20, display.contentCenterY, "munro.ttf", 200 )
    sceneGroup:insert( title )

    button = display.newRect( display.contentCenterX, display.contentCenterY + 300, 500, 200 )
    buttonText = display.newText("Play", display.contentCenterX, display.contentCenterY + 285, "munro.ttf", 150)
    buttonText:setFillColor(0, 0, 0)
    sceneGroup:insert(button)
    sceneGroup:insert(buttonText)

    button:addEventListener("tap", changeScenes)
end
 
 
-- show()
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is still off screen (but is about to come on screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs when the scene is entirely on screen
 
    end
end
 
 
-- hide()
function scene:hide( event )
 
    local sceneGroup = self.view
    local phase = event.phase
 
    if ( phase == "will" ) then
        -- Code here runs when the scene is on screen (but is about to go off screen)
 
    elseif ( phase == "did" ) then
        -- Code here runs immediately after the scene goes entirely off screen
 
    end
end
 
 
-- destroy()
function scene:destroy( event )
 
    local sceneGroup = self.view
    -- Code here runs prior to the removal of scene's view
    
end
 
 
-- -----------------------------------------------------------------------------------
-- Scene event function listeners
-- -----------------------------------------------------------------------------------
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------
 
return scene