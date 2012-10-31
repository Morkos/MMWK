/*
 *  Typedefs.h
 *  DragonEye
 *
 *  Created by alkaiser on 3/10/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */

#ifndef TYPEDEFS_H
#define TYPEDEFS_H

typedef unsigned int uint;
typedef unsigned long ulong;

typedef struct Center {
	
	CGPoint origin;
	
} Center;


typedef struct Rectangle {
	
	CGPoint topLeft;
	CGPoint bottomRight;
	
} Rectangle;

/**
 * Positive dimensions
 */
typedef struct PositiveDimension {
	
	NSUInteger width;
	NSUInteger height;
	
} PositiveDimension;

/**
 * Denotes Game boundaries
 */

typedef struct Boundary {
	
	NSUInteger left;
	NSUInteger right;
	
} Boundary;

typedef struct Coordinate {
	
	NSInteger x;
	NSInteger y;
	
} Coordinate;

typedef struct {
	CGFloat x,y,z; 
} GLPosition;

// Shortcut macro for format NSStrings
#define NSSTRING_FORMAT(str, ...) [NSString stringWithFormat:(str), ##__VA_ARGS__]


#endif