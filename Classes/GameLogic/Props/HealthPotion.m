//
//  HealthPotion.m
//  DragonEye
//
//  Created by Alkaiser on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HealthPotion.h"
#import "SimpleAudioEngine.h"

@implementation HealthPotion

@synthesize hpIncrease;

+ (HealthPotion *) itemWithTexture:(NSString *) textureFilename {
    return [[[HealthPotion alloc] initWithFile:textureFilename] autorelease];
}

- (id) initWithFile:(NSString *) filename {
    if (self = [super initWithFile:filename]) {
        hpIncrease = 0;
    }
    
    return self;
}

- (void) actionOnPickup:(Player *)player {
    [player increaseHp:hpIncrease];
    [[SimpleAudioEngine sharedEngine] playEffect:@"pickupItem.wav"];
}

@end
