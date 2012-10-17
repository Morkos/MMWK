//
//  ComboState.h
//  DragonEye
//
//  Created by Mark Mikhail on 7/18/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//


#import "Character.h"

@interface ComboState : NSObject<CharacterState> {
    Character * character;
    NSString * comboKey;
    NSUInteger currentAttack;
}

@property (nonatomic, retain) Character * character;
@property (nonatomic, assign) NSUInteger currentAttack;
@property (nonatomic, retain) NSString * comboKey;

+ (ComboState *) createWithCharacter:(Character *) character 
                            comboKey:(NSString *) comboKey;
                        

- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end
