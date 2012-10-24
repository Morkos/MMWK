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
    [SpriteSheetAnimator startAnimation:character.sprite
                            spriteSheet:character.spriteSheet
                               frameKey:ANIMATOR_STAND
                          frameInterval:0.1f];
}

- (void) updateState {
    //NSLog(@"updating state...%@", self.character);
    if ([self.character isMemberOfClass:[Enemy class]]) {
        Player * player = [[ObjectContainer sharedInstance] player];
        //player is close to enemy
        
        CGFloat distanceToPlayer = DISTANCE(player.position, self.character.position);
        if(CGRectIntersectsRect(player.sprite.boundingBox, self.character.sprite.boundingBox))
        {
            NSLog(@"Collision detected.");
            [self.character setState:[AttackState createWithCharacter:self.character]];
        } else if( distanceToPlayer > 100 ) {
            
            NSLog(@"Begin chasing the player.");
            [self.character setState:[ChaseState createWithCharacter:self.character]];
            /*
             * If player "x" distance away then chase player.
             */
        }
    }
}

- (void) transitionToState:(id<CharacterState>) newState {
    [character setState:newState];
}

@end
