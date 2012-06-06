//
//  SpriteSheetAnimator.h
//  DragonEye
//
//  Created by alkaiser on 5/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <QuartzCore/QuartzCore.h>
#import "SpriteSheet.h"
#import "Typedefs.h"
#import "AnimationTimer.h"

/**
 * A utility class used to animate an object
 */
@interface SpriteSheetAnimator : NSObject {
    SpriteSheet *spSheet;
    NSDictionary *stringToRowMap;
    id<AnimationTimer> timer;
    uint spsheetRowInd, spsheetColInd;
    bool isReplay, isAnimating;
    NSString *currentKey;
}

@property (nonatomic, retain) SpriteSheet *spSheet;
@property (nonatomic, retain) NSDictionary *stringToRowMap;
@property (nonatomic, retain) id<AnimationTimer> timer;
@property (nonatomic, assign) uint spsheetRowInd, spsheetColInd;
@property (nonatomic, assign) bool isReplay, isAnimating;
@property (nonatomic, copy) NSString *currentKey;

+ (SpriteSheetAnimator *) createWithSpsheet:(SpriteSheet *) spSheet
                             stringToRowMap:(NSDictionary *) stringToRowMap
                                      timer:(id<AnimationTimer>) timer;

- (void) startAnimation:(NSString *) key
                 replay:(bool) isReplay;

- (void) startAnimation:(NSString *) key
                 replay:(bool) isReplay
          frameInterval:(ulong) frameInterval;

- (void) stopAnimation;

- (void) animate;

- (bool) isAnimating;

- (bool) isLastAnimation;

@end
