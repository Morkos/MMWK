//
//  Gauge.m
//  DragonEye
//
//  Created by Mark Mikhail on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Gauge.h"
#import "CCUtil.h"

@implementation Gauge

+ (Gauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                          barTextures:(NSArray *) barTextures{
    return [[[Gauge alloc] initWithContainerTexture:containerTexture 
                                        barTextures:barTextures] autorelease];
}

-(id) initWithContainerTexture:(NSString *) containerTexture
                   barTextures:(NSArray *) barTextures{
    if (self = [super init]) {
        containerSprite = [CCSprite spriteWithFile:containerTexture];
        containerSprite.anchorPoint = ccp(0, 0);
        
        //TODO: Support multiple bar texture layers
        assert([barTextures count] == 1);
        barProgressTimer = [CCProgressTimer progressWithSprite:[CCSprite spriteWithFile:[barTextures objectAtIndex:0]]];
        barProgressTimer.anchorPoint = ccp(0, 0);
        barProgressTimer.midpoint = ccp(0, 0);
        barProgressTimer.type = kCCProgressTimerTypeBar;
        barProgressTimer.barChangeRate = ccp(1, 0);
    }
    
    [self addChild:containerSprite z:1];
    [self addChild:barProgressTimer z:2];
    
    return self;
}

- (void) animateBarFromStartCapacity:(CGFloat) startCapacity
                         endCapacity:(CGFloat) endCapacity
                         maxCapacity:(CGFloat) maxCapacity {
    CCAction * action = 
        [self createAnimationActionFromStartCapacity:startCapacity 
                                         endCapacity:endCapacity 
                                         maxCapacity:maxCapacity];
    
    [barProgressTimer runAction:action];
}

- (CCFiniteTimeAction *) createAnimationActionFromStartCapacity:(CGFloat) startCapacity
                                          endCapacity:(CGFloat) endCapacity
                                          maxCapacity:(CGFloat) maxCapacity {
    CGFloat startingPercentage = (startCapacity / maxCapacity) * 100;
    CGFloat endPercentage = (endCapacity / maxCapacity) * 100;
    
    return [CCProgressFromTo actionWithDuration:0.25f
                                           from:startingPercentage 
                                             to:endPercentage];
}

@end
