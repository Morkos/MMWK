//
//  Gauge.h
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gauge : NSObject {
    @private
    NSUInteger gauge;    
}

@property (nonatomic, assign) NSUInteger gauge;

/**
 * Increase the guage's capacity.
 * @param quantity the amount to increase 
 */
- (void) increase:(NSUInteger) quantity;

/**
 * Decrease the guage's capacity.
 * @param quantity the amount to decrease 
 */
- (void) decrease:(NSUInteger) quantity;

@end
