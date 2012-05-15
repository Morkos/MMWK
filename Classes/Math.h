//
//  Math.h
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//
#ifndef MYMATH_H
#define MYMATH_H
#import <Foundation/Foundation.h>

/**
 * Operator overload to multiple a point by a constant factor.
 *
 * @param c The constant factor
 * @param p0 The point to multiply to
 * @return the new point
 */
extern CGPoint operator *(const CGFloat &c, const CGPoint &p0);
extern CGPoint operator +(const CGPoint &p0, const CGPoint &p1);
extern CGPoint operator -(const CGPoint &p0, const CGPoint &p1);
extern CGPoint operator -(const CGPoint &p);

#endif