//
//  Overlay.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "SpriteSheetAnimator.h"
#import "PropState.h"

@interface Overlay : CCSprite <Drawable> {
	SpriteSheet *spriteSheet;
	OverlayState currentState;
}

@property (nonatomic, retain) SpriteSheet *spriteSheet;
@property (nonatomic, assign) OverlayState currentState;

- (id) initWithPosition:(CGPoint)position 
                   size:(CGSize)size 
            spriteSheet:(SpriteSheet *)spriteSheet;

// From GraphicsContext protocol
- (void) update;

- (void) show;
- (void) hide;


@end
