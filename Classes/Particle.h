//
//  Particle.h
//  DragonEye
//
//  Created by alkaiser on 4/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"
#import "GraphicsEngine.h"


@interface Particle : NSObject {
	Texture *image;
	GLfloat startingOpacity, opacity;
	CGPoint prevPosition;
	CGPoint position;
	GLfloat angle, startAngle;
	CGSize size;
	Orientation orientation;
	bool isAlive;
}

@property (nonatomic, retain) Texture *image;
@property (nonatomic, assign) GLfloat startingOpacity, opacity;
@property (nonatomic, assign) CGPoint prevPosition;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) GLfloat angle, startAngle;
@property (nonatomic, assign) CGSize size;
@property (nonatomic, assign) Orientation orientation;
@property (nonatomic, assign) bool isAlive;
		   
+ (Particle *) particleWithPosition:(CGPoint) position
									   size:(CGSize) size
									  angle:(GLfloat) angle
									opacity:(GLfloat) opacity
									  image:(Texture *) image
									isAlive:(bool) isAlive;

- (void) draw;

/**
 * Move to new position
 * @param newPosition The new position
 */
- (void) moveTo:(CGPoint) newPosition;

/**
 * Rotate the particle by angle in radians
 * @param angleIncrement The angle in radians to rotate by
 */
- (void) rotateBy:(GLfloat) angleIncrement;

/**
 * Move back to original state
 */
- (void) moveBack;

@end
