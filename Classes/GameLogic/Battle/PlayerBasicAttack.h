//
//  BasicAttack.h
//  DragonEye
//
//  Created by Alkaiser on 1/11/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "BattleCharacter.h"

@interface PlayerBasicAttack : NSObject

+(void) attackWithDamage:(NSUInteger) damage 
                  target:(BattleCharacter *) target;
@end
