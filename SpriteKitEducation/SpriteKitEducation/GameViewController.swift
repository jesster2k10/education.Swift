//
//  GameViewController.swift
//  SpriteKitEducation
//
//  Created by Родыгин Дмитрий on 02.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    let scene = GameScene(fileNamed:"GameScene")
    
    override func viewDidLoad() {
        super.viewDidLoad()

            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = true
            skView.showsNodeCount = true
            skView.showsPhysics = true
            
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene?.scaleMode = .AspectFill
            
            skView.presentScene(scene)
                    
    }

    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override func prefersStatusBarHidden() -> Bool {
        return true
    }
    
    
    @IBAction func lButton(sender: UIButton) {
        scene!.circle.physicsBody?.applyImpulse(CGVector(dx: -50, dy: 200))
    }
    
    @IBAction func rButton(sender: UIButton) {
        scene!.circle.physicsBody?.applyImpulse(CGVector(dx: 50, dy: 200))
    }
}
