//
//  Enemy.m
//  DragonEye
//
//  Created by Mark Mikhail on 7/30/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Enemy.h"

@implementation Enemy

- (void) update {
    //NSLog(@"hr...");
    [self.currentState updateState];
}
@end
