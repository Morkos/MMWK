//
//  HUDLayer.m
//  DragonEye
//
//  Created by mac on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"

@implementation HUDLayer

- (id) init {
    if (self = [super init]) {
        // enable events
#ifdef __CC_PLATFORM_IOS
		self.isTouchEnabled = YES;
		//self.isAccelerometerEnabled = YES;
#elif defined(__CC_PLATFORM_MAC)
		self.isMouseEnabled = YES;
#endif  
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"dpadNintendo.png"];
        sprite.position = ccp(50, 50);
        sprite.scale = 0.75f;
        
        dpadButton = [DpadButton buttonWithSprite:sprite];
        
        [self addChild:dpadButton.sprite];	
    }
    
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    Character *character = [[ObjectContainer sharedInstance] player];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
		[dpadButton decideHowPlayerShouldMove:character point:location];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    Character *character = [[ObjectContainer sharedInstance] player];
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        
		location = [[CCDirector sharedDirector] convertToGL: location];
		[dpadButton decideHowPlayerShouldMove:character point:location];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    Character *character = [[ObjectContainer sharedInstance] player];
	for(UITouch *touch in touches ) {
        [character stand];
	}
}


@end
