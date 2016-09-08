import Foundation
import SpriteKit
import XCPlayground

let view:SKView = SKView(frame: CGRectMake(0, 0, 1024, 768))
XCPlaygroundPage.currentPage.liveView = view

let scene = SKScene(size: CGSizeMake(1024, 768))
scene.name = "PlaygroundScene"
scene.physicsWorld.gravity =  CGVectorMake(0.0, -0.0)
scene.scaleMode = SKSceneScaleMode.AspectFit

let vehicle = SKNode()

var joints = [SKPhysicsJoint]()
let wheelOffsetY:CGFloat    =   60;
let damping:CGFloat     =   1;
let frequency :CGFloat    =   4;

let chassis = SKSpriteNode.init(color: UIColor.whiteColor(), size: CGSizeMake(120, 8))
chassis.position = CGPoint(x: scene.size.width/2, y: scene.size.height/2)
chassis.physicsBody =  SKPhysicsBody.init(rectangleOfSize: chassis.size)
vehicle.addChild(chassis)


let ctop = SKSpriteNode.init(color: UIColor.greenColor(), size: CGSizeMake(70, 16))
ctop.position = CGPointMake(chassis.position.x+20, chassis.position.y+12);
ctop.physicsBody = SKPhysicsBody.init(rectangleOfSize: ctop.size)
vehicle.addChild(ctop)



let cJoint = SKPhysicsJointFixed.jointWithBodyA(chassis.physicsBody!, bodyB: ctop.physicsBody!, anchor: CGPointMake(ctop.position.x, ctop.position.y))



let leftWheel = SKSpriteNode(imageNamed: "wheel.png")
leftWheel.position = CGPointMake(chassis.position.x - chassis.size.width / 2, chassis.position.y - wheelOffsetY)  //Always set position before physicsBody
leftWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width/2)
leftWheel.physicsBody!.allowsRotation = true;
vehicle.addChild(leftWheel)


let rightWheel = SKSpriteNode(imageNamed: "wheel.png")
rightWheel.position = CGPointMake(chassis.position.x + chassis.size.width / 2, chassis.position.y - wheelOffsetY)  //Always set position before physicsBody
rightWheel.physicsBody = SKPhysicsBody(circleOfRadius: leftWheel.size.width/2)
rightWheel.physicsBody!.allowsRotation = true;
vehicle.addChild(rightWheel)


//--------------------- LEFT SUSPENSION ---------------------- //

let leftShockPost = SKSpriteNode(color: UIColor.blueColor(), size:CGSizeMake(7, wheelOffsetY) )

leftShockPost.position = CGPointMake(chassis.position.x - chassis.size.width / 2, chassis.position.y - leftShockPost.size.height/2)

leftShockPost.physicsBody = SKPhysicsBody(rectangleOfSize: leftShockPost.size)
vehicle.addChild(leftShockPost)

let leftSlide = SKPhysicsJointSliding.jointWithBodyA(chassis.physicsBody!, bodyB: leftShockPost.physicsBody!, anchor:CGPointMake(leftShockPost.position.x, leftShockPost.position.y), axis:CGVectorMake(0, 1))


leftSlide.shouldEnableLimits = true;
leftSlide.lowerDistanceLimit = 5;
leftSlide.upperDistanceLimit = wheelOffsetY;


let leftSpring = SKPhysicsJointSpring.jointWithBodyA(chassis.physicsBody!, bodyB: leftWheel.physicsBody!, anchorA: CGPointMake(chassis.position.x - chassis.size.width / 2, chassis.position.y), anchorB: leftWheel.position)


leftSpring.damping = damping;
leftSpring.frequency = frequency;

let lPin = SKPhysicsJointPin.jointWithBodyA(leftShockPost.physicsBody!, bodyB:leftWheel.physicsBody!, anchor:leftWheel.position)


//--------------------- Right SUSPENSION ---------------------- //

let rightShockPost = SKSpriteNode(color: UIColor.blueColor(), size:CGSizeMake(7, wheelOffsetY) )

rightShockPost.position = CGPointMake(chassis.position.x + chassis.size.width / 2, chassis.position.y - rightShockPost.size.height/2)

rightShockPost.physicsBody = SKPhysicsBody(rectangleOfSize: rightShockPost.size)
vehicle.addChild(rightShockPost)

let rightSlide = SKPhysicsJointSliding.jointWithBodyA(chassis.physicsBody!, bodyB: rightShockPost.physicsBody!, anchor:CGPointMake(rightShockPost.position.x, rightShockPost.position.y), axis:CGVectorMake(0, 1))


rightSlide.shouldEnableLimits = true;
rightSlide.lowerDistanceLimit = 5;
rightSlide.upperDistanceLimit = wheelOffsetY;


let rightSpring = SKPhysicsJointSpring.jointWithBodyA(chassis.physicsBody!, bodyB: rightWheel.physicsBody!, anchorA: CGPointMake(chassis.position.x - chassis.size.width / 2, chassis.position.y), anchorB: rightWheel.position)


rightSpring.damping = damping;
rightSpring.frequency = frequency;

let rPin = SKPhysicsJointPin.jointWithBodyA(leftShockPost.physicsBody!, bodyB:rightWheel.physicsBody!, anchor:rightWheel.position)


// Add all joints to the array.

joints.append(cJoint)
joints.append(leftSlide)
joints.append(leftSpring)
joints.append(rightSlide)
joints.append(rightSpring)
joints.append(rPin)


scene.addChild(vehicle)
view.presentScene(scene)