//
//  Camera.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Camera.h"
#import "ObjectContainer.h"

static Camera * camera = NULL;
static PositiveDimension defaultFrameDimension = { 100, 100 };

@implementation Camera

@synthesize frameDimension,
			frameBoundary,
            endOfLevelBoundary,
			mainPlayer,
			isCameraLocked,
            timer;

+ (Camera *) getInstance {
	
	//DLOG("Setup and returning Camera singleton.");
	return [Camera getInstance:defaultFrameDimension];
	
}

+ (Camera *) getInstance:(PositiveDimension) position {
	
	if (!camera) {
		
		camera = [[Camera alloc] init];
		Boundary bounds = { 0,  position.width };

		camera.frameDimension = position;		
		camera.frameBoundary = bounds;
		camera.mainPlayer = [ObjectContainer sharedInstance].player;
		camera.isCameraLocked = FALSE;
        camera.timer = [FrameBasedTimer createTimerWithFrameInterval:1];
		
		DLOG("LB: %d, RB: %d", 
			 camera.frameBoundary.left, 
			 camera.frameBoundary.right);
	}
    
	return camera;
	
}

- (void) update {
	
    if ([timer updateTimer]) {
        Player * player = [ObjectContainer sharedInstance].player;
            
        NSInteger distanceFromTheRight = frameBoundary.right - player.position.x;
        
        //end of level.
        if (player.position.x > (endOfLevelBoundary - DISTANCE_FROM_RIGHT_TO_ADVANCE_FRAME)) {
            [self lockCamera];
        }

        
        if (!self.isLocked && distanceFromTheRight < DISTANCE_FROM_RIGHT_TO_ADVANCE_FRAME) {
         
            NSInteger shift = DISTANCE_FROM_RIGHT_TO_ADVANCE_FRAME - distanceFromTheRight;
            frameBoundary.right += shift; 
            frameBoundary.left  += shift;
        }
    }
}

- (void) lockCamera {
    self.isCameraLocked = true;
}
    

@end
