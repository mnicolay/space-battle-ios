//
//  Player.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/8/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "player")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 80, height: 80))
        self.name = "player"
//        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
//    private func animate(){
//        var playerTextures:[SKTexture] = []
//        for i in 1...2 {
//            playerTextures.append(SKTexture(imageNamed: "player\(i)"))
//        }
//        let playerAnimation = SKAction.repeatActionForever( SKAction.animateWithTextures(playerTextures, timePerFrame: 0.1))
//        self.runAction(playerAnimation)
//    }
}
