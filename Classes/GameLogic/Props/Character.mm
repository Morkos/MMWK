//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "OverlayLayer.h"
#import "CCBlade.h"
#import "ParticleInvoker.h"

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
			currentState, 
			physicsEngine,
			currentDirection,
			currentOrientation,
            strength,
            defense,
            healthGauge,
            speed;


//Private method
- (void) move:(CGPoint)movement {
    self.position = ccpAdd(position_, ccpMult(movement, 2.0f));
    switch (currentOrientation) {
        case ORIENTATION_FORWARD:
            self.flipX = false;
            break;
            
        case ORIENTATION_BACKWARDS:
            self.flipX = true;
            break;
            
        default:
            break;
    }
}

- (id) init:(CGPoint) pos
	   size:(CGSize) size 
     spriteFrame:(CCSpriteFrame *) spriteFrame {
	
	if(self = [super initWithTexture:spriteFrame.texture 
                                rect:spriteFrame.rect]) {
        self.position = pos;
        self.scaleX = size.width;
        self.scaleY = size.height;
        
		self.currentDirection = RIGHT;
		self.currentOrientation = ORIENTATION_FORWARD;
		self.physicsEngine = [PhysicsEngine getInstance];
        self.healthGauge = [[Gauge alloc] init];
        self.speed = 1.0;
	}
    
	return self;
	
}

- (void) update {
	//TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
	[currentState updateState];
}

- (void) setDirectionAndOrientation:(Direction) dir {
    currentDirection = dir;
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
}

- (void) runTo:(Direction) dir {
    NSLog(@"character...%@", self);
    [currentState transitionToState:[MoveState createWithCharacter:self]];
	[self setDirectionAndOrientation:dir];
}

- (void) moveTowards:(Direction) dir {
	[self move:cgPoints[dir]];
    [self setDirectionAndOrientation:dir];
}

- (void) stand {
    [currentState transitionToState:[StandState createWithCharacter:self]];
}

- (void) attack {
    [currentState transitionToState:[AttackState createWithCharacter:self]];
}

- (void) setState:(id<CharacterState>) newState {
    NSLog(@"Transitioning from %@ to %@", self.currentState, newState);
    [self.currentState release];
    self.currentState = newState;
    [self.currentState start];
}

+ (Direction) oppositeDirection:(Direction) direction {
    return directionToOpposite[direction];
}

@end
