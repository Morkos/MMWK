//
//  OverlayLayer.m
//  DragonEye
//
//  Created by mac on 10/7/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "OverlayLayer.h"

@implementation OverlayLayer

@synthesize freezeModeManager;

- (id) init {
    if (self = [super init]) {
        self.freezeModeManager = [FreezeModeManager managerWithPlist:@"combos.plist"
                                                               layer:self];
    }
    
    return self;
}

- (void) displayNodes:(NSString *) comboKey {
    [self.freezeModeManager displayNodes:comboKey];
}

- (void) dealloc {
    [self.freezeModeManager release];
    [super dealloc];
}

@end
