//
//  BattlePlayer.m
//  DragonEye
//
//  Created by Alkaiser on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattlePlayer.h"
#import "SimpleAudioEngine.h"

@interface BattlePlayer ()
    -(void) endOfBattleTimerAction;
@end

@implementation BattlePlayer

@synthesize waitTimeGauge;

-(void) startBattleTimer:(CCFiniteTimeAction *) targetAction {
    [super startBattleTimer:
        [CCSequence actions:
            [CCCallFunc actionWithTarget:self selector:@selector(endOfBattleTimerAction)],
            targetAction, 
            nil]];
    
    [waitTimeGauge animateBarFromStartCapacity:0 endCapacity:100 maxCapacity:100];
}

-(void) endOfBattleTimerAction {
    [[SimpleAudioEngine sharedEngine] playEffect:@"pickupItem.wav"];
}

@end
