//
//  ChaseState.h
//  DragonEye
//
//  Created by Mark Mikhail on 10/10/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterState.h"
#import "Character.h"
#import "CoordinateSystem.h"

@interface ChaseState : NSObject<CharacterState> {
    Character * character;
    CoordinateSystem * coordinateSystem;
}

@property (nonatomic, retain) Character *character;
@property (nonatomic, retain) CoordinateSystem * coordinateSystem;

+ (ChaseState *) createWithCharacter:(Character *) character;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end
