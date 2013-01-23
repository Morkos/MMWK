//
//  Vertex.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vertex.h"
#import "chipmunk.h"

@implementation Vertex
@synthesize position,
            leastDistance,
            previous,
            visited,
            adjacencies;

+ (Vertex *) newVertex:(CGPoint) position {
    
    Vertex * vertex = [[Vertex alloc] init];
    vertex.position = position;
    vertex.leastDistance = INFINITY;
    vertex.previous = nil;
    vertex.visited = NO;
    //TODO: come back here
    vertex.adjacencies = [NSMutableArray arrayWithCapacity:5];
    return vertex;
}

- (id) copyWithZone:(NSZone *) zone {
    //Should we be calling the super class' copyWithZone?
    return [Vertex newVertex:self.position];
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Vertex: %@", NSStringFromCGPoint(self.position)];
}

@end
