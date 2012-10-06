//
//  SpriteSheetAnimator.mm
//  DragonEye
//
//  Created by alkaiser on 5/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SpritesheetAnimator.h"

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
    
    NSArray *animFrames = [spriteSheet getSpriteFramesForKey:key];
    CCAnimation *animationAction = [CCAnimation animationWithSpriteFrames:animFrames];
    animationAction.delayPerUnit = frameInterval;

    CCAction *action;
    if (selector == NULL || target == NULL) {
        action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animationAction]];
    } else {
        action = [target performSelector:selector withObject:animationAction];
    }
    
    action.tag = TAG_ANIMATION_ACTION;
    
    [sprite stopActionByTag:TAG_ANIMATION_ACTION];
    [sprite runAction:action];

}

@end
