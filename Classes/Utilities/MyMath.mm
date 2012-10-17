//
//  Math.mm
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MyMath.h"

// Operator overloads
CGPoint operator*(const CGFloat &c, const CGPoint &p0) {
	return CGPointMake(c * p0.x, c * p0.y);
}

CGPoint operator +(const CGPoint &p0, const CGPoint &p1) {
	return CGPointMake(p0.x + p1.x, p0.y + p1.y);
}

CGPoint operator -(const CGPoint &p0, const CGPoint &p1) {
	return CGPointMake(p0.x - p1.x, p0.y - p1.y);
}

CGPoint operator -(const CGPoint &p) {
	return CGPointMake(-p.x, -p.y);
}