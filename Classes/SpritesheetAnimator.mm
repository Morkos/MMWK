//
//  SpriteSheetAnimator.mm
//  DragonEye
//
//  Created by alkaiser on 5/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpritesheetAnimator.h"

@implementation SpriteSheetAnimator

@synthesize spSheet,
            stringToRowMap,
            timer,
            spsheetRowInd,
            spsheetColInd,
            isReplay,
            isAnimating,
            currentKey;

const NSString *ANIMATOR_STAND = @"stand";
const NSString *ANIMATOR_MOVE = @"move";
NSString *ANIMATOR_ATTACK = @"attack%d";

+ (SpriteSheetAnimator *) createWithSpsheet:(SpriteSheet *) spSheet
                             stringToRowMap:(NSDictionary *) stringToRowMap 
                                      timer:(id<AnimationTimer>) timer {
    SpriteSheetAnimator *spriteSheetAnimator = [[SpriteSheetAnimator alloc] init];
    spriteSheetAnimator.spSheet = spSheet;
    spriteSheetAnimator.stringToRowMap = stringToRowMap;
    spriteSheetAnimator.currentKey = nil;
    spriteSheetAnimator.timer = timer;
    
    return spriteSheetAnimator;
}

- (void) startAnimation:(NSString *) key
                 replay:(bool) isReplayParam { 
    [self startAnimation:key 
                  replay:isReplayParam 
           frameInterval:[timer frameInterval]];
}

- (void) startAnimation:(NSString *) key 
                 replay:(bool) isReplayParam
          frameInterval:(ulong) frameInterval {
    self.isReplay = isReplayParam;
    self.currentKey = key;
    self.spsheetRowInd = [[stringToRowMap objectForKey:key] intValue];
    self.spsheetColInd = 0;
    self.isAnimating = true;
    [timer setFrameInterval:frameInterval];
}

- (void) stopAnimation {
    isAnimating = false;
}

- (void) animate {
    if ([self isAnimating]) {
        if ([timer updateTimer]) {
            uint lastIndex = [[spSheet getTextureCoords:spsheetRowInd] count] - 1;
            if (spsheetColInd++ >= lastIndex) {
                spsheetColInd = 0;
                
                if (!isReplay) {
                    [self stopAnimation];
                }
            }
        }
    }
}

- (bool) isLastAnimation {
    return spsheetColInd == [[spSheet getTextureCoords:spsheetRowInd] count] - 1;
}

@end
