import Foundation
import SpriteKit
import XCPlayground

extension Int {
    var degreesToRadians: Double { return Double(self) * M_PI / 180 }
    var radiansToDegrees: Double { return Double(self) * 180 / M_PI }
    
    public static func random (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
}

extension Float {
    public static func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
}

func randomBool() -> Bool {
    return arc4random_uniform(2) == 0 ? true: false
}

var beizerPath = UIBezierPath()
var coinsArray = [CGPoint]()

beizerPath.moveToPoint(CGPoint(x: 0,y: 0))
coinsArray.removeAll()

var planetRadius : Float = 100
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
    
    let coinCount = 0
    var newTheta : Float = 3.0
    for _ in 0...coinCount {
        newRadius += 10
        
        x3 = newRadius * cos(((theta - newTheta) * Float(M_PI)) / 180)
        y3 = newRadius * sin(((theta - newTheta) * Float(M_PI)) / 180)
        
        if randomBool() {
            coinsArray.append((CGPoint(x: CGFloat(x3),y: CGFloat(y3))))
        }
        newTheta += 3
    }
    theta += 9
}

beizerPath.closePath()

var planet = SKShapeNode(path: beizerPath.CGPath)
planet.position = CGPointMake(0, 0)
planet.fillColor = SKColor.greenColor()

for i in coinsArray {
    var coin = SKShapeNode(circleOfRadius: 7)
    coin.position = i
    
    coin.fillColor = SKColor.blueColor()
    
    if !beizerPath.containsPoint(i) {
    }
    if !coin.intersectsNode(planet) {
        let error = SKShapeNode(circleOfRadius: 5)
        error.fillColor = SKColor.redColor()
        error.position = i
        error.zPosition = 2
        planet.addChild(error)
    }
    
    planet.addChild(coin)
}


planet








