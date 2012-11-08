//
//  Player.m
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Loggers.h"
#import <Foundation/NSDictionary.h>
#import "ObjectContainer.h"
#import "FreezeModeManager.h"
#import "ComboState.h"
#import "OverlayLayer.h"
#import "cocos2d.h"

@implementation Player

@synthesize specialGauge;

// physics
- (void) resolveCollisions {
	[physicsEngine detectScreenCollision:[[ObjectContainer sharedInstance] player]] ;
    
}
							
- (void) collidesWithPlayer {
	[super moveTowards:[Character oppositeDirection:currentDirection]];
}

- (void) collidesWithScreen {
    [super moveTowards:[Character oppositeDirection:currentDirection]];
}

- (void) initiateComboAttempt:(NSUInteger) hits {
    NSString * hitCount = [NSString stringWithFormat:@"%d", hits, nil];
    NSLog(@"hit count: %@", hitCount);
    OverlayLayer *layer = (OverlayLayer *) [[[CCDirector sharedDirector] runningScene] getChildByTag:tagOverlayLayer]; 
    [layer displayNodes:hitCount];
}

- (void) initiateComboAnimation:(NSString *)comboKey {
    NSLog(@"Initiating combo animation...");
    [self setState:[ComboState createWithCharacter:self
                                          comboKey:ANIMATOR_ATTACK]];
}

@end
