//
//  BattleEnemy.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleEnemy.h"
#import "BattleLayer.h"
#import "SpriteSheetAnimator.h"

@interface BattleEnemy()
-(void) decrementDebugTimer;
-(void) showDebugLabel;
@end

@implementation BattleEnemy

@synthesize debugLabel;

#ifdef WAIT_TIME_DEBUG
-(void) setDebugLabel:(CCLabelTTF *)debugLabelP {
    [debugLabel removeFromParentAndCleanup:true];
    debugLabel = [debugLabelP retain];
    [self addChild:debugLabel];
}
#endif

-(void) startBattleTimer {
    if ([self isAlive]) {
        [super startBattleTimer];
        
#ifdef WAIT_TIME_DEBUG
        currentWaitTime = waitTimeDelay;
        [self schedule:@selector(decrementDebugTimer) interval:1 repeat:kCCRepeatForever delay:0];
#endif
    }
}
-(void) startOfWaitTime {
    [super startOfWaitTime];
}

-(void) endOfWaitTime {
    [super endOfWaitTime];
    [self showDebugLabel];
    [self runAction:
     [CCSequence actions:
      [CCAnimate actionWithAnimation:
       [SpriteSheetAnimator createAnimationAction:ANIMATOR_BASIC_ATTACK 
                                      spriteSheet:self.spriteSheet
                                    frameInterval:0.2f]],
      [CCAnimate actionWithAnimation:
       [SpriteSheetAnimator createAnimationAction:ANIMATOR_STAND 
                                      spriteSheet:self.spriteSheet
                                    frameInterval:0.2f]], 
      nil]];
    
    [parentLayer.player isAttackedBy:self];
    [parentLayer resumeBattleTimer];
    [self startBattleTimer];
}

-(void) decrementDebugTimer {
    [debugLabel setString:NSSTRING_FORMAT(@"%.0f", currentWaitTime)];
    currentWaitTime -= 1;
}

-(void) showDebugLabel {
#ifdef WAIT_TIME_DEBUG
    [debugLabel setString:NSSTRING_FORMAT(@"%.0f", currentWaitTime)];
#endif
}

-(void) dealloc {
    [debugLabel release];
    [super dealloc];
}
@end
