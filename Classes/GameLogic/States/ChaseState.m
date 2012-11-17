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
    
    CGFloat pct = 0.7f;
    CGRect adjustedRect = CGRectMake(pct * player.position.x, 
                                     pct * player.position.y, 
                                     pct * player.contentSize.width,
                                     pct * player.contentSize.height);
    
    if(CGRectIntersectsRect(adjustedRect, self.character.boundingBox)) {
        CGFloat newX = self.character.position.x - player.position.x;
        if(newX > 0) {
            [self.character setCurrentOrientation:ORIENTATION_BACKWARDS];
        } else {
            [self.character setCurrentOrientation:ORIENTATION_FORWARD];
        }
        [self.character setState:[StandState createWithCharacter:self.character]];   

    } else {
        [self.character moveTowards:directionToChase];
    }

}

@end
