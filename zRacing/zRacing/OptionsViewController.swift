//
//  OptionsViewController.swift
//  zRacing
//
//  Created by zlobo on 27.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class OptionsViewController : UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func backButton(sender: UIButton) {
        let transition = CATransition()
        transition.duration = 0.2
        transition.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        transition.type = kCATransitionFade
        navigationController?.view.layer.add(transition, forKey: nil)
        
        _ = navigationController?.popViewController(animated: false)
        navigationController?.dismiss(animated: false, completion: nil)
    }
    
}
