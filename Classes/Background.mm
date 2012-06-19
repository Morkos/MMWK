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
			displayLink;

+ (Background *) backgroundWithScrollSpeed:(GLfloat)scrollSpeed {
	
	Background *background = [[Background alloc] init];
	background.textures = [NSMutableArray arrayWithCapacity:10];
	background.rightBoundary = camera.frameDimension.width;
	background.scrollSpeed = scrollSpeed;
	background.scrollDirection = NO_WHERE;
	
	[background startAnimation];
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

- (void) draw {
		
	TexCoords *texCoords = [TexCoords defaultTexCoords];
	
	/* PERF: Don't draw the side of the background that is not on the screen
	   Maybe taken care of by OpenGL already */
	
    /*
     * TODO: Remove mixing of game coordinates and opengl positions here
     *       Try to remove the dependency off the depth field
     */
	NSInteger shift = rightBoundary - (camera.frameDimension.width / 2);
	CGPoint positionLeftNoDepth = CGPointMake(shift, camera.frameDimension.width / 2);
	CGPoint positionRightNoDepth = positionLeftNoDepth;
    
	positionRightNoDepth.x += camera.frameDimension.width;
	
    CGPoint glPositionLeft  = [GraphicsEngine convertPointToGl:positionLeftNoDepth];
	CGPoint glPositionRight = [GraphicsEngine convertPointToGl:positionRightNoDepth];
	
    GLPosition glPositionLeftWithDepth = {glPositionLeft.x, glPositionLeft.y, 1.0};
    GLPosition glPositionRightWithDepth = {glPositionRight.x, glPositionRight.y, 1.0}; 
		
	CGSize size = CGSizeMake(camera.frameDimension.width,
							 camera.frameDimension.height);
	CGSize glSize = [GraphicsEngine convertSizeToGl:size];
	
    // Drawing the left side of the background
	[GraphicsEngine drawTexture:[self.textures objectAtIndex:[self getBgIndexFromPosition:positionLeftNoDepth]]
					  texCoords:texCoords 
					   position:glPositionLeftWithDepth
						   size:glSize 
					orientation:ORIENTATION_FORWARD];
	
	// Drawing the right side of the background
	[GraphicsEngine drawTexture:[self.textures objectAtIndex:[self getBgIndexFromPosition:positionRightNoDepth]] 
					  texCoords:texCoords 
					   position:glPositionRightWithDepth
						   size:glSize 
					orientation:ORIENTATION_FORWARD];
}

- (void) startAnimation {
	
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];
	
	[aDisplayLink setFrameInterval:1];
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}

- (GLfloat) wrapBoundary:(GLfloat) boundary {

	if (boundary < camera.frameBoundary.left) {
		
		GLfloat shift = boundary;
		boundary = camera.frameDimension.width + shift;

	} 

	return boundary;
}

- (void) update {

}

- (void) animate {
	
	if (scrollDirection == LEFT) {
		rightBoundary -= scrollSpeed;
	} else if (scrollDirection == RIGHT) {
		rightBoundary += scrollSpeed;
	}
	
	rightBoundary = [self wrapBoundary:rightBoundary];
}
	 
- (void) scroll:(Direction) direction {
	scrollDirection = direction;
}

@end
