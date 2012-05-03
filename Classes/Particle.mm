//
//  TrailingParticle.mm
//  DragonEye
//
//  Created by alkaiser on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Particle.h"


@implementation Particle

@synthesize image,
			startingOpacity,
			opacity,
			prevPosition,
			position,
			size,
			angle,
			isAlive;

+ (Particle *) particleWithPosition:(CGPoint) position
									   size:(CGSize) size
									  angle:(GLfloat) angle
									opacity:(GLfloat) opacity
									  image:(Texture *) image 
									isAlive:(bool) isAlive {
	
	Particle *particle = [[Particle alloc] init];
	particle.position = particle.prevPosition = position;
	particle.size = size;
	particle.angle = angle;
	particle.image = image;
	particle.startingOpacity = opacity;
	particle.opacity = opacity;
	particle.isAlive = isAlive;
	
	return particle;
}

- (void) draw {
	if (isAlive) {
		Position glPosition = {position.x, position.y, (position.y + 1.0) / 2.0};
		[GraphicsEngine drawTexture:image
						  texCoords:[TexCoords defaultTexCoords]
						   position:glPosition 
							   size:size 
							  angle:angle
						orientation:ORIENTATION_FORWARD
							opacity:opacity];
	}
}

- (void) moveTo:(CGPoint) newPosition {
	prevPosition = position;
	position = newPosition;
}

- (void) moveBack {
	CGPoint temp = position;
	position = prevPosition;
	prevPosition = temp;
}

@end
