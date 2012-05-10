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

static CGPoint cgPoints[NUM_OF_DIRECTIONS]; 
static NSMutableDictionary * directionToOpposite = [NSMutableDictionary new];

@implementation Player

@synthesize attackingRowIndexes,
			currentAttack,
			effectsManager;

// Texture row indexes in the sprite sheet
static const uint STANDING_ROW_INDEX = 0; 
static const uint MOVEMENT_ROW_INDEX = 1;
static const uint ATTACKING_ROW_INDEX = 2;

//Private method
- (void) moveTowards:(Direction) dir{
	[self move:cgPoints[dir]];
}

+ (Character *) characterAtPosition:(CGPoint) position 
							   size:(CGSize) size 
						spriteSheet:(SpriteSheet *) spriteSheet 
					effectsManager:(ParticleEffectsManager *) effectsManager {
	
	Player *player = [[Player alloc] init];
	
	player.position = position;
	player.size = size;
	player.sprite = spriteSheet;
	player.effectsManager = effectsManager;
	
	player.spsheetRowInd = STANDING_ROW_INDEX;
	player.spsheetColInd = 0;
	player.currentState = STOP_STATE;
	player.currentDirection = RIGHT;
	player.currentOrientation = ORIENTATION_FORWARD;
	player.physicsEngine = [PhysicsEngine getInstance];
	player.attackingRowIndexes = [NSArray arrayWithObjects:
									[NSNumber numberWithInt:2],
									[NSNumber numberWithInt:3],
									[NSNumber numberWithInt:4],
									 nil
								  ];
	
	//TODO: move to PropState.h
	[directionToOpposite setObject:[NSNumber numberWithInt:RIGHT] 
							forKey:[NSNumber numberWithInt:LEFT]]; 
	
	[directionToOpposite setObject:[NSNumber numberWithInt:LEFT] 
							forKey:[NSNumber numberWithInt:RIGHT]];
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP] 
							forKey:[NSNumber numberWithInt:DOWN]]; 
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN] 
							forKey:[NSNumber numberWithInt:UP]]; 
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP_RIGHT] 
							forKey:[NSNumber numberWithInt:DOWN_LEFT]];
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN_LEFT] 
							forKey:[NSNumber numberWithInt:UP_RIGHT]];
	
	[directionToOpposite setObject:[NSNumber numberWithInt:UP_LEFT] 
							forKey:[NSNumber numberWithInt:DOWN_RIGHT]]; 
	[directionToOpposite setObject:[NSNumber numberWithInt:DOWN_RIGHT] 
							forKey:[NSNumber numberWithInt:UP_LEFT]];
	
	[player startAnimation];
	
	//TODO: change to map?
	cgPoints[NO_WHERE]   = CGPointMake(0, 0);
	cgPoints[RIGHT]      = CGPointMake( 0.01f, 0); 
	cgPoints[LEFT]       = CGPointMake(-0.01f, 0); 
	cgPoints[UP]         = CGPointMake(0,       0.01f); 
	cgPoints[DOWN]       = CGPointMake(0,      -0.01f); 
	cgPoints[UP_RIGHT]   = CGPointMake( 0.01f,  0.01f); 
	cgPoints[UP_LEFT]    = CGPointMake(-0.01f,  0.01f); 
	cgPoints[DOWN_RIGHT] = CGPointMake( 0.01f, -0.01f); 
	cgPoints[DOWN_LEFT]  = CGPointMake(-0.01f, -0.01f);
	
	return player;
}

- (void) startAnimation {
	CADisplayLink *aDisplayLink = [[CADisplayLink displayLinkWithTarget:self 
															   selector:@selector(animate)] 
								   retain];

	[aDisplayLink addToRunLoop:[NSRunLoop currentRunLoop] 
					   forMode:NSDefaultRunLoopMode];
	
	self.displayLink = aDisplayLink;
}

- (bool) hasSprite {
	return sprite != nil;
}

-(void) update {
	switch(self.currentState) {
		case MOVING_STATE:
			spsheetRowInd = MOVEMENT_ROW_INDEX;
			[self moveTowards:currentDirection];
			[self.displayLink setFrameInterval:8];
			break;
			
		case ATTACKING_STATE:
			[self.displayLink setFrameInterval:6];
			break;
			
		case STOP_STATE:
			spsheetRowInd = STANDING_ROW_INDEX;
			[self.displayLink setFrameInterval:8];
			break;
			
		default:
			[self.displayLink setFrameInterval:8];
			break;
	}
}

- (void) animate {
	if (currentState == ATTACKING_STATE) {
		// Only supports left and right
		if (currentOrientation == ORIENTATION_FORWARD) {
			[self move:CGPointMake(0.05f, 0.0f)];
		} else {
			[self move:CGPointMake(-0.05f, 0.0f)];
		}
	}
	
	if (spsheetColInd++ >= [sprite getNumOfColumnsInRow:spsheetRowInd] - 1) {
		spsheetColInd = 0;
		
		if (currentState == ATTACKING_STATE) {
			currentState = STOP_STATE;
		}
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
}

- (void) stand {
	currentState = STOP_STATE;
	spsheetRowInd = STANDING_ROW_INDEX;
}

- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
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
		
		// Invoke particle effect
		[effectsManager invokeEffect:[NSString stringWithFormat:@"attack%d", currentAttack] 
								prop:self];
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
			
			// Invoke particle effect
			[effectsManager invokeEffect:[NSString stringWithFormat:@"attack%d", currentAttack] 
									prop:self];
		}
	}
}
							
// physics
- (void) resolveCollisions {
	/*if([physicsEngine isTheirACollision:[ObjectContainer singleton].player 
							  otherProp:[[ObjectContainer singleton] getObject:2]]) {
		
		[[ObjectContainer singleton].player moveTowards:(Direction)([[directionToOpposite objectForKey:[NSNumber 
														   numberWithInt:currentDirection]] intValue])];
	}*/
}

@end
