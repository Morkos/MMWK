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
                   spriteFrame:(CCSpriteFrame *) spriteFrame {
    PlayerBuilder *builder = [[PlayerBuilder alloc] init];
    [builder.character autorelease];
    builder.character = [[Player alloc] init:position 
                                        size:size
                                 spriteFrame:spriteFrame];

    return builder;
}


@end
