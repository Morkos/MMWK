//
//  Gauge.h
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gauge : NSObject {
    CCSprite *containerSprite;
    CCSprite *barSprite;
}

+ (Gauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                          barTextures:(NSArray *) barTextures
                             position:(CGPoint) position
                                scale:(CGSize) scale;

-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures
                      position:(CGPoint) position
                         scale:(CGSize) scale;


- (void) addToLayer:(CCLayer *) layer;

- (void) animateBarFromStartCapacity:(CGFloat) startCapacity
                         endCapacity:(CGFloat) endCapacity
                         maxCapacity:(CGFloat) maxCapacity;

@end
