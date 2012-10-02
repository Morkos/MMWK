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

enum {
	kTagParentNode = 1,
};


#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
	HelloWorldLayer *layer = [HelloWorldLayer node];
	
	// add layer as a child to scene
	[scene addChild: layer];
	
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
		// Use batch node. Faster
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"lancelotSpSheet.png" capacity:100];
		spriteTexture_ = [parent texture];

		[self addChild:parent z:1 tag:kTagParentNode];	
        
        [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        PlayerBuilder *builder = [PlayerBuilder newBuilder:ccp(20,20) 
                                                      size:CGSizeMake(10.0f, 10.0f)
                                                    sprite:[spriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]
                                     ];
        Player *player = [[builder buildSpriteSheet:spriteSheet] build];
        [[ObjectContainer sharedInstance] addObject:player];
        
        [parent addChild:player.sprite];
        [self addChild:[BackgroundLayer node] z:-2];
        [self addChild:[HUDLayer node] z:2];

		[self scheduleUpdate];
	}
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

-(void) update:(ccTime) delta {
    [[[ObjectContainer getInstance] player] update];
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
