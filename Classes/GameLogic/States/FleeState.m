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
#import "PolarCoordinates.h"

@implementation FleeState

+ (FleeState *) createWithCharacter:(Character *) character {
    FleeState *state = [[FleeState alloc] init];
    state.character = character;
    
    return state;
}
-(void) start {
    [super start];
}

-(void) updateState {    
    cpVect result = [character.behavior flee:character];
    character.position = result;
    
    Player * player = [ObjectContainer sharedInstance].player;
    
    CGFloat distanceFromPlayer = cpvdist(player.position, character.position);
    
    if(distanceFromPlayer > 150) {
        [character setState:[StandState createWithCharacter:self.character]];
    }    
}

-(void) transitionToState:(id<CharacterState>)newState {
    [self.character setState:newState];
}
@end
