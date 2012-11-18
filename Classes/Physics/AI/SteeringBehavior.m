//
//  SteeringBehavior.m
//  DragonEye
//
//  Created by Mark Mikhail on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SteeringBehavior.h"
#import "ObjectContainer.h"
#import "Player.h"

@implementation SteeringBehavior
@synthesize wanderRadius, 
            wanderDistance,
            wanderJitter,
            wanderTarget;

static double randomClamp() {
    double r = (double)rand() / (double)RAND_MAX;    
    return r;
}

- (cpVect) seek:(Character *) character {
    //Player * player = [ObjectContainer sharedInstance].player;
    return CGPointZero;
}

- (id) init {
    wanderRadius = 20;
    wanderDistance = 50;
    wanderJitter = 2;
    wanderTarget = cpv(150, 150);
    
    return self;
}

- (cpVect) wander:(Character *) character {
    wanderTarget = cpvadd(wanderTarget, cpv(randomClamp() * wanderJitter, randomClamp() * wanderJitter));
    wanderTarget = cpvnormalize(wanderTarget);
    wanderTarget = cpvmult(wanderTarget, wanderRadius);
    
    cpVect targetLocal = cpvadd(wanderTarget, cpv(wanderDistance, 0));
    
    return cpvsub(targetLocal, cpv(character.position.x, character.position.y));
}

- (cpVect) pursuit:(Character *) character {
 
    return CGPointZero;
}

- (cpVect) flee:(Character *)character {
    Player * player = [ObjectContainer sharedInstance].player;
    cpVect desiredV = cpvmult(cpvnormalize(cpvsub(character.position, player.position)), character.speed);
    
    CGPoint pt = cpvadd(desiredV, character.position);
    if (character.position.x < player.position.x) {
        [character setCurrentOrientation:ORIENTATION_BACKWARDS];
    } else {
        [character setCurrentOrientation:ORIENTATION_FORWARD];
    }
    NSLog(@"new pt: %lf, %lf", pt.x, pt.y);
    
    return pt;
}

- (cpVect) calculate:(Character *) character {
    return [self flee:character];
}
@end
