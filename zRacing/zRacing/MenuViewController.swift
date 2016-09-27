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
            
            navigationController?.pushViewController(gameViewController, animated: false)
        }
    }
    
    @IBAction func optionsMenuButton(sender: UIButton) {
        if let storyboard = storyboard {
            let optionsViewController = storyboard.instantiateViewController(withIdentifier: "OptionsViewController") as! OptionsViewController
            
            let transition = CATransition()
            transition.duration = 0.2
            transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
            transition.type = kCATransitionFade
            navigationController?.view.layer.add(transition, forKey: nil)
            
            navigationController?.pushViewController(optionsViewController, animated: false)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
