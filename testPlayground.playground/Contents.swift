import Foundation
import SpriteKit
import XCPlayground

-(SKTexture *)tiledTextureImage:(UIImage *)image ForSize:(CGSize)size tileSize:(CGSize)tileSize{
    
    // First we create a new size based on the longest side of your rect
    int targetDimension = (int)fmax(size.width,size.height);
    CGSize targetSize = CGSizeMake(targetDimension, targetDimension);
    
    // Create a CGImage from the input image and start a new image context.
    struct CGImage *targetRef = image.CGImage;
    UIGraphicsBeginImageContext(targetSize);
    CGContextRef contextRef = UIGraphicsGetCurrentContext();
    
    // Now we simply draw a tiled image
    CGContextDrawTiledImage(contextRef, CGRectMake(0,0, tileSize.width,tileSize.height), targetRef);
    UIImage *tiledTexture = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    // Finally create a texture and return it.
    return  [SKTexture textureWithImage:tiledTexture];
}





