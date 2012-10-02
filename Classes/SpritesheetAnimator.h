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
#import "TexCoords.h"
#import "AnimatorConstants.h"

/**
 * A utility class used to animate an object
 */
@interface SpriteSheetAnimator : NSObject {
}

+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) key
                 replay:(bool) isReplay;

+ (void) startAnimation:(CCSprite *) sprite
            spriteSheet:(SpriteSheet *) spriteSheet
               frameKey:(NSString *) key
                 replay:(bool) isReplay
          frameInterval:(float) frameInterval;

@end
