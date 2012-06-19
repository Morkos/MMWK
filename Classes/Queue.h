//
//  NSMutableArray+QueueAdditions.h
//  DragonEye
//
//  Created by Mark Mikhail on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (QueueAdditions)
- (id) dequeue;
- (void) enqueue:(id)obj;
- (id) peek;
@end
