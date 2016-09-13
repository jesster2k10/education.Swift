import SpriteKit

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

func getRandomColor() -> SKColor{
    
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return SKColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}

// -------------------------------------------------------------------------------------

var beizerPath = UIBezierPath()
var planetRadius = Float()
var planet = SKShapeNode()

beizerPath.moveToPoint(CGPoint(x: 0,y: 0))

planetRadius = 100
var theta : Float = 20.0

let ox = planetRadius * cos((Float(M_PI)) / 180)
let oy = planetRadius * sin((Float(M_PI)) / 180)

beizerPath.moveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)))

for _ in 0...17 {
    var newRadius = Float.random(planetRadius, upper: planetRadius + planetRadius / 4)
    
    var x2 = newRadius * cos((theta * Float(M_PI)) / 180)
    var y2 = newRadius * sin((theta * Float(M_PI)) / 180)
    
    var x3 = newRadius * cos(((theta - 10) * Float(M_PI)) / 180)
    var y3 = newRadius * sin(((theta - 10) * Float(M_PI)) / 180)
    
    if theta == 360 {
        beizerPath.addQuadCurveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
    }
    else {
        beizerPath.addQuadCurveToPoint(CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3))) }
    //beizerPath4.addCurveToPoint(CGPoint(x: CGFloat(x4),y: CGFloat(y4)), controlPoint1: CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint2: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
    
    theta += 20
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
fieldNode.falloff = 1
fieldNode.strength = 200

planet.addChild(fieldNode)
