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
#import "FrameBasedTimer.h"

/**
 * Implements a slashing particle effect. 
 * BUG: Since there is only one list of particles at any one time, one 
 *		slashing effect cannot be invoked more than once.
 */
@interface SlashingParticleEffect : NSObject<ParticleEffect> {
	NSMutableArray *particles;
    id<AnimationTimer> timer;
	CGPoint source;
	Orientation orientation;
	GLfloat opacityFactor;
	ulong frameInterval;
	GLfloat startAngle, angleIncrements;
	uint speed;
	uint curIndex;
	bool isActive;
}

@property (nonatomic, retain) NSMutableArray *particles;
@property (nonatomic, retain) id<AnimationTimer> timer;
@property (nonatomic, assign) CGPoint source;
@property (nonatomic, assign) Orientation orientation;
@property (nonatomic, assign) GLfloat opacityFactor;
@property (nonatomic, assign) ulong frameInterval;
@property (nonatomic, assign) GLfloat startAngle, angleIncrements;
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
 * @param opacityFactor The factor by how much to fade out the particles
 * @param frameInterval The frame interval for the effect's animation
 * @param image The texture to use for the slashing effect
 */
+ (SlashingParticleEffect *) createEffect:(BezierCurve *) path 
									speed:(uint) speed
							 particleSize:(CGSize) size
							   startAngle:(GLfloat) startAngle
								 endAngle:(GLfloat) endAngle
							opacityFactor:(GLfloat) opacityFactor
							frameInterval:(ulong) frameInterval
									image:(Texture *) image;

- (void) draw;
- (void) update;
- (void) invoke:(Prop *) prop;

@end
