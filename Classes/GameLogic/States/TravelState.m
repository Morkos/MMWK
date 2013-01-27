//
//  TravelState.m
//  DragonEye
//
//  Created by Mark Mikhail on 1/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "TravelState.h"
#import "Player.h"
#import "BattleScene.h"

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
    [state.character.behavior newBehavior:[path objectEnumerator]];    
    
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
    BOOL atend = [character.behavior followPath:character path:self.path];
    if(atend) {
        [[CCDirector sharedDirector] replaceScene:[CCTransitionFlipX transitionWithDuration:1.0 
                                                                                      scene:[BattleScene scene]]];
        [self transitionToState:[StandState createWithCharacter:self.character]];
    
    }

}

- (void) transitionToState:(id<CharacterState>) newState {
    if (!IS_SUBCLASS(newState, TravelState)) {
        [character setState:newState];
    }
}

@end
