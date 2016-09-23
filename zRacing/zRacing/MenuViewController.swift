//
//  MenuViewController.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 23.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class MenuViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    @IBAction func startGame(sender: UIButton) {
        if let storyboard = storyboard {
            let gameViewController = storyboard.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
            
            navigationController?.pushViewController(gameViewController, animated: true)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
