//
//  BattleLayer.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleLayer.h"
#import "BattleEnemy.h"
#import "SpriteSheetManager.h"
#import "CCBlade.h"
#import "HealthPotion.h"
#import "ParticleInvoker.h"
#import "VerticalGauge.h"

@implementation BattleLayer

@synthesize player;

-(id) init
{
    if(self=[super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        SpriteSheet *playerSpriteSheet = 
            [[SpriteSheetManager getInstance] loadSpriteSheet:@"megamanSpSheet.png"];
        
        SpriteSheet *enemySpriteSheet = [SpriteSheet createWithFile:@"orcSkeleton"];
        
        Gauge * waitTimeGauge = 
            [VerticalGauge gaugeWithContainerTexture:@"healthBar-back.png" 
                                         barTextures:[NSArray arrayWithObjects:@"healthBar-front.png",nil]];
        waitTimeGauge.position = ccp(20, 10);
        
        player = 
            [[[BattlePlayer alloc] initWithSpriteFrame:
              [playerSpriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]] autorelease];
        player.parentLayer = self;
        player.position = ccp(winSize.width/2.0, 0);
        player.spriteSheet = playerSpriteSheet;
        player.waitTimeGauge = waitTimeGauge;
        player.waitTimeDelay = 3;
        waitTimeGauge.barChangeDuration = player.waitTimeDelay;
        
        BattleEnemy *enemy = 
            [[[BattleEnemy alloc] initWithSpriteFrame:
                [enemySpriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]] autorelease];
        enemy.parentLayer = self;
        enemy.position = ccp(winSize.width/2.0, winSize.height/2.0);
        enemy.spriteSheet = enemySpriteSheet;
        enemy.waitTimeDelay = 4;
        enemy.debugLabel = [CCLabelTTF labelWithString:NSSTRING_FORMAT(@"%d", enemy.isWaiting)
                                              fontName:@"Courier"
                                              fontSize:10.0f];
        enemy.debugLabel.position = ccp(0.0f, 20.0f);
        
        CCSprite *background = [CCSprite spriteWithFile:@"background.jpg"];
        background.position = ccp(winSize.width/2.0, winSize.height/2.0);
        
        [self addChild:player z:1];
        [self addChild:waitTimeGauge z:2];
        [self addChild:enemy z:1];
        [self addChild:background z:0];
        
        // TODO: Enemies and player should be a parameter to the layer initialization
        enemies = [[NSMutableArray arrayWithObjects:enemy, nil] retain];
        
        // TODO: Attributes should be set as parameters
        player.attributes.currentHp = 80;
        player.attributes.maxHp = 100;
        player.attributes.attackPower = 10;

        enemy.attributes.currentHp = 20;
        enemy.attributes.maxHp = 20;
        enemy.attributes.attackPower = 10;
        
        self.isTouchEnabled = true;
        [self resetBattleTimer];
    }
    
    return self;
}

-(void) resetBattleTimer {
    isBattleTimerOn = true;
    [player startBattleTimer];
    for (BattleEnemy *enemy in enemies) {
        [enemy startBattleTimer];
    }
}

-(void) resumeBattleTimer {
    isBattleTimerOn = true;
    [player resumeBattleTimer];
    for (BattleEnemy *enemy in enemies) {
        [enemy resumeBattleTimer];
    }
}

-(void) pauseBattleTimer {
    isBattleTimerOn = false;
    [player pauseBattleTimer];
    for (BattleEnemy *enemy in enemies) {
        [enemy pauseBattleTimer];
    }
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (!isBattleTimerOn && ![player isWaiting]) {
            for (BattleEnemy *enemy in enemies) {
                if ([enemy isAlive] && [enemy isLocationInBoundingBox:location]) {
                    [enemy isAttackedBy:player];
                    [player startBattleTimer];
                    [self resumeBattleTimer];
                    return;
                }
            }
        }
    }
}

-(void) dealloc {
    [enemies release];
    [super dealloc];
}

@end
