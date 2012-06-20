//
//  LinePoints.h
//  DragonEye
//
//  Created by mac on 6/6/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>

/**
 * A class to represent a list of points representing
 * a straight line
 */
@interface LinePoints : NSObject {
    NSMutableArray *points;
}

@property (nonatomic, retain) NSMutableArray *points;

+ (LinePoints *) createWithStart:(CGPoint) start
                             end:(CGPoint) end
                     numOfPoints:(uint) numOfPoints;
                    
@end
