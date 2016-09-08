//
//  GameScene.swift
//  SpriteKitEducation
//
//  Created by Родыгин Дмитрий on 02.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    let circle = SKShapeNode(circleOfRadius: 50)
    
    let cam = SKCameraNode()
    
    var tileMap = JSTileMap(named: "map.tmx")
    
    var MyLocation = CGPointMake(0, 0)
    var x = CGFloat(0)
    
    override func didMoveToView(view: SKView) {
        
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        
        tileMap.position = CGPoint(x: 0, y: 0)
        
        for var a=0; a < Int(tileMap.mapSize.width); a++ {
            for var b = 0; b < Int(tileMap.mapSize.height); b++ {
                let layerInfo: TMXLayerInfo = tileMap.layers.firstObject as! TMXLayerInfo
                let point = CGPoint(x: a, y: b)
                let gid = layerInfo.layer.tileGidAt(layerInfo.layer.pointForCoord(point))
                
                if  (gid >= 105 && gid <= 110) || gid == 88 || gid == 89 || gid == 95 || gid == 94{
                    let node = layerInfo.layer.tileAtCoord(point)
                    node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
                    node.physicsBody?.dynamic = false
                }
            }
        }
        
        self.addChild(tileMap)
        
        //self.physicsWorld.contactDelegate = self
        let borderBody = SKPhysicsBody(edgeLoopFromRect: self.frame)
        self.physicsBody = borderBody
        
        self.camera = cam
        
        circle.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        circle.physicsBody = SKPhysicsBody(circleOfRadius: 60)
        circle.lineWidth = 5
        circle.fillColor = SKColor.purpleColor()
        circle.zPosition = 1
        circle.physicsBody?.dynamic = true
        circle.physicsBody?.linearDamping = 1
        circle.physicsBody?.allowsRotation = true
        
        
        let ground = SKShapeNode(rectOfSize: CGSize(width: self.frame.size.width, height: 50))
        ground.position = CGPointMake(CGRectGetMidX(self.frame), ground.frame.size.height-25)
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.frame.size)
        ground.physicsBody?.dynamic = false
        ground.fillColor = SKColor.brownColor()
        ground.zPosition = 0
        
        let quad = SKShapeNode(rect: CGRectMake(-25, -25, 50, 50))
        quad.position = CGPointMake(CGRectGetMidX(self.frame) + 200, 300)
        quad.fillColor = SKColor.blackColor()
        quad.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: 60, height: 60))
        quad.physicsBody?.dynamic = true
        quad.zPosition = 1
        quad.physicsBody?.allowsRotation = true
        
        let triangePath = UIBezierPath()
        triangePath.moveToPoint(CGPointMake(0, 0))
        triangePath.addLineToPoint(CGPointMake(50, 100))
        triangePath.addLineToPoint(CGPointMake(100, 0))
        triangePath.addLineToPoint(CGPointMake(0, 0))
        
        let triangle = SKShapeNode(path: triangePath.CGPath)
        triangle.position = CGPointMake(CGRectGetMidX(self.frame) + 300, 300)
        triangle.fillColor = SKColor.redColor()
        triangle.physicsBody = SKPhysicsBody(polygonFromPath: triangePath.CGPath)
        triangle.physicsBody?.dynamic = true
        triangle.zPosition = 1
        
        
        self.backgroundColor = SKColor.orangeColor()
        
//        self.addChild(ground)
//        self.addChild(quad)
//        self.addChild(triangle)
        self.addChild(circle)
        
//        let myJointPin = SKPhysicsJointPin.jointWithBodyA(circle.physicsBody!, bodyB: quad.physicsBody!, anchor: circle.position)
//        let myJointLimit = SKPhysicsJointLimit.jointWithBodyA(circle.physicsBody!, bodyB: quad.physicsBody!, anchorA: circle.position, anchorB: quad.position)
//        let myJointSpring = SKPhysicsJointSpring.jointWithBodyA(circle.physicsBody!, bodyB: quad.physicsBody!, anchorA: circle.position, anchorB: quad.position)
//        self.physicsWorld.addJoint(myJointLimit)
    }

    override func didFinishUpdate() {
        cam.position = circle.position
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        circle.physicsBody?.velocity = CGVector.zero
        circle.physicsBody?.applyImpulse(CGVector(dx: 0, dy: 200))
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        MyLocation = CGPointMake(x, 60)
        tileMap.position = MyLocation
        
        x = x - 3
    }
}
