//
//  SteeringBehavior.h
//  DragonEye
//
//  Created by Mark Mikhail on 11/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "chipmunk.h"
#import "Character.h"
#import "Vertex.h"

@interface SteeringBehavior : NSObject {
    NSArray * wayPoints;
    NSEnumerator * rator;
    Vertex * start;
}

@property (nonatomic, retain) NSArray * wayPoints;
@property (nonatomic, retain) NSEnumerator * rator;
@property (nonatomic, retain) Vertex * start;

- (id) init;

- (cpVect) seek:(CGPoint) src 
         target:(CGPoint) target;

- (BOOL) followPath:(Character *) character;
- (cpVect) flee:(Character *) character;
- (cpVect) pursuit:(Character *) character;
- (cpVect) calculate:(CGPoint) src
              target:(CGPoint) target;

@end
