//
//  WoundedState.m
//  DragonEye
//
//  Created by mac on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WoundedState.h"

@implementation WoundedState

@synthesize character;

+ (WoundedState *) createWithCharacter:(Character *) character {
    WoundedState *state = [[WoundedState alloc] init];
    state.character = character;
    
    return state;
}

- (void) start {
    /*[character.animator startAnimation:ANIMATOR_WOUNDED
                                replay:false];*/
}

- (void) updateState {
    
}

- (void) transitionToState:(id<CharacterState>) newState {
    // No transition can be made when you are wounded
}

@end
