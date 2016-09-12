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

public extension Float {
    public static func random(lower: Float, upper: Float) -> Float {
        let r = Float(arc4random()) / Float(UInt32.max)
        return (r * (upper - lower)) + lower
    }
}

public extension Int {
    public static func random (lower: Int , upper: Int) -> Int {
        return lower + Int(arc4random_uniform(UInt32(upper - lower + 1)))
    }
    
}


var beizerPath3 = UIBezierPath()
var beizerPath4 = UIBezierPath()

var ox = 300 * cos((Float(M_PI)) / 180)
var oy = 300 * sin((Float(M_PI)) / 180)
beizerPath4.moveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)))

var theta : Float = 20.0

//beizerPath3.moveToPoint(CGPoint(x: 0, y: 0))
for y in 0...17 {
    let x = 200 * cos((theta * Float(M_PI)) / 180)
    let y = 200 * sin((theta * Float(M_PI)) / 180)
    
    beizerPath3.addLineToPoint(CGPoint(x: CGFloat(x),y: CGFloat(y)))
    let controlPoint1 = Float.random(0.0, upper: 0.6)
    let controlPoint2 = Float.random(0.0, upper: 0.6)
    
    let controlPoint3 = controlPoint1 + Float.random(0.9, upper: 1.2)
    let controlPoint4 = controlPoint2 + Float.random(0.9, upper: 1.2)
    
   
    let x2 = Float.random(200, upper: 300) * cos((theta * Float(M_PI)) / 180)
    let y2 = Float.random(200, upper: 300) * sin((theta * Float(M_PI)) / 180)
    
    let x3 = Float.random(200, upper: 300) * cos(((theta - 10) * Float(M_PI)) / 180)
    let y3 = Float.random(200, upper: 300) * sin(((theta - 10) * Float(M_PI)) / 180)
    
    let x4 = x + 50
    let y4 = y + 50
    
    if theta == 360 {
        beizerPath4.addQuadCurveToPoint(CGPoint(x: CGFloat(ox),y: CGFloat(oy)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
    }
    else if theta == 0 {
            //ox = x2
            //oy = y2
            //beizerPath4.addQuadCurveToPoint(CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
    }
    else {
        beizerPath4.addQuadCurveToPoint(CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint: CGPoint(x: CGFloat(x3),y: CGFloat(y3))) }
    //beizerPath4.addCurveToPoint(CGPoint(x: CGFloat(x4),y: CGFloat(y4)), controlPoint1: CGPoint(x: CGFloat(x2),y: CGFloat(y2)), controlPoint2: CGPoint(x: CGFloat(x3),y: CGFloat(y3)))
    
    theta += 20
}

beizerPath4.closePath()


Float.random(1.1, upper: 1.5)
Int.random(1, upper: 5)

let numberOfPlaces = 2.0
let multiplier = pow(10.0, numberOfPlaces)
let num = Float.random(1.1, upper: 1.5)
let rounded = round(num * 10) / 10
round(Float.random(1.1, upper: 1.5) * 10) / 10



func getRandomColor() -> SKColor{
    
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return SKColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}

getRandomColor()
getRandomColor()


// up 0-90 down 0-260 left 260-0 right 90-0 up right 90-60 up left 260-60 down left 260-260 down right 90-260
















































