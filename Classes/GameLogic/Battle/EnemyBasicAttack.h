//
//  EnemyBasicAttack.h
//  DragonEye
//
//  Created by Alkaiser on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BattleEnemy.h"

@interface EnemyBasicAttack : NSObject

+(void) attackWithDamage:(NSUInteger) damage 
                attacker:(BattleEnemy *) attacker
                  target:(BattleCharacter *) target;

@end
