//
//  ComboState.m
//  DragonEye
//
//  Created by Mark Mikhail on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ComboState.h"

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
}

- (void) updateState {
    
    if([character.animator isLastAnimation]) {
        NSString * key = [NSString stringWithFormat:comboKey, currentAttack++];
        [self.character.animator startAnimation:key
                                         replay:false];
        
        // Invoke particle effect
        [character.effectsManager invokeEffect:key 
                                          prop:character];
        
        //TODO: abstract this when we have real combos.
        if (currentAttack >= 4) {
            NSLog(@"set to standing state...");
            [character setState:[StandState createWithCharacter:character]];
        }
    }
}

- (void) transitionToState:(id<CharacterState>)newState {
    if ([[newState class] isSubclassOfClass:[StandState class]]) {
        [character setState:newState];
    }
}

@end
