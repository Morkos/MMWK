//
//  BezierCurve.h
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Math.h"

/**
 * A class to create a bezier curve. 
 *
 */
@interface BezierCurve : NSObject {
	NSMutableArray *points;
}

@property (nonatomic, retain) NSMutableArray *points;

- (id) init;
/**
 * Create a bezier curve
 * @param p0 The first point to connect from
 * @param p1 The second point to connect to
 * @param numOfPoints Number of points between p0 to p1
 */
+ (BezierCurve *) curveFrom:(CGPoint)p0 
						 to:(CGPoint)p1
						 c0:(CGPoint)c0
						 c1:(CGPoint)c1
				numOfPoints:(uint)numOfPoints; 

@end
