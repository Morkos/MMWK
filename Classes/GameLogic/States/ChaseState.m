//
//  ChaseState.m
//  DragonEye
//
//  Created by Mark Mikhail on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ChaseState.h"
#import "StandState.h"
#import "MacroHelpers.h"
#import "Player.h"

@implementation ChaseState
@synthesize coordinateSystem;

+ (ChaseState *) createWithCharacter:(Character *) character {
    ChaseState * chaseState = [[ChaseState alloc] init];
    chaseState.character = character;
    chaseState.coordinateSystem =
        [CoordinateSystem  createWithCenter:character.contentSize.width 
                                  imgHeight:character.contentSize.height];
    
    return chaseState;
}

-(void) start {
    [super start];
    NSLog(@"ChaseState has begun for enemy: %@", self.character);
}

-(void) transitionToState:(id<CharacterState>) newState {
    [self.character setState:newState];
}

-(void) updateState {
    Player * player = [ObjectContainer sharedInstance].player;	
    Direction directionToChase = 
    [self.coordinateSystem decideDirectionFromSrcToTarget:self.character.position
                                              targetPoint:player.position]; 
    //CGFloat distanceFromPlayer = DISTANCE(player.position, self.character.position);

    NSLog(@"Direction to chase is %d", directionToChase);
    
    [self.character moveTowards:directionToChase];
    
    if(CGRectIntersectsRect(player.boundingBox, self.character.boundingBox)) {
        [self.character setState:[AttackState createWithCharacter:self.character]];   
    } 
    //else if(distanceFromPlayer > 150) {
    //    self.character setState:<#(id<CharacterState>)#>
    //}
}

@end
