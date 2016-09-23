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
    @IBAction func gasButton(_ sender: UIButton){
        gasButtonState = true
    }
    
    @IBAction func brakeButton(_ sender: UIButton){
        brakeButtonState = true
    }
    
    @IBAction func gasButtonUp(_ sender: UIButton) {
        gasButtonState = false
    }
    @IBAction func brakeButtonUp(_ sender: UIButton) {
        brakeButtonState = false
    }
    
    @IBAction func reloadButton(_ sender: UIButton) {
        scene?.reloadGame()
    }
    
    @IBAction func camScale(_ sender: UIButton) {
        scene?.cam.xScale += 5
        scene?.cam.yScale += 5
        print("cam scale + 5")
    }
}
