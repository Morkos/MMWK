//
//  StandingState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StandState.h"

@implementation StandState

@synthesize character;

+ (StandState *) createWithCharacter:(Character *) character {
    StandState *state = [[StandState alloc] init];
    state.character = character;

    return state;
}

- (void) start {
    [character.animator startAnimation:ANIMATOR_STAND replay:true];
}

- (void) updateState {
    
}

- (void) transitionToState:(id<CharacterState>) newState {
    [character setState:newState];
}

@end
