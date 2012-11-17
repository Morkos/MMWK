//
//  Gauge.h
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gauge : CCNode {
    CCSprite *containerSprite;
    CCProgressTimer *barProgressTimer;
}

+ (Gauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                          barTextures:(NSArray *) barTextures;

-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures;

- (void) animateBarFromStartCapacity:(CGFloat) startCapacity
                         endCapacity:(CGFloat) endCapacity
                         maxCapacity:(CGFloat) maxCapacity;

- (CCFiniteTimeAction *) createAnimationActionFromStartCapacity:(CGFloat) startCapacity
                                          endCapacity:(CGFloat) endCapacity
                                          maxCapacity:(CGFloat) maxCapacity;
@end
