//
//  EnemyBuilder.m
//  DragonEye
//
//  Created by Mark Mikhail on 8/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyBuilder.h"
#import "Enemy.h"

@implementation EnemyBuilder

- (EnemyBuilder *) newBuilder:(CGPoint)position 
                         size:(CGSize)size 
                       sprite:(CCSprite *) sprite {
    [character autorelease];
    character = [[Enemy alloc] init:position 
                               size:size
                             sprite:sprite];
    
    return self;
}

@end