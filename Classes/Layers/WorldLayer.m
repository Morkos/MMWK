//
//  WorldLayer.m
//  DragonEye-Cocos2D
//
//  Created by mac on 9/17/12.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "AppDelegate.h"

// Import the interfaces
#import "WorldLayer.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "OverlayLayer.h"
#import "PlayerBuilder.h"
#import "EnemyBuilder.h"
#import "Enemy.h"
#import "CCBlade.h"

#pragma mark - WorldLayer
@interface WorldLayer ()
    -(void) sortChildrenByYPosition;
@end
@implementation WorldLayer

// Helper class method that creates a Scene with the WorldLayer as the only child.
+(CCScene *) scene
{
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];

	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
	
	[scene addChild:[WorldLayer node] z:1 tag:tagWorldLayer];
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
        
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        SpriteSheet *enemySpriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"megamanSpSheet.png"];

        PlayerBuilder *builder = [PlayerBuilder newBuilder:ccp(120,220) 
                                                      size:CGSizeMake(10.0f, 10.0f)
                                                    sprite:[spriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]];
        Player *player = [[builder buildSpriteSheet:spriteSheet] build];
        
        EnemyBuilder *enemyBuilder = [EnemyBuilder newBuilder:ccp(220,220) 
                                                     size:CGSizeMake(20.0f, 20.0f)
                                                   sprite:[enemySpriteSheet getSpriteForKey:ANIMATOR_STAND frameNum:0]
                                  ];
        Enemy *enemy = [[enemyBuilder buildSpriteSheet:enemySpriteSheet] build];
        
        [[ObjectContainer sharedInstance] addObject:player];
        [[ObjectContainer sharedInstance] addObject:enemy];
        [self addChild:player.sprite];
        [self addChild:enemy.sprite];

        map = CFDictionaryCreateMutable(NULL,0,NULL,NULL);
        
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
}

-(void) visit
{
	if(!visible_)
	{
		return;
	}
    
	[self sortChildrenByYPosition];
    
	for(CCNode *child in children_)
	{
		[child visit];
	}
}

// Sorts the children based on their Y position (lower Y = rendered later)
-(void) sortChildrenByYPosition
{
	// Sprites will always be partially ordered after the first sort, so use insert sort.
	CCNode *testValue;
	int length = children_.count;
	int i;
    
	for(int j = 1; j < length; j++)
	{
		testValue = [[children_ objectAtIndex:j] retain];
		for(i = j-1; i >= 0; i--)
		{
            CCNode * node = [children_ objectAtIndex:i];
            
            // Have to use the bottom of the sprite instead of the center so that it
            // looks more realistic.
            CGFloat nodeY = node.position.y - (node.boundingBox.size.height/2.0f);
            CGFloat testValueY = testValue.position.y - (testValue.boundingBox.size.height/2.0f);
            
            if (nodeY >= testValueY) {
                break;
            }
            
			[children_ replaceObjectAtIndex:i+1 withObject:[children_ objectAtIndex:i]];
		}
        
		[children_ replaceObjectAtIndex:i+1 withObject:testValue];
        [testValue release];
	}
}

#pragma mark GameKit delegate

- (void) ccTouchesBegan:(NSSet *) touches withEvent:(UIEvent *) event{
	for (UITouch *touch in touches) {
		CCBlade *w = [CCBlade bladeWithMaximumPoint:50];
        w.autoDim = YES;
        int rand = arc4random() % 3 + 1;
		w.texture = [[CCTextureCache sharedTextureCache] addImage:[NSString stringWithFormat:@"streak%d.png",rand]];
        
        CFDictionaryAddValue(map,touch,w);
        
		[self addChild:w];
		CGPoint pos = [touch locationInView:touch.view];
		pos = [[CCDirector sharedDirector] convertToGL:pos];
        NSLog(@"Touch position: %@", NSStringFromCGPoint(pos));
		[w push:pos];
	}
}

- (void) ccTouchesMoved:(NSSet *) touches withEvent:(UIEvent *) event{
	for (UITouch *touch in touches) {
		CCBlade *w = (CCBlade *)CFDictionaryGetValue(map, touch);
		CGPoint pos = [touch locationInView:touch.view];
		pos = [[CCDirector sharedDirector] convertToGL:pos];
		[w push:pos];
	}
}

- (void) ccTouchesEnded:(NSSet *) touches withEvent:(UIEvent *) event{
	for (UITouch *touch in touches) {
		CCBlade *w = (CCBlade *)CFDictionaryGetValue(map, touch);
        [w finish];
        CFDictionaryRemoveValue(map,touch);
	}
}


-(void) achievementViewControllerDidFinish:(GKAchievementViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

-(void) leaderboardViewControllerDidFinish:(GKLeaderboardViewController *)viewController {
	AppController *app = (AppController*) [[UIApplication sharedApplication] delegate];
	[[app navController] dismissModalViewControllerAnimated:YES];
}

@end