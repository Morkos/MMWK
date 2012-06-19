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

//pure C-style for private functions within in a file.
- (void) decideHowPlayerShouldMove:(CGPoint) point
                             width:(NSInteger) width
                            height:(NSInteger) height {
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *player = singleton.player;
	
    
    CoordinateSystem * coordinateSystem = [CoordinateSystem initWithDimensions:width 
                                                                     imgHeight:height];
    
    Direction direction = [coordinateSystem decideDirectionFromCartestian:point.x 
                                                              yCoordinate:point.y];
	if (direction == NO_WHERE) {
		[player stand];
	} else {
		[player runTo:direction];
	}	    
}

- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point  = [touch locationInView:self];
	
	[self decideHowPlayerShouldMove:point 
                              width:self.frame.size.width 
                             height:self.frame.size.height];
}


- (void) touchesMoved:(NSSet *)touches 
			withEvent:(UIEvent *)event {
	
	UITouch *touch = [[touches allObjects] objectAtIndex:0];
	CGPoint point  = [touch locationInView:self];
	
	[self decideHowPlayerShouldMove:point 
                              width:self.frame.size.width 
                             height:self.frame.size.height];
}

- (void)touchesEnded:(NSSet *)touches 
		   withEvent:(UIEvent *)event {
	
	ObjectContainer *singleton = [ObjectContainer singleton];
	Player *player = singleton.player;
	
	[player stand];
}

@end
