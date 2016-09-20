//
//  GameScene_Touches.swift
//  SpriteKitPlayGround
//
//  Created by Родыгин Дмитрий on 01.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heroEmmiter.isHidden = false
        
        hero.physicsBody?.velocity = CGVector.zero
        hero.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 100))
        
        heroFlyTexturesArray = [SKTexture(imageNamed: "Fly0.png"), SKTexture(imageNamed: "Fly1.png"), SKTexture(imageNamed: "Fly2.png"), SKTexture(imageNamed: "Fly3.png"), SKTexture(imageNamed: "Fly4.png")]
        let heroFlyAnimation = SKAction.animate(with: heroFlyTexturesArray, timePerFrame: 0.08)
        let flyHero = SKAction.repeatForever(heroFlyAnimation)
        hero.run(flyHero)

    }
}
