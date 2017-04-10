//
//  Enemy.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/10/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode {
    var enemyRow = 0
    var enemyColumn = 0
    
    init() {
        let texture = SKTexture(imageNamed: "enemy")
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 60, height: 60))
        self.name = "enemy"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    
    func fireBullet(scene: SKScene){
        
    }
}
