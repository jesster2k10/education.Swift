import SpriteKit

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

extension CGPath {
    func points() -> [CGPoint]
    {
        var bezierPoints = [CGPoint]()
        self.forEach({ (element: CGPathElement) in
            let numberOfPoints: Int = {
                switch element.type {
                case .MoveToPoint, .AddLineToPoint: // contains 1 point
                    return 1
                case .AddQuadCurveToPoint: // contains 2 points
                    return 2
                case .AddCurveToPoint: // contains 3 points
                    return 3
                case .CloseSubpath:
                    return 0
                }
            }()
            for index in 0..<numberOfPoints {
                let point = element.points[index]
                bezierPoints.append(point)
            }
        })
        return bezierPoints
    }
    
    func forEach(@noescape body: @convention(block) (CGPathElement) -> Void) {
        typealias Body = @convention(block) (CGPathElement) -> Void
        func callback(info: UnsafeMutablePointer<Void>, element: UnsafePointer<CGPathElement>) {
            let body = unsafeBitCast(info, Body.self)
            body(element.memory)
        }
        let unsafeBody = unsafeBitCast(body, UnsafeMutablePointer<Void>.self)
        CGPathApply(self, unsafeBody, callback)
    }
}

var bezierPoints = beizerPath4.CGPath.points()

let testShape = SKShapeNode(circleOfRadius: 5)

testShape.position = CGPoint(x: bezierPoints[5].x, y: bezierPoints[5].y)
//testShape.position = CGPoint(x: bezierPoints[15].x, y: bezierPoints[15].y)

beizerPath4.containsPoint(beizerPath4.CGPath.points()[5])

let testShape2 = SKShapeNode(path: beizerPath4.CGPath)
testShape2.position = CGPoint(x: 0, y: 0)

testShape2.addChild(testShape)




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
















































