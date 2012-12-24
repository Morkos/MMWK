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

-(void) isAttackedBy:(BattleCharacter *) target {
    // TODO: To distinguish between basic vs advanced attacks
    [attributes decreaseHp:target.attributes.attackPower];
    [[ParticleInvoker invoker] invokeParticleEffect:slashEffect 
                                               prop:self];
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
     
    [[SimpleAudioEngine sharedEngine] playEffect:@"swordSwing.wav"];
}

-(void) startBattleTimer {
    [self runAction:[CCSequence actions:
                     [CCCallFunc actionWithTarget:self selector:@selector(startOfWaitTime)],
                     [CCDelayTime actionWithDuration:waitTimeDelay],
                     [CCCallFunc actionWithTarget:self selector:@selector(endOfWaitTime)],
                     nil]];
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

-(void) dealloc {
    [parentLayer release];
    [spriteSheet release];
    [attributes release];
    [super dealloc];
}

@end
