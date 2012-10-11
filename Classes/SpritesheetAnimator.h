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
#import "TexCoords.h"
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

@end
