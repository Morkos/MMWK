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

+ (id) getInstance {
    if (!specialBar) {
        specialBar = [[SpecialBar alloc] init];
        specialBar.gauge = 0;
    }
    return specialBar;
}

@end
