//
//  Character.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Character.h"
#import "MyConstants.h"
#import "WorldLayer.h"

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

- (void) attack {
    [currentState transitionToState:[AttackState createWithCharacter:self]];
    
    WorldLayer *worldLayer = (WorldLayer *) [[[CCDirector sharedDirector] runningScene] getChildByTag:tagWorldLayer]; 
    
    //for (int i = 0; i < 50; i++) {
    CCParticleFlower *explosion = [[CCParticleFlower alloc] initWithTotalParticles:500];
    explosion.autoRemoveOnFinish = true;
    explosion.startSize = 10;
    explosion.emissionRate = 500;
    explosion.life = 0.5f;
    explosion.gravity = ccp(0, -90);
    explosion.position = ccp(sprite.position.x + 10, sprite.position.y);
    explosion.speed = 100;
    ccColor4F color = {1.0f, 0.5f, 0.0f, 1.0f};
    explosion.startColor = color;
    explosion.radialAccel = 100;
        
        [worldLayer addChild:explosion];
    //}
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
