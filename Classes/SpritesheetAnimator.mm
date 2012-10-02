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
                 replay:(bool) isReplay { 
    [SpriteSheetAnimator startAnimation:sprite
                            spriteSheet:spriteSheet
                               frameKey:key 
                                 replay:isReplay 
                          frameInterval:0.1f];
}

+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) key
                 replay:(bool) isReplay
          frameInterval:(float) frameInterval {
    
    NSLog(@"Start animation for key %@, isReplay: %d, frameInterval: %f", 
          key, isReplay, frameInterval);
    NSArray *animFrames = [spriteSheet getSpriteFramesForKey:key];
    CCAnimation *animationAction = [CCAnimation 
                             animationWithSpriteFrames:animFrames];
    animationAction.delayPerUnit = frameInterval;
    
    CCAction *action;
    if (isReplay) {
        action = [CCRepeatForever actionWithAction: [CCAnimate actionWithAnimation:animationAction]];
    } else {
        //TODO
    }
    
    action.tag = TAG_ANIMATION_ACTION;
    
    [sprite stopActionByTag:TAG_ANIMATION_ACTION];
    [sprite runAction:action];

}

@end
