//
//  BezierCurve.mm
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "BezierCurve.h"


@implementation BezierCurve

@synthesize points;

- (void) addPoint:(CGPoint)point {
	[self.points addObject:[NSValue valueWithCGPoint:point]];
}

- (id) init {
	if (self = [super init]) {
		self.points = [NSMutableArray arrayWithCapacity:20];
	}
	return self;
}

+ (BezierCurve *) curveFrom:(CGPoint)p0
                         c0:(CGPoint)c0
                         c1:(CGPoint)c1
                         to:(CGPoint)p1
                numOfPoints:(uint)numOfPoints {
	BezierCurve *curve = [[BezierCurve alloc] init];
	
	CGFloat interval = 1.0/numOfPoints;
	
	// Create a list of points to make up the curve
	for (CGFloat t = 0; t <= 1.0; t += interval) {
		// P = (1-t)3•P1 + 3•(1-t)2•t•C1 + 3•(1-t)•t2•C2 + t3•P2 
		CGPoint exp0 = pow((1 - t), 3) * p0,
				exp1 = (3 * (pow((1-t), 2)) * t) * c0,
				exp2 = (3 * ((1-t) * pow(t, 2))) * c1,
				exp3 = pow(t, 3) * p1;
		
		CGPoint point =  exp0 + exp1 + exp2 + exp3;
		[curve addPoint:point];
	}
	
	return curve;
}

@end
