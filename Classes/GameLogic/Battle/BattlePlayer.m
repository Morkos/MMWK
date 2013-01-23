//
//  BattlePlayer.m
//  DragonEye
//
//  Created by Alkaiser on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattlePlayer.h"
#import "SimpleAudioEngine.h"

@implementation BattlePlayer

@synthesize waitTimeGauge;

-(void) startBattleTimer {
    [super startBattleTimer];
    [waitTimeGauge animateBarFromStartCapacity:0 endCapacity:100 maxCapacity:100];
}

-(void) endOfWaitTime {
    [super endOfWaitTime];
    [[SimpleAudioEngine sharedEngine] playEffect:@"pickupItem.wav"];
}

-(void) resumeBattleTimer {
    [super resumeBattleTimer];
    [waitTimeGauge resumeSchedulerAndActions];
}

-(void) pauseBattleTimer {
    [super pauseBattleTimer];
    [waitTimeGauge pauseSchedulerAndActions];
}

@end
