//
//  StandingState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StandState.h"
#import "ChaseState.h"
#import "Enemy.h"
#import "Player.h"
#import "ObjectContainer.h"
#import "FleeState.h"
#import "PolarCoordinates.h"

@implementation StandState

@synthesize character;

+ (StandState *) createWithCharacter:(Character *) character {
    StandState *state = [[StandState alloc] init];
    state.character = character;

    return state;
}

- (void) start {
    [SpriteSheetAnimator startAnimation:character
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_STAND
                          frameInterval:0.1f];
}

- (void) updateState {
    //NSLog(@"updating state...%@", self.character);
    if ([self.character isMemberOfClass:[Enemy class]]) {
        Player * player = [[ObjectContainer sharedInstance] player];
        
        if(CGRectIntersectsRect(player.boundingBox, self.character.boundingBox)) {
            [self.character setState:[AttackState createWithCharacter:self.character]];
        }
    }
}

- (void) transitionToState:(id<CharacterState>) newState {
    [character setState:newState];
}

@end
