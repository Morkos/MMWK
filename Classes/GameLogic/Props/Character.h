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

@interface Character : Prop {
    SpriteSheet *spriteSheet;
	PhysicsEngine *physicsEngine;
	id<CharacterState> currentState;
	Direction currentDirection;
	Orientation currentOrientation;
	
	NSArray *attackingRowIndexes;
    
    NSUInteger strength;
    NSUInteger defense;
    
    Gauge *healthGauge;
    
}

@property (nonatomic, retain) SpriteSheet *spriteSheet;
@property (nonatomic, retain) id<CharacterState> currentState;
@property (nonatomic, retain) NSArray *attackingRowIndexes;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;
@property (nonatomic, assign) NSUInteger strength;
@property (nonatomic, assign) NSUInteger defense;
@property (nonatomic, retain) Gauge *healthGauge;

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
     sprite:(CCSprite *) sprite;

- (void) runTo:(Direction) dir;
- (void) moveTowards:(Direction) dir;

// From Drawable
- (void) update;

// Actions
- (void) stand;
- (uint) getNumberOfAttacks;
- (uint) getRowForAttack:(uint) attackIndex;
- (void) attack;

- (void) setState:(id<CharacterState>) newState;

/**
 * Returns the opposite direction of the given direction
 */
+ (Direction) oppositeDirection:(Direction) direction;

@end
