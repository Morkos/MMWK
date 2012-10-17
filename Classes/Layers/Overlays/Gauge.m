//
//  Gauge.m
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Gauge.h"

@implementation Gauge
@synthesize gauge;

- (void) increase:(NSUInteger) quantity {
    self.gauge += quantity;
}

- (void) decrease:(NSUInteger) quantity {
    self.gauge -= quantity;
}

@end
