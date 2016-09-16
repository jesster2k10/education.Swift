//
//  Utils.swift
//  zRacing
//
//  Created by zlobo on 10.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import Foundation
import SpriteKit

//Extensions
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

//Functions
func getRandomColor() -> SKColor{
    
    let randomRed:CGFloat = CGFloat(drand48())
    let randomGreen:CGFloat = CGFloat(drand48())
    let randomBlue:CGFloat = CGFloat(drand48())
    
    return SKColor(red: randomRed, green: randomGreen, blue: randomBlue, alpha: 1.0)
    
}

