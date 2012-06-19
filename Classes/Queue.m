//
//  NSMutableArray+QueueAdditions.m
//  DragonEye
//
//  Created by Mark Mikhail on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Queue.h"

@implementation NSMutableArray (Queue)

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

- (id) peek {
    return [self objectAtIndex:0];
}
@end
