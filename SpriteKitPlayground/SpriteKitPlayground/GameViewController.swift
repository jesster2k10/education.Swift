//
//  GameViewController.swift
//  SpriteKitPlayGround
//
//  Created by Родыгин Дмитрий on 01.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    var scene = GameScene(fileNamed:"GameScene")
    
    @IBOutlet weak var reloadGameBtn: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        reloadGameBtn?.hidden = true
        
        let skView = self.view as! SKView

        skView.ignoresSiblingOrder = true
        scene?.gameViewControllerBridge = self
        
        scene!.scaleMode = .AspectFill
        skView.presentScene(scene)
        skView.showsPhysics = true
        
    }
    
    @IBAction func reloadGameButton(sender: UIButton) {
        scene?.reloadGame()
        reloadGameBtn?.hidden = true
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
}
