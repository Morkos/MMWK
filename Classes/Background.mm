//
//  Background.mm
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Background.h"
#import "Camera.h"

static Camera * camera = [Camera getInstance];

@implementation Background

@synthesize textures, 
            bgSequence,
			rightBoundary,
			scrollSpeed,
			scrollDirection,
            timer;

+ (Background *) backgroundWithScrollSpeed:(GLfloat)scrollSpeed {
	
	Background *background = [[Background alloc] init];
	background.textures = [NSMutableArray arrayWithCapacity:10];
	background.rightBoundary = camera.frameDimension.width;
	background.scrollSpeed = scrollSpeed;
	background.scrollDirection = NO_WHERE;
    background.timer = [FrameBasedTimer createTimerWithFrameInterval:1];
	
	return background;
}

///////////////////////////////////////////////////////////////
//helper/private method
- (NSUInteger) getBgIndexFromPosition:(CGPoint) position {
	
    return [[bgSequence objectAtIndex:(position.x / camera.frameDimension.width)] intValue];
	
}
///////////////////////////////////////////////////////////////

- (void) addBackgroundTexture:(Texture *) texture {
	
	[self.textures addObject:texture];
	 
}

- (GLfloat) wrapBoundary:(GLfloat) boundary {

	if (boundary < camera.frameBoundary.left) {
		
		GLfloat shift = boundary;
		boundary = camera.frameDimension.width + shift;

	} 

	return boundary;
}

- (void) update {
    if ([timer updateTimer]) {
        if (scrollDirection == LEFT) {
            rightBoundary -= scrollSpeed;
        } else if (scrollDirection == RIGHT) {
            rightBoundary += scrollSpeed;
        }
        
        rightBoundary = [self wrapBoundary:rightBoundary];
    }
}
	 
- (void) scroll:(Direction) direction {
	scrollDirection = direction;
}

@end
