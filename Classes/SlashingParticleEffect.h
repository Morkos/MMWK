//
//  SlashingParticleEffect.h
//  DragonEye
//
//  Created by alkaiser on 4/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import <Math.h>
#import "Texture.h"
#import "BezierCurve.h"
#import "Typedefs.h"
#import "GraphicsEngine.h"
#import "ObjectContainer.h"
#import "Particle.h"
#import "ParticleEffect.h"
#import "Math.h"

/**
 * Implements a slashing particle effect. 
 */
@interface SlashingParticleEffect : NSObject<ParticleEffect> {
	CADisplayLink *displayLink;
	NSMutableArray *particles;
	GLfloat distanceFromSource;
	uint speed;
	uint curIndex;
	bool isActive;
}

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) NSMutableArray *particles;
@property (nonatomic, assign) GLfloat distanceFromSource;
@property (nonatomic, assign) uint speed;
@property (nonatomic, assign) uint curIndex;
@property (nonatomic, assign, readonly, getter=isActive) bool isActive;

/**
 * Create a slashing effect from a given curve path.
 *
 * @param path The curve path the slash would follow. This path has to have (0,0) as the center.
 * @param speed The slashing speed
 * @param particleSize Size of each particle
 * @param startAngle The starting angle of the first particle 
 * @param endAngle The end angle of the last particle
 * @param distanceFromSource Distance of the effect from the source (the prop)
 * @param image The texture to use for the slashing effect
 */
+ (SlashingParticleEffect *) createEffect:(BezierCurve *) path 
									speed:(uint) speed
							 particleSize:(CGSize) size
							   startAngle:(GLfloat) startAngle
								 endAngle:(GLfloat) endAngle
					   distanceFromSource:(GLfloat) distance
									image:(Texture *) image;

- (void) draw;
- (void) update;
- (void) animate;
- (void) invoke:(Prop *) prop;

@end
