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

@synthesize character;

+ (MoveState *) createWithCharacter:(Character *) character {
    MoveState *state = [[MoveState alloc] init];
    state.character = character;
    
    return state;
}

- (void) start {
    CCLOGINFO(@"Starting MoveState for %@", self.character);
    [SpriteSheetAnimator startAnimation:character
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_MOVE
                          frameInterval:0.1f];
}

- (void) updateState {
    [character moveTowards:character.currentDirection];
    
    if (IS_SUBCLASS(character, Player)) {
        Player *player = (Player *) character;
        NSArray *items = 
            [[ObjectContainer sharedInstance] findCollidingProps:character fromContainer:CONTAINER_ITEMS];
        
        for (Item *item in items) {
            [item isPickedUpBy:player];
        }
    }
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (!IS_SUBCLASS(newState, MoveState)) {
        [character setState:newState];
    }
}

@end
