//
//  GameScene.swift
//  Pong
//
//  Created by Salil Punalekar on 8/10/20.
//  Copyright © 2020 Salil Punalekar. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    // initialization of all variables and declaring them as SKSpriteNode()
    
    var ball = SKSpriteNode()
    var enemy = SKSpriteNode()
    var main = SKSpriteNode()
    
    var topLbl = SKLabelNode()
    var btmLbl = SKLabelNode()
    
    var score = [Int]()
    
    var enemyGameOver = SKLabelNode()
    var gameOver = SKLabelNode()
    var enemyWin = SKLabelNode()
    var mainWin = SKLabelNode()
    
    
    var divider = SKLabelNode()
    
    
    

    override func didMove(to view: SKView) {
        
       
        
        
        
        
        divider = self.childNode(withName: "dividerLabel") as! SKLabelNode
 
        enemyGameOver = self.childNode(withName: "enemyGameOverLabel") as! SKLabelNode
        gameOver = self.childNode(withName: "gameOverLabel") as! SKLabelNode
        enemyWin = self.childNode(withName: "enemyWon") as! SKLabelNode
        mainWin = self.childNode(withName: "mainWon") as! SKLabelNode
        
        
        
        topLbl = self.childNode(withName: "topLabel") as! SKLabelNode
        btmLbl = self.childNode(withName: "btmLabel") as! SKLabelNode
        
        ball = self.childNode(withName: "ball") as! SKSpriteNode
        
        enemy = self.childNode(withName: "enemy") as! SKSpriteNode
        // places the paddles in frame for varying screen sizes
        enemy.position.y = (self.frame.height / 2) - 100
        
       
        
        
        main = self.childNode(withName: "main") as! SKSpriteNode
        // places the paddles in frame for varying screen sizes
        main.position.y = (-self.frame.height / 2 ) + 100
        
        
        // speed and direction of ball - launches the ball at a 45 degree angle
        // the ball size changed in the secong iteration, and the x and y values were halved because the ball speed was very high
         //CGvector of 20,20 results in a downward motion towards main paddle
        
        // adds a border to the scene
        let border = SKPhysicsBody(edgeLoopFrom: self.frame)
        border.friction = 0
        border.restitution = 1 // the ball has to bounce all around off the wall
        
        // applying border to scene
        self.physicsBody = border
        
        startGame()
        
    }
    
    // resets score at the start of the game - score[0] = player score & score[1] = enemy score
    func startGame(){
        
        
        
        score = [0,0]
        
//        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
//
//        enemyInstructionBox.run(disappearAnimation())
//        enemyInstructionLbl.run(disappearAnimation())
//        firstEnemyInstruction.run(disappearAnimation())
//        secondEnemyInstruction.run(disappearAnimation())
//
//        mainInstructionBox.run(disappearAnimation())
//        mainInstructionLbl.run(disappearAnimation())
//        firstMainInstruction.run(disappearAnimation())
//        secondMainInstruction.run(disappearAnimation())
//
//        ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
        
        
        
        
        
        
        //changes the score on each label, based on the placeholder in the array 'score'
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 13, dy:13))
        
    }
    
    // this function is called based on the Y coordinates of the ball and the paddle
    // it is called in the Update function
    func addScore(playerWhoWon : SKSpriteNode ){
        
        
        
        //prevents the impulse from being applied infinitely
        ball.position = CGPoint(x: -50, y: 0) //places the ball in the center of the screen
        ball.physicsBody?.velocity = CGVector(dx: 0, dy: 0) // resets the impulsese that the ball already has
        
        // checks which player won, and incremenets their score by one point
        if playerWhoWon == main{
            
            
            
            if score[0] >= 20{
                ball.position = CGPoint(x: 0, y: 0)
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
                ball.isHidden = true
                
                gameOver.text = "GAME OVER!"
                mainWin.text = "WINNER"
                mainWin.run(blinkAnimation())
                enemyWin.text = "LOSER"
                enemyGameOver.text = "GAME OVER!"
                
                divider.text = " "
            }
            else{
                
                score[0] += 1
                // restarts the balls position - gives the ball to the player who won the point
                //ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                
                do{ sleep(1/2)}
                
                if score[0] >= 5 || score[1] >= 5{
                    ball.physicsBody?.applyImpulse(CGVector(dx: 20, dy: 20))
                }
                
                else{
                    ball.physicsBody?.applyImpulse(CGVector(dx: 13, dy: 13))
                }
                
                
                
            }
            
        }
        else if playerWhoWon == enemy{
            
            
            if score[1] >= 20{
                
                
                ball.position = CGPoint(x: 0, y: 0)
                ball.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 0))
                main.position = CGPoint(x: 0, y: -500)
                ball.isHidden = true
                
                gameOver.text = "GAME OVER!"
                enemyWin.text = "WINNER"
                enemyWin.run(blinkAnimation())
                mainWin.text = "LOSER"
                enemyGameOver.text = "GAME OVER!"
                
                divider.text = " "
                
                
                
                
                
                
            }
            else{
                
                score[1] += 1
                // restarts the balls position - gives the ball to the player who won the point
                //ball.physicsBody?.applyImpulse(CGVector(dx: 10, dy: 10))
                
                if score[0] >= 5 || score[1] >= 5{
                    ball.physicsBody?.applyImpulse(CGVector(dx: -20, dy: -20))
                }
                
                else{
                    ball.physicsBody?.applyImpulse(CGVector(dx: -13, dy: -13))
                }
                
            }
            
        }
        
        //displays the score on the labels
        topLbl.text = "\(score[1])"
        btmLbl.text = "\(score[0])"
    
    }
    
   
    

    
    // when the person simply taps the screen
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // takes one of the touches when the screen is clicked
        for touch in touches{
            
            
            // pinpoints one of the touches in all of them
            let location = touch.location(in: self)
            
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    // moves the paddle across the horizontal axis based on the location of the finger with a delay of 0.2 seconds
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0{
                    // moves the paddle across the horizontal axis based on the location of the finger with a delay of 0.2 seconds
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
        }
        
    }
    
    // when the person is dragging their finger
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        // pinpoints one of the touches in all of them
        for touch in touches{
            let location = touch.location(in: self)
            
            if currentGameType == .player2 {
                if location.y > 0 {
                    // moves the paddle across the horizontal axis based on the location of the finger with a delay of 0.2 seconds
                    enemy.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
                if location.y < 0{
                    // moves the paddle across the horizontal axis based on the location of the finger with a delay of 0.2 seconds
                    main.run(SKAction.moveTo(x: location.x, duration: 0.2))
                }
            }
            
            else {
                main.run(SKAction.moveTo(x: location.x, duration: 0.2))
            }
            
            
        
            
        }
        
    }
    
    func blinkAnimation() -> SKAction{
        
        let duration = 0.4
        let fadeOut = SKAction.fadeAlpha(to: 0.0, duration: duration)
        let fadeIn = SKAction.fadeAlpha(to: 1.0, duration: duration)
        let blink = SKAction.sequence([fadeOut,fadeIn])
        return SKAction.repeatForever(blink)
        
        
    }
    
    
        
    
    override func update(_ currentTime: TimeInterval) {
        
        
        switch currentGameType{
        case .easy:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.8))
            break
        case .medium:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.4))
            break
        case .hard:
            enemy.run(SKAction.moveTo(x: ball.position.x, duration: 0.2))
            break
        case .player2:
            
                
            
            break
        }

        // code for the enemy paddle
        // the enemy paddle follows the ball's x position, and essentially follows it with a delay of 1 second
        // this delay can be changed to make the enemy a more challenging player
        //enemy.run(SKAction.moveTo(x: ball.position.x, duration: 1.0))
        
        // checks if the ball's y coordinate is 70 points lower than the y poisiton of the main paddle - adds score to enemy count
        // second iteration: due to varying screen sizes the value was changed to 30 to nail it every time
        if ball.position.y <= main.position.y - 30{
            
            addScore(playerWhoWon: enemy) // the enemy won
            
        }
    
        // checks if the ball's y coordinate is 70 points highet than the y poisiton of the enemy paddle - adds score to main count
        // second iteration: due to varying screen sizes the value was changed to 30 to nail it every time
        else if ball.position.y >= enemy.position.y + 30{
            
            addScore(playerWhoWon: main) // the player won
            
        }

    }
}
