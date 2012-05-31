//
//  AnimationTimer.h
//  DragonEye
//
//  Created by mac on 5/25/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Typedefs.h"


@protocol AnimationTimer <NSObject>

@required

/**
 * Updates timer for animation of the object. Returns true if 
 * the object should be updated.
 */
- (bool) updateTimer;

/**
 * A frame interval is the number of frames between each animation
 */
- (void) setFrameInterval:(ulong) frameInterval;
- (ulong) frameInterval;

/**
 * Resets the timer for a new animation
 */
- (void) reset;

@end
