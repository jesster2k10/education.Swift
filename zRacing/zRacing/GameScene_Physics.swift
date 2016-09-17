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
        if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
            let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
            
            coinNode?.removeFromParent()
        }
    }
}
