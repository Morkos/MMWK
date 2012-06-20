//
//  LinePoints.m
//  DragonEye
//
//  Created by mac on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LinePoints.h"

@implementation LinePoints

@synthesize points;

- (void) addPoint:(CGPoint)point {
	[self.points addObject:[NSValue valueWithCGPoint:point]];
}

static void swap(CGFloat &x, CGFloat &y) {
    CGFloat temp = y;
    y = x;
    x = temp;
}

+ (LinePoints *) createWithStart:(CGPoint) start
                             end:(CGPoint) end 
                     numOfPoints:(uint)numOfPoints{
    LinePoints *line = [[LinePoints alloc] init];
    line.points = [NSMutableArray arrayWithCapacity:numOfPoints];
    
    // Taken from http://en.wikipedia.org/wiki/Bresenham%27s_line_algorithm#Generalization
    CGFloat x0 = start.x,
            x1 = end.x,
            y0 = start.y,
            y1 = end.y;
    
    bool steep = fabsf(y1 - y0) > fabsf(x1 - x0);
    
    if (steep) { 
        swap(x0, y0);
        swap(x1, y1);
    }
    
    if(x0 > x1) {
        swap(x0, x1);
        swap(y0, y1);
    }
    
    CGFloat deltax = x1 - x0;
    CGFloat deltay = fabsf(y1 - y0);
    CGFloat error = 0;
    CGFloat deltaerr = deltay / deltax;
    CGFloat ystep = deltay / numOfPoints;
    CGFloat xstep = deltax / numOfPoints;
    CGFloat y = y0;
    
    if (y0 >= y1) {
        ystep = -ystep;
    }
    
    for (CGFloat x = x0; x <= x1; x += xstep) {
        if (steep) { 
            [line addPoint:CGPointMake(y,x)];
        } else { 
            [line addPoint:CGPointMake(x,y)];
        }
        error = error + deltaerr;
        if (error >= 0.5) {
            y = y + ystep;
            error = error - 1.0;
        }
    }
    
    return line;
}

@end
