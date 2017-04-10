//
//  GameScene.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 2/22/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import SpriteKit
import GameplayKit

var enemyNum = 1
var victory = false

class GameScene: SKScene, SKPhysicsContactDelegate {
    let rowsOfEnemies = 3
    var enemies:[Enemy] = []
    var enemiesAlive = 0
    
    
    let player:Player = Player()
    var touched = false
    var touchLocation = CGPoint.zero
    enum Directions {
        case None, Left, Right
    }
    var direction = Directions.None
    var enemyDirection = Directions.Left
    var fire = false
    var firing = false
    
    override func didMove(to view: SKView) {
        
        //physicsworld exists to hold the player inside the screen and check if bullet has reached edge of screen
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.name = "world"
        borderBody.friction = 0.0
        borderBody.restitution = 1.0
        borderBody.categoryBitMask = 0x0000F000
        self.physicsBody = borderBody
        
        backgroundColor = SKColor.black
        
        setupPlayer()
        
        setupEnemies()
        
        setupButtons()
        
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        //if an enemy collides with the side of the screen or another enemy, change enemy's direction
       
        if (contact.bodyA.node?.name == "world" &&
            contact.bodyB.node?.name == "enemy") ||
            (contact.bodyA.node?.name == "enemy" &&
                contact.bodyB.node?.name == "world"){
                enemyDirection = (enemyDirection == .Left ? .Right : .Left)
        }
        
        if contact.bodyA.node?.name == "playerLaser" {
            contact.bodyA.node?.removeFromParent()
            firing = false
            if contact.bodyB.node?.name == "enemy" {
                contact.bodyB.node?.removeFromParent()
                enemiesAlive -= 1
            }
        }
        else if contact.bodyB.node?.name == "playerLaser" {
            contact.bodyB.node?.removeFromParent()
            firing = false
            if contact.bodyA.node?.name == "enemy" {
                contact.bodyA.node?.removeFromParent()
                enemiesAlive -= 1
            }
        }
        if (enemiesAlive <= 0) {
            victory = true
            let gameOverScene = GameOverScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(gameOverScene, transition: fade)
        }
        
        
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = true
        for touch in touches {
            touchLocation = touch.location(in: self)
            let touchedNode = self.atPoint(touchLocation)
            if(touchedNode.name == "rightBtn"){
                direction = .Right
            }
            else if(touchedNode.name == "leftBtn"){
                direction = .Left
            }
            else {
                direction = .None
            }
            
            if (touchedNode.name == "fireBtn"){
                if !firing {
                    fire = true
                }
            }
            
            if (touchedNode.name == "menuBtn") {
                let startGameScene = StartGameScene(size: size)
                startGameScene.scaleMode = scaleMode
                let fade = SKTransition.fade(withDuration: 0.5)
                view?.presentScene(startGameScene, transition: fade)
            }
        }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            touchLocation = touch.location(in: self)
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        touched = false
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        if (touched) {
            movePlayer(direction)
        }
        if (fire && !firing) {
            fireLaser(from: player)
            firing = true
        }
        moveEnemies(enemyDirection)
    }
    
    func setupButtons() {
        let menuBtn = SKSpriteNode(imageNamed: "menuBtn")
        menuBtn.position = CGPoint(x: 70, y: size.height-30)
        menuBtn.name = "menuBtn"
        menuBtn.scale(to: CGSize(width: 120, height: 40))
        addChild(menuBtn)
        
        let leftBtn = SKSpriteNode(imageNamed: "leftBtn")
        leftBtn.position = CGPoint(x: 50, y: 50)
        leftBtn.name = "leftBtn"
        leftBtn.scale(to: CGSize(width: 60, height: 60))
        addChild(leftBtn)
        
        let rightBtn = SKSpriteNode(imageNamed: "rightBtn")
        rightBtn.position = CGPoint(x: 120, y: 50)
        rightBtn.name = "rightBtn"
        rightBtn.scale(to: CGSize(width: 60, height: 60))
        addChild(rightBtn)
        
        let fireBtn = SKSpriteNode(imageNamed: "fireBtn")
        fireBtn.position = CGPoint(x: size.width - 50, y: 50)
        fireBtn.name = "fireBtn"
        fireBtn.scale(to: CGSize(width: 60, height: 60))
        addChild(fireBtn)
    }
    
