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
    NSLog(@"character position:%@", NSStringFromCGPoint(character.position));
    
    self.character.behavior.wayPoints = self.path;
    [character.behavior followPath:character];
    
    /*
    if (IS_SUBCLASS(character, Player)) {
        Player *player = (Player *) character;
        NSArray *items = 
            [[ObjectContainer sharedInstance] findCollidingProps:character fromContainer:CONTAINER_ITEMS];
        
        for (Item *item in items) {
            [item isPickedUpBy:player];
        }
    }*/
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (!IS_SUBCLASS(newState, MoveState)) {
        [character setState:newState];
    }
}

@end
