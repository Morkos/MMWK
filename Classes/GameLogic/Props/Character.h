//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Prop.h"
#import "PropState.h"
#import "PhysicsEngine.h"
#import "SpriteSheet.h"
#import "SpritesheetAnimator.h"
#import "CharacterState.h"
#import "MoveState.h"
#import "AttackState.h"
#import "StandState.h"
#import "Gauge.h"
#import "StateMachine.h"

@interface Character : Prop {
    SpriteSheet * spriteSheet;
	PhysicsEngine * physicsEngine;
	StateMachine * fsm;
    
	Direction currentDirection;
	Orientation currentOrientation;

    CGFloat speed;
    Gauge *healthGauge;
    NSUInteger maxHp, currentHp, strength, defense;
    
}

@property (nonatomic, retain) SpriteSheet * spriteSheet;
@property (nonatomic, retain) StateMachine * fsm;
@property (nonatomic, retain) NSArray *attackingRowIndexes;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (nonatomic, retain) Gauge *healthGauge;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;
@property (nonatomic, assign) CGFloat speed;
@property (nonatomic, assign) NSUInteger maxHp, currentHp, strength, defense;

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
     spriteFrame:(CCSpriteFrame *) spriteFrame;

- (void) runTo:(Direction) dir;
- (void) moveTowards:(Direction) dir;

// From Drawable
- (void) update;

// Actions
- (void) stand;
- (void) attack;

- (void) setState:(id<CharacterState>) newState;

/**
 * Perform an attack on target character
 */
- (void) attacksTarget:(Character *) target;

/**
 * Returns the opposite direction of the given direction
 */
+ (Direction) oppositeDirection:(Direction) direction;

@end
