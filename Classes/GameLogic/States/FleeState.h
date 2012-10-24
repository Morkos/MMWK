//
//  FleeState.h
//  DragonEye
//
//  Created by Mark Mikhail on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterState.h"
#import "Character.h"

@interface FleeState : MoveState {
}

+ (FleeState *) createWithCharacter:(Character *) character;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end
