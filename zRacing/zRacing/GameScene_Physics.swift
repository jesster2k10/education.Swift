//
//  GameScene_Physics.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 15.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    
    @objc(didBeginContact:) func didBegin(_ contact: SKPhysicsContact) {
        
        var firstBody: SKPhysicsBody
        var secondBody: SKPhysicsBody
        
        UserDefaults.standard.set(highScore, forKey: "highScore")
        
        if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        } else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        
        if firstBody.categoryBitMask == carGroup && secondBody.categoryBitMask == coinGroup {
            if secondBody.node?.parent != nil {
                secondBody.node?.removeFromParent()
                score += 1
                updateScoreLabels()
            }
        }
        //else if firstBody.categoryBitMask == coinGroup && secondBody.categoryBitMask == carGroup {
        //    print("nope")
        //}
    }
}
