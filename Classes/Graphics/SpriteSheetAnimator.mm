//
//  SpriteSheetAnimator.mm
//  DragonEye
//
//  Created by alkaiser on 5/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpritesheetAnimator.h"

@interface SpriteSheetAnimator ()
@end
@implementation SpriteSheetAnimator

+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) key 
          frameInterval:(float)frameInterval { 
    [SpriteSheetAnimator startAnimation:sprite
                            spriteSheet:spriteSheet
                               frameKey:key 
                          frameInterval:frameInterval
                                 target:NULL
                                 selector:NULL];
}

+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) key
          frameInterval:(float) frameInterval
                 target:(id) target
               selector:(SEL) selector {
    
    CCAnimation *animationAction = 
        [SpriteSheetAnimator createAnimationAction:key
                                       spriteSheet:spriteSheet
                                     frameInterval:frameInterval];

    CCAction *action;
    if (selector == NULL || target == NULL) {
        action = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animationAction]];
    } else {
        action = [target performSelector:selector withObject:animationAction];
    }
    
    action.tag = TAG_ANIMATION_ACTION;
    
    [sprite stopActionByTag:TAG_ANIMATION_ACTION];
    [sprite runAction:action];

}

+ (void) startAnimationSeries:(CCSprite *) sprite
                  spriteSheet:(SpriteSheet *) spriteSheet
                    frameKeys:(NSArray *) frameKeys
                frameInterval:(float) frameInterval
                       target:(id) target
                     selector:(SEL) selector {

    NSMutableArray *animations = [NSMutableArray arrayWithCapacity:[frameKeys count]];
    
    for (NSString *key in frameKeys) {
        CCAnimation *animationAction = 
            [SpriteSheetAnimator createAnimationAction:key
                                           spriteSheet:spriteSheet
                                         frameInterval:frameInterval];
        
        [animations addObject:animationAction];
    }
    
    CCAction *action = [target performSelector:selector withObject:animations];
    
    action.tag = TAG_ANIMATION_ACTION;
    
    [sprite stopActionByTag:TAG_ANIMATION_ACTION];
    [sprite runAction:action];
}   

+ (CCAnimation *) createAnimationAction:(NSString *) key
                            spriteSheet:(SpriteSheet *) spriteSheet
                          frameInterval:(float) frameInterval {
    NSArray *animFrames = [spriteSheet getSpriteFramesForKey:key];
    CCAnimation *animationAction = [CCAnimation animationWithSpriteFrames:animFrames];
    animationAction.delayPerUnit = frameInterval;
    
    return animationAction;
}


@end
