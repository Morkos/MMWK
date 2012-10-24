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
            currentState, 
            position, 
            size;

- (id) initWithPosition:(CGPoint)positionParam 
                   size:(CGSize)sizeParam 
            spriteSheet:(SpriteSheet *)spriteSheetParam {
	
    if (self = [super init]) {
        self.position = positionParam;
        self.size = sizeParam;
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
