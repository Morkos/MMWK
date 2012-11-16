//
//  EnemyHealthGauge.m
//  DragonEye
//
//  Created by Alkaiser on 11/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "EnemyHealthGauge.h"
#import "AnimatorConstants.h"

@interface EnemyHealthGauge()
    -(CCFiniteTimeAction *) show;
    -(CCFiniteTimeAction *) hide;
    -(CCFiniteTimeAction *) delay;
    -(CCFiniteTimeAction *) getActionForNodeIndex:(NSUInteger) i
                                    startCapacity:(CGFloat) startCapacity
                                      endCapacity:(CGFloat) endCapacity
                                      maxCapacity:(CGFloat) maxCapacity;
@end
@implementation EnemyHealthGauge

+ (EnemyHealthGauge *) gaugeWithContainerTexture:(NSString *) containerTexture
                                     barTextures:(NSArray *) barTextures {
    return [[[EnemyHealthGauge alloc] initWithContainerTexture:containerTexture 
                                                   barTextures:barTextures] autorelease];
}

- (id) initWithContainerTexture:(NSString *) containerTexture 
                    barTextures:(NSArray *) barTextures {
    if (self = [super initWithContainerTexture:containerTexture
                                    barTextures:barTextures]) { 
        [containerSprite runAction:[self hide]];
        ccNodesArr = [[NSArray arrayWithObjects:containerSprite, barProgressTimer, nil] retain];
    }
    
    return self;
}

- (void) animateBarFromStartCapacity:(CGFloat) startCapacity 
                         endCapacity:(CGFloat) endCapacity 
                         maxCapacity:(CGFloat) maxCapacity {
    
    // TODO: A lot of the actions are duplicated between the container and the actual bar. Need refactoring
    for (int i = 0; i < [ccNodesArr count]; i++) {
        NSMutableArray *actionsArr = [NSMutableArray arrayWithCapacity:5];
        CCNode * node = [ccNodesArr objectAtIndex:i];
        bool isActionRunning = [node getActionByTag:TAG_GAUGE_ACTION] != nil;
        
        // If an action is not running, add "show" action to the beginning
        if (!isActionRunning) {
            [actionsArr addObject:[self show]];
        }
        
        [actionsArr addObject:[self getActionForNodeIndex:i 
                                            startCapacity:startCapacity
                                              endCapacity:endCapacity
                                              maxCapacity:maxCapacity]];
        [actionsArr addObject:[self delay]];
        [actionsArr addObject:[self hide]];
        
        CCAction *sequenceAction = [CCSequence actionWithArray:actionsArr];
        sequenceAction.tag = TAG_GAUGE_ACTION;
        
        if (isActionRunning) {
            [node stopActionByTag:TAG_GAUGE_ACTION];
        }
        
        [node runAction:sequenceAction];
    }
}

- (CCFiniteTimeAction *) show {
    return [CCFadeIn actionWithDuration:0.1f];
}

- (CCFiniteTimeAction *) hide {
    return [CCFadeOut actionWithDuration:0.25f];
}

- (CCFiniteTimeAction *) delay {
    return [CCDelayTime actionWithDuration:3.0f];
}
         
- (CCFiniteTimeAction *) getActionForNodeIndex:(NSUInteger) i
                                startCapacity:(CGFloat) startCapacity
                                  endCapacity:(CGFloat) endCapacity
                                  maxCapacity:(CGFloat) maxCapacity {
    // For containerSprite
    if (i == 0) {
        return [CCDelayTime actionWithDuration:0.25f];
    } 
    // For barProgress
    else if (i == 1) {
        return [super createAnimationActionFromStartCapacity:startCapacity
                                                 endCapacity:endCapacity 
                                                 maxCapacity:maxCapacity];
    } else {
        return nil;
    }
}
     
- (void) dealloc {
    [ccNodesArr release];
    [super dealloc];
}
@end
