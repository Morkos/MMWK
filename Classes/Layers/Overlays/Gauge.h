//
//  Gauge.h
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Gauge : NSObject {
    CGFloat capacity, maxCapacity;
    CCSprite *containerSprite;
    CCSprite *barSprite;
}

+ (Gauge *) gaugeWithMaxCapacity:(CGFloat) maxCapacity
                containerTexture:(NSString *) containerTexture
                     barTextures:(NSArray *) barTextures
                        position:(CGPoint) position
                           scale:(CGSize) scale;

-(id) initWithMaxCapacity:(CGFloat) maxCapacity
         containerTexture:(NSString *) containerTexture
              barTextures:(NSArray *) barTextures
                 position:(CGPoint) position
                    scale:(CGSize) scale;


/**
 * Increase the guage's capacity.
 * @param quantity the amount to increase 
 */
- (void) increase:(CGFloat) quantity;

/**
 * Decrease the guage's capacity.
 * @param quantity the amount to decrease 
 */
- (void) decrease:(CGFloat) quantity;

- (void) addToLayer:(CCLayer *) layer;

@end
