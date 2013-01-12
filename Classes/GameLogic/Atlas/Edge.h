//
//  Edge.h
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vertex.h"

@interface Edge : NSObject {
    NSUInteger cost;
    Vertex * terminalVertex;
}

+ (Edge *) newEdge:(Vertex *) terminalVertex;

@property (nonatomic, assign) NSUInteger cost;
@property (nonatomic, retain) Vertex * terminalVertex;

@end
