//
//  StartGameScene.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/6/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

var sound = true

class StartGameScene: SKScene {
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        
        let title1 = SKLabelNode(text: "Battle Space Space Battle:")
        title1.position = CGPoint(x: size.width/2, y: size.height/2 + 150)
        title1.fontSize = 36
        title1.name = "title1"
        addChild(title1)
        let title2 = SKLabelNode(text: "in Space")
        title2.position = CGPoint(x: size.width/2, y: size.height/2 + 114)
        title2.fontSize = 36
        title2.name = "title2"
        addChild(title2)
        
        let startGameButton = SKSpriteNode(imageNamed: "startBtn")
        startGameButton.position = CGPoint(x: size.width/2, y: size.height/2 + 25)
        startGameButton.name = "startBtn"
        addChild(startGameButton)
        
        let settingsButton = SKSpriteNode(imageNamed: "settingsBtn")
        settingsButton.position = CGPoint(x: size.width/2, y: size.height/2 - 125)
        settingsButton.name =  "settingsBtn"
        addChild(settingsButton)
        
        let controlsButton = SKSpriteNode(imageNamed: "controlsBtn")
        controlsButton.position = CGPoint(x: size.width/2, y: size.height/2 - 275)
        controlsButton.name =  "controlsBtn"
        addChild(controlsButton)
        
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let touchedNode = self.atPoint(touchLocation!)
        if(touchedNode.name == "startBtn"){
            let gameScene = GameScene(size: size)
            gameScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(gameScene, transition: fade)
        }
        else if(touchedNode.name == "settingsBtn"){
            let settingsScene = SettingsScene(size: size)
            settingsScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(settingsScene, transition: fade)
        }
        else if(touchedNode.name == "controlsBtn"){
            let controlsScene = ControlsScene(size: size)
            controlsScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(controlsScene, transition: fade)
        }
    }
    
    
    
}
