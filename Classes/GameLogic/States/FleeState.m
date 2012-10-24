//
//  FleeState.m
//  DragonEye
//
//  Created by Mark Mikhail on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FleeState.h"
#import "Character.h"
#import "Player.h"
#import "ObjectContainer.h"
//#import "MacroHelpers.h"
#import "PolarCoordinates.h"

@implementation FleeState

static Direction directionToFlee;

+ (FleeState *) createWithCharacter:(Character *) character {
    FleeState *state = [[FleeState alloc] init];
    state.character = character;
    
    return state;
}
-(void) start {
    [super start];
    
    NSLog(@"Enemy is in harm's way...");
    Player * player = [ObjectContainer sharedInstance].player;

    directionToFlee = player.currentDirection;
}

-(void) updateState {    
    Player * player = [ObjectContainer sharedInstance].player;
    [character moveTowards:directionToFlee];
    CGFloat distanceFromPlayer = DISTANCE(player.position, self.character.position);
    
    if(distanceFromPlayer > 150) {
        [character setState:[StandState createWithCharacter:self.character]];
    }    
}

-(void) transitionToState:(id<CharacterState>)newState {
    [self.character setState:newState];
}
@end
