//
//  Atlas.h
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Vertex.h"

@protocol Atlas <NSObject>

@required

- (void) computePaths:(CGPoint) src;

- (NSMutableArray *) findShortestPath:(CGPoint) src
                        target:(CGPoint) target;

- (Vertex *) findNearestNode:(CGPoint) point;

@end
