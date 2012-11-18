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
    
    CGFloat pct = 0.9f;
    CGRect playerRect = CGRectMake(pct * player.position.x, 
                                   pct * player.position.y, 
                                   pct * player.contentSize.width,
                                   pct * player.contentSize.height);
    
    CGRect enemyRect = CGRectMake(pct * self.character.position.x, 
                                  pct * self.character.position.y, 
                                  pct * self.character.contentSize.width, 
                                  pct * self.character.contentSize.height);
    
    if(CGRectIntersectsRect(playerRect, enemyRect)) {
        NSLog(@"player position %lf, %lf, and enemy %lf, %lf", player.position.x, player.position.y, self.character.position.x, self.character.position.y);
        CGFloat newX = self.character.position.x - player.position.x;
        if(newX > 0) {
            [self.character setCurrentOrientation:ORIENTATION_FORWARD];
        } else {
            [self.character setCurrentOrientation:ORIENTATION_BACKWARDS];
        }
        [self.character setState:[AttackState createWithCharacter:self.character]];   

    } else {
        [self.character moveTowards:directionToChase];
    }

}

@end
