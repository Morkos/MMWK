//
//  untitled.m
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

@implementation Node
@synthesize nodeVisualState,
            sprite;

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

+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
			  spriteSheet:(SpriteSheet *)spriteSheet {
	
	Node *node = [[Node alloc] initWithPosition:position
                                           size:size
                                    spriteSheet:spriteSheet];
    
    node.sprite = [spriteSheet getSpriteForKey:ANIMATOR_NODE_NEUTRAL frameNum:0];
    node.sprite.position = position;
    node.sprite.scaleX = size.width;
    node.sprite.scaleY = size.height;
    node.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
	
	return node;
}

- (bool) isLocationInView:(CGPoint) location {
    return CGRectContainsPoint(sprite.boundingBox, location);
}

- (void) markValid {
    self.nodeVisualState = ANIMATOR_NODE_VALID;
    [SpriteSheetAnimator startAnimation:sprite
                            spriteSheet:spriteSheet
                               frameKey:self.nodeVisualState
                          frameInterval:1.0f];
}
- (void) markInvalid {
    self.nodeVisualState = ANIMATOR_NODE_INVALID;
    [SpriteSheetAnimator startAnimation:sprite
                            spriteSheet:spriteSheet
                               frameKey:self.nodeVisualState
                          frameInterval:1.0f];
}

- (void) markNeutral {
    self.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    [SpriteSheetAnimator startAnimation:sprite
                            spriteSheet:spriteSheet
                               frameKey:self.nodeVisualState
                          frameInterval:1.0f];
}

- (BOOL) isNeutral {
    return [self.nodeVisualState isEqual:ANIMATOR_NODE_NEUTRAL];
}

- (id) copyWithZone:(NSZone *)zone {
    Node *nodeCopy = [Node nodeAtPosition:self.position 
                                     size:self.size
                              spriteSheet:self.spriteSheet];
    
    nodeCopy.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    
    return nodeCopy;
    
}
@end
