//
//  NodeConnector.m
//  DragonEye
//
//  Created by mac on 6/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "NodeConnector.h"

@implementation NodeConnector

@synthesize line,
            image,
            size,
            angle;

+ (NodeConnector *) createFromStart:(Node *) startNode
                             toNode:(Node *) endNode
                              image:(Texture *) image 
                               size:(CGSize) size {
    NodeConnector *connector = [[NodeConnector alloc] init];
    connector.image = image;
    connector.size = size;
    connector.angle = [CoordinateSystem calculateDegreesFromPoint:startNode.position 
                                                          toPoint:endNode.position];
    NSLog(@"Degrees: %f", connector.angle);
    connector.angle = TO_RADIANS(connector.angle);
    NSLog(@"Radians: %f", connector.angle);
    
    CGFloat distance = PYTHAG(startNode.position.x - endNode.position.x, 
                              startNode.position.y - endNode.position.y);
    
    uint numOfPoints = distance / (size.width + 0.05f);
    
    connector.line = [LinePoints createWithStart:startNode.position 
                                             end:endNode.position 
                                     numOfPoints:numOfPoints];
    return connector;
}

-(void) draw {
    for (NSValue *val in line.points) {
        CGPoint point = [val CGPointValue];
        GLPosition gamePosition = {point.x, point.y, 0.0f};
        [GraphicsEngine drawTexture:image
                          texCoords:[TexCoords defaultTexCoords] 
                           position:gamePosition 
                               size:size 
                              angle:angle
                        orientation:ORIENTATION_FORWARD
                            opacity:1.0f];
    }
}

-(void) update {
    
}

@end
