//
//  HUDControl.m
//  DragonEye
//
//  Created by mac on 10/2/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDControl.h"

@implementation HUDControl

@synthesize sprite;

- (bool) isLocationInView:(CGPoint) location {
    NSLog(@"Location %@ in box %@", 
          NSStringFromCGPoint(location), NSStringFromCGRect(sprite.boundingBox));
    return CGRectContainsPoint(sprite.boundingBox, location);
}

@end
