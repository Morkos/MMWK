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
#import "ParticleEffectsManager.h"
#import "SpritesheetAnimator.h"
#import "CharacterState.h"
#import "MoveState.h"
#import "AttackState.h"
#import "StandState.h"

@interface Character : Prop {
	PhysicsEngine *physicsEngine;
	id<CharacterState> currentState;
	Direction currentDirection;
	Orientation currentOrientation;
	
	NSArray *attackingRowIndexes;
	uint currentAttack;
	
	ParticleEffectsManager *effectsManager;
    SpriteSheetAnimator * animator;
}

@property (nonatomic, retain) id<CharacterState> currentState;
@property (nonatomic, retain) NSArray *attackingRowIndexes;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;
@property (nonatomic, retain) ParticleEffectsManager *effectsManager;
@property (nonatomic, retain) SpriteSheetAnimator * animator;

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
effectsManager:(ParticleEffectsManager *) effectsManager
animator:(SpriteSheetAnimator *) animator;

- (void) runTo:(Direction) dir;
- (void) moveTowards:(Direction) dir;

// from GraphicsContext protocol
- (void) draw;
- (void) update;

// Actions
- (void) stand;
- (uint) getNumberOfAttacks;
- (uint) getRowForAttack:(uint) attackIndex;
- (void) attack;

- (void) setState:(id<CharacterState>) newState;

@end
