//
//  Overlay.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "GraphicsEngine.h"
#import "SpriteSheetAnimator.h"
#import "PropState.h"

@class Node;

@interface Overlay : NSObject <Drawable> {
	SpriteSheetAnimator *animator;
	OverlayState currentState;
	CGPoint position;
	CGSize size;
}

@property (nonatomic, retain) SpriteSheetAnimator *animator;
@property (nonatomic, assign) OverlayState currentState;
@property (nonatomic, assign) CGPoint position;
@property (nonatomic, assign) CGSize size;

+ (void) initialize:(Overlay *)overlay 
		   position:(CGPoint)position 
			   size:(CGSize)size 
		spriteSheet:(SpriteSheetAnimator *)animator;

// From GraphicsContext protocol
- (void) draw;
- (void) update;

- (void) show;
- (void) hide;


@end
