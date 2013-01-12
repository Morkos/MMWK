//
//  Edge.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Edge.h"

@implementation Edge
@synthesize cost,
            terminalVertex;

+ (Edge *) newEdge:(Vertex *)terminalVertex {
    
    Edge * edge = [[Edge alloc] init];
    
    edge.cost = 1;
    edge.terminalVertex = terminalVertex;
    
    return edge;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"Cost: %d, %@", self.cost, self.terminalVertex];
}

@end
