//
//  CoordinateSystem.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "PropState.h"

//Tweak these parameters to get the feel of the joystick/dpad correct.
//TODO: these can be made as parameters to a setter or a factory method.

static const NSInteger DEGREES_PER_DIRECTION			   = 45;
static const NSInteger UP_RIGHT_DIRECTION_STARTS_AT_DEGREE = 25;
static const CGFloat RADIUS_PCT_TO_STAND_STILL_IN_CENTER   = 0.10f;

@interface CoordinateSystem : NSObject {
	CGFloat width;
	CGFloat height;
}

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;

/**
 * Sets up a simple 2D coordinate system.
 * NOTE: this mainly used by the dpad/joystick, but could possibly 
 * be used for A.I.
 *
 * @param imgWidth - width of object
 * @param imgHeight - height of object
 * @return CoordinateSystem
 *
 */
+ (CoordinateSystem *) createWithCenter:(CGFloat) imgWidth 
                              imgHeight:(CGFloat) imgHeight;

/**
 * Calculate degrees from a point to point w.r.t x-axis
 * 
 */ 
+ (CGFloat) calculateDegreesFromPoint:(CGPoint) fromPoint
                              toPoint:(CGPoint) toPoint;

/**
 * Given a point (x,y) relative to the coordinate system,
 * it will specify which direction the point is in.
 *
 * Example:
 *   If one hits the point between the up-arrow and right-arrow 
 *   on the dpad (a coordinate system), it will return UP_RIGHT direction
 *   
 * @param point - coordinates of the point
 * @return Direction 
 */
- (Direction) decideDirectionFromSrcToTarget:(CGPoint) srcPoint
                                 targetPoint:(CGPoint) targetPoint;


@end
