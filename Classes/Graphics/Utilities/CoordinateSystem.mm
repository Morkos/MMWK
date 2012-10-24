//
//  CoordinateSystem.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/1/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CoordinateSystem.h"
#import "PolarCoordinates.h"
#import "Loggers.h"

@implementation CoordinateSystem
@synthesize width, 
            height;

//Data-driven technique to get direction from degrees
//start counter-clock wise, and have the 0th index be the RIGHT direction
//and wrap around back to the RIGHT direction on the last index.
static Direction indexToDirection[MAX_DIRECTIONS + 1] = {
    RIGHT,
    UP_RIGHT,
    UP,
    UP_LEFT,
    LEFT,
    DOWN_LEFT,
    DOWN,
    DOWN_RIGHT,
    RIGHT
};
static BOOL withinCenterOfRadius(CGPoint, CGFloat);

+ (CoordinateSystem *) createWithCenter:(CGFloat) imgWidth 
                              imgHeight:(CGFloat) imgHeight {
	
    CoordinateSystem *coordinateSystem = [[CoordinateSystem alloc] init];
    coordinateSystem.width = imgWidth;
    coordinateSystem.height = imgHeight;
    
	return coordinateSystem;
	
}

+ (CGFloat) calculateDegreesFromPoint:(CGPoint) fromPoint
                              toPoint:(CGPoint) toPoint {
	
    CGFloat xDiff = toPoint.x - fromPoint.x;
    CGFloat yDiff = toPoint.y - fromPoint.y;
    
    //normalize y to origin by flipping substraction
    //CGFloat yDiff = fromPoint.y - toPoint.y;
    
	CGFloat degrees = 0;
	
	NSNumber * angle = [NSNumber numberWithFloat:atan2f(yDiff, xDiff)];
    degrees = TO_DEGREES([angle floatValue]);
	
	if (degrees < 0) {
		degrees += FULL_CYCLE_IN_DEGREES;
	}

    return degrees;
}

- (Direction) decideDirectionFromSrcToTarget:(CGPoint) srcPoint
                                 targetPoint:(CGPoint) targetPoint {
	CGFloat degrees = [CoordinateSystem calculateDegreesFromPoint:srcPoint
                                                          toPoint:targetPoint];
    
    degrees += UP_RIGHT_DIRECTION_STARTS_AT_DEGREE;
	
    //find radius using pythag. d thm
	CGFloat radius = PYTHAG(self.width, self.height);
    
    NSLog(@"SrcPoint: (%f, %f), TargetPoint: (%f, %f), degrees: %f, radius: %f", srcPoint.x, 
          srcPoint.y, targetPoint.x, targetPoint.y, degrees, radius);
    
    // Shift point so that it is relative to origin
	if (withinCenterOfRadius(CGPointMake(targetPoint.x - (self.width/2), 
                                         targetPoint.y - (self.height/2)), 
                             radius)) {
		return NO_WHERE;
		
	} else {
		//This will find the correct direction to go to including diagonals.
	    NSInteger index = ((int) degrees) / DEGREES_PER_DIRECTION;
		return indexToDirection[index];
	}
}

@end

static BOOL withinCenterOfRadius(CGPoint point, CGFloat radius) {
	float radiusPrime = RADIUS_PCT_TO_STAND_STILL_IN_CENTER * radius;
	return fabsf(point.x) < radiusPrime && fabsf(point.y) < radiusPrime;
}
