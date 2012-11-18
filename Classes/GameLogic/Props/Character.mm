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
#import "WoundedState.h"

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
            physicsEngine,
			fsm, 
            healthGauge,
			currentDirection,
			currentOrientation,
            maxHp,
            currentHp,
            strength,
            defense,
            speed,
            behavior;


//Private method
//TODO: Mig
- (void) isOrientationAdjustmentNeeded {
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
- (void) move:(CGPoint)movement {
    self.position = ccpAdd(position_, ccpMult(movement, self.speed + 1.0f));
    [self isOrientationAdjustmentNeeded];
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
        self.fsm = [[StateMachine alloc] init];
        
        // Set default values
        self.strength = 1;
        self.maxHp = 10;
        self.currentHp = 10;
        
        self.behavior = [[SteeringBehavior alloc] init];
	}
    
	return self;
	
}

- (void) update {
	//TLOG("Character position: (%lf, %lf)", self.position.x, self.position.y);
    [fsm update];
}

- (void) setDirectionAndOrientation:(Direction) dir {
    currentDirection = dir;
	if (currentDirection != UP && currentDirection != DOWN) {
		currentOrientation = getOrientationFromDirection(currentDirection);
	}
}

- (void) runTo:(Direction) dir {
    NSLog(@"character...%@", self);
    [fsm.currentState transitionToState:[MoveState createWithCharacter:self]];
	[self setDirectionAndOrientation:dir];
}

- (void) moveTowards:(Direction) dir {
	[self move:cgPoints[dir]];
    [self setDirectionAndOrientation:dir];
}

//TODO: take out?

- (void) setPosition:(CGPoint) pt {
    [super setPosition:pt];
    [self isOrientationAdjustmentNeeded];
}

- (void) stand {
    [fsm.currentState transitionToState:[StandState createWithCharacter:self]];
}

- (void) attack {
    [fsm.currentState transitionToState:[AttackState createWithCharacter:self]];
}

- (void) setState:(id<CharacterState>) newState {
    NSLog(@"Transitioning from %@ to %@", fsm.currentState, newState);
    [fsm.currentState release];
    fsm.currentState = newState;
    [fsm.currentState start];
}

- (void) attacksTarget:(Character *) target {
    [target decreaseHp:strength];
    [target setState:[WoundedState createWithCharacter:target]];
}

- (void) increaseHp:(CGFloat) hpIncrease {
    CGFloat previousHp = currentHp;
    currentHp = min(maxHp, currentHp + hpIncrease);
    
    [healthGauge animateBarFromStartCapacity:previousHp
                                 endCapacity:currentHp 
                                 maxCapacity:maxHp];

}

- (void) decreaseHp:(CGFloat) hpDecrease {
    CGFloat previousHp = currentHp;
    // TODO: If zero hp, the target should die
    currentHp = max(0, currentHp - hpDecrease);
    
    [healthGauge animateBarFromStartCapacity:previousHp
                                 endCapacity:currentHp 
                                 maxCapacity:maxHp];
}

- (void) setHealthGauge:(Gauge *) healthGaugeParam {
    healthGauge = [healthGaugeParam retain];
    [healthGauge animateBarFromStartCapacity:currentHp 
                                 endCapacity:currentHp 
                                 maxCapacity:maxHp];
}

+ (Direction) oppositeDirection:(Direction) direction {
    return directionToOpposite[direction];
}

- (void) dealloc {
    [spriteSheet release];
    [physicsEngine release];
    [healthGauge release];
    [fsm release];
    [super dealloc];
}

@end
