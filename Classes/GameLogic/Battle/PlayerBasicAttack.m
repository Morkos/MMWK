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
                  target:(BattleCharacter *) target 
            angleOfSwipe:(CGFloat) angle{
    [[ParticleInvoker invoker] doSlashEffect:target 
                                       angle:angle
                                      length:target.boundingBox.size.width/2];
    
    [[SimpleAudioEngine sharedEngine] playEffect:@"swordSwing.wav"];
    
    [target isAttackedBy:damage];
}

@end
