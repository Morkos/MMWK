//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"

static CGPoint cgPoints[MAX_DIRECTIONS] = {
    /*NO_WHERE*/   CGPointMake( 0.00f,   0.00f),
    /*UP*/         CGPointMake( 0.00f,   1.00f), 
    /*DOWN*/       CGPointMake( 0.00f,  -1.00f), 
    /*LEFT*/       CGPointMake(-1.00f,   0.00f), 
    /*RIGHT*/      CGPointMake( 1.00f,   0.00f), 
    /*UP_LEFT*/    CGPointMake(-1.00f,   1.00f),
    /*UP_RIGHT*/   CGPointMake( 1.00f,   1.00f), 
    /*DOWN_LEFT*/  CGPointMake(-1.00f,  -1.00f), 
    /*DOWN_RIGHT*/ CGPointMake( 1.00f,  -1.00f), 
};

static Direction directionToOpposite[MAX_DIRECTIONS] = {
    /*NO_WHERE*/   NO_WHERE,
    /*UP*/         DOWN,
    /*DOWN*/       UP,
    /*LEFT*/       RIGHT,
    /*RIGHT*/      LEFT,
    /*UP_LEFT*/    DOWN_RIGHT,
    /*UP_RIGHT*/   DOWN_LEFT,
    /*DOWN_LEFT*/  UP_RIGHT,
    /*DOWN_RIGHT*/ UP_LEFT
};

@implementation Character

@synthesize spriteSheet,
            attackingRowIndexes,
			currentState, 
			physicsEngine,
			currentDirection,
			currentOrientation,
            strength,
            defense,
            healthGauge;


//Private method
- (void) move:(CGPoint)movement {
	position.x += movement.x;
	position.y += movement.y;
	
    //TODO comment out and use game position
    sprite.position = ccpAdd(sprite.position, ccpMult(movement, 2.0f));

    switch (currentOrientation) {
        case ORIENTATION_FORWARD:
            sprite.flipX = false;
            break;
            
        case ORIENTATION_BACKWARDS:
            sprite.flipX = true;
            break;
            
        default:
            break;
    }
}

- (id) init:(CGPoint) pos
	   size:(CGSize) sz 
     sprite:(CCSprite *) spriteParam {
	
	if(self = [super init]) {
		self.position = pos;
		self.size = sz;
        self.sprite = spriteParam;
        //TODO: use game coordinates instead of screen coordinates
        self.sprite.position = pos;
		self.currentDirection = RIGHT;
		self.currentOrientation = ORIENTATION_FORWARD;
		self.physicsEngine = [PhysicsEngine getInstance];
        
		// TODO: Put in configuration file passed in as parameter
		self.attackingRowIndexes = [NSArray arrayWithObjects:
									  [NSNumber numberWithInt:2],
									  [NSNumber numberWithInt:3],
									  [NSNumber numberWithInt:4],
									  nil 
									  ];
        
        self.healthGauge = [[Gauge alloc] init];
	}
    
	return self;
	
}

- (void) update {
	//TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
	[currentState updateState];
}

- (void) runTo:(Direction) dir {
    [currentState transitionToState:[MoveState createWithCharacter:self]];
	currentDirection = dir;
	
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
}

- (void) moveTowards:(Direction) dir {
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
	}*/
    [currentState transitionToState:[AttackState createWithCharacter:self]];
}

- (void) setState:(id<CharacterState>) newState {
    [self.currentState release];
    self.currentState = newState;
    [self.currentState start];
}

+ (Direction) oppositeDirection:(Direction) direction {
    return directionToOpposite[direction];
}

@end
