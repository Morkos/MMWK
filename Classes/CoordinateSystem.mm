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
@synthesize width, height;

static Direction indexToDirection[MAX_DIRECTIONS + 1];
static BOOL withinCenterOfDPad(float, float, float);

//TODO: take out if issue is not fixed.
static CoordinateSystem * coordinateSystem;

//Private Method (alternative style for private fxns; although there's 
//no clean way of doing private methods
//in Objective-C)
- (id) init:(NSInteger)imgWidth imgHeight:(NSInteger)imgHeight {
	
	if (self = [super init]) {
		self.width  = imgWidth / 2;
		self.height = imgHeight / 2;
	}
	return self;
	
}

+ (CoordinateSystem *) initWithDimensions:(NSInteger)imgWidth 
								imgHeight:(NSInteger)imgHeight {
	
	//Data-driven technique to get direction from degrees
	//start counter-clock wise, and have the 0th index be the RIGHT direction
	//and wrap around back to the RIGHT direction on the last index.
	//TODO: initialize this only once.
    if(!coordinateSystem) {
        indexToDirection[0] = RIGHT;
        indexToDirection[1] = UP_RIGHT;
        indexToDirection[2] = UP;
        indexToDirection[3] = UP_LEFT;
        indexToDirection[4] = LEFT;
        indexToDirection[5] = DOWN_LEFT;
        indexToDirection[6] = DOWN;
        indexToDirection[7] = DOWN_RIGHT;
        indexToDirection[8] = RIGHT;
	
        coordinateSystem = [[CoordinateSystem alloc] init:imgWidth 
                                                imgHeight:imgHeight];
    }
	//[coordinateSystem autorelease];
	return coordinateSystem;
	
}

+ (CGFloat) calculateDegreesFromPoint:(CGPoint) fromPoint
                              toPoint:(CGPoint) toPoint {
	
    CGFloat xDiff = toPoint.x - fromPoint.x;
    
    //normalize y to origin by flipping substraction
    CGFloat yDiff = fromPoint.y - toPoint.y;
    
	CGFloat degrees = 0;
	
	NSNumber * angle = [NSNumber numberWithFloat:atan2f(yDiff, xDiff)];
    degrees = TO_DEGREES([angle floatValue]);
	
	if (degrees < 0) {
		degrees += FULL_CYCLE_IN_DEGREES;
	}

    return degrees;
}

- (Direction) decideDirectionFromCartestian:(CGFloat)xCoordinate 
								yCoordinate:(CGFloat)yCoordinate {
	
	//normalize x to origin by subtracting it
	CGFloat pointX = xCoordinate - self.width;
	CGFloat pointY = yCoordinate - self.height;
	
	CGFloat degrees = [CoordinateSystem calculateDegreesFromPoint:CGPointMake(0.0f, 0.0f) 
                                        toPoint:CGPointMake(pointX, pointY)];
    
    degrees += UP_RIGHT_DIRECTION_STARTS_AT_DEGREE;
	
    //find radius using pythag. d thm
	CGFloat radius = PYTHAG(self.width, self.height);
	if (withinCenterOfDPad(pointX, pointY, radius)) {
		return NO_WHERE;
		
	} else {
		//This will find the correct direction to go to including diagonals.
	    NSInteger index = ((int) degrees) / DEGREES_PER_DIRECTION;
		return indexToDirection[index];
	}
}

@end

static BOOL withinCenterOfDPad(CGFloat pointX, CGFloat pointY, CGFloat radius) {
	
	float radiusPrime = RADIUS_PCT_TO_STAND_STILL_IN_CENTER * radius;
	return fabsf(pointX) < radiusPrime && fabsf(pointY) < radiusPrime;
}
