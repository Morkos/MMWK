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
#import "PlayerBasicAttack.h"
#import "CoordinateSystem.h"

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
        player.waitTimeDelay = 1.5;
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

        enemy.attributes.currentHp = 1000;
        enemy.attributes.maxHp = 1000;
        enemy.attributes.attackPower = 10;
        
        self.isTouchEnabled = true;
        [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self 
                                                                  priority:0
                                                           swallowsTouches:false];
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

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event {
    if (!hasPreviousTouch) {
        hasPreviousTouch = true;
        previousLocation = [touch previousLocationInView:[touch view]];
        previousLocation = [[CCDirector sharedDirector] convertToGL: previousLocation];
        return YES;
    }
    
    return NO;
}

-(void) ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event {
    CGPoint location = [touch locationInView: [touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    if (!isBattleTimerOn && ![player isWaiting] && (ccpDistance(previousLocation, location) >= 5)) {
        for (BattleEnemy *enemy in enemies) {
            if ([enemy isAlive] && [enemy isLocationInBoundingBox:location]) {
                CGFloat angleInDegrees = [CoordinateSystem calculateDegreesFromPoint:previousLocation 
                                                                             toPoint:location];
                CGFloat angle = CC_DEGREES_TO_RADIANS(angleInDegrees);
                CCLOG(@"Angle of swipe: %f, %@, %@", 
                      angleInDegrees, 
                      NSStringFromCGPoint(previousLocation), 
                      NSStringFromCGPoint(location));
                [PlayerBasicAttack attackWithDamage:player.attributes.attackPower
                                             target:enemy
                                       angleOfSwipe:angle];
                [player startBattleTimer];
                [self resumeBattleTimer];
                return;
            }
        }
    }
}

-(void) ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event {
    hasPreviousTouch = false;
}

-(void) dealloc {
    [enemies release];
    [[[CCDirector sharedDirector] touchDispatcher] removeDelegate:self];
    [super dealloc];
}

@end
