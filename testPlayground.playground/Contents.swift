//: Playground - noun: a place where people can play

import UIKit
import SpriteKit
import XCPlayground

let frame = CGRect(x: 0, y: 0, width: 600, height: 600)
let midPoint = CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0)

//Create a scene, add something to it
var scene = SKScene(size: frame.size)

//Set up the view and show the scene
let view = SKView(frame: frame)
view.presentScene(scene)
XCPlaygroundPage.currentPage.liveView = view

//Code:

let tileSize = CGSize(width: 100, height: 50)

func getTilePosition(row r:Int, column c:Int) -> CGPoint
{
    let x = 100 + (c * (Int(tileSize.width + 1)))
    let y = 100 + (r * (Int(tileSize.height + 1)))
    return CGPoint(x: x, y: y)
}

let temp = SKSpriteNode()

for r in 0...2 {
    for c in 0...2 {
        let tile = SKSpriteNode(color: SKColor.white, size: CGSize(width: 30, height: 30))
        tile.size = CGSize(width: tileSize.width, height: tileSize.height)
        tile.position = getTilePosition(row: r, column: c)
        temp.addChild(tile)
    }
}
temp.anchorPoint = CGPoint(x: 0.5, y: 0.5)

scene.addChild(temp)

var a : Int? = nil
var b  =  a ?? 0