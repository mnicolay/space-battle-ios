//
//  GameOverScene.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/11/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit


class GameOverScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let title = SKLabelNode (text: (victory == true ? "You Win!" : "Game Over")) // if I eventually give enemies ability to shoot, player can die (game over instead of you win)
        title.fontSize = 100
        title.position = CGPoint(x: size.width/2, y: size.height/2 + 200)
        title.name = "title"
        addChild(title)
        
        
        let playAgainBtn = SKSpriteNode(imageNamed: "playAgainBtn")
        playAgainBtn.position = CGPoint(x: size.width/2, y: size.height/2)
        playAgainBtn.name = "playAgainBtn"
        addChild(playAgainBtn)
        
        let backToMenuBtn = SKSpriteNode(imageNamed: "backToMenuBtn")
        backToMenuBtn.position = CGPoint(x: size.width/2, y: size.height/2 - 150)
        backToMenuBtn.name = "backToMenuBtn"
        addChild(backToMenuBtn)
        victory = false
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let touchedNode = self.atPoint(touchLocation!)
        if(touchedNode.name == "playAgainBtn"){
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(gameScene, transition: fade)
        }
        else if(touchedNode.name == "backToMenuBtn"){
            let startGameScene = StartGameScene(size: size)
            startGameScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(startGameScene, transition: fade)
        }
    }
}
