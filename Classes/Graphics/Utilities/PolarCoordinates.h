//
//  PolarCoordinates.h
//  DragonEye
//
//  Created by Mark Mikhail on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "math.h"
#import <math.h>

#define HALF_CYCLE_IN_DEGREES 180
#define FULL_CYCLE_IN_DEGREES 360

#define TO_DEGREES(radians) ((radians) * HALF_CYCLE_IN_DEGREES / M_PI)
#define TO_RADIANS(degrees) ((degrees) * M_PI / HALF_CYCLE_IN_DEGREES)

#define PYTHAG(x, y) sqrt(pow((x), 2) + pow((y), 2))