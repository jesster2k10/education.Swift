//
//  GameScene.swift
//  SpriteKitPlayGround
//
//  Created by Родыгин Дмитрий on 01.09.16.
//  Copyright (c) 2016 Родыгин Дмитрий. All rights reserved.
//

import SpriteKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Animations
    var animations = AnimationClass()
    
    //Variables
    var sound = true
    var moveElectricGateY = SKAction()
    var gameViewControllerBridge: GameViewController!
    
    //Texture
    var bgTexture: SKTexture!
    var flyHeroTex: SKTexture!
    var runHeroTex: SKTexture!
    var coinTexture: SKTexture!
    var redCoinTexture: SKTexture!
    var coinHeroTex: SKTexture!
    var redCoinHerotext: SKTexture!
    var electricGateTex: SKTexture!
    var deadHeroTex: SKTexture!
    
    //Emitters Node
    var heroEmmiter = SKEmitterNode()
    
    //Sprite Nodes
    var bg = SKSpriteNode()
    var hero = SKSpriteNode()
    var ground = SKSpriteNode()
    var sky = SKSpriteNode()
    var coin = SKSpriteNode()
    var redCoin = SKSpriteNode()
    var electricGate = SKSpriteNode()
    
    //Sprite Objects
    var bgObject = SKNode()
    var heroObject = SKNode()
    var groundObject = SKNode()
    var movingObject = SKNode()
    var heroEmmierObject = SKNode()
    var coinObject = SKNode()
    var redCoinObject = SKNode()
    
    
    //Textures Array for animateWithTexture
    var heroFlyTexturesArray = [SKTexture]()
    var heroRunTexturesArray = [SKTexture]()
    var coinTexturesArray = [SKTexture]()
    var electricGateTexturesArray = [SKTexture]()
    var heroDeathTexturesArray = [SKTexture]()
    
    //Timers
    var timerAddCoin = NSTimer()
    var timerAddRedCoin = NSTimer()
    var timerAddElectricGate = NSTimer()

    //Sounds
    var pickCoinPreload = SKAction()
    var electricGateCreatePreload = SKAction()
    var electricGateDeadPreload = SKAction()
    
    //Bit Masks
    var heroGroup: UInt32 = 0x1 << 1
    var groundGroup: UInt32 = 0x1 << 2
    var coinGroup: UInt32 = 0x1 << 3
    var redCoinGroup : UInt32 = 0x1 << 4
    var objectGroup: UInt32 = 0x1 << 5
    
    
    override func didMoveToView(view: SKView) {
        //Backgroung Texture
        bgTexture = SKTexture(imageNamed: "bg01.png")
        
        //Hero Texture
        flyHeroTex = SKTexture(imageNamed: "Fly0.png")
        runHeroTex = SKTexture(imageNamed: "Run0.png")
        
        //Coin Texture
        coinTexture = SKTexture(imageNamed: "coin.jpg")
        redCoinTexture = SKTexture(imageNamed: "coin.jpg")
        coinHeroTex = SKTexture(imageNamed: "Coin0.png")
        redCoinHerotext = SKTexture(imageNamed: "Coin0.png")
        
        //Emmiters
        heroEmmiter = SKEmitterNode(fileNamed: "engine.sks")!
        
        //Electric Gate Texture
        electricGateTex = SKTexture(imageNamed: "ElectricGate01.png")
        
        self.physicsWorld.contactDelegate = self
        
        createObjects()
        createGame()
        
        pickCoinPreload = SKAction.playSoundFileNamed("pickCoin.mp3", waitForCompletion: false)
        electricGateDeadPreload = SKAction.playSoundFileNamed("electricDead.mp3", waitForCompletion: false)
        electricGateCreatePreload = SKAction.playSoundFileNamed("electricCreate.wav", waitForCompletion: false)
        
    }
    
    override func didFinishUpdate() {
        heroEmmiter.position = hero.position - CGPoint(x: 35, y: 13)
    }
    
    func createObjects() {
        self.addChild(bgObject)
        self.addChild(groundObject)
        self.addChild(heroObject)
        self.addChild(movingObject)
        self.addChild(heroEmmierObject)
        self.addChild(coinObject)
        self.addChild(redCoinObject)
    }
    
    func createGame() {
        createBg()
        createGround()
        createSky()
        
        createHero()
        createHeroEmitter()
        timerFunc()
        addElectricGate()
        
        gameViewControllerBridge.reloadGameBtn?.hidden = true
    }
    
    func createBg() {
       //bgTexture = SKTexture(imageNamed: "bg01.png")
        
        let moveBg = SKAction.moveByX(-bgTexture.size().width, y: 0, duration: 3)
        let replaceBg = SKAction.moveByX(bgTexture.size().width, y: 0, duration: 0)
        let moveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveBg, replaceBg]))
        
        for i in 0..<3 {
            bg = SKSpriteNode(texture: bgTexture)
            bg.position = CGPoint(x: size.width/4 + bgTexture.size().width * CGFloat(i), y: size.height/2.0)
            bg.size.height = self.frame.height
            bg.runAction(moveBgForever)
            bg.zPosition = -1
            
            bgObject.addChild(bg)
        }
    }
    
    func createGround() {
        ground = SKSpriteNode()
        ground.position = CGPoint.zero
        ground.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.width, height: self.frame.height/4 + self.frame.height/8))
        ground.physicsBody?.dynamic = false
        ground.physicsBody?.categoryBitMask = groundGroup
        ground.zPosition = 1
        
        groundObject.addChild(ground)
    }
    
    func createSky() {
        sky = SKSpriteNode()
        sky.position = CGPoint(x: 0, y: self.frame.maxX)
        sky.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: self.frame.size.width + 100, height: self.frame.size.height - 50))
        sky.physicsBody?.dynamic = false
        sky.zPosition = 1
        
        movingObject.addChild(sky)
    }
    
    func addHero(heroNode: SKSpriteNode, atPosition position: CGPoint) {
        hero = SKSpriteNode(texture: flyHeroTex)
        
        //Animation hero
        heroFlyTexturesArray = [SKTexture(imageNamed: "Fly0.png"), SKTexture(imageNamed: "Fly1.png"), SKTexture(imageNamed: "Fly2.png"), SKTexture(imageNamed: "Fly3.png"), SKTexture(imageNamed: "Fly4.png")]
        let heroFlyAnimation = SKAction.animateWithTextures(heroFlyTexturesArray, timePerFrame: 0.1)
        let flyHero = SKAction.repeatActionForever(heroFlyAnimation)
        hero.runAction(flyHero)
        
        hero.position = position
        hero.size.height = 84
        hero.size.width = 120
        
        hero.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: hero.size.width - 40, height: hero.size.height - 30))
        
        hero.physicsBody?.categoryBitMask = heroGroup
        hero.physicsBody?.contactTestBitMask = groundGroup | coinGroup | redCoinGroup | objectGroup
        hero.physicsBody?.collisionBitMask = groundGroup
        
        hero.physicsBody?.dynamic = true
        hero.physicsBody?.allowsRotation = false
        hero.zPosition = 1
        
        heroObject.addChild(hero)
    }
    
    func createHero() {
        addHero(hero, atPosition: CGPoint(x: self.size.width/4, y: 0 + flyHeroTex.size().height + 400))
    }
    
    func createHeroEmitter() {
        heroEmmiter = SKEmitterNode(fileNamed: "engine.sks")!
        heroEmmierObject.zPosition = 1
        heroEmmierObject.addChild(heroEmmiter)
    }
    
    func addCoin() {
        coin = SKSpriteNode(texture: coinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Coin0.png"), SKTexture(imageNamed: "Coin1.png"), SKTexture(imageNamed: "Coin2.png"), SKTexture(imageNamed: "Coin3.png")]
        let coinAnimation = SKAction.animateWithTextures(coinTexturesArray, timePerFrame: 0.1)
        let coinHero = SKAction.repeatActionForever(coinAnimation)
        
        coin.runAction(coinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffSet = CGFloat(movementAmount) - self.frame.size.height / 4
        
        coin.size.width = 40
        coin.size.height = 40
        coin.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: coin.size.width - 20 , height: coin.size.height - 20))
        coin.physicsBody?.restitution = 0 //сопротивление
        coin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffSet)
        
        let moveCoin = SKAction.moveToX(-self.frame.size.width * 2, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveCoin, removeAction]))
        
        coin.runAction(coinMoveBgForever)
        
        coin.physicsBody?.dynamic = false
        coin.physicsBody?.categoryBitMask = coinGroup
        coin.zPosition = 1
        coinObject.addChild(coin)
    }
    
    func redCoinAdd() {
        redCoin = SKSpriteNode(texture: redCoinTexture)
        
        coinTexturesArray = [SKTexture(imageNamed: "Coin0.png"), SKTexture(imageNamed: "Coin1.png"), SKTexture(imageNamed: "Coin2.png"), SKTexture(imageNamed: "Coin3.png")]
        let redCoinAnimation = SKAction.animateWithTextures(coinTexturesArray, timePerFrame: 0.1)
        let redCoinHero = SKAction.repeatActionForever(redCoinAnimation)
        redCoin.runAction(redCoinHero)
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 2)
        let pipeOffSet = CGFloat(movementAmount) - self.frame.size.height / 4
        
        redCoin.size.width = 40
        redCoin.size.height = 40
        redCoin.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: redCoin.size.width - 10 , height: redCoin.size.height - 10))
        redCoin.physicsBody?.restitution = 0 //сопротивление
        redCoin.position = CGPoint(x: self.size.width + 50, y: 0 + coinTexture.size().height + 90 + pipeOffSet)
        
        let moveCoin = SKAction.moveToX(-self.frame.size.width * 2, duration: 5)
        let removeAction = SKAction.removeFromParent()
        let coinMoveBgForever = SKAction.repeatActionForever(SKAction.sequence([moveCoin, removeAction]))
        
        redCoin.runAction(coinMoveBgForever)
        
        animations.scaleZdirection(redCoin)
        animations.redColorAnimation(redCoin, animDuration: 0.5)
        
        redCoin.setScale(1.3)
        redCoin.physicsBody?.dynamic = false
        redCoin.physicsBody?.categoryBitMask = redCoinGroup 
        redCoin.zPosition = 1
        redCoinObject.addChild(redCoin)

    }
    
    func addElectricGate() {
        if sound == true {
            runAction(electricGateCreatePreload)
        }
        
        electricGate = SKSpriteNode(texture: electricGateTex)
        
        electricGateTexturesArray = [SKTexture(imageNamed: "ElectricGate01.png"), SKTexture(imageNamed: "ElectricGate02.png"), SKTexture(imageNamed: "ElectricGate03.png"), SKTexture(imageNamed: "ElectricGate04.png")]
        let electricGateAnimation = SKAction.animateWithTextures(electricGateTexturesArray, timePerFrame: 0.1)
        let electricGateAnimationForever = SKAction.repeatActionForever(electricGateAnimation)
        electricGate.runAction(electricGateAnimationForever)
        
        let randomPosition = arc4random() % 2
        
        let movementAmount = arc4random() % UInt32(self.frame.size.height / 5)
        let pipeOffset = self.frame.size.height/4 + 30 - CGFloat(movementAmount)
        
        if randomPosition == 0 {
           electricGate.position = CGPoint(x: self.size.width + 50, y: 0 + electricGateTex.size().height/2 + 90 + pipeOffset)
            electricGate.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
        } else {
            electricGate.position = CGPoint(x: self.size.width + 50, y: self.frame.size.height - electricGateTex.size().height/2 - 90 - pipeOffset)
            electricGate.physicsBody = SKPhysicsBody(rectangleOfSize: CGSize(width: electricGate.size.width - 40, height: electricGate.size.height - 20))
        }
        
        //Rotate
        electricGate.runAction(SKAction.repeatActionForever(SKAction.sequence([SKAction.runBlock({
            self.electricGate.runAction(SKAction.rotateByAngle(CGFloat(M_PI * 2), duration: 0.5))
        }), SKAction.waitForDuration(20)])))
        
        //Move
        let moveAction = SKAction.moveByX(-self.frame.width - 300, y: 0, duration: 6)
        electricGate.runAction(moveAction)
        
        //Scale
        var scaleValue: CGFloat = 0.3
        
        let scaleRandom = arc4random() % UInt32(5)
        if scaleRandom == 1 { scaleValue = 0.9 }
        else if scaleRandom == 2 { scaleValue = 0.6 }
        else if scaleRandom == 3 { scaleValue = 0.8 }
        else if scaleRandom == 4 { scaleValue = 0.7 }
        else if scaleRandom == 0 { scaleValue = 1.0 }
        
        electricGate.setScale(scaleValue)

        
        let movementRandom = arc4random() % 9
        if movementRandom == 0 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 + 220, duration: 4)
        } else if movementRandom == 1 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 - 220, duration: 5)
        } else if movementRandom == 2 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 - 150, duration: 4)
        } else if movementRandom == 3 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 + 120, duration: 5)
        } else if movementRandom == 4 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 + 50, duration: 4)
        } else if movementRandom == 5 {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2 - 20, duration: 5)
        } else {
            moveElectricGateY = SKAction.moveToY(self.frame.height / 2, duration: 4)
        }
        
        electricGate.runAction(moveElectricGateY)
        
        electricGate.physicsBody?.restitution = 0
        electricGate.physicsBody?.dynamic = false
        electricGate.physicsBody?.categoryBitMask = objectGroup
        electricGate.zPosition = 1
        movingObject.addChild(electricGate)
        
    }
    
    func timerFunc() {
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        
        timerAddCoin = NSTimer.scheduledTimerWithTimeInterval(2.64, target: self, selector: #selector(GameScene.addCoin), userInfo: nil, repeats: true)
        timerAddRedCoin = NSTimer.scheduledTimerWithTimeInterval(8.64, target: self, selector: #selector(GameScene.redCoinAdd), userInfo: nil, repeats: true)
        timerAddElectricGate = NSTimer.scheduledTimerWithTimeInterval(5.234, target: self, selector: #selector(GameScene.addElectricGate), userInfo: nil, repeats: true)
    }
    
    func reloadGame() {
        coinObject.removeAllChildren()
        redCoinObject.removeAllChildren()
        scene?.paused = false
        
        movingObject.removeAllChildren()
        heroObject.removeAllChildren()
        
        coinObject.speed = 1
        heroObject.speed = 1
        movingObject.speed = 1
        self.speed = 1
        
        createGround()
        createSky()
        createHero()
        createHeroEmitter()
        timerAddCoin.invalidate()
        timerAddRedCoin.invalidate()
        timerAddElectricGate.invalidate()
        
        timerFunc()
    }
    
    func stopGameObject() {
        coinObject.speed = 0
        movingObject.speed = 0
        heroObject.speed = 0
        redCoinObject.speed = 0
    }
}
