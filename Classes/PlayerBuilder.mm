//
//  PlayerBuilder.m
//  DragonEye
//
//  Created by Mark Mikhail on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "PlayerBuilder.h"
#import "Player.h"

@implementation PlayerBuilder

+ (PlayerBuilder *) newBuilder:(CGPoint)position
                          size:(CGSize)size 
                        sprite:(CCSprite *) sprite {
    PlayerBuilder *builder = [[PlayerBuilder alloc] init];
    builder.character = [[Player alloc] init:position 
                                     size:size
                                   sprite:sprite];
    return builder;
}


@end
