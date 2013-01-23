//
//  EnemyBasicAttack.m
//  DragonEye
//
//  Created by Alkaiser on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "EnemyBasicAttack.h"
#import "SpriteSheetAnimator.h"

@implementation EnemyBasicAttack

+(void) attackWithDamage:(NSUInteger) damage 
                attacker:(BattleEnemy *) attacker
                  target:(BattleCharacter *) target {
    // Perform attack animation on the attacker
    [attacker runAction:
     [CCSequence actions:
      [CCAnimate actionWithAnimation:
       [SpriteSheetAnimator createAnimationAction:ANIMATOR_BASIC_ATTACK 
                                      spriteSheet:attacker.spriteSheet
                                    frameInterval:0.2f]],
      [CCAnimate actionWithAnimation:
       [SpriteSheetAnimator createAnimationAction:ANIMATOR_STAND 
                                      spriteSheet:attacker.spriteSheet
                                    frameInterval:0.2f]], 
      nil]];
    
    [target isAttackedBy:damage];
}


@end
