import Foundation
import SpriteKit
import XCPlayground

class RadialGradientLayer: CALayer {
    
    override init(){
        
        super.init()
        
        needsDisplayOnBoundsChange = true
    }
    
    init(center:CGPoint,radius:CGFloat,colors:[CGColor]){
        
        self.center = center
        self.radius = radius
        self.colors = colors
        
        super.init()
        
    }
    
    required init(coder aDecoder: NSCoder) {
        
        super.init()
        
    }
    
    var center : CGPoint = CGPointMake(50,50)
    var radius : CGFloat = 20
    var colors:[CGColor] = [UIColor(red: 251/255, green: 237/255, blue: 33/255, alpha: 1.0).CGColor , UIColor(red: 251/255, green: 179/255, blue: 108/255, alpha: 1.0).CGColor]
    
    override func drawInContext(ctx: CGContext!) {
        
        CGContextSaveGState(ctx)
        
        var colorSpace = CGColorSpaceCreateDeviceRGB()
        
        var locations:[CGFloat] = [0.0, 1.0]
        
        var gradient = CGGradientCreateWithColors(colorSpace, colors, [0.0,1.0])
        
        var startPoint = CGPointMake(0, self.bounds.height)
        var endPoint = CGPointMake(self.bounds.width, self.bounds.height)
        
        CGContextDrawRadialGradient(ctx, gradient, center, 0.0, center, radius, CGGradientDrawingOptions.DrawsAfterEndLocation)
    }
    
}

var gradient = RadialGradientLayer(center: CGPoint(x: 0,y: 0), radius: 100, colors: [UIColor.blueColor().CGColor, UIColor.redColor().CGColor])
gradient.setNeedsDisplay()
gradient.drawInContext(UIGraphicsGetCurrentContext())


SKView()

//Create the SpriteKit View
let view:SKView = SKView(frame: CGRectMake(0, 0, 1024, 768))

//Add it to the TimeLine
XCPShowView("Live View", view: view)

//Create the scene and add it to the view
let scene:SKScene = SKScene(size: CGSizeMake(1024, 768))
scene.scaleMode = SKSceneScaleMode.AspectFit
view.presentScene(scene)

//Add something to it!
