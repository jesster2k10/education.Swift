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
        
        reloadGameBtn?.isHidden = true
        
        let skView = self.view as! SKView

        skView.ignoresSiblingOrder = true
        scene?.gameViewControllerBridge = self
        
        scene!.scaleMode = .aspectFill
        skView.presentScene(scene)
        skView.showsPhysics = true
        
    }
    
    @IBAction func reloadGameButton(_ sender: UIButton) {
        scene?.reloadGame()
        reloadGameBtn?.isHidden = true
    }

    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden : Bool {
        return true
    }
}
