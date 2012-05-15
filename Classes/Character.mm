//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "GraphicsEngine.h"

static CGPoint cgPoints[MAX_DIRECTIONS]; 

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 1;

@implementation Character


@synthesize sprite, 
			spsheetRowInd, 
			spsheetColInd, 
			attackingRowIndexes,
			currentAttack,
			displayLink, 
			currentState, 
			physicsEngine,
			currentDirection,
			currentOrientation,
			effectsManager;

//Private method
- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
	
}

- (id) init:(CGPoint) pos
	   size:(CGSize) sz
spriteSheet:(SpriteSheet *) spriteSheet 
effectsManager:(ParticleEffectsManager *) effectsManagerParam {
	
	if(self = [super init]) {
		
		self.position = pos;
		self.size = sz;
		self.sprite = spriteSheet;
		self.currentState = STOP_STATE;
		self.currentDirection = RIGHT;
		self.currentOrientation = ORIENTATION_FORWARD;
		self.physicsEngine = [PhysicsEngine getInstance];
		self.effectsManager = effectsManagerParam;
		
		self.spsheetRowInd = STANDING_ROW_INDEX;
		self.spsheetColInd = MOVEMENT_ROW_INDEX;
		
		// TODO: Put in configuration file passed in as parameter
		self.attackingRowIndexes = [NSArray arrayWithObjects:
									  [NSNumber numberWithInt:2],
									  [NSNumber numberWithInt:3],
									  [NSNumber numberWithInt:4],
									  nil 
									  ];
		
		[self startAnimation];
		
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
	
	return self;
	
}

- (void) startAnimation {
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];
	
	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}


- (void) animate {
	//TODO: This HAX NEEDS TO GOOOOOO!!
	if (currentState == ATTACKING_STATE) {
		// Only supports left and right
		if (currentOrientation == ORIENTATION_FORWARD) {
			[self move:CGPointMake(0.05f, 0.0f)];
		} else {
			[self move:CGPointMake(-0.05f, 0.0f)];
		}
	}
	
	if (spsheetColInd++ >= [[sprite getTextureCoords:spsheetRowInd] count] - 1) {
		spsheetColInd = 0;
		
		// TODO: THIS IS HAX TOOOOO
		if (currentState == ATTACKING_STATE) {
			currentState = STOP_STATE;
		}
	}
}

- (void) update {
	//TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
	switch(self.currentState) {
		case MOVING_STATE:
			[self moveTowards:currentDirection];
			[self.displayLink setFrameInterval:8];
			break;
			
		case ATTACKING_STATE:
			[self.displayLink setFrameInterval:6];
			break;
			
		case STOP_STATE:
			[self stand];
			break;
			
		default:
			[self.displayLink setFrameInterval:8];
			break;
	}
}


- (void) draw {
	[GraphicsEngine drawCharacter:self];
	[GraphicsEngine drawParticleEffects:effectsManager];
}

- (void) runTo:(Direction) dir {
	currentState = MOVING_STATE;
	currentDirection = dir;
	
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
	
	spsheetRowInd = MOVEMENT_ROW_INDEX;
}

- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

- (void) stand {
	currentState = STOP_STATE;
	spsheetRowInd = STANDING_ROW_INDEX;
}


- (uint) getNumberOfAttacks {
	return [attackingRowIndexes count];
}

- (uint) getRowForAttack:(uint) attackIndex {
	return [[attackingRowIndexes objectAtIndex:attackIndex] intValue];
}

- (void) attack {
	// Begin attack if player isn't attacking already
	if (currentState != ATTACKING_STATE) {
	    currentState = ATTACKING_STATE;
		currentAttack = 0;
		spsheetRowInd = [self getRowForAttack:currentAttack];
	} 
	// Else check attacking sprite for regular combo chains
	else {
		uint lastAttackingImageIndex = [sprite getNumOfColumnsInRow:spsheetRowInd] - 1;
		
		// If attack is called when its at the last animation image 
		// of an attack and there is still an attack series next, 
		// initiate a combo for the next series of image
		if (spsheetColInd == lastAttackingImageIndex && 
			++currentAttack < [self getNumberOfAttacks]) {
			spsheetRowInd = [self getRowForAttack:currentAttack];
			spsheetColInd = 0;
		}
	}
	
	// Invoke particle effect
	[effectsManager invokeEffect:[NSString stringWithFormat:@"attack%d", currentAttack] 
							prop:self];
}

@end
