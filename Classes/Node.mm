//
//  untitled.m
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Node.h"

@implementation Node
@synthesize nodeVisualState;

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
			  animator:(SpriteSheetAnimator *)animator {
	
	Node *node = [[Node alloc] init];
	
	[Overlay initialize:node 
			   position:position 
				   size:size 
			spriteSheet:animator];
    
    node.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    [animator startAnimation:ANIMATOR_NODE_NEUTRAL replay:true];
	
	return node;
}

- (BOOL) isPressed:(CGPoint)point {
	DLOG("Touched (%f, %f), node position(%f, %f), height %f", point.x, point.y, self.position.x, self.position.y, size.height);
	return [self distanceFrom:point to:self.position] < size.height;
}

- (void) markValid {
    self.nodeVisualState = ANIMATOR_NODE_VALID;
    [animator startAnimation:ANIMATOR_NODE_VALID replay:false];
}
- (void) markInvalid {
    self.nodeVisualState = ANIMATOR_NODE_INVALID;
    [animator startAnimation:ANIMATOR_NODE_INVALID replay:false];
}

- (void) markNeutral {
    self.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    [animator startAnimation:ANIMATOR_NODE_NEUTRAL replay:false];
}

- (BOOL) isNeutral {
    return [self.nodeVisualState isEqual:ANIMATOR_NODE_NEUTRAL];
}

- (id) copyWithZone:(NSZone *)zone {
    Node *nodeCopy = [Node nodeAtPosition:self.position 
                                     size:self.size
                                 animator:self.animator];
    
    nodeCopy.nodeVisualState = ANIMATOR_NODE_NEUTRAL;
    
    return nodeCopy;
    
}
@end
