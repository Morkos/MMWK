//
//  HealthPotion.m
//  DragonEye
//
//  Created by Alkaiser on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HealthPotion.h"

@implementation HealthPotion

+ (HealthPotion *) itemWithTexture:(NSString *) textureFilename {
    return [[[HealthPotion alloc] initWithFile:textureFilename] autorelease];
}

- (void) isPickedUpBy:(Player *)player {
    [player increaseHp:hpIncrease];
    [super isPickedUpBy:player];
}

@end
