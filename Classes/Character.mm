//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GraphicsEngine.h"
#import "SpecialBar.h"
#import "ObjectContainer.h"
#import "FreezeModeManager.h"

static CGPoint cgPoints[MAX_DIRECTIONS]; 

// Texture row indexes in the sprite sheet
static const NSUInteger STANDING_ROW_INDEX = 0; 
static const NSUInteger MOVEMENT_ROW_INDEX = 1;

@implementation Character

@synthesize attackingRowIndexes,
			currentState, 
			physicsEngine,
			currentDirection,
			currentOrientation,
			effectsManager,
            animator;

//Private method
- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
	
}

- (id) init:(CGPoint) pos
	   size:(CGSize) sz 
effectsManager:(ParticleEffectsManager *) effectsManagerParam
animator:(SpriteSheetAnimator *) animatorParam {
	
	if(self = [super init]) {
		
		self.position = pos;
		self.size = sz;
		self.currentDirection = RIGHT;
		self.currentOrientation = ORIENTATION_FORWARD;
		self.physicsEngine = [PhysicsEngine getInstance];
		self.effectsManager = effectsManagerParam;
        self.animator = animatorParam;
		
		// TODO: Put in configuration file passed in as parameter
		self.attackingRowIndexes = [NSArray arrayWithObjects:
									  [NSNumber numberWithInt:2],
									  [NSNumber numberWithInt:3],
									  [NSNumber numberWithInt:4],
									  nil 
									  ];
		
		//TODO: change to map?
		cgPoints[NO_WHERE]   = CGPointMake( 0.00f,   0.00f);
		cgPoints[RIGHT]      = CGPointMake( 1.00f,   0.00f); 
		cgPoints[LEFT]       = CGPointMake(-1.00f,   0.00f); 
		cgPoints[UP]         = CGPointMake( 0.00f,   1.00f); 
		cgPoints[DOWN]       = CGPointMake( 0.00f,  -1.00f); 
		cgPoints[UP_RIGHT]   = CGPointMake( 1.00f,   1.00f); 
		cgPoints[UP_LEFT]    = CGPointMake(-1.00f,   1.00f); 
		cgPoints[DOWN_RIGHT] = CGPointMake( 1.00f,  -1.00f); 
		cgPoints[DOWN_LEFT]  = CGPointMake(-1.00f,  -1.00f); 
		
	}
	
    [self setState:[StandState createWithCharacter:self]];
	return self;
	
}

- (void) update {
	//TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
    [animator animate];
	[currentState updateState];
    [effectsManager updateCurrentEffect];
}


- (void) draw {
	[GraphicsEngine drawCharacter:self];
	[GraphicsEngine drawParticleEffects:effectsManager];
}

- (void) runTo:(Direction) dir {
    [currentState transitionToState:[MoveState createWithCharacter:self]];
	currentDirection = dir;
	
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
}

- (void) moveTowards:(Direction) dir {
    [currentState transitionToState:[MoveState createWithCharacter:self]];
	[self move:cgPoints[dir]];
}

- (void) stand {
    [currentState transitionToState:[StandState createWithCharacter:self]];
}


- (uint) getNumberOfAttacks {
	return [attackingRowIndexes count];
}

- (uint) getRowForAttack:(uint) attackIndex {
	return [[attackingRowIndexes objectAtIndex:attackIndex] intValue];
}

- (void) attack {
	// Begin attack if player isn't attacking already
	/*if (currentState != ATTACKING_STATE) {
	    currentState = ATTACKING_STATE;
		currentAttack = 0;
	} */
    [currentState transitionToState:[AttackState createWithCharacter:self]];
}

- (void) setState:(id<CharacterState>) newState {
    [self.currentState release];
    self.currentState = newState;
    [self.currentState start];
}

@end
