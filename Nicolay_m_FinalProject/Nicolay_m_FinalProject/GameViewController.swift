//
//  GameViewController.swift
//  Nicolay_m_FinalProject
//
//  Created by Nicolay, Matthew on 2/22/17.
//  Copyright © 2017 DePaul University. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit
import AVFoundation

class GameViewController: UIViewController {
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        let scene = StartGameScene(size: view.bounds.size)
        let skView = view as! SKView
//        skView.showsFPS = true // debugging purposes
//        skView.showsNodeCount = true // debugging purposes
        skView.ignoresSiblingOrder = true
        scene.scaleMode = .resizeFill
        skView.presentScene(scene)
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
