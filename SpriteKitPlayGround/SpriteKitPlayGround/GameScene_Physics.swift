//
//  GameScene+Physics.swift
//  SpriteKitPlayGround
//
//  Created by Родыгин Дмитрий on 01.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    func didBeginContact(contact: SKPhysicsContact) {
        
        if contact.bodyA.categoryBitMask == objectGroup || contact.bodyB.categoryBitMask == objectGroup {
            hero.physicsBody?.velocity = CGVector(dx: 0, dy: 0)
            
            animations.shakeAndFlashAnimation(self.view!)
            
            if sound == true {
                runAction(electricGateDeadPreload)
            }
            
            hero.physicsBody?.allowsRotation = false
            
            heroEmmierObject.removeAllChildren()
            coinObject.removeAllChildren()
            redCoinObject.removeAllChildren()
            //groundObject.removeAllChildren()
            movingObject.removeAllChildren()
            
            stopGameObject()
            
            timerAddCoin.invalidate()
            timerAddRedCoin.invalidate()
            timerAddElectricGate.invalidate()
            
            heroDeathTexturesArray = [SKTexture(imageNamed: "Dead0.png"), SKTexture(imageNamed: "Dead1.png"), SKTexture(imageNamed: "Dead2.png"), SKTexture(imageNamed: "Dead3.png"), SKTexture(imageNamed: "Dead4.png"), SKTexture(imageNamed: "Dead5.png"), SKTexture(imageNamed: "Dead6.png")]
            
            let heroDeadAnimation = SKAction.animateWithTextures(heroDeathTexturesArray, timePerFrame: 0.02)
            hero.runAction(heroDeadAnimation)
            
            
            self.scene?.paused = true
            self.heroObject.removeAllChildren()
            
            self.gameViewControllerBridge.reloadGameBtn?.hidden = false
        }
        
        if contact.bodyA.categoryBitMask == groundGroup || contact.bodyB.categoryBitMask == groundGroup {
            
            heroEmmiter.hidden = true
            
            heroRunTexturesArray = [SKTexture(imageNamed: "Run0.png"), SKTexture(imageNamed: "Run1.png"), SKTexture(imageNamed: "Run2.png"), SKTexture(imageNamed: "Run3.png"), SKTexture(imageNamed: "Run4.png"), SKTexture(imageNamed: "Run5.png"), SKTexture(imageNamed: "Run6.png")]
            
            let heroRunAnimation = SKAction.animateWithTextures(heroRunTexturesArray, timePerFrame: 0.08)
            let heroRun = SKAction.repeatActionForever(heroRunAnimation)
            
            hero.runAction(heroRun)
        }
        
        if contact.bodyA.categoryBitMask == coinGroup || contact.bodyB.categoryBitMask == coinGroup {
            let coinNode = contact.bodyA.categoryBitMask == coinGroup ? contact.bodyA.node : contact.bodyB.node
            
            if sound == true {
                runAction(pickCoinPreload)
            }
            
            coinNode?.removeFromParent()
        }
        
        if contact.bodyA.categoryBitMask == redCoinGroup || contact.bodyB.categoryBitMask == redCoinGroup {
            let redCoinNode = contact.bodyA.categoryBitMask == redCoinGroup ? contact.bodyA.node : contact.bodyB.node
            
            if sound == true {
                runAction(pickCoinPreload)
            }
            
            redCoinNode?.removeFromParent()
        }
    }
}