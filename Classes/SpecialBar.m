//
//  SpecialBar.m
//  DragonEye
//
//  Created by Mark Mikhail on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SpecialBar.h"

static SpecialBar * specialBar = nil;

@implementation SpecialBar

@synthesize gauge;

+ (id) getInstance {
    
    if (!specialBar) {
        specialBar = [[SpecialBar alloc] init];
        specialBar.gauge = 0;
    }
    return specialBar;
}

- (void) increaseBar:(NSInteger) quantity {
    self.gauge += quantity;
}

- (void) decreaseBar:(NSInteger)quantity {
    if((self.gauge - quantity) >= 0) {
        self.gauge -= quantity;
    }
}

@end
