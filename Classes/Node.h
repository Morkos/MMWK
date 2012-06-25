//
//  untitled.h
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "Overlay.h"
#import "Loggers.h"

@interface Node : Overlay {
 
}

+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
			  animator:(SpriteSheetAnimator *)spriteSheet;

- (bool) isPressed:(CGPoint)point;
- (void) markValid;
- (void) markInvalid;

@end
