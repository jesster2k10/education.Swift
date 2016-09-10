//
//  GameScene.swift
//  zRacing
//
//  Created by Родыгин Дмитрий on 05.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //Variables
    var gameViewControllerBridge: GameViewController!
    
    var planet = SKShapeNode()
    
    //Tile Map
    var tileMap = JSTileMap(named: "map2.tmx")
    var myLocation = CGPointMake(0, 0)
    var x = CGFloat(0)
    
    //Textures
    var mapTexture = SKTexture()
    var carTexture = SKTexture()
    var wheel1Texture = SKTexture()
    var wheel2Texture = SKTexture()
    
    //Nodes
    //var sceneNode = SKNode()
    var carNode = SKNode()
    
    //Sprites
    var map = SKSpriteNode()
    var car = SKSpriteNode()
    var wheel1 = SKSpriteNode()
    var wheel2 = SKSpriteNode()
    var suspension1 = SKSpriteNode()
    var suspension2 = SKSpriteNode()
    
    //Camera
    let cam = SKCameraNode()
    
    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0, 0) //Earth gravity (0, -9.8)
        self.physicsWorld.speed = 0.8
        self.anchorPoint = CGPoint(x: 0, y: 0)
        self.position = CGPoint(x: 0, y: 0)
        self.camera = cam
        
        createGame()
    }
    
    func createGame() {
        self.addChild(carNode)
        //self.addChild(sceneNode)

        loadMap()
        createCar()
        addJoint()
    }
    
    func loadMap() {
//        mapTexture = SKTexture(imageNamed: "map_01")
//        map = SKSpriteNode(texture: mapTexture)
//        map.position = CGPointMake(0 + map.frame.size.width/4 , 0 + self.frame.size.height/4)
//        map.physicsBody = SKPhysicsBody(texture: mapTexture, size: mapTexture.size())
//        
//        map.physicsBody?.dynamic = false
//        
//        map.zPosition = 0
//        
//        sceneNode.addChild(map)
        
//        let map = SKShapeNode(rectOfSize: CGSize(width: self.frame.size.width*3, height: 50))
//        map.position = CGPointMake(-CGRectGetMidX(self.frame)/2, -self.frame.height/8)
//        map.physicsBody = SKPhysicsBody(rectangleOfSize: map.frame.size)
//        map.physicsBody?.dynamic = false
//        map.fillColor = SKColor.brownColor()
//        
//        sceneNode.addChild(map)
        
       // let road = self.childNodeWithName("road") as? SKSpriteNode
       // road?.physicsBody?.friction = 2
        tileMap.position = CGPoint(x: 0, y: 0)
        
        for var a=0; a < Int(tileMap.mapSize.width); a++ {
            for var b = 0; b < Int(tileMap.mapSize.height); b++ {
                let layerInfo: TMXLayerInfo = tileMap.layers.firstObject as! TMXLayerInfo
                let point = CGPoint(x: a, y: b)
                let gid = layerInfo.layer.tileGidAt(layerInfo.layer.pointForCoord(point))
                
                if gid == 9 || gid == 152 || gid == 104 || gid == 153 || gid == 21 || gid == 33 || gid == 129 {
                    let node = layerInfo.layer.tileAtCoord(point)
                    node.physicsBody = SKPhysicsBody(texture: node.texture!, size: node.size)
                    node.physicsBody?.dynamic = false
                }
            }
        }
        tileMap.physicsBody?.friction = 1
        
        //self.addChild(tileMap)
        
        var beizerPath4 = UIBezierPath()
        beizerPath4.moveToPoint(CGPoint(x: 0,y: 0))
        var theta : Float = 0.0
        
        for _ in 0...18 {
            let x = 1000 * cos((theta * Float(M_PI)) / -180)
            let y = 1000 * sin((theta * Float(M_PI)) / -180)
            
            beizerPath4.addQuadCurveToPoint(CGPoint(x: CGFloat(x),y: CGFloat(y)), controlPoint: CGPoint(x: CGFloat(x*1.1),y: CGFloat(y*1.1)))
            theta += 20
        }
        
        planet = SKShapeNode(path: beizerPath4.CGPath)
        planet.position = CGPointMake(0, 0)
        planet.physicsBody = SKPhysicsBody(edgeLoopFromPath: beizerPath4.CGPath)
        planet.physicsBody?.dynamic = false
        planet.fillColor = SKColor.greenColor()
        
        var fieldNode = SKFieldNode.radialGravityField()
        fieldNode.falloff = 1
        fieldNode.strength = 200
        
        planet.addChild(fieldNode)
        self.addChild(planet)
        
    }
    
    func createCar() {
        carTexture = SKTexture(imageNamed: "Body.png")
        car = SKSpriteNode(texture: carTexture)
        //car.position = CGPointMake(tileMap.position.x + 600, tileMap.position.y + 600)
        car.position = CGPointMake(0, planet.position.y + 1200)
        car.physicsBody = SKPhysicsBody(texture: carTexture, size: car.frame.size)
        car.physicsBody?.dynamic = true
        car.physicsBody?.mass = 3
        car.setScale(0.3)
        car.zPosition = 1
        
        //Roch Shok
        suspension1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 5, height: 5))
        suspension1.position = CGPointMake(car.position.x + car.size.width / 2 - 35, car.position.y - 60)
        suspension1.zPosition = 3
        suspension1.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        suspension1.physicsBody?.dynamic = true
        suspension1.physicsBody?.mass = 1
        
        suspension2 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 5, height: 5))
        suspension2.position = CGPointMake(car.position.x - car.size.width / 2 + 25, car.position.y - 60)
        suspension2.zPosition = 3
        suspension2.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        suspension2.physicsBody?.dynamic = true
        suspension2.physicsBody?.mass = 1
        
        wheel1Texture = SKTexture(imageNamed: "Wheel1")
        wheel2Texture = SKTexture(imageNamed: "Wheel2")
        wheel1 = SKSpriteNode(texture: wheel1Texture)
        wheel2 = SKSpriteNode(texture: wheel2Texture)
        wheel1.setScale(0.3)
        wheel2.setScale(0.3)
        wheel1.physicsBody = SKPhysicsBody(circleOfRadius: wheel1.size.width/2)
        wheel2.physicsBody = SKPhysicsBody(circleOfRadius: wheel2.size.width/2)
        wheel1.position = suspension1.position
        wheel2.position = suspension2.position
        wheel1.physicsBody?.allowsRotation = true
        wheel2.physicsBody?.allowsRotation = true
        wheel1.physicsBody?.dynamic = true
        wheel2.physicsBody?.dynamic = true
        wheel1.physicsBody?.friction = 1
        wheel2.physicsBody?.friction = 1
        //wheel1.physicsBody?.linearDamping = 1
        //wheel2.physicsBody?.linearDamping = 1
        wheel1.physicsBody?.mass = 2
        wheel2.physicsBody?.mass = 2
        
        //wheel1.physicsBody?.restitution = 1
        //wheel2.physicsBody?.restitution = 1
        //wheel1.physicsBody?.density = 3
        //wheel2.physicsBody?.density = 3
        wheel1.zPosition = 2
        wheel2.zPosition = 2
        
        carNode.addChild(car)
        carNode.addChild(suspension1)
        carNode.addChild(suspension2)
        carNode.addChild(wheel1)
        carNode.addChild(wheel2)
    }
    
    func addJoint() {
        //Wheel1
        let wheel1JointSliding = SKPhysicsJointSliding.jointWithBodyA(car.physicsBody!, bodyB: suspension1.physicsBody!, anchor: suspension1.position, axis: CGVectorMake(0,1))
        
        wheel1JointSliding.shouldEnableLimits = true
        wheel1JointSliding.lowerDistanceLimit = 5
        wheel1JointSliding.upperDistanceLimit = 20
        
        let wheel1JointSpring = SKPhysicsJointSpring.jointWithBodyA(car.physicsBody!, bodyB: wheel1.physicsBody!, anchorA: CGPointMake(wheel1.position.x + 20, wheel1.position.y + 20), anchorB: suspension1.position)
        
        wheel1JointSpring.damping = 1
        wheel1JointSpring.frequency = 4
        
        let wheel1JointPin = SKPhysicsJointPin.jointWithBodyA(suspension1.physicsBody!, bodyB: wheel1.physicsBody!, anchor: wheel1.position)
        
        //Wheel2
        let wheel2JointSliding = SKPhysicsJointSliding.jointWithBodyA(car.physicsBody!, bodyB: suspension2.physicsBody!, anchor: suspension2.position, axis: CGVectorMake(0, 1))
        
        wheel2JointSliding.shouldEnableLimits = true
        wheel2JointSliding.lowerDistanceLimit = 5
        wheel2JointSliding.upperDistanceLimit = 20
        
        let wheel2JointSpring = SKPhysicsJointSpring.jointWithBodyA(car.physicsBody!, bodyB: wheel2.physicsBody!, anchorA: CGPointMake(wheel2.position.x - 20, wheel2.position.y + 20), anchorB: suspension2.position)
        
        wheel2JointSpring.damping = 1
        wheel2JointSpring.frequency = 4
        
        let wheel2JointPin = SKPhysicsJointPin.jointWithBodyA(suspension2.physicsBody!, bodyB: wheel2.physicsBody!, anchor: wheel2.position)
        
        //Addjoints
        self.physicsWorld.addJoint(wheel1JointSliding)
        self.physicsWorld.addJoint(wheel1JointSpring)
        self.physicsWorld.addJoint(wheel1JointPin)
        
        self.physicsWorld.addJoint(wheel2JointSliding)
        self.physicsWorld.addJoint(wheel2JointSpring)
        self.physicsWorld.addJoint(wheel2JointPin)
        
    }
    
    override func didFinishUpdate() {
        let a = sqrt(pow(planet.position.x - car.position.x, 2) + pow(planet.position.y - car.position.y, 2))
        
        let angle = atan2(car.position.y, car.position.x) - 0.2
        
        let cx = (Float(a) * cosf(Float(angle)))
        let cy = (Float(a) * sinf(Float(angle)))
        
        let cx2 = (Float(a) * cosf(Float(angle)))
        let cy2 = (Float(a) * sinf(Float(angle)))
        
        let angle2 = atan2(CGFloat(cy2), CGFloat(cx2))
        
        cam.position = CGPoint(x: CGFloat(cx), y: CGFloat(cy))
        cam.zRotation = angle2
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if gameViewControllerBridge.gasButtonState {
            wheel2.physicsBody?.angularVelocity = -35
            wheel1.physicsBody?.angularVelocity = -35
        } else if gameViewControllerBridge.brakeButtonState {
            wheel2.physicsBody?.angularVelocity = 35
            wheel1.physicsBody?.angularVelocity = 35
        }
    }
    
    func reloadGame() {
        carNode.removeAllChildren()
        
        createCar()
        addJoint()
    }
}
