//
//  CharacterAttributes.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterAttributes.h"

@implementation CharacterAttributes

@synthesize maxHp, 
            currentHp, 
            attackPower, 
            magicPower;

- (void) decreaseHp:(NSUInteger) hpDecrease {
    // TODO: If zero hp, the target should die
    currentHp = max(0, currentHp - hpDecrease);
}

@end
