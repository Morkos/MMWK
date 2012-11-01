//
//  AttackState.m
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "AttackState.h"
#import "ObjectContainer.h"
#import "Enemy.h"
#import "ParticleInvoker.h"

@interface AttackState ()
    -(CCAction *) createAction:(CCAnimation *) animationAction;
    -(void) transitionToStand;
    -(void) setCurrentlyInBetweenAttacks;
@end
@implementation AttackState

// Maximum number of basic attacks for player
// TODO: Might have to be put in parameter instead.
const uint maxAttacks = 3;

@synthesize character,
            currentAttack,
            isInBetweenAttacks;

+ (AttackState *) createWithCharacter:(Character *) character {
    AttackState *state = [[AttackState alloc] init];
    state.character = character;
    state.currentAttack = 0;
    state.isInBetweenAttacks = true;
    
    return state;
}

- (void) start {
    isInBetweenAttacks = false;
    [SpriteSheetAnimator startAnimation:character.sprite
                            spriteSheet:character.spriteSheet
                               frameKey:NSSTRING_FORMAT(ANIMATOR_ATTACK, currentAttack)
                          frameInterval:0.1f
                                 target:self
                               selector:@selector(createAction:)];
}

-(CCAction *) createAction:(CCAnimation *) animationAction {
    animationAction.restoreOriginalFrame = false;
    CCAction *action = [CCSequence actions:[CCAnimate actionWithAnimation:animationAction],
                                           [CCCallFunc actionWithTarget:self selector:@selector(setCurrentlyInBetweenAttacks)],
                                           [CCDelayTime actionWithDuration:0.2f],
                                           [CCCallFunc actionWithTarget:self selector:@selector(transitionToStand)],
                                            nil];
    
    return action;
}

-(void) setCurrentlyInBetweenAttacks {
    if (++currentAttack < maxAttacks) {
        isInBetweenAttacks = true;
    }
    
    //TODO: Find closest enemy instead of hard code
    Enemy *closestEnemy = [[ObjectContainer sharedInstance] getObject:1];
    bool collided = [[PhysicsEngine getInstance] detectRectangleCollision:character 
                                                                otherProp:closestEnemy];
    
    if (collided) {
        [[ParticleInvoker invoker] invokeParticleEffect:slashEffect 
                                                   prop:closestEnemy];
    }
}

- (void) updateState {
}

- (void) transitionToStand {
    [character setState:[StandState createWithCharacter:character]];;
}

- (void) transitionToState:(id<CharacterState>) newState {
    if ([[newState class] isSubclassOfClass:[AttackState class]] && 
        isInBetweenAttacks) {
        [self start];
    }
}

- (void) dealloc {
    [character release];
    [super dealloc];
}

@end
