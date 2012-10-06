//
//  AttackState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AttackState.h"

@interface AttackState ()
    -(CCAction *) createAction:(CCAnimation *) animationAction;
    -(void) transitionToStand;
    -(void) setIsDelayed;
@end
@implementation AttackState

@synthesize character,
            currentAttack,
            isInDelay;

+ (AttackState *) createWithCharacter:(Character *) character {
    AttackState *state = [[AttackState alloc] init];
    state.character = character;
    state.currentAttack = 0;
    state.isInDelay = true;
    
    return state;
}

- (void) start {
    isInDelay = false;
    [SpriteSheetAnimator startAnimation:character.sprite
                            spriteSheet:character.spriteSheet
                               frameKey:NSSTRING_FORMAT(ANIMATOR_ATTACK, currentAttack)
                          frameInterval:0.1f
                                 target:self
                               selector:@selector(createAction:)];
}

-(CCAction *) createAction:(CCAnimation *) animationAction {
    animationAction.restoreOriginalFrame = false;
    CCAction *action = [CCSequence actions:[CCAnimate actionWithAnimation:animationAction],
                                           [CCCallFunc actionWithTarget:self selector:@selector(setIsDelayed)],
                                           [CCDelayTime actionWithDuration:0.2f],
                                           [CCCallFunc actionWithTarget:self selector:@selector(transitionToStand)],
                                            nil];
    
    return action;
}

-(void) setIsDelayed {
    isInDelay = true;
}

- (void) updateState {
}

- (void) transitionToStand {
    [character setState:[StandState createWithCharacter:character]];;
}

- (void) transitionToState:(id<CharacterState>) newState {
    if ([[newState class] isSubclassOfClass:[AttackState class]] && 
        isInDelay) {
        currentAttack++;
        [self start];
    }
}

@end
