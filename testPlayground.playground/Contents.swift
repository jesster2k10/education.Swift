import Foundation
import SpriteKit
import XCPlayground

SKView()

//Create the SpriteKit View
let view:SKView = SKView(frame: CGRectMake(0, 0, 1024, 768))

//Add it to the TimeLine
XCPShowView("Live View", view: view)

//Create the scene and add it to the view
let scene:SKScene = SKScene(size: CGSizeMake(1024, 768))
scene.scaleMode = SKSceneScaleMode.AspectFit
view.presentScene(scene)

//---------------------------------------------------------------------------------------
let ground = SKShapeNode(rectOfSize: CGSize(width: scene.size.width, height: 50))
ground.physicsBody = SKPhysicsBody(rectangleOfSize: ground.frame.size)
ground.physicsBody?.dynamic = false
ground.position = CGPointMake(scene.frame.width / 2, scene.frame.height / 10)

let node = SKNode()

let shape = SKShapeNode(circleOfRadius: 50)
shape.physicsBody = SKPhysicsBody(circleOfRadius: 50)
shape.position = CGPoint(x: 0 ,y: 0)

let quad = SKShapeNode(rectOfSize: CGSize(width: 50, height: 50), cornerRadius: 2)
quad.physicsBody = SKPhysicsBody(rectangleOfSize: quad.frame.size)
quad.position = CGPoint(x: 100 ,y: 0)

node.position = CGPointMake(scene.frame.width / 4, scene.frame.height)

node.addChild(shape)
shape.addChild(quad)

scene.addChild(ground)
scene.addChild(node)





