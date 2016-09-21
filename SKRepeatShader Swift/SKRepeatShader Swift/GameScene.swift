//
//  GameScene.swift
//  SKRepeatShader Swift
//
//  Created by Родыгин Дмитрий on 21.09.16.
//  Copyright © 2016 Родыгин Дмитрий. All rights reserved.
//

import SpriteKit
import GameplayKit

extension SKShapeNode {
    
}

class GameScene: SKScene {
    
    private var spinnyNode : SKShapeNode?
    
    override func didMove(to view: SKView) {
        
        // Get label node from scene and store it for use later
        
        //self.addChild(generateRepeatTiledImageNode(backgroundSizePoints: CGSize(width: 500, height: 500)))
        let texture = setTiledFillTexture(imageName: "tile",frameSize:  CGSize(width: 500, height: 500) , tileSize: CGSize(width: 100, height: 10))
        let shape = SKSpriteNode(texture: texture)
        
        self.addChild(shape)
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    func setTiledFillTexture(imageName: String, frameSize: CGSize ,tileSize: CGSize) -> SKTexture {
        let targetSize = CGSize(width: frameSize.width, height: frameSize.height)
        let targetRef = UIImage(named: imageName)?.cgImage
        
        UIGraphicsBeginImageContext(targetSize)
        
        UIGraphicsGetCurrentContext()?.draw(targetRef!, in: CGRect(origin: CGPoint.zero, size: tileSize), byTiling: true)
        
        let tiledTexture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return SKTexture(image: tiledTexture!)
    }
    
    func generateRepeatTiledImageNode(backgroundSizePoints: CGSize) -> SKSpriteNode
    {
    let textureFilename = "tile.png"
    
    // Load the tile as a SKTexture
    
    let tileTex = SKTexture(imageNamed: textureFilename)
    
    // Dimensions of tile image
    
    let tileSizePixels = CGRect(x: 0, y: 0, width: tileTex.size().width, height: tileTex.size().height) // tile texture dimensions
        
    //NSLog(@"tile size in pixels %d x %d", (int)tileSizePixels.width, (int)tileSizePixels.height);
    
    // Generate tile that exactly covers the whole screen
    
    let screenScale = UIScreen.main.scale
    
    let coverageSizePixels = CGRect(x: 0, y: 0, width: Int(backgroundSizePoints.width * screenScale), height: Int(backgroundSizePoints.height * screenScale))
    
    let coverageSizePoints = CGRect(x: 0, y: 0, width: Int(coverageSizePixels.width / screenScale), height: Int(coverageSizePixels.height / screenScale))
    
    // Make shader and calculate uniforms to be used for pixel center calculations
    
    let shader = SKShader(fileNamed: "shader_opengl.fsh")
    
    //assert(shader)
        
    let outSampleHalfPixelOffsetX = 1.0 / (2.0 * Float(coverageSizePixels.width))
    let outSampleHalfPixelOffsetY = 1.0 / (2.0 * Float(coverageSizePixels.height))
    
    shader.addUniform(SKUniform(name: "outSampleHalfPixelOffset", vectorFloat2: vector_float2(outSampleHalfPixelOffsetX, outSampleHalfPixelOffsetY)))
    
    // normalized width passed into mod operation
    
    let tileWidth = tileSizePixels.width
    let tileHeight = tileSizePixels.height
        
    shader.addUniform(SKUniform(name: "tileSize", vectorFloat2: vector_float2(Float(tileWidth), Float(tileHeight))))
    
    // Tile pixel width and height
    
    let inSampleHalfPixelOffsetX = 1.0 / (2.0 * Float(tileSizePixels.width))
    let inSampleHalfPixelOffsetY = 1.0 / (2.0 * Float(tileSizePixels.height))
    
    shader.addUniform(SKUniform(name: "inSampleHalfPixelOffset", vectorFloat2: vector_float2(inSampleHalfPixelOffsetX, inSampleHalfPixelOffsetY)))
    // Attach shader to node
    
    let node = SKSpriteNode(color: UIColor.white, size: coverageSizePoints.size)
        
    node.texture = tileTex
    
    node.texture?.filteringMode = SKTextureFilteringMode.nearest
    
    node.shader = shader
    
    return node;
    }

    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchDown(atPoint: t.location(in: self)) }
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
