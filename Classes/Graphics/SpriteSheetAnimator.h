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
#import "AnimatorConstants.h"

/**
 * A utility class used to animate an object
 */
@interface SpriteSheetAnimator : NSObject {
}

/**
 * Start animation using a given sprite, and runs forever. 
 *
 *@param sprite The CCSprite object to run the animation on
 *@param spriteSheet The sprite sheet where the images are stored
 *@param frameKey The frameKey to use on the spriteSheet to get the CCSpriteFrames
 *@param frameInterval The interval between each frame
 */
+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) frameKey
          frameInterval:(float) frameInterval;

/**
 * Start animation using a given sprite, by running the CCAction on the sprite 
 * given by the selector.
 *
 *@param sprite The CCSprite object to run the animation on
 *@param spriteSheet The sprite sheet where the images are stored
 *@param frameKey The frameKey to use on the spriteSheet to get the CCSpriteFrames
 *@param frameInterval The interval between each frame
 *@param target The target for the selector
 *@param selector The selector to create the CCAction to run on the sprite. 
 *                The selector need to follow the following implementation: 
 *                 -(CCAction *) selector:(CCAnimation *) animationAction
 */
+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) frameKey
          frameInterval:(float) frameInterval
                 target:(id) target
               selector:(SEL) selector;

/**
 * Starts a series of animations using a given sprite, by running a series of CCAction on the sprite 
 * given by the selector.
 *
 *@param sprite The CCSprite object to run the animation on
 *@param spriteSheet The sprite sheet where the images are stored
 *@param frameKeys An array of NSString objects to be used as frameKeys on the spriteSheet to get the CCSpriteFrames 
 *                 for each animation action
 *@param frameInterval The interval between each frame
 *@param target The target for the selector
 *@param selector The selector to create the CCAction to run on the sprite. 
 *                The selector need to follow the following implementation: 
 *                 -(CCAction *) selector:(NSArray *) animationActions
 *                 where animationActions is an array of CCAnimationAction.
 */
+ (void) startAnimationSeries:(CCSprite *) sprite
                  spriteSheet:(SpriteSheet *) spriteSheet
                    frameKeys:(NSArray *) frameKeys
                frameInterval:(float) frameInterval
                       target:(id) target
                     selector:(SEL) selector;

+ (CCAnimation *) createAnimationAction:(NSString *) key
                            spriteSheet:(SpriteSheet *) spriteSheet
                          frameInterval:(float) frameInterval;

@end
