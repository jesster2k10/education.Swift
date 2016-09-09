import SpriteKit

let rect = SKShapeNode(rectOfSize: CGSize(width: 100, height: 50))

rect.fillColor = SKColor.blueColor()

let beizerPath = UIBezierPath()
beizerPath.moveToPoint(CGPoint(x: 0, y: 0))
beizerPath.addLineToPoint(CGPointMake(10, 20))
beizerPath.addCurveToPoint(CGPointMake(200, 20), controlPoint1: CGPointMake(50, 50), controlPoint2: CGPointMake(30, 150))

beizerPath.addCurveToPoint(CGPointMake(200, -20), controlPoint1: CGPointMake(200, -30), controlPoint2: CGPointMake(200, 0))
beizerPath.closePath()
let rect2 = SKShapeNode(path: beizerPath.CGPath)
rect2.fillColor = SKColor.redColor()
let beizerPath2 = UIBezierPath()
beizerPath2.addArcWithCenter(CGPointMake(0, 0), radius: 50, startAngle: CGFloat((M_PI * 0)/180), endAngle: CGFloat((M_PI * 360)/180), clockwise: false)


func randomPointOnCircle(radius:Float, center:CGPoint) -> CGPoint {
    // Random angle in [0, 2*pi]
    let theta = Float(arc4random_uniform(UInt32.max))/Float(UInt32.max-1) * Float(M_PI) * 2.0
    // Convert polar to cartesian
    let x = radius * cosf(theta)
    let y = radius * sinf(theta)
    return CGPointMake(CGFloat(x)+center.x,CGFloat(y)+center.y)
}

for i in 0 ..< 3 {
    var point = randomPointOnCircle(50, center: CGPoint(x: 0, y: 0))
beizerPath2.addQuadCurveToPoint(point, controlPoint: CGPointMake(point.x * 2, point.y * 2))
    
}

var beizerPath3 = UIBezierPath()
var beizerPath4 = UIBezierPath()
beizerPath4.moveToPoint(CGPoint(x: 0,y: 0))
var theta : Float = 0.0

beizerPath3.moveToPoint(CGPoint(x: 0, y: 0))
for y in 0...18 {
    let x = 50 * cos((theta * Float(M_PI)) / 180)
    let y = 50 * sin((theta * Float(M_PI)) / 180)
    
    beizerPath3.addLineToPoint(CGPoint(x: CGFloat(x),y: CGFloat(y)))
    beizerPath4.addQuadCurveToPoint(CGPoint(x: CGFloat(x),y: CGFloat(y)), controlPoint: CGPoint(x: CGFloat(x*1.8),y: CGFloat(y*1.4)))
    theta += 20
}


// up 0-90 down 0-260 left 260-0 right 90-0 up right 90-60 up left 260-60 down left 260-260 down right 90-260
















































