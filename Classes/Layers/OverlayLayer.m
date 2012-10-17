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
        
        self.isTouchEnabled = true;
    }
    
    return self;
}

- (void) displayNodes:(NSString *) comboKey {
    [self.freezeModeManager displayNodes:comboKey];
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        [self.freezeModeManager processNodesTouches:location];
    }
}

- (void) dealloc {
    [self.freezeModeManager release];
    [super dealloc];
}

@end
