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
    var coinsArray = [CGPoint]()
    var planetRadius = Float()
    
    //Beizer Path
    var beizerPath = UIBezierPath()
    
    //Tile Map
    var tileMap = JSTileMap(named: "map2.tmx")
    var myLocation = CGPointMake(0, 0)
    var x = CGFloat(0)
    
    //Textures
    var mapTexture = SKTexture()
    var carTexture = SKTexture()
    var wheel1Texture = SKTexture()
    var wheel2Texture = SKTexture()
    var coinTexture = SKTexture()
    
    //Nodes
    //var sceneNode = SKNode()
    var sceneNode = SKNode()
    var carNode = SKNode()
    
    //Sprites
    var map = SKSpriteNode()
    var car = SKSpriteNode()
    var wheel1 = SKSpriteNode()
    var wheel2 = SKSpriteNode()
    var suspension1 = SKSpriteNode()
    var suspension2 = SKSpriteNode()
    var coin = SKSpriteNode()
    
    //Emitters
    var wheelDirtEmitter = SKEmitterNode()
    
    //Shapes
    var planet = SKShapeNode()
    
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
        self.addChild(cam)
        self.addChild(carNode)
        self.addChild(sceneNode)
        
        cam.setScale(50)
        
        loadMap()
        addCoins()
        createCar()
        addJoint()
    }
    
    func loadMap() {
        // Tile Maps ------------------------------------------------
        /*tileMap.position = CGPoint(x: 0, y: 0)
        
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
        tileMap.physicsBody?.restitution = 0
        sceneNode.addChild(tileMap)
        //-------------------------------------------------------------
        */
        beizerPath.moveToPoint(CGPoint(x: 0,y: 0))
        coinsArray.removeAll()
        
        planetRadius = Float.random(2000, upper: 5000)
        var theta : Float = 9.0
        
        var ox = planetRadius * cos((Float(M_PI)) / 180)
        var oy = planetRadius * sin((Float(M_PI)) / 180)
        
        beizerPath.moveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)))
        
        for _ in 0...38 {
            var newRadius = Float.random(planetRadius, upper: planetRadius + planetRadius / 4)

            var x2 = newRadius * cos((theta * Float(M_PI)) / 180)
            var y2 = newRadius * sin((theta * Float(M_PI)) / 180)
            
            var x3 = newRadius * cos(((theta - 3.5) * Float(M_PI)) / 180)
            var y3 = newRadius * sin(((theta - 3.5) * Float(M_PI)) / 180)
            
            var x4 = newRadius * cos(((theta ) * Float(M_PI)) / 180)
            var y4 = newRadius * sin(((theta ) * Float(M_PI)) / 180)
            
            if theta == 360 {
                beizerPath.addQuadCurveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
            }
            else {
                if randomBool() {
                beizerPath.addQuadCurveToPoint(CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
                }
                else {
                beizerPath.addCurveToPoint(CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint1: CGPoint(x: CGFloat(x3),y: CGFloat(y3)), controlPoint2: CGPoint(x: CGFloat(x4),y: CGFloat(y4)))
                }
            }
            
            let coinCount = Int.random(0, upper: 3)
            var newTheta : Float = 3.0
            for _ in 0...coinCount {
                newRadius += Float.random(50, upper: 70)
                
                x3 = newRadius * cos(((theta - newTheta) * Float(M_PI)) / 180)
                y3 = newRadius * sin(((theta - newTheta) * Float(M_PI)) / 180)
                
                if randomBool() {
                coinsArray.append(CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
                }
                newTheta += 3
            }
            theta += 9
        }
        
        beizerPath.closePath()
        
        planet = SKShapeNode(path: beizerPath.CGPath)
        planet.position = CGPointMake(0, 0)
        planet.physicsBody = SKPhysicsBody(edgeLoopFromPath: beizerPath.CGPath)
        planet.physicsBody?.dynamic = false
        planet.fillColor = getRandomColor()
        planet.strokeColor = getRandomColor()
        planet.lineWidth = 7
        planet.glowWidth = 0.5
        
        let fieldNode = SKFieldNode.radialGravityField()
        fieldNode.position = planet.position
        
        //Gravity & Friction
        planet.physicsBody?.friction = 1.0
        fieldNode.falloff = 0.9
        fieldNode.strength = 200
        
        planet.addChild(fieldNode)
        sceneNode.addChild(planet)
 
    }
    
    func addCoins() {
        //let beizerPoints = beizerPath.CGPath.points()
        coinTexture = SKTexture(imageNamed: "coin.jpg")
        //To edit --------------
        for i in coinsArray {
            if !beizerPath.containsPoint(i) {
                coin = SKSpriteNode(texture: coinTexture)
                coin.setScale(0.15)
                coin.position = i
                planet.addChild(coin)
            }
        }
    }
    
    func createCar() {
        carTexture = SKTexture(imageNamed: "Body.png")
        car = SKSpriteNode(texture: carTexture)
        //car.position = CGPointMake(tileMap.position.x + 600, tileMap.position.y + 600)
        car.position = CGPointMake(600, planet.frame.maxY + car.frame.height + 100)
        car.physicsBody = SKPhysicsBody(texture: carTexture, size: car.frame.size)
        //car.physicsBody?.dynamic = true
        car.physicsBody?.mass = 0.1
        //car.physicsBody?.density = 0.1
        car.setScale(0.3)
        car.zPosition = 1
        //car.physicsBody?.restitution = 0
        
        //Roch Shok
        suspension1 = SKSpriteNode(color: SKColor.redColor(), size: CGSize(width: 5, height: 5))
        suspension1.position = CGPointMake(car.position.x + car.size.width / 2 - 35, car.position.y - 50)
        suspension1.zPosition = 3
        suspension1.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        suspension1.physicsBody?.dynamic = true
        suspension1.physicsBody?.mass = 0.1
        //suspension1.physicsBody?.restitution = 0
        //suspension1.physicsBody?.density = 0.1
        
        suspension2 = SKSpriteNode(color: SKColor.greenColor(), size: CGSize(width: 5, height: 5))
        suspension2.position = CGPointMake(car.position.x - car.size.width / 2 + 25, car.position.y - 50)
        suspension2.zPosition = 3
        suspension2.physicsBody = SKPhysicsBody(circleOfRadius: 5)
        suspension2.physicsBody?.dynamic = true
        suspension2.physicsBody?.mass = 0.1
        //suspension2.physicsBody?.restitution = 0
        //suspension2.physicsBody?.density = 0.1
        
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

        wheel1.physicsBody?.mass = 0.2
        wheel2.physicsBody?.mass = 0.1
        
//        car.physicsBody?.restitution = 1
//        suspension1.physicsBody?.restitution = 1
//        suspension2.physicsBody?.restitution = 1
//        wheel1.physicsBody?.restitution = 1s
//        wheel2.physicsBody?.restitution = 1
        
        //wheel1.physicsBody?.restitution = 1
        //wheel2.physicsBody?.restitution = 1
        //wheel1.physicsBody?.density = 0.1
        //wheel2.physicsBody?.density = 0.1
        
        wheel1.zPosition = 2
        wheel2.zPosition = 2
        
        carNode.addChild(car)
        carNode.addChild(suspension1)
        carNode.addChild(suspension2)
        carNode.addChild(wheel1)
        carNode.addChild(wheel2)
        
        carNode.physicsBody = SKPhysicsBody(bodies: [car.physicsBody!, wheel1.physicsBody!, wheel2.physicsBody!, suspension1.physicsBody!, suspension2.physicsBody!])
        carNode.physicsBody?.restitution = 1
        
        //addWheelDirtEmiter()
    }
    
    func addWheelDirtEmiter() {
        wheelDirtEmitter = SKEmitterNode(fileNamed: "WheelDirtEmitter.sks")!
        carNode.addChild(wheelDirtEmitter)
        
        wheelDirtEmitter.hidden = true
    }
    
    func addJoint() {
        //Wheel1
        let wheel1JointSliding = SKPhysicsJointSliding.jointWithBodyA(car.physicsBody!, bodyB: suspension1.physicsBody!, anchor: suspension1.position, axis: CGVectorMake(0,1))
        
        wheel1JointSliding.shouldEnableLimits = true
        wheel1JointSliding.lowerDistanceLimit = 5
        wheel1JointSliding.upperDistanceLimit = 20
        
        let wheel1JointSpring = SKPhysicsJointSpring.jointWithBodyA(car.physicsBody!, bodyB: wheel1.physicsBody!, anchorA: CGPointMake(car.position.x - car.frame.size.width / 2, car.position.y), anchorB: suspension1.position)
        
        wheel1JointSpring.damping = 1
        wheel1JointSpring.frequency = 10

        
        let wheel1JointPin = SKPhysicsJointPin.jointWithBodyA(suspension1.physicsBody!, bodyB: wheel1.physicsBody!, anchor: wheel1.position)
        
        //Wheel2
        let wheel2JointSliding = SKPhysicsJointSliding.jointWithBodyA(car.physicsBody!, bodyB: suspension2.physicsBody!, anchor: suspension2.position, axis: CGVectorMake(0, 1))
        
        wheel2JointSliding.shouldEnableLimits = true
        wheel2JointSliding.lowerDistanceLimit = 5
        wheel2JointSliding.upperDistanceLimit = 20
        
        let wheel2JointSpring = SKPhysicsJointSpring.jointWithBodyA(car.physicsBody!, bodyB: wheel2.physicsBody!, anchorA: CGPointMake(car.position.x + car.frame.size.width / 2, car.position.y), anchorB: suspension2.position)
        
        wheel2JointSpring.damping = 1
        wheel2JointSpring.frequency = 10
        
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
        
        let angle = atan2(car.position.y, car.position.x)
        let theta : CGFloat = 0.0
        
        let cx = (Float(a) * cosf(Float(angle - theta)))
        let cy = (Float(a) * sinf(Float(angle - theta)))
        
        let camZoom = SKAction.scaleTo(1, duration: 0.5)
        
        cam.position = CGPoint(x: CGFloat(cx), y: CGFloat(cy))
        cam.zRotation = angle - CGFloat(M_PI_2)
        cam.runAction(camZoom)
        
        wheelDirtEmitter.position = CGPointMake(wheel2.position.x, wheel2.position.y)
        wheelDirtEmitter.zRotation = cam.zRotation
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
        if gameViewControllerBridge.gasButtonState {
            wheel2.physicsBody?.angularVelocity = -35
            wheel1.physicsBody?.angularVelocity = -35

            
            wheelDirtEmitter.hidden = false
        } else if gameViewControllerBridge.brakeButtonState {
            wheel2.physicsBody?.angularVelocity = 35
            wheel1.physicsBody?.angularVelocity = 35
        } else {
            wheelDirtEmitter.hidden = true
        }
        
    }
    
    func reloadGame() {
        beizerPath.removeAllPoints()
        carNode.removeAllChildren()
        sceneNode.removeAllChildren()

        loadMap()
        createCar()
        addJoint()
        addCoins()
        
        let camZoom = SKAction.scaleTo(50, duration: 0.1)
        cam.runAction(camZoom)

    }
}
