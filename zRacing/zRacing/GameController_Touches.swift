//
//  GameController_Touches.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 05.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

extension GameViewController {    
    @IBAction func gasButton(sender: UIButton){
        gasButtonState = true
    }
    
    @IBAction func brakeButton(sender: UIButton){
        brakeButtonState = true
    }
    
    @IBAction func gasButtonUp(sender: UIButton) {
        gasButtonState = false
    }
    @IBAction func brakeButtonUp(sender: UIButton) {
        brakeButtonState = false
    }
    
    @IBAction func reloadButton(sender: UIButton) {
        scene?.reloadGame()
    }
    
    @IBAction func camScale(sender: UIButton) {
        scene?.cam.xScale += 5
        scene?.cam.yScale += 5
        print("cam scale + 5")
    }
}