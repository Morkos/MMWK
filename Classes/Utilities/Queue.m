//
//  NSMutableArray+QueueAdditions.m
//  DragonEye
//
//  Created by Mark Mikhail on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"

//Possible TODO: change this to inheritance and add a traversal ptr.
@implementation NSMutableArray (QueueAdditions)

- (id) dequeue {
    if([self count] == 0) {
        return nil;
    }
    
    //id obj = [[[self objectAtIndex:0] retain] autorelease];
    [self removeObjectAtIndex:0];
    return nil;
}

- (void) enqueue:(id) obj {
    [self addObject:obj];
}

- (BOOL) isEmpty {
    return [self count] == 0;
}

@end
