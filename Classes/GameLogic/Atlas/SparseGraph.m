//
//  SparseGraph.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SparseGraph.h"
#import "Edge.h"
#import "Vertex.h"
#import "chipmunk.h"
#import "Queue.h"

static SparseGraph * sparseGraph = nil;

@implementation SparseGraph
@synthesize adjacencyList,
            shortestPath;

Vertex * getLeastCostVertex(Queue * queue) {
    NSUInteger minDistance = INFINITY;
    Vertex * leastDistanceVertex = nil;
    
    for(Vertex * vertex in queue) {
        if (vertex.leastDistance < minDistance) {
            minDistance = vertex.leastDistance;
            leastDistanceVertex = vertex;
        }
    }
    
    [queue removeObject:leastDistanceVertex];
    return leastDistanceVertex;
}

+ (void) addUndirectEdge:(Vertex *) start 
                     end:(Vertex *) end {
    
    [start.adjacencies addObject:[Edge newEdge:end]];
    [end.adjacencies addObject:[Edge newEdge:start]];
}

+ (SparseGraph *) sharedInstance {
    if (sparseGraph == nil) {
        sparseGraph = [[SparseGraph alloc] init];
        sparseGraph.adjacencyList = [NSMutableArray arrayWithCapacity:10];
        sparseGraph.shortestPath = [NSMutableArray arrayWithCapacity:10];
        
        Vertex * start = [Vertex newVertex:cpv(50, 245)];
        Vertex * a = [Vertex newVertex:cpv(105, 220)];
        Vertex * b = [Vertex newVertex:cpv(163, 230)];
        Vertex * c = [Vertex newVertex:cpv(273, 243)];
        Vertex * d = [Vertex newVertex:cpv(332, 246)];
        Vertex * e = [Vertex newVertex:cpv(442, 243)];
        Vertex * f = [Vertex newVertex:cpv(439, 243)];
        Vertex * g = [Vertex newVertex:cpv(378, 138)];
        Vertex * belowLadder = [Vertex newVertex:cpv(439, 138)];

        Vertex * h = [Vertex newVertex:cpv(364, 151)];
        Vertex * end = [Vertex newVertex:cpv(360, 186)];
                
        Vertex * off = [Vertex newVertex:cpv(100, 75)];
        
        [SparseGraph addUndirectEdge:start end:a];
        [SparseGraph addUndirectEdge:start end:off];
        [SparseGraph addUndirectEdge:off end:end];
        
        [SparseGraph addUndirectEdge:a end:b];
        [SparseGraph addUndirectEdge:b end:c];
        [SparseGraph addUndirectEdge:c end:d];
        [SparseGraph addUndirectEdge:d end:e];
        [SparseGraph addUndirectEdge:e end:f];
        [SparseGraph addUndirectEdge:f end:g];
        [SparseGraph addUndirectEdge:g end:h];
        [SparseGraph addUndirectEdge:h end:end];
        
        [SparseGraph addUndirectEdge:belowLadder end:g];
        [SparseGraph addUndirectEdge:f end:belowLadder];
        
        [sparseGraph.adjacencyList addObject:start];
        [sparseGraph.adjacencyList addObject:off];
        [sparseGraph.adjacencyList addObject:belowLadder];
        [sparseGraph.adjacencyList addObject:a];
        [sparseGraph.adjacencyList addObject:b];
        [sparseGraph.adjacencyList addObject:c];
        [sparseGraph.adjacencyList addObject:d];
        [sparseGraph.adjacencyList addObject:e];
        [sparseGraph.adjacencyList addObject:f];
        [sparseGraph.adjacencyList addObject:g];
        [sparseGraph.adjacencyList addObject:h];
        [sparseGraph.adjacencyList addObject:end];
        
        NSLog(@"Sparse-Graph: %@", sparseGraph.adjacencyList);
        
        [sparseGraph computePaths:start.position];
    }
    return sparseGraph;
}

- (Vertex *) findNearestNode:(CGPoint)point {
    for(Vertex * vertex in sparseGraph.adjacencyList) {
        if(cpvdist(vertex.position, point) < 10) {
            return vertex;
        }
    }
    
    return nil;
}

- (void) computePaths:(CGPoint) src {
    
    
    Vertex * start = [self findNearestNode:src];
    NSLog(@"recomputing paths from %@", start);
    Queue * queue = [NSMutableArray arrayWithCapacity:10];
    [queue enqueue:start];
    
    for(Vertex * vertex in sparseGraph.adjacencyList) {
        vertex.visited = NO;
        vertex.leastDistance = INFINITY;
        vertex.previous = nil;
    }
    
    start.leastDistance = 0;
    
    while (! [queue isEmpty]) {
        Vertex * current = getLeastCostVertex(queue);
        current.visited = YES;
        for (Edge * edge in current.adjacencies) {
            Vertex * next = edge.terminalVertex;
            
            NSUInteger distance = edge.cost + current.leastDistance;
            if (!next.visited && distance < next.leastDistance) {
                next.leastDistance = distance;
                next.previous = current;
                [queue addObject:next];
            }
        }
    }
}

- (NSMutableArray *) findShortestPath:(CGPoint) src 
                               target:(CGPoint) target {
   
    NSMutableArray * array = [NSMutableArray arrayWithCapacity:10];
    Vertex * end = [self findNearestNode:target];
    Vertex * source = [self findNearestNode:src];

    Vertex * vertex = nil;
    for(vertex = end; ! CGPointEqualToPoint(vertex.position, source.position); vertex = vertex.previous) {
        NSLog(@"vertex: %@", vertex);
        [array addObject:vertex];
    }
    
    NSLog(@"last %@", vertex);
    if (vertex) { //hack
        [array addObject:vertex];
    }
    
    
    NSMutableArray * reverseArray = 
        [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    return reverseArray;
}

@end
