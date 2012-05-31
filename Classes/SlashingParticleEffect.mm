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
            timer,
			source,
			orientation,
			opacityFactor,
			frameInterval,
			startAngle,
			angleIncrements,
			curIndex,
			isActive;

- (void) startAnimation {
	isActive = true;
    [timer reset];
}

+ (SlashingParticleEffect *) createEffect:(BezierCurve *) path 
									speed:(uint) speed
							 particleSize:(CGSize) size
							   startAngle:(GLfloat) startAngle
								 endAngle:(GLfloat) endAngle
							opacityFactor:(GLfloat) opacityFactor
							frameInterval:(ulong) frameInterval
									image:(Texture *) image {
	
	SlashingParticleEffect *effect = [[SlashingParticleEffect alloc] init];
	uint numOfParticles = [path.points count];
	NSMutableArray *particles = [NSMutableArray arrayWithCapacity:numOfParticles];
	
	GLfloat divisor = pow(numOfParticles/2, 2);
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
													  angle:0.0f
													opacity:opacity
													  image:image
													isAlive:false
							  ]
		 ];
	}
	
	effect.particles = particles;
	effect.speed = speed;
	effect.opacityFactor = opacityFactor;
	effect.frameInterval = frameInterval;
	effect.startAngle = startAngle;
	effect.angleIncrements = (endAngle - startAngle) / numOfParticles;
    effect.timer = [FrameBasedTimer createTimerWithFrameInterval:frameInterval];
	
	// TODO: Hack so it wouldn't be invoked on construction the first time.
	effect.curIndex = numOfParticles;
	
	return effect;
}
								   
- (void) draw {
	for (Particle *particle in particles) {
		[particle draw];
	}
}

- (void) update {
    if (isActive && 
        [timer updateTimer]) {
        // Create a particle for each point in the path
        for (uint i = 0; i < speed; i++) {
            if (curIndex < [particles count]) {
                Particle *particle = ((Particle *)[particles objectAtIndex:curIndex]);
                [particle moveBack];
                
                CGPoint newPosition = source;
                GLfloat angle = startAngle + (i * angleIncrements);
                
                // Flip slash horizontally
                if (orientation == ORIENTATION_FORWARD) {
                    newPosition.x += particle.position.x;
                    [particle rotateBy:angle];
                } else if (orientation == ORIENTATION_BACKWARDS) {
                    newPosition.x -= particle.position.x;
                    [particle rotateBy:-angle];
                }
                
                newPosition.y += particle.position.y;
                
                [particle moveTo:newPosition];
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
                particle.opacity /= opacityFactor;
                
                if (particle.opacity < 0.1) {
                    particle.isAlive = false;
                    particle.opacity = particle.startingOpacity;
                }
            }
        }
    }
}

- (void) invoke:(Prop *) prop {
	curIndex = 0;
	
	// Can only use slashing effect on Characters
	if (![[prop class] isSubclassOfClass:[Character class]]) {
		return;
	}
	
	Character *character = (Character *) prop;
	orientation = character.currentOrientation;
	
	// TODO: Change screen size. Mark shall remove dependency on screen size
	source = [GraphicsEngine convertPointToGl:character.position];
	
	[self startAnimation];
}

@end
