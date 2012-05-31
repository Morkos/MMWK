//
//  MoveState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoveState.h"

@implementation MoveState

@synthesize character;

+ (MoveState*) createWithCharacter:(Character *) character {
    MoveState *state = [[MoveState alloc] init];
    state.character = character;
    
    return state;
}

- (void) start {
    [character.animator startAnimation:@"move" replay:true];
}

- (void) updateState {
    [character moveTowards:character.currentDirection];
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (![[newState class] isSubclassOfClass:[MoveState class]]) {
        [character setState:newState];
    }
}

@end
