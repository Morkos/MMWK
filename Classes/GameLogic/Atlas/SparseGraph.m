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
#import "NSPropertyUtil.h"
#import "ObjectContainer.h"

static SparseGraph * sparseGraph = nil;

@implementation SparseGraph
@synthesize adjacencyList;

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

- (void) loadGraphByPropertyList:(NSString *) plist {
    
    NSMutableDictionary * stringKeyToVertices = [NSMutableDictionary dictionaryWithCapacity:10];
    
    NSDictionary * atlasProps = [NSPropertyUtil loadProperties:plist];
    NSDictionary * verticesPlist = [atlasProps objectForKey:@"Vertices"];
    NSArray * edgesPlist = [atlasProps objectForKey:@"edges"];
    
    self.adjacencyList = [NSMutableArray arrayWithCapacity:[verticesPlist count]];
    
    [verticesPlist enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        NSString * position = (NSString *) obj;
        NSArray * positions = [position componentsSeparatedByString:@","];
        Vertex * vertex = [Vertex newVertex:cpv(
                                                [[positions objectAtIndex:0] intValue],
                                                [[positions objectAtIndex:1] intValue])
                           ];
        
        [self.adjacencyList addObject:vertex];
        [stringKeyToVertices setObject:vertex 
                                forKey:key];
        
    }];
    
    NSRegularExpression * regex = [NSRegularExpression regularExpressionWithPattern:@"(\\w+)\\s*:\\s*([a-z,\\s*]+)" 
                                                                            options:NSRegularExpressionCaseInsensitive 
                                                                              error:nil];
    
    NSString * edgeStrings = [edgesPlist description];
    NSArray * matches = [regex matchesInString:edgeStrings
                                       options:0 
                                         range:NSMakeRange(0, [edgeStrings length])];
    
    for(NSTextCheckingResult * match in matches) {
        NSString * vertex = [edgeStrings substringWithRange:[match rangeAtIndex:1]];
        NSString * adjacencies = [edgeStrings substringWithRange:[match rangeAtIndex:2]];
        
        NSArray * edges = [adjacencies componentsSeparatedByString:@","];
        for (NSString * edge in edges) {
            NSString * trimmeddge = [edge stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
            [SparseGraph addUndirectEdge:[stringKeyToVertices objectForKey:vertex] 
                                     end:[stringKeyToVertices objectForKey:trimmeddge]];
            
        }
        
    }
    
    CCLOG(@"Sparse-Graph: %@", self.adjacencyList);
}

+ (SparseGraph *) sharedInstance {
    if (sparseGraph == nil) {
        sparseGraph = [[SparseGraph alloc] init];
        [sparseGraph loadGraphByPropertyList:@"level1-atlas.plist"];
    }
    return sparseGraph;
}

- (Vertex *) findNearestNode:(CGPoint)point {
    Player * player = [ObjectContainer sharedInstance].player;
    
    for(Vertex * vertex in sparseGraph.adjacencyList) {
        if(cpvdist(vertex.position, point) < 10) {
            return vertex;
        }
    }
    
    if([player isTravelingTheWorld]) {
        return  player.behavior.start;
    }
    
    //TODO: if a user clicks another node to go to while traveling; it will fail.
    return nil;
}

- (void) computePaths:(CGPoint) src {
    
    Vertex * start = [self findNearestNode:src];
    CCLOG(@"recomputing paths from %@", start);
    
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
    Vertex * current = nil;
    
    for(current = end; ! CGPointEqualToPoint(current.position, source.position); current = current.previous) {
        NSLog(@"vertex: %@", current);
        [array addObject:current];
    }
    
    if (current) { //hack
        [array addObject:current];
    }
    
    NSMutableArray * reverseArray = 
        [NSMutableArray arrayWithArray:[[array reverseObjectEnumerator] allObjects]];
    
    return reverseArray;
}

@end
