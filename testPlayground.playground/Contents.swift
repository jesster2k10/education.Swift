import Foundation
import SpriteKit
import XCPlayground

let frame = CGRect(x: 0, y: 0, width: 800, height:800)
let midPoint = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)

var scene = SKScene(size: frame.size)

let view = SKView(frame: frame)
view.presentScene(scene)
XCPlaygroundPage.currentPage.liveView = view

//------------------------------------------------------------------------------------

let shape = SKShapeNode(circleOfRadius: 300)
shape.position = midPoint
shape.fillColor = SKColor.white
shape.strokeColor = SKColor.green
shape.lineWidth = 10

scene.addChild(shape)


