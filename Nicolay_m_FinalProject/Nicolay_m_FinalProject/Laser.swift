//
//  Laser.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 3/10/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit

class Laser: SKSpriteNode {
    
    //using super and subclassing in case I give the enemies the ability to shoot

    init(imageName: String, laserSound: String?) {
        let texture = SKTexture(imageNamed: imageName)
        super.init(texture: texture, color: SKColor.clear, size: CGSize(width: 5, height: 25))
        if(laserSound != nil){
            run(SKAction.playSoundFileNamed(laserSound!, waitForCompletion: false))
        }
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
