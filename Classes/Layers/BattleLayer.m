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

@interface BattleLayer ()
    - (void) resetBattleTimer;
@end

@implementation BattleLayer


-(id) init
{
    if(self=[super init]) {
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        SpriteSheet *playerSpriteSheet = 
            [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        SpriteSheet *enemySpriteSheet = 
            [[SpriteSheetManager getInstance] loadSpriteSheet:@"megamanSpSheet.png"];
        
        player = 
            [[[BattlePlayer alloc] initWithSpriteFrame:
              [playerSpriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]] autorelease];
        player.position = ccp(winSize.width/2.0, 0);
        
        Gauge * waitTimeGauge = 
            [VerticalGauge gaugeWithContainerTexture:@"healthBar-back.png" 
                                         barTextures:[NSArray arrayWithObjects:@"healthBar-front.png",nil]];
        waitTimeGauge.position = ccp(20, 10);
        waitTimeGauge.barChangeDuration = 5;
        player.waitTimeGauge = waitTimeGauge;
        player.waitTimeDelay = 5;
        
        BattleEnemy *enemy = 
            [[[BattleEnemy alloc] initWithSpriteFrame:
                [enemySpriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]] autorelease];
        enemy.position = ccp(winSize.width/2.0, winSize.height/2.0);
        enemy.waitTimeDelay = 10;
        enemy.spriteSheet = enemySpriteSheet;
        
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

        enemy.attributes.currentHp = 100;
        enemy.attributes.maxHp = 100;
        enemy.attributes.attackPower = 10;
        
        self.isTouchEnabled = true;
        [self resetBattleTimer];
    }
    
    return self;
}

-(void) resetBattleTimer {
    isBattleTimerOn = true;
    [player startBattleTimer:[CCCallFunc actionWithTarget:self selector:@selector(stopBattleTimer)]];
    /*for (BattleCharacter *enemy in enemies) {
        [enemy update];
    }*/
}

-(void) stopBattleTimer {
    isBattleTimerOn = false;
}

-(void) ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        if (!isBattleTimerOn) {
            for (BattleEnemy *character in enemies) {
                if ([character isLocationInBoundingBox:location]) {
                    [character isAttackedBy:player];
                    [self resetBattleTimer];
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
