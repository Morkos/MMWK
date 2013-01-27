//
//  MoveState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MoveState.h"
#import "Player.h"
#import "Item.h"
#import "ObjectContainer.h"

@implementation MoveState

@synthesize character,
            path;

+ (MoveState *) createWithCharacter:(Character *) character {
    MoveState *state = [[MoveState alloc] init];
    state.character = character;
    
    return state;
}

+ (MoveState *) createWithCharacter:(Character *) character 
                               path:(NSArray *) path {
    
    MoveState *state = [[MoveState alloc] init];
    state.character = character;
    state.path = path;
    return state;
}

- (void) start {
    NSLog(@"Starting MoveState for %@", self.character);
    [SpriteSheetAnimator startAnimation:character
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_MOVE
                          frameInterval:0.1f];
}

- (void) updateState {
    
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (!IS_SUBCLASS(newState, MoveState)) {
        [character setState:newState];
    }
}

@end
