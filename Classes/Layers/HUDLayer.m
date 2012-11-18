//
//  HUDLayer.m
//  DragonEye
//
//  Created by mac on 10/1/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "HUDLayer.h"
#import "EnemyHealthGauge.h"
#import "Enemy.h"

@interface HUDLayer()
    -(void) touchDpadButton:(CGPoint) location;
    -(void) touchStartAttackButton:(CGPoint) location;
    -(void) touchEndedAttackButton:(CGPoint) location;
@end

@implementation HUDLayer 


- (id) init {
    if (self = [super init]) {
        // enable events
#ifdef __CC_PLATFORM_IOS
		self.isTouchEnabled = YES;
		//self.isAccelerometerEnabled = YES;
#elif defined(__CC_PLATFORM_MAC)
		self.isMouseEnabled = YES;
#endif  
        
        CGSize windowSize = [[CCDirector sharedDirector] winSize];
        
        CCSprite *sprite = [CCSprite spriteWithFile:@"dpadNintendo.png"];
        sprite.position = ccp(50, 50);
        sprite.scale = 0.75f;
        
        dpadButton = [DpadButton buttonWithSprite:sprite];
        
        sprite = [CCSprite spriteWithFile:@"attackButton.png"];
        sprite.position = ccp(windowSize.width - 50, 50);
        sprite.scale = 0.75f;
        
        attackButton = [AttackButton buttonWithSprite:sprite];
        
        Gauge *enemyHealthGauge = 
             [EnemyHealthGauge gaugeWithContainerTexture:@"healthBar-back.png" 
                                             barTextures:[NSArray arrayWithObjects:@"healthBar-front.png",nil]];
        enemyHealthGauge.position = ccp(460, 300);
        enemyHealthGauge.scaleX = 1.0f;
        enemyHealthGauge.scaleY = 1.0f;
        
        [self addChild:enemyHealthGauge];
        
        // Link all enemies with the health gauge
        for (Enemy *enemy in [[ObjectContainer sharedInstance] getAllPropsFromContainer:CONTAINER_ENEMIES]) {
            enemy.healthGauge = enemyHealthGauge;
        }
        
        
        Gauge *playerHealthGauge = 
            [Gauge gaugeWithContainerTexture:@"healthBar-back.png" 
                                 barTextures:[NSArray arrayWithObjects:@"healthBar-front.png",nil]];
        playerHealthGauge.position = ccp(20, 300);
        
        [ObjectContainer sharedInstance].player.healthGauge = playerHealthGauge;
        [self addChild:playerHealthGauge];
        
        [self addChild:dpadButton.sprite];
        [self addChild:attackButton.sprite];
    }
    
    return self;
}

- (void)ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
        [self touchDpadButton:location];
        [self touchStartAttackButton:location];
    }
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        
		[self touchDpadButton:location];
    }
}

- (void)ccTouchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    Character *character = [[ObjectContainer sharedInstance] player];
	for(UITouch *touch in touches ) {
        CGPoint location = [touch locationInView: [touch view]];
        location = [[CCDirector sharedDirector] convertToGL: location];
        [character stand];
        
        [self touchEndedAttackButton:location];
	}
}

- (void) touchDpadButton:(CGPoint) location {
    Character *character = [[ObjectContainer sharedInstance] player];
    
    if ([dpadButton isLocationInView:location]) {
        [dpadButton decideHowPlayerShouldMove:character point:location];
    }
}

- (void) touchStartAttackButton:(CGPoint) location {
    if ([attackButton isLocationInView:location]) {
        [attackButton buttonInitiated];
    }
}

- (void) touchEndedAttackButton:(CGPoint) location {
    if ([attackButton isLocationInView:location]) {
        [attackButton buttonEnded];
    }    
}

@end
