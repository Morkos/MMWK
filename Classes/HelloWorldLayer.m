//
//  HelloWorldLayer.m
//  DragonEye-Cocos2D
//
//  Created by mac on 9/17/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"

// Import the interfaces
#import "HelloWorldLayer.h"
#import "PhysicsSprite.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "Enemy.h"
enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
	
    HelloWorldLayer *layer = [HelloWorldLayer node];
    BackgroundLayer * bgLayer = [BackgroundLayer node];
	HUDLayer *hudLayer = [HUDLayer node];
    
	// add layer as a child to scene
    [scene addChild:bgLayer z:-2];
	[scene addChild:layer];
	[scene addChild:hudLayer z:2];
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"lancelotSpSheet.png" capacity:100];

		[self addChild:parent z:1 tag:kTagParentNode];	
        
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];

        PlayerBuilder *builder = [PlayerBuilder newBuilder:ccp(120,220) 
                                                      size:CGSizeMake(10.0f, 10.0f)
                                                    sprite:[spriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]
                                     ];
        
        
        Player *player = [[builder buildSpriteSheet:spriteSheet] build];
        [[ObjectContainer sharedInstance] addObject:player];
        
        [parent addChild:player.sprite];
		[self scheduleUpdate];
	}
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

-(void) update:(ccTime) delta {
    [[[ObjectContainer sharedInstance] player] update];
}

#pragma mark GameKit delegate

-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end
