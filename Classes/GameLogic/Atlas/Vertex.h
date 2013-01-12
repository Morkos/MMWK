//
//  Vertex.h
//  DragonEye
//
//  Created by Mark Mikhail on 12/17/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

@interface Vertex : NSObject<NSCopying> {
    CGPoint position;
    NSMutableArray * adjacenies;
    NSUInteger leastDistance;
    Vertex * previous;
    BOOL visited;
}

@property (nonatomic, assign) CGPoint position;
@property (nonatomic, retain) NSMutableArray * adjacencies;
@property (nonatomic, assign) NSUInteger leastDistance;
@property (nonatomic, retain) Vertex * previous;
@property (nonatomic, assign) BOOL visited;

+ (Vertex *) newVertex:(CGPoint) position;
- (id) copyWithZone:(NSZone *) zone;

@end
