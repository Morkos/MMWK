/*
 *  PropState.h
 *  DragonEye
 *
 *  Created by alkaiser on 3/21/12.
 *  Copyright 2012 __MyCompanyName__. All rights reserved.
 *
 */
#ifndef PROP_STATE_H
#define PROP_STATE_H

typedef enum {
	NO_WHERE,      // 0
	UP,            // 1
	DOWN,          // 2  
	LEFT,          // 3
	RIGHT,         // 4
	UP_LEFT,       // 5
 	UP_RIGHT,      // 6
	DOWN_LEFT,     // 7
	DOWN_RIGHT,    // 8
	MAX_DIRECTIONS // 9
} Direction;

typedef enum {
	OVERLAY_HIDDEN,
	OVERLAY_SHOWN
} OverlayState;

typedef enum {
	ORIENTATION_FORWARD,
	ORIENTATION_BACKWARDS
} Orientation;

extern bool isDirectionRight(Direction direction);

extern bool isDirectionLeft(Direction direction);

// TODO: Only handle LEFT and RIGHT directions
extern Orientation getOrientationFromDirection(Direction direction);

#endif
