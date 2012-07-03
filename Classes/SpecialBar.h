//
//  SpecialBar.h
//  DragonEye
//
//  Created by Mark Mikhail on 6/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SpecialBar : NSObject {
@private
    NSInteger gauge;    
}

@property (nonatomic, assign) NSInteger gauge;

/**
 * SpecialBar is a gauge that allows the main player
 * to perform combos
 *
 * @return a single instance of SpecialBar
 */
+ (id) getInstance;

- (void) increaseBar:(NSInteger) quantity;
- (void) decreaseBar:(NSInteger) quantity;


@end
