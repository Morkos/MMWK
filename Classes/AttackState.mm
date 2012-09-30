//
//  AttackState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AttackState.h"

@implementation AttackState

@synthesize character,
            currentAttack,
            isNextAttack;

+ (AttackState *) createWithCharacter:(Character *) character {
    AttackState *state = [[AttackState alloc] init];
    state.character = character;
    state.currentAttack = 0;
    
    return state;
}

- (void) start {
    isNextAttack = true;
    currentAttack = 0;
}

- (void) updateState {
    /*if (isNextAttack && [character.animator isLastAnimation]) {
        //NSString *key = [NSString stringWithFormat:ANIMATOR_ATTACK, currentAttack++];
        
        // Invoke sprite animation
        //[character.animator startAnimation:key replay:false];
        
        // Invoke particle effect
        [character.effectsManager invokeEffect:key 
                                          prop:character];
        
        isNextAttack = false;
    }*/
    
    /*if ([character.animator isLastAnimation]) {
        if ((currentAttack >= [character.attackingRowIndexes count] - 1) || 
            !isNextAttack) {
            [character setState:[StandState createWithCharacter:character]];
        }
    }*/
    
}

- (void) transitionToState:(id<CharacterState>) newState {
    if ([[newState class] isSubclassOfClass:[AttackState class]]) {
        isNextAttack = true;
    }
    
    
}

@end
