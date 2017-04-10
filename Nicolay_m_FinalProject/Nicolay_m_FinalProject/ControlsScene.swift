//
//  ControlScene.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/8/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class ControlsScene: SKScene, SKPhysicsContactDelegate {
    
    let player:Player = Player()
    var touched = false
    var touchLocation = CGPoint.zero
    enum Directions {
        case None, Left, Right
    }
    var direction = Directions.None
    var fire = false
    var firing = false
    
    //TODO
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        //physicsworld exists to hold the player inside the screen and check if bullet has reached edge of screen
        physicsWorld.gravity = CGVector(dx: 0.0, dy: 0.0)
        physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        self.name = "world"
        borderBody.friction = 0.0
        borderBody.restitution = 1.0
        borderBody.categoryBitMask = 0x0000F000
        self.physicsBody = borderBody
        
        let title = SKLabelNode (text: "Controls")
        title.position = CGPoint(x: size.width/2, y: size.height - 100)
        title.name = "title"
        addChild(title)
        
        let ex1 = "Use the arrows to move the ship"
        let ex2 = "left and right."
        let ex3 = "Press the fire button on the right"
        let ex4 = "hand side to shoot."
        let exLine1 = SKLabelNode(text: ex1)
        exLine1.position = CGPoint(x: size.width/2, y: size.height/2 + 48)
        exLine1.name = "explanation"
        exLine1.fontSize = 24
        addChild(exLine1)
        let exLine2 = SKLabelNode(text: ex2)
        exLine2.position = CGPoint(x: size.width/2, y: size.height/2 + 24)
        exLine2.name = "explanation"
        exLine2.fontSize = 24
        addChild(exLine2)
        let exLine3 = SKLabelNode(text: ex3)
        exLine3.position = CGPoint(x: size.width/2, y: size.height/2)
        exLine3.name = "explanation"
        exLine3.fontSize = 24
        addChild(exLine3)
        let exLine4 = SKLabelNode(text: ex4)
        exLine4.position = CGPoint(x: size.width/2, y: size.height/2 - 24)
        exLine4.name = "explanation"
        exLine4.fontSize = 24
        addChild(exLine4)
        
        
        setupPlayer()
        
        setupButtons()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "playerLaser" {
            contact.bodyA.node?.removeFromParent()
            firing = false
        }
        else if contact.bodyB.node?.name == "playerLaser" {
            contact.bodyB.node?.removeFromParent()
            firing = false
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
            print(touchedNode.name ?? "no name")
            if(touchedNode.name == "menuBtn"){
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
}
