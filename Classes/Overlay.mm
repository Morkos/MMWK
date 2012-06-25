//
//  Overlay.mm
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Overlay.h"
#import "Node.h"

@implementation Overlay

@synthesize animator, 
            currentState, 
            position, 
            size;

+ (void) initialize:(Overlay *)overlay 
		   position:(CGPoint)position 
			   size:(CGSize)size 
		spriteSheet:(SpriteSheetAnimator *)animator {
	
	overlay.position = position;
	overlay.size = size;
	overlay.animator = animator;
	overlay.currentState = OVERLAY_SHOWN;
}

- (void) draw {
	if (currentState == OVERLAY_SHOWN) {
		[GraphicsEngine drawOverlay:self];
	}
}

- (void) update {
    [animator animate];
}

- (void) hide {
	currentState = OVERLAY_HIDDEN;
}

- (void) show {
	currentState = OVERLAY_SHOWN;
}


@end
