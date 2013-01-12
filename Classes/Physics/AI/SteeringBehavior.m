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
#import "SparseGraph.h"
#import "Edge.h"

@implementation SteeringBehavior
@synthesize wayPoints, 
            rator,
            start;

- (id) init {
    
    if(self = [super init]) {
        //TODO: This should not be here

        NSLog(@"start: %@", start);
        NSLog(@"way pts: %@", wayPoints);
        NSLog(@"rator %@", rator);
    }
    
    return self;
}

- (cpVect) pursuit:(Character *) character {
    
    return CGPointZero;
}

- (cpVect) seek:(CGPoint) src
         target:(CGPoint) target {
    
    cpVect seekPath = cpvnormalize(cpvsub(target, src)); 
    Player * player = [ObjectContainer sharedInstance].player;
    
    player.position = cpvadd(src, seekPath);
    return seekPath;
}

- (BOOL) followPath:(Character *) character {
    
    //NSLog(@"path: %@", self.wayPoints);
    
    BOOL nearNextPoint = cpvdist(character.position, self.start.position) < 10;
    BOOL nearend = cpvdist(character.position, ((Vertex *)[wayPoints lastObject]).position) < 10;
    
    if (nearend) {
        return YES;
    } else if (nearNextPoint) {
        self.start = [rator nextObject];
        NSLog(@"next wayPoint: %@", self.start);
    } 
    
    NSLog(@"seeking to %@", self.start);		
    
    [self seek:character.position 
        target:self.start.position];
    
    return NO;
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
    return pt;
}

- (cpVect) calculate:(CGPoint) src 
              target:(CGPoint) target {
    return [self seek:src 
               target:target];
}
@end
