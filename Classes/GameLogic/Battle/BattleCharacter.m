//
//  BattleCharacter.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleCharacter.h"
#import "ParticleInvoker.h"
#import "SimpleAudioEngine.h"
#import "SpriteSheetAnimator.h"

@implementation BattleCharacter

@synthesize parentLayer,
            spriteSheet,
            attributes,
            waitTimeDelay,
            isWaiting;

-(id) initWithSpriteFrame:(CCSpriteFrame *) spriteFrame {
    if (self = [super initWithSpriteFrame:spriteFrame]) {
        self.attributes = [[CharacterAttributes alloc] init];
    }
    
    return self;
}

-(void) isAttackedBy:(BattleCharacter *) target {
    // TODO: To distinguish between basic vs advanced attacks
    [attributes decreaseHp:target.attributes.attackPower];
    [[ParticleInvoker invoker] invokeParticleEffect:slashEffect 
                                               prop:self];
    
    if ([self isAlive]) {
        [self runAction:
         [CCSequence actions:
            [CCAnimate actionWithAnimation:
                [SpriteSheetAnimator createAnimationAction:ANIMATOR_WOUNDED 
                                               spriteSheet:self.spriteSheet
                                             frameInterval:0.1f]],
            [CCAnimate actionWithAnimation:
                [SpriteSheetAnimator createAnimationAction:ANIMATOR_STAND 
                                               spriteSheet:self.spriteSheet
                                             frameInterval:0.1f]], 
            nil]];
    } else {
        [self runAction:
         [CCSequence actions:
             [CCAnimate actionWithAnimation:
              [SpriteSheetAnimator createAnimationAction:ANIMATOR_DEAD 
                                             spriteSheet:self.spriteSheet
                                           frameInterval:0.1f]],
             [CCCallFunc actionWithTarget:self selector:@selector(stopBattleTimer)],
             nil]];
    }
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"swordSwing.wav"];
}

-(bool) isAlive {
    return attributes.currentHp > 0;
}

-(void) startBattleTimer {
    waitTimeAction = [CCSequence actions:
                         [CCCallFunc actionWithTarget:self selector:@selector(startOfWaitTime)],
                         [CCDelayTime actionWithDuration:waitTimeDelay],
                         [CCCallFunc actionWithTarget:self selector:@selector(endOfWaitTime)],
                         nil];
    [self runAction:waitTimeAction];
}

-(void) startOfWaitTime {
    isWaiting = true;
}

-(void) endOfWaitTime {
    isWaiting = false;
    [parentLayer pauseBattleTimer];
}

-(void) resumeBattleTimer {
    [self resumeSchedulerAndActions];
}

-(void) pauseBattleTimer {
    [self pauseSchedulerAndActions];
}

-(void) stopBattleTimer {
    [self stopAction:waitTimeAction];
    waitTimeAction = nil;
}

-(void) dealloc {
    [parentLayer release];
    [spriteSheet release];
    [attributes release];
    [super dealloc];
}

@end
