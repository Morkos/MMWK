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
#import "SimpleAudioEngine.h"

@interface AttackState ()
    -(id) initWithCharacter:(Character *) characterParam;
    -(CCAction *) createAction:(CCAnimation *) animationAction;
    -(void) transitionToStand;
    -(void) setCurrentlyInBetweenAttacks;
@end
@implementation AttackState

// Maximum number of basic attacks for player
// TODO: Might have to be put in parameter instead.
const uint maxAttacks = 3;

+ (AttackState *) createWithCharacter:(Character *) character {
    return [[AttackState alloc] initWithCharacter:character];
}

- (id) initWithCharacter:(Character *) characterParam {
    if (self = [super init]) {
        character = [characterParam retain];
        currentAttack = 0;
        isInBetweenAttacks = true;
    }
    
    return self;
}
- (void) start {
    isInBetweenAttacks = false;
    [SpriteSheetAnimator startAnimation:character
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
    
    if (IS_SUBCLASS(character, Player)) {
        NSArray *enemies = 
            [[ObjectContainer sharedInstance] findCollidingProps:character fromContainer:CONTAINER_ENEMIES];

        for (Enemy *enemy in enemies) {
            // TODO: Use pixel collision here
            [[ParticleInvoker invoker] invokeParticleEffect:slashEffect 
                                                       prop:enemy];
        
            // TODO: Take out of for loop so it doesn't play this more than once
            [[SimpleAudioEngine sharedEngine] playEffect:@"swordSwing.wav"];
            
            [[ObjectContainer sharedInstance].enemyHealthGauge decrease:10.f];
        }
    }
}

- (void) updateState {
}

- (void) transitionToStand {
    [character setState:[StandState createWithCharacter:character]];;
}

- (void) transitionToState:(id<CharacterState>) newState {
    if (IS_SUBCLASS(newState, AttackState) && isInBetweenAttacks) {
        [self start];
    }
}

- (void) dealloc {
    [character release];
    [super dealloc];
}

@end
