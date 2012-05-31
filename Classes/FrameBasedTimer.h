//
//  FrameBasedTimer.h
//  DragonEye
//
//  Created by mac on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AnimationTimer.h"
#import "Typedefs.h"

@interface FrameBasedTimer : NSObject<AnimationTimer> {
    ulong frameCount, frameInterval;
}

@property(nonatomic, assign) ulong frameCount, frameInterval;

+ (FrameBasedTimer *) createTimerWithFrameInterval:(ulong) frameInterval;
- (bool) updateTimer;
- (void) reset;
@end
