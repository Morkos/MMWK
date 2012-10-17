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
#import "OverlayLayer.h"
#import "Enemy.h"
#import "PlayerBuilder.h"
#import "EnemyBuilder.h"

#pragma mark - HelloWorldLayer

@implementation HelloWorldLayer

// Helper class method that creates a Scene with the HelloWorldLayer as the only child.
+(CCScene *) scene
{
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];

	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
	
	[scene addChild:[HelloWorldLayer node]];
    [scene addChild:[BackgroundLayer node] z:-2];	
    [scene addChild:[HUDLayer node] z:2];
    [scene addChild:[OverlayLayer node] z:3 tag:tagOverlayLayer];
    
	// return the scene
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
		CCSpriteBatchNode *parent = [CCSpriteBatchNode batchNodeWithFile:@"lancelotSpSheet.png" capacity:100];

		[self addChild:parent z:1];	
        
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        SpriteSheet *spriteSheet2 = [[SpriteSheetManager getInstance] loadSpriteSheet:@"megamanSpSheet.png"];

        PlayerBuilder *builder = [PlayerBuilder newBuilder:ccp(120,220) 
                                                      size:CGSizeMake(10.0f, 10.0f)
                                                    sprite:[spriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]];
        Player *player = [[builder buildSpriteSheet:spriteSheet] build];
        
        EnemyBuilder *builder2 = [EnemyBuilder newBuilder:ccp(220,220) 
                                                     size:CGSizeMake(20.0f, 20.0f)
                                                   sprite:[spriteSheet2 getSpriteForKey:ANIMATOR_STAND frameNum:0]
                                  ];
        Enemy * enemy = [[[builder2 buildSpriteSheet:spriteSheet2] 
                                         buildSpeed:0.50f]
                            build];
        
        [[ObjectContainer sharedInstance] addObject:player];
        [parent addChild:player.sprite];
        [self addChild:enemy.sprite];
        
        [[ObjectContainer sharedInstance] addObject:enemy];

        /**
         * Every node on this layer will follow the main player
         * TODO: calculate the correct width for the world boundary
         */
        [self runAction:[CCFollow actionWithTarget:player.sprite 
                                     worldBoundary:CGRectMake(0, 0, 2000, winSize.height)]];
		[self scheduleUpdate];
	}
	
	return self;
}

- (void)dealloc {
	[super dealloc];
}

-(void) update:(ccTime) delta {
    [[[ObjectContainer sharedInstance] player] update];
    
    Enemy * enemy = [[ObjectContainer sharedInstance] getObject:1];
    
    [enemy update];
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
