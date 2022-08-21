-- composer init
local composer = require( "composer" )
local scene = composer.newScene()


-- init 
local w = display.contentWidth
local h = display.contentHeight
local bg = display.setDefault( "background", 0, 0, 0 )

local ballSpeed = 512
local ballVelocity = {}
ballVelocity.x = ballSpeed
ballVelocity.y = 0

local paddleSize = {}
paddleSize.x = 25
paddleSize.y = h/4

local paddleSpeed = 5.3
local upperBound = display.newRect( w/2, (h-h)+1, w, 5 )
local lowerBound = display.newRect( w/2 , h, w, 5 )
local playerScoreText 
local enemyScoreText
local playerPaddle = display.newRect( 30, h/2, paddleSize.x, paddleSize.y )
local enemyPaddle = display.newRect( w - 30, h/2, paddleSize.x, paddleSize.y )
local ball = display.newCircle( w/2, h/2, 25 )
local playerScore = 0
local enemyScore = 0




local phys = require( "physics" )
local math = require( "math" )

physics.start()
physics.setGravity(0, 0)
physics.addBody( playerPaddle, "static" )
physics.addBody( enemyPaddle, "static" )
physics.addBody( upperBound, "static" )
physics.addBody( lowerBound, "static" )
physics.addBody( ball, "dynamic", {bounce = 0.8} )


function scene:create( event )

    local sceneGroup = self.view

    upperBound:setFillColor( 0, 0, 0 )
    lowerBound:setFillColor( 0, 0, 0 )

    playerScore = 0
    enemyScore = 0

    playerScoreText = display.newText(tostring(playerScore), w/2 - w/4, h/6, "munro.ttf", 150)
    enemyScoreText = display.newText(tostring(enemyScore), w/2 + w/4, h/6 , "munro.ttf", 150)

    sceneGroup:insert(upperBound)
    sceneGroup:insert(lowerBound)
    sceneGroup:insert(playerScoreText)
    sceneGroup:insert(enemyScoreText)
    sceneGroup:insert(playerPaddle)
    sceneGroup:insert(enemyPaddle)
    sceneGroup:insert(ball)

    

end



-- GAME FUNCTIONS --------------------------------------------------------------------
local function setBall ( event )
    local phase = event.phase
    local dir = nil

    if (phase == "began") then
        if (event.other == upperBound) then
            dir = 1 
        elseif (event.other == lowerBound) then
            dir = -1 
        else    
            dir = math.random(-1, 1)
            if (dir == 0) then dir = 1 end
        end
    if (event.other == playerPaddle or event.other == enemyPaddle) then
        ballVelocity.x = -ballVelocity.x    
    end
    
    ballVelocity.y = ballSpeed * dir
    ballSpeed = ballSpeed + 30
    end
end


local function moveBall()
    ball:setLinearVelocity( ballVelocity.x, ballVelocity.y )
end


local function movePlayer( event )
    local phase = event.phase 
    if (phase == "moved") then
        playerPaddle.y = event.y
    end
end


local function moveEnemy()    
    local dist = ball.y - enemyPaddle.y
    local move = 0
    if (dist > 0) then
        move = paddleSpeed * math.min(dist, paddleSpeed/2)
    elseif (dist < 0) then
        move = -(paddleSpeed * math.min(-dist, paddleSpeed/2))
    end
    enemyPaddle.y = enemyPaddle.y + move
end


local function resetBall()
    ballSpeed = 512
    ballVelocity.y = 0
    ball.x = w/2
    ball.y = h/2
end


local function drawScore()
    playerScoreText.text = tostring(playerScore)
    enemyScoreText.text = tostring(enemyScore)
end


local function ballCheck()
    if (ball.x < playerPaddle.x) then
        enemyScore = enemyScore + 1
        drawScore()
        resetBall()
    elseif (ball.x > enemyPaddle.x) then
        playerScore = playerScore + 1
        drawScore()
        resetBall()
    end
end


local function stopBall()
    physics.removeBody(ball)
    Runtime:removeEventListener("lateUpdate", moveBall)
end


local function startBall()
    physics.addBody( ball, "dynamic", {bounce = 0.8} )
    Runtime:addEventListener( "lateUpdate", moveBall )
end


local function gameCheck()
    if (playerScore == 5) then
        playerScore = 0
        enemyScore = 0
        composer.gotoScene("win", {effect = "fade", time = 500})
        stopBall()

    elseif (enemyScore == 5) then
        playerScore = 0
        enemyScore = 0
        composer.gotoScene("lose", {effect = "fade", time = 500})
        stopBall()
    end
end



-- SCENE FUNCTIONS ------------------------------------------------------------------------------


    
function scene:show( event )
 
    local sceneGroup = self.view
    local phase = event.phase
     
    if ( phase == "will" ) then
        playerScore = 0
        enemyScore = 0
        playerScoreText.text = tostring(playerScore)
        enemyScoreText.text = tostring(enemyScore)

    elseif ( phase == "did" ) then
        startBall()
    end
end


-- main loop event listeners 
ball:addEventListener( "collision", setBall )
Runtime:addEventListener( "touch", movePlayer )
Runtime:addEventListener( "lateUpdate", moveEnemy )
Runtime:addEventListener( "lateUpdate", ballCheck )
Runtime:addEventListener( "lateUpdate", gameCheck)
scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
return scene
