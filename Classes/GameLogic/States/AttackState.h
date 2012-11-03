//
//  AttackState.h
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "CharacterState.h"
#import "Character.h"
#import "AnimatorConstants.h"

@class Character;

@interface AttackState : NSObject<CharacterState> {
    Character *character;
    uint currentAttack;
    bool isInBetweenAttacks;
}

+ (AttackState *) createWithCharacter:(Character *) character;

- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;
@end
