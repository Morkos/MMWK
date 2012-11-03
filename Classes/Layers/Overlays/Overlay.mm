//
//  Overlay.mm
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Overlay.h"

@implementation Overlay

@synthesize spriteSheet, 
            currentState;

- (id) initWithPosition:(CGPoint)position 
                   size:(CGSize)size 
            spriteSheet:(SpriteSheet *)spriteSheetParam {
	
    if (self = [super init]) {
        self.position = position;
        self.scaleX = size.width;
        self.scaleY = size.height;
        self.spriteSheet = spriteSheetParam;
        self.currentState = OVERLAY_SHOWN;
    }
    
    return self;
}

- (void) update {
}

- (void) hide {
	currentState = OVERLAY_HIDDEN;
}

- (void) show {
	currentState = OVERLAY_SHOWN;
}


@end
