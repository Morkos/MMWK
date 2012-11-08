//
//  ComboState.m
//  DragonEye
//
//  Created by Mark Mikhail on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboState.h"

@interface ComboState () 
    -(void) transitionToStand;
@end
@implementation ComboState

@synthesize character,
        currentAttack,
             comboKey;

+ (ComboState *) createWithCharacter:(Character *)character 
                            comboKey:(NSString *)comboKey {
    
    ComboState * comboState = [[ComboState alloc] init];
    comboState.character = character;
    comboState.currentAttack = 0;
    comboState.comboKey = comboKey;
    return comboState;
}

- (void) start {
    // TODO For now, hardcode all 3 attacks. Will revisit when there is an actual combo
    NSString *attack0 = NSSTRING_FORMAT(ANIMATOR_ATTACK, 0);
    NSString *attack1 = NSSTRING_FORMAT(ANIMATOR_ATTACK, 1);
    NSString *attack2 = NSSTRING_FORMAT(ANIMATOR_ATTACK, 2);
    
    [SpriteSheetAnimator startAnimationSeries:character
                                  spriteSheet:character.spriteSheet
                                    frameKeys:[NSArray arrayWithObjects:attack0, attack1, attack2, nil]
                                frameInterval:0.1f
                                       target:self
                                     selector:@selector(createAction:)];

}

-(CCAction *) createAction:(NSArray *) animations {
    CCAnimation *attack0 = [animations objectAtIndex:0];
    CCAnimation *attack1 = [animations objectAtIndex:1];
    CCAnimation *attack2 = [animations objectAtIndex:2];
    
    attack0.restoreOriginalFrame = false;
    attack1.restoreOriginalFrame = false;
    attack2.restoreOriginalFrame = false;
    CCAction *action = [CCSequence actions:[CCAnimate actionWithAnimation:attack0],
                                           [CCDelayTime actionWithDuration:0.2f],
                                           [CCAnimate actionWithAnimation:attack1],
                                           [CCDelayTime actionWithDuration:0.2f],
                                           [CCAnimate actionWithAnimation:attack2],
                                           [CCDelayTime actionWithDuration:0.2f],
                                           [CCCallFunc actionWithTarget:self selector:@selector(transitionToStand)],
                                           nil];
    
    return action;
}


- (void) updateState {
}

- (void) transitionToStand {
    [character setState:[StandState createWithCharacter:character]];;
}

- (void) transitionToState:(id<CharacterState>)newState {
    // Can't transition to anything in combo mode
}

@end
