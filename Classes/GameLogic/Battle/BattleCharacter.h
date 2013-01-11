//
//  BattleCharacter.h
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "SpriteSheet.h"
#import "CharacterAttributes.h"

@class BattleLayer;
@interface BattleCharacter : Prop {
    BattleLayer *parentLayer;
    SpriteSheet * spriteSheet;
    CharacterAttributes *attributes;
    CCFiniteTimeAction *waitTimeAction;
    CGFloat waitTimeDelay;
    bool isWaiting;
}

@property(nonatomic, retain) BattleLayer *parentLayer;
@property(nonatomic, retain) SpriteSheet *spriteSheet;
@property(nonatomic, retain) CharacterAttributes *attributes;
@property(nonatomic, assign) CGFloat waitTimeDelay;
@property(nonatomic, readonly) bool isWaiting;

-(void) isAttackedBy:(NSUInteger) damage;
-(bool) isAlive;
-(void) startBattleTimer;
-(void) resumeBattleTimer;
-(void) pauseBattleTimer;

// Private methods. Do not call directly
-(void) startOfWaitTime;
-(void) endOfWaitTime;
-(void) stopBattleTimer;

@end
