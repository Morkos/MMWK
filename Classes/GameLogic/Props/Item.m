//
//  Item.m
//  DragonEye
//
//  Created by Alkaiser on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Item.h"

@implementation Item

- (void) isPickedUpBy:(Player *) player {
    [self removeFromParentAndCleanup:false];
}

@end
