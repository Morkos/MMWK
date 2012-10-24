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

@interface Overlay : NSObject <Drawable> {
	SpriteSheet *spriteSheet;
	OverlayState currentState;
	CGPoint position;
	CGSize size;
}

@property (nonatomic, retain) SpriteSheet *spriteSheet;
@property (nonatomic, assign) OverlayState currentState;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

- (id) initWithPosition:(CGPoint)position 
                   size:(CGSize)size 
            spriteSheet:(SpriteSheet *)spriteSheet;

// From GraphicsContext protocol
- (void) update;

- (void) show;
- (void) hide;


@end
