//
//  Prop.m
//  DragonEye
//
//  Created by alkaiser on 3/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "CCUtil.h"

@implementation Prop

- (void) update {
}

- (void) resolveCollisions {
}

-(void) draw {
    [super draw];
    
#ifdef BOUNDING_BOX
    CGPoint origin = self.boundingBox.origin;
    CGPoint destination = ccpAdd(origin, ccp(self.boundingBox.size.width, self.boundingBox.size.height));
    
    ccDrawRect([self convertToNodeSpace:origin], 
               [self convertToNodeSpace:destination]);
#endif
}

- (bool) isLocationInBoundingBox:(CGPoint) location {
    return CGRectContainsPoint(self.boundingBox, location);
}

@end
