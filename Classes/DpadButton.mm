//
//  DpadButton.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DpadButton.h"
#import "CoordinateSystem.h"
#import "Loggers.h"

static BOOL flag = false;
@implementation DpadButton

@synthesize sprite,
            coordinateSystem;

+ (DpadButton *) buttonWithSprite:(CCSprite *) sprite {
    DpadButton *button = [[DpadButton alloc] init];
    button.sprite = sprite;
    
    CGFloat width = sprite.contentSize.width * sprite.scaleX;
    CGFloat height = sprite.contentSize.height * sprite.scaleY;
    
    NSLog(@"Width and height of dpad: %lf, %lf, center: (%f, %f)", width, height, sprite.position.x, sprite.position.y);
    CoordinateSystem * coordinateSystem = [CoordinateSystem createWithCenter:sprite.position
                                                                    imgWidth:width 
                                                                   imgHeight:height];
    
    button.coordinateSystem = coordinateSystem;
    return button;
}

- (void) decideHowPlayerShouldMove:(Character *) player
                             point:(CGPoint) point {
    
    Direction direction = [self.coordinateSystem decideDirectionFromPoint:point];
    NSLog(@"Direction picked: %d", direction);
	if (direction == NO_WHERE) {
		[player stand];
	} else {
		[player runTo:direction];
	}	    
}

@end
