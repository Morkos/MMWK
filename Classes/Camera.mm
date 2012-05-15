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
			lockCamera;

- (void) triggerUpdateLoop {
	
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(update)] 
								   retain];
	
	[aDisplayLink setFrameInterval:1];
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
}

+ (Camera *) getInstance {
	
	DLOG("Setup and returning Camera singleton.");
	return [Camera getInstance:defaultFrameDimension];
	
}

+ (Camera *) getInstance:(PositiveDimension) position {
	
	if (!camera) {
		
		camera = [[Camera alloc] init];
		Boundary bounds = { 0,  position.width };

		camera.frameDimension = position;		
		camera.frameBoundary = bounds;
		camera.mainPlayer = [ObjectContainer singleton].player;
		camera.lockCamera = FALSE;
		
		[camera triggerUpdateLoop];
		
		DLOG("LB: %d, RB: %d", 
			 camera.frameBoundary.left, 
			 camera.frameBoundary.right);
	}
	
	return camera;
	
}

- (void) update {
	
	Player * player = [ObjectContainer singleton].player;
		
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

- (void) lockCamera {
    
    self.lockCamera = TRUE;
    
}
    

@end
