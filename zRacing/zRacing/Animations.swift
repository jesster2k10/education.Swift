//
//  Animations.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 16.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

class AnimationClass {
    
    func scaleZdirection(sprite: SKSpriteNode) {
        sprite.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.scaleBy(2.0, duration: 0.5), SKAction.scaleTo(1.0, duration: 1.0)])))
    }
    
    func redColorAnimation(sprite: SKSpriteNode, animDuration: NSTimeInterval) {
        sprite.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.colorizeWithColor(SKColor.redColor(), colorBlendFactor: 1.0, duration: animDuration), SKAction.colorizeWithColorBlendFactor(0.0, duration: animDuration)])))
    }
    
    func shakeAndFlashAnimation(view: SKView) {
        //While flash
        let aView = UIView(frame: view.frame)
        aView.backgroundColor = UIColor.whiteColor()
        view.addSubview(aView)
        
        UIView.animateWithDuration(0.5, delay: 0, options: .CurveEaseInOut, animations: {aView.alpha = 0.0 }, completion: {(done) in aView.removeFromSuperview()})
        
        //Shake animation
        let shake = CAKeyframeAnimation(keyPath: "transform")
        shake.values = [
            NSValue(CATransform3D: CATransform3DMakeTranslation(-15, 5, 5)),
            NSValue(CATransform3D: CATransform3DMakeTranslation(15, 5, 5))
        ]
        shake.autoreverses = true
        shake.repeatCount = 2
        shake.duration = 7/100
        view.layer.addAnimation(shake, forKey: nil)
    }
    
}