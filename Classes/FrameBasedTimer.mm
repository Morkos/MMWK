//
//  FrameBasedTimer.m
//  DragonEye
//
//  Created by mac on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FrameBasedTimer.h"

@implementation FrameBasedTimer

@synthesize frameCount,
            frameInterval;

+ (FrameBasedTimer *) createTimerWithFrameInterval:(ulong) frameInterval {
    FrameBasedTimer *timer = [[FrameBasedTimer alloc] init];
    timer.frameCount = 0;
    timer.frameInterval = frameInterval;
    
    return timer;
}

- (bool) updateTimer {
    if ((self.frameCount++ % self.frameInterval) == 0) {
        return true;
    }
    
    return false;
}

- (void) reset {
    frameCount = 0;
}

@end
