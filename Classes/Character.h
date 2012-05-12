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

@interface Character : Prop {
	
	PhysicsEngine * physicsEngine;
	
	PlayerState currentState;
	Direction currentDirection;
	Orientation currentOrientation;
	SpriteSheet *sprite;
	CADisplayLink *displayLink;
	
	// Current matrix index in the sprite sheet
	uint spsheetRowInd, spsheetColInd;
	
	NSArray *attackingRowIndexes;
	uint currentAttack;
	
	ParticleEffectsManager *effectsManager;
}

@property (nonatomic, assign) PlayerState currentState;
@property (nonatomic, retain) SpriteSheet *sprite;
@property (assign) uint spsheetRowInd, spsheetColInd;
@property (nonatomic, retain) NSArray *attackingRowIndexes;
@property (nonatomic, assign) uint currentAttack;
@property (nonatomic, assign) CADisplayLink *displayLink;
@property (nonatomic, retain) PhysicsEngine *physicsEngine;
@property (nonatomic, assign) Direction currentDirection;
@property (nonatomic, assign) Orientation currentOrientation;
@property (nonatomic, retain) ParticleEffectsManager *effectsManager;

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
spriteSheet:(SpriteSheet *) spriteSheet
effectsManager:(ParticleEffectsManager *) effectsManager;

- (void) startAnimation;
- (void) runTo:(Direction) dir;
- (void) moveTowards:(Direction) dir;

// from GraphicsContext protocol
- (void) draw;
- (void) update;
- (void) animate;

// Actions
- (void) stand;
- (uint) getNumberOfAttacks;
- (uint) getRowForAttack:(uint) attackIndex;
- (void) attack;
@end