    func setupPlayer() {
        player.position = CGPoint(x: size.width/2, y: 125)
        player.physicsBody = SKPhysicsBody(circleOfRadius: player.size.width / 2)
        player.physicsBody?.categoryBitMask = 0x0000000F
        addChild(player)
    }
    
    func setupEnemies(){
        var enemyRow = 0;
        var enemyColumn = 0;
        let numberOfEnemies = enemyNum * 2 + 1
        var i = 1
        while i <= rowsOfEnemies {
            enemyRow = i
            var j = 1
            while j <= numberOfEnemies {
                enemyColumn = j
                let tempEnemy:Enemy = Enemy()
                let halfWidth:CGFloat = tempEnemy.size.width/2
                let xPositionStart:CGFloat = size.width/2 - halfWidth - tempEnemy.size.width + CGFloat(35)
                tempEnemy.position = CGPoint(x:xPositionStart + ((tempEnemy.size.width+CGFloat(10))*(CGFloat(j-1))), y:CGFloat(size.height - CGFloat(100 + 50 * i)))
                tempEnemy.enemyRow = enemyRow
                tempEnemy.enemyColumn = enemyColumn
                tempEnemy.physicsBody = SKPhysicsBody(circleOfRadius: tempEnemy.size.width / 2)
                tempEnemy.physicsBody!.collisionBitMask = 0x0000F0FF
                tempEnemy.physicsBody!.contactTestBitMask = tempEnemy.physicsBody!.collisionBitMask
                tempEnemy.physicsBody?.categoryBitMask = 0x000000F0
                addChild(tempEnemy)
                enemies.append(tempEnemy)
                enemiesAlive += 1
                j += 1
            }
            i += 1
        }
        
    }
    
    func movePlayer (_ dir: Directions) {
        switch (dir) {
        case .Left:
                player.run(SKAction.move(to: CGPoint(x: player.position.x - 10, y: player.position.y),  duration: 0.05))
            break
        case .Right:
                player.run(SKAction.move(to: CGPoint(x: player.position.x + 10, y: player.position.y),  duration: 0.05))
            break
        case .None:
            //do nothing
            break
        }
    }
    
    func moveEnemies(_ dir: Directions) {
        for enemy in enemies {
            switch (dir) {
            case .Left:
                enemy.run(SKAction.move(to: CGPoint(x: enemy.position.x - 10, y: enemy.position.y),  duration: 0.05))
                break
            case .Right:
                enemy.run(SKAction.move(to: CGPoint(x: enemy.position.x + 10, y: enemy.position.y),  duration: 0.05))
                break
            case .None:
                //do nothing. Should never occur in this function
                break
            }
        }
        
    }
    
    func fireLaser (from: SKSpriteNode) {
        let laser = Laser(imageName: "laser", laserSound: (sound ? "laserBlast.wav" : nil))
        laser.position = CGPoint(x: from.position.x, y: from.position.y + 100)
        laser.name = (from is Player ? "playerLaser" : "enemyLaser") // in case I eventually give the enemies the ability to shoot
        laser.physicsBody = SKPhysicsBody(rectangleOf: CGSize(width: laser.size.width, height: laser.size.height))
        laser.physicsBody?.categoryBitMask = 0x00000F00
        laser.physicsBody!.collisionBitMask = 0x0000F0FF
        laser.physicsBody!.contactTestBitMask = laser.physicsBody!.collisionBitMask
        addChild(laser)
        fire = false
        laser.run(SKAction.move(by: CGVector(dx: 0, dy: size.height), duration: 2))
    }
    
    func kill (enemy: SKNode) {
        enemy.removeFromParent()
        enemies.removeLast()
        if (enemies.isEmpty) {
            victory = true
            let gameOverScene = GameOverScene(size: size)
            gameOverScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(gameOverScene, transition: fade)
        }
    }
}
