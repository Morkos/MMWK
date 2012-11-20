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
#import "HealthPotion.h"

#pragma mark - WorldLayer
@interface WorldLayer ()
    - (void) sortChildrenByYPosition;
@end
@implementation WorldLayer

-(id) init
{
    if( (self=[super init])) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];

        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        
        SpriteSheet *enemySpriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"megamanSpSheet.png"];

        PlayerBuilder *builder = 
            [PlayerBuilder newBuilder:ccp(50,220) 
                                 size:CGSizeMake(1.0f, 1.0f)
                          spriteFrame:[spriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]];
        
        Player *player = [[[[builder buildSpriteSheet:spriteSheet] 
                                       buildStrength:5] 
                                       buildSpeed:2]
                                       build];
        player.currentHp = 80;
        player.maxHp = 100;
        
        EnemyBuilder *enemyBuilder = 
            [EnemyBuilder newBuilder:ccp(300,220) 
                                size:CGSizeMake(1.0f, 1.0f)
                         spriteFrame:[enemySpriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]];
        
        Enemy *enemy = [[[enemyBuilder buildSpriteSheet:enemySpriteSheet] 
                                            buildHealth:100]
                                            build];
        
        HealthPotion *healthPotion = [HealthPotion itemWithTexture:@"healthPotion.png"];
        healthPotion.position = ccp(300, 100);
        healthPotion.hpIncrease = 20;
        
        [self addChild:player z:1];
        [self addChild:enemy z:1];
        [self addChild:healthPotion z:1];

        [self addChild:[BackgroundLayer node] z:0];

        [self runAction:[CCFollow actionWithTarget:player 
                                     worldBoundary:CGRectMake(0, 0, 2000, winSize.height)]];
        
        [self scheduleUpdate];
    }
    
    return self;
}

- (void)dealloc {
    [super dealloc];
}

-(void) update:(ccTime) delta {
    [[ObjectContainer sharedInstance] update];
}

/*-(void) visit {
    if(!visible_) {
        return;
    }
    
    [self sortChildrenByYPosition];
    
    for(CCNode *child in children_) {
      [child visit];
    }
}*/

// Sorts the children based on their Y position (lower Y = rendered later)
-(void) sortChildrenByYPosition {
    // Sprites will always be partially ordered after the first sort, so use insert sort.
    CCNode *testValue;
    int length = children_.count;
    int i;
    
    for(int j = 1; j < length; j++)
    {
        testValue = [[children_ objectAtIndex:j] retain];
        CGFloat testValueY = testValue.position.y - (testValue.boundingBox.size.height/2.0f);
        for(i = j-1; i >= 0; i--)
        {
            CCNode *node = [children_ objectAtIndex:i]; 
            // Have to use the bottom of the sprite instead of the center so that it
            // looks more realistic.
            CGFloat nodeY = node.position.y - (node.boundingBox.size.height/2.0f);
            
            if (IS_SUBCLASS(node, BackgroundLayer) || 
                (!IS_SUBCLASS(testValue, BackgroundLayer) && nodeY >= testValueY)) {
                break;
            }
            
            [children_ replaceObjectAtIndex:i+1 withObject:[children_ objectAtIndex:i]];
        }
        [children_ replaceObjectAtIndex:i+1 withObject:testValue];
        [testValue release];
    }
    
}

- (void) addChild:(CCNode *)node z:(NSInteger)z tag:(NSInteger)tag {
    [[ObjectContainer sharedInstance] addObject:node];
    [super addChild:node z:z tag:tag];
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
