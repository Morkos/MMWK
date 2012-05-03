//
//  SlashingParticleEffect.mm'
//  DragonEye
//
//  Created by alkaiser on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SlashingParticleEffect.h"


@implementation SlashingParticleEffect

@synthesize speed,
			particles,
			distanceFromSource,
			displayLink,
			curIndex,
			isActive;

- (void) startAnimation {
	if (!self.displayLink) {
		CADisplayLink *aDisplayLink = [CADisplayLink displayLinkWithTarget:self 
																  selector:@selector(animate)];
		[aDisplayLink setFrameInterval:1];
		[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
						   forMode:NSDefaultRunLoopMode];
		
		self.displayLink = aDisplayLink;
	}
}

- (void) stopAnimation {
	if (self.displayLink) {
		[self.displayLink invalidate];
		self.displayLink = nil;
	}
}

+ (SlashingParticleEffect *) createEffect:(BezierCurve *) path 
									speed:(uint) speed
							 particleSize:(CGSize) size
							   startAngle:(GLfloat) startAngle
								 endAngle:(GLfloat) endAngle
					   distanceFromSource:(GLfloat) distance
									image:(Texture *) image {
	
	SlashingParticleEffect *effect = [[SlashingParticleEffect alloc] init];
	effect.speed = speed;
	effect.distanceFromSource = distance;
	
	uint numOfParticles = [path.points count];
	NSMutableArray *particles = [NSMutableArray arrayWithCapacity:numOfParticles];
	
	GLfloat divisor = pow(numOfParticles/2, 2);
	GLfloat angleIncrements = (endAngle - startAngle) / numOfParticles;
	uint halfNumOfParticles = numOfParticles/2;
	for (uint i = 0; i < numOfParticles; i++) {
		CGPoint position = [[path.points objectAtIndex:i] CGPointValue];
		GLfloat opacity = 1.0f;
		
		// Starting from the half way point, create an effect of fading in
		// inwards
		if (i >= halfNumOfParticles) {
			GLfloat x = i - halfNumOfParticles;
			opacity = (-pow(x, 2) / divisor) + 1.0f;
		}
		
		//TODO: Use parameters instead of hard coded values
		[particles addObject:[Particle particleWithPosition:position 
													   size:size
													  angle:startAngle + (i * angleIncrements)
													opacity:opacity
													  image:image
													isAlive:false
							  ]
		 ];
	}
	
	effect.particles = particles;
	
	// TODO: Hack so it wouldn't be invoked on construction the first time.
	effect.curIndex = [particles count];
	
	return effect;
}
								   
- (void) draw {
	for (Particle *particle in particles) {
		[particle draw];
	}
}

- (void) update {
}

- (void) animate {
	// Create a particle for each point in the path
	for (uint i = 0; i < speed; i++) {
		if (curIndex < [particles count]) {
			Particle *particle = ((Particle *)[particles objectAtIndex:curIndex]);
			[particle moveBack];
			[particle moveTo:(particle.position + CGPointMake(distanceFromSource, 0))];
			particle.isAlive = true;
			curIndex++;			  
		} else {
			break;
		}
	}
	
	// Fade out each particle that has been drawn
	isActive = false;
	for (uint i = 0; i < curIndex; i++) {
		Particle * particle = [particles objectAtIndex:i];
		
		if (particle.isAlive) {
			isActive = true;
			particle.opacity /= 1.15f;
			
			if (particle.opacity < 0.1) {
				particle.isAlive = false;
				particle.opacity = particle.startingOpacity;
			}
		}
	}
	
	if (!isActive) {
		[self stopAnimation];
	}
}

- (void) invoke:(Prop *) prop {
	curIndex = 0;
	
	// Can only use slashing effect on Characters
	if (![[prop class] isSubclassOfClass:[Character class]]) {
		return;
	}
	
	Character *character = (Character *) prop;
	
	if (((character.currentOrientation == ORIENTATION_FORWARD) && distanceFromSource < 0) || 
		((character.currentOrientation == ORIENTATION_BACKWARDS) && distanceFromSource > 0)) {
		distanceFromSource = -distanceFromSource;
	}
	
	[self startAnimation];
}

@end
