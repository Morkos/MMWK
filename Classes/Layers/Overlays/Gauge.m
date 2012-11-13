//
//  Gauge.m
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Gauge.h"
#import "CCUtil.h"

@interface Gauge()
    -(void) setBarPercentage:(CGFloat) width;
@end
@implementation Gauge

+ (Gauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                          barTextures:(NSArray *) barTextures
                             position:(CGPoint) position
                                scale:(CGSize)scale {
    return [[[Gauge alloc] initWithContainerTexture:containerTexture 
                                        barTextures:barTextures
                                           position: position
                                              scale:scale] autorelease];
}

-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures
                      position:(CGPoint) position
                         scale:(CGSize) scale {
    if (self = [super init]) {
        containerSprite = [CCSprite spriteWithFile:containerTexture];
        containerSprite.position = position;
        containerSprite.scaleX = scale.width;
        containerSprite.scaleY = scale.height;
        containerSprite.anchorPoint = ccp(0, 0);
        
        //TODO: Support multiple bar texture layers
        assert([barTextures count] == 1);
        barSprite = [CCSprite spriteWithFile:[barTextures objectAtIndex:0]];
        barSprite.position = position;
        barSprite.scaleX = scale.width;
        barSprite.scaleY = scale.height;
        barSprite.anchorPoint = ccp(0, 0);
    }
    
    return self;
}

- (void) addToLayer:(CCLayer *) layer {
    [layer addChild:containerSprite z:1];
    [layer addChild:barSprite z:2];
    
    [self setBarPercentage:1.0f];
}

- (void) animateBarFromStartCapacity:(CGFloat) startCapacity
                         endCapacity:(CGFloat) endCapacity
                         maxCapacity:(CGFloat) maxCapacity {
    CGFloat startingPercentage = startCapacity / maxCapacity;
    CGFloat endPercentage = endCapacity / maxCapacity;
    [barSprite runAction:[CCSequence actions:
         [CCScaleTo actionWithDuration:0.0f scaleX:startingPercentage scaleY:barSprite.scaleY],
         [CCScaleTo actionWithDuration:0.25f scaleX:endPercentage scaleY:barSprite.scaleY],
          nil]];
}

- (void) setBarPercentage:(CGFloat) percentage {
    percentage = min(percentage, 1.0f);
    percentage = max(percentage, 0.0f);

    CGFloat scaleXBy = percentage / barSprite.scaleX;
    [barSprite runAction:[CCScaleBy actionWithDuration:0.25f scaleX:scaleXBy scaleY:1.0f]];
    
}

@end
