local composer = require( "composer" )
local scene = composer.newScene()
 
local bg
local title
local button
local buttonText

local w = display.contentWidth
local h = display.contentHeight

local function changeScenes()
    composer.gotoScene("pong", {effect = "slideUp", time = 1500})
end


-- create()
function scene:create( event )
 
    local sceneGroup = self.view
    -- Code here runs when the scene is first created but has not yet appeared on screen
    
    -- magic number hell
    bg = display.setDefault( "background" , {0, 0, 0});

    title = display.newText( "You Win!", w/2 + 20, display.contentCenterY - 30, "munro.ttf", 180 )
    sceneGroup:insert( title )

    button = display.newRect( display.contentCenterX, display.contentCenterY + 300, w/2 , 200 )
    buttonText = display.newText("Play", display.contentCenterX, display.contentCenterY + 285, "munro.ttf", 135)
    buttonText:setFillColor(0, 0, 0)
    sceneGroup:insert(button)
    sceneGroup:insert(buttonText)

    button:addEventListener("tap", changeScenes)
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