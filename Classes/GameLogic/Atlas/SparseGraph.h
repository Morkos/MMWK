//
//  SparseGraph.h
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Atlas.h"

@interface SparseGraph : NSObject<Atlas> {
    NSMutableArray * adjacencyList;
}

@property (nonatomic, retain) NSMutableArray * adjacencyList;

+ (SparseGraph *) sharedInstance;
- (void) computePaths:(CGPoint) src;

@end
