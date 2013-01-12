//
//  MainMenu.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenu.h"
#import "IntroLayer.h"

@implementation MainMenu

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	IntroLayer *layer = [IntroLayer node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}

@end
