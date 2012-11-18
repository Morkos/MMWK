//
//  SteeringBehavior.h
//  DragonEye
//
//  Created by Mark Mikhail on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "chipmunk.h"
#import "Character.h"

@interface SteeringBehavior : NSObject {
    CGFloat wanderRadius;
    CGFloat wanderDistance;
    CGFloat wanderJitter;
    cpVect wanderTarget;
}

@property (nonatomic, assign) CGFloat wanderRadius;
@property (nonatomic, assign) CGFloat wanderDistance;
@property (nonatomic, assign) CGFloat wanderJitter;
@property (nonatomic, assign) cpVect wanderTarget;

- (id) init;
- (cpVect) wander:(Character *) character;
- (cpVect) calculate:(Character *) character;
- (cpVect) flee:(Character *) character;
- (cpVect) pursuit:(Character *) character;

@end
