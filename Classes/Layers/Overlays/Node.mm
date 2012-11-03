//
//  untitled.m
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

@implementation Node

- (CGFloat) distanceFrom:(CGPoint)point1 
                      to:(CGPoint)point2 {
	CGFloat x1 = point1.x;
	CGFloat x2 = point2.x;
	CGFloat y1 = point1.y;
	CGFloat y2 = point2.y;
	
	CGFloat distance = sqrt(pow(y2-y1, 2) + pow(x2-x1, 2));
	DLOG("Distance %f", distance);
	return distance;
}

- (id) initWithPosition:(CGPoint)positionParam 
                   size:(CGSize)size 
            spriteSheet:(SpriteSheet *)spriteSheetParam {
    if (self = [super initWithPosition:positionParam 
                                  size:size 
                           spriteSheet:spriteSheetParam]) {
        CCSpriteFrame *frame = [spriteSheet getFrameForKey:ANIMATOR_NODE_NEUTRAL frameNum:0];
        [self setTexture:frame.texture];
        [self setTextureRect:frame.rect];
        nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    }
    
    return self;
}

+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
			  spriteSheet:(SpriteSheet *)spriteSheet {
	
	Node *node = [[Node alloc] initWithPosition:position
                                           size:size
                                    spriteSheet:spriteSheet];
    
    
	return node;
}

- (bool) isLocationInView:(CGPoint) location {
    return CGRectContainsPoint(self.boundingBox, location);
}

- (void) markValid {
    nodeVisualState = ANIMATOR_NODE_VALID;
    [SpriteSheetAnimator startAnimation:self
                            spriteSheet:spriteSheet
                               frameKey:nodeVisualState
                          frameInterval:1.0f];
}
- (void) markInvalid {
    nodeVisualState = ANIMATOR_NODE_INVALID;
    [SpriteSheetAnimator startAnimation:self
                            spriteSheet:spriteSheet
                               frameKey:nodeVisualState
                          frameInterval:1.0f];
}

- (void) markNeutral {
    nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    [SpriteSheetAnimator startAnimation:self
                            spriteSheet:spriteSheet
                               frameKey:nodeVisualState
                          frameInterval:1.0f];
}

- (BOOL) isNeutral {
    return [nodeVisualState isEqual:ANIMATOR_NODE_NEUTRAL];
}

/*- (id) copyWithZone:(NSZone *)zone {
    CGSize size = {scaleX_, scaleY_};
    Node *nodeCopy = [Node nodeAtPosition:self.position 
                                     size:size
                              spriteSheet:self.spriteSheet];
    
    nodeCopy.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    
    return nodeCopy;
    
}*/
@end
