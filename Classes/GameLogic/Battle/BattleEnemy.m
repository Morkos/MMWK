//
//  BattleEnemy.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleEnemy.h"
#import "BattleLayer.h"

@implementation BattleEnemy

@synthesize debugLabel;

-(void) setDebugLabel:(CCLabelTTF *)debugLabelP {
    [debugLabel release];
    debugLabel = [debugLabelP retain];
    [self addChild:debugLabel];
}

-(void) startOfWaitTime {
    [super startOfWaitTime];
    [debugLabel setString:NSSTRING_FORMAT(@"%d", isWaiting)];    
}

-(void) endOfWaitTime {
    [super endOfWaitTime];
    [debugLabel setString:NSSTRING_FORMAT(@"%d", isWaiting)];
    [parentLayer.player isAttackedBy:self];
    [parentLayer resumeBattleTimer];
    [self startBattleTimer];
}

-(void) dealloc {
    [debugLabel release];
    [super dealloc];
}
@end
