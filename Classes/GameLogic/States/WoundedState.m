//
//  WoundedState.m
//  DragonEye
//
//  Created by mac on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WoundedState.h"

@interface WoundedState()
    -(CCAction *) createAction:(CCAnimation *) animationAction;
@end
@implementation WoundedState

@synthesize character;

+ (WoundedState *) createWithCharacter:(Character *) character {
    WoundedState *state = [[WoundedState alloc] init];
    state.character = character;
    
    return state;
}

- (void) start {
    [SpriteSheetAnimator startAnimation:character
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_WOUNDED
                          frameInterval:0.1f
                                 target:self
                               selector:@selector(createAction:)];
}

- (void) updateState {
    
}

-(CCAction *) createAction:(CCAnimation *) animationAction {
    animationAction.restoreOriginalFrame = false;
    CCAction *action = [CCSequence actions:
                        [CCAnimate actionWithAnimation:animationAction],
                        [CCDelayTime actionWithDuration:0.2f],
                        [CCCallFunc actionWithTarget:self selector:@selector(transitionToStand)],
                        nil];
    
    return action;
}

- (void) transitionToStand {
    [character setState:[StandState createWithCharacter:character]];
}

- (void) transitionToState:(id<CharacterState>) newState {
    // No transition can be made when you are wounded
}

@end
