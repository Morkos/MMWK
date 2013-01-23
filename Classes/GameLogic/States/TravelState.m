//
//  TravelState.m
//  DragonEye
//
//  Created by Mark Mikhail on 1/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TravelState.h"
#import "Player.h"

@implementation TravelState

@synthesize character,
            path;

+ (TravelState*) createWithCharacter:(Character *) character {
    TravelState *state = [[TravelState alloc] init];
    state.character = character;
    
    return state;
}

+ (TravelState *) createWithCharacter:(Character *) character 
                                 path:(NSArray *) path {
    
    TravelState *state = [[TravelState alloc] init];
    state.character = character;
    state.path = path;
    
    state.character.behavior.rator = [path objectEnumerator];
    state.character.behavior.start = [state.character.behavior.rator nextObject];
    
    return state;
}

- (void) start {

    
    NSLog(@"Starting TravelState for %@", self.character);
    [SpriteSheetAnimator startAnimation:character
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_MOVE
                          frameInterval:0.1f];
}

- (void) updateState {
    [character.behavior followPath:character path:self.path];
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (!IS_SUBCLASS(newState, TravelState)) {
        [character setState:newState];
    }
}

@end
