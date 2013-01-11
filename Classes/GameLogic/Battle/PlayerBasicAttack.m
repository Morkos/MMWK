//
//  BasicAttack.m
//  DragonEye
//
//  Created by Alkaiser on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "PlayerBasicAttack.h"
#import "ParticleInvoker.h"
#import "SimpleAudioEngine.h"

@implementation PlayerBasicAttack

+(void) attackWithDamage:(NSUInteger) damage 
                  target:(BattleCharacter *) target {
    [[ParticleInvoker invoker] invokeParticleEffect:slashEffect 
                                               prop:target];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"swordSwing.wav"];
    
    [target isAttackedBy:damage];
}

@end
