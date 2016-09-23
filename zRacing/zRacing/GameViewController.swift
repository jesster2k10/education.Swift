//
//  GameViewController.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 05.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var loadingView: UIView!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var hightScoreLabel: UILabel!

    var scene = GameScene(fileNamed:"GameScene")
    var gasButtonState = false
    var brakeButtonState = false
    let textureAtlas = SKTextureAtlas(named: "texture.atlas")
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SwiftSpinner.show("Loading...", animated: true)
        loadingView.isHidden = false
    
        scene?.gameViewControllerBridge = self
        
        // Configure the view.
        let skView = self.view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        
        //skView.showsPhysics = true
        
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        
        /* Set the scale mode to scale to fit the window */
        scene!.scaleMode = .aspectFill
        
        textureAtlas.preload(completionHandler: {
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                self.loadingView.isHidden = true
                SwiftSpinner.hide()
                skView.presentScene(self.scene)
            })
        })
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        
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
