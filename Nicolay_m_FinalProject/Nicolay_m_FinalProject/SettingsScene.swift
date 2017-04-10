//
//  SettingsScene.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/8/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit



class SettingsScene: SKScene {

    var musVol:SKLabelNode!
    var sfxState:SKLabelNode!
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.black
        let title = SKLabelNode (text: "Settings")
        title.position = CGPoint(x: size.width/2, y: size.height - 100)
        title.name = "title"
        addChild(title)
        
        let menuBtn = SKSpriteNode(imageNamed: "menuBtn")
        menuBtn.position = CGPoint(x: 70, y: size.height-30)
        menuBtn.name = "menuBtn"
        menuBtn.scale(to: CGSize(width: 120, height: 40))
        addChild(menuBtn)
        
        let musLabel = SKLabelNode(text: "Music Volume:")
        musLabel.position = CGPoint(x: size.width/2 - 100, y: size.height/2 - 10)
        musLabel.name = "musLabel"
        addChild(musLabel)
        
        let musDown = SKSpriteNode(imageNamed: "minusBtn")
        musDown.position = CGPoint(x:size.width/2 + 50, y: size.height/2)
        musDown.name = "musDown"
        musDown.scale(to: CGSize(width: 50, height: 50))
        addChild(musDown)
        
        musVol = SKLabelNode(text: String(format: "%.0f", musicPlayer.volume * 10))
        musVol.position = CGPoint(x: size.width/2 + 100, y:size.height/2 - 10)
        musVol.name = "musVol"
        addChild(musVol)
        
        let musUp = SKSpriteNode(imageNamed: "plusBtn")
        musUp.position = CGPoint(x:size.width/2 + 150, y: size.height/2)
        musUp.name = "musUp"
        musUp.scale(to: CGSize(width: 50, height: 50))
        addChild(musUp)
        
        let sfxLabel = SKLabelNode(text: "Sound Effects: ")
        sfxLabel.position = CGPoint(x: size.width/2 - 100, y: size.height/2 + 90)
        sfxLabel.name = "sfxLabel"
        addChild(sfxLabel)
        
        let sfxOff = SKSpriteNode(imageNamed: "offBtn")
        sfxOff.position = CGPoint(x:size.width/2 + 50, y: size.height/2 + 100)
        sfxOff.name = "sfxOff"
        sfxOff.scale(to: CGSize(width: 50, height: 50))
        addChild(sfxOff)
        
        sfxState = SKLabelNode(text: (sound ? "On" : "Off"))
        sfxState.position = CGPoint(x:size.width/2 + 100, y: size.height/2 + 90)
        sfxState.name = "sfxState"
        addChild(sfxState)
        
        let sfxOn = SKSpriteNode(imageNamed: "onBtn")
        sfxOn.position = CGPoint(x:size.width/2 + 150, y: size.height/2 + 100)
        sfxOn.name = "sfxOn"
        sfxOn.scale(to: CGSize(width: 50, height: 50))
        addChild(sfxOn)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch!
        let touchLocation = touch?.location(in: self)
        let touchedNode = self.atPoint(touchLocation!)
        if(touchedNode.name == "menuBtn"){
            let startGameScene = StartGameScene(size: size)
            startGameScene.scaleMode = scaleMode
            let fade = SKTransition.fade(withDuration: 0.5)
            view?.presentScene(startGameScene, transition: fade)
        }
        else if(touchedNode.name == "musUp"){
            if (musicPlayer.volume < 1) {
                musicPlayer.volume += 0.1
                musVol.text = String(format: "%.0f", musicPlayer.volume * 10)
            }
        }
        else if(touchedNode.name == "musDown"){
            if (musicPlayer.volume > 0.1) {
                musicPlayer.volume -= 0.1
                musVol.text = String(format: "%.0f", musicPlayer.volume * 10)
            }
            else {
                // when music player volume goes below 0.1, it goes to lower bound of float instead of 0
                // so this deals with displaying 0
                musicPlayer.volume -= 0.1
                musVol.text = "0"
            }
            
        }
        else if(touchedNode.name == "sfxOff"){
            sound = false
            sfxState.text = "Off"
        }
        else if(touchedNode.name == "sfxOn"){
            sound = true
            sfxState.text = "On"
        }
        
        
            
    }
}
