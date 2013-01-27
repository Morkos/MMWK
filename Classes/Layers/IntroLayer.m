//
//  IntroLayer.m
//  DragonEye-Cocos2D
//
//  Created by mac on 9/17/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "IntroLayer.h"
#import "WorldLayer.h"
#import "SimpleAudioEngine.h"
#import "Level1.h"
#import "WorldAtlas.h"
#import "BattleScene.h"

#pragma mark - IntroLayer

@implementation IntroLayer

-(id) init {
	self = [super init];
    // ask director for the window size
	CGSize size = [[CCDirector sharedDirector] winSize];
    CCSprite *background;
	
	if( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone ) {		
		background = [CCSprite spriteWithFile:@"Default.png"];
		background.rotation = 90;
	}
    
	background.position = ccp(size.width, size.height);
    
    CCLabelTTF * gameLabel = [CCLabelTTF labelWithString:@"Fyka's Memento" 
                                                fontName:@"Courier" 
                                                fontSize:40];
    gameLabel.position = ccp(225, 250);
    
    CCMenuItemFont * font = [CCMenuItemFont itemWithString:@"Start Game" 
                                                    target:self 
                                                  selector:@selector(onClick)];
    [font setFontSize:30];
    [font setFontName:@"Courier"];
    
    CCMenu * menu = [CCMenu menuWithItems:font, nil];
    
    [menu setPosition:ccp(225, 200)];

	// add the label as a child to this Layer
	[self addChild:background];
    [self addChild:menu];
    [self addChild:gameLabel];
        
    return self;
	
}

-(void) onClick {
	[[CCDirector sharedDirector] replaceScene:
     [CCTransitionFade transitionWithDuration:1.0 
                                        scene:[WorldAtlas scene] 
                                    withColor:ccWHITE]];
}

@end
