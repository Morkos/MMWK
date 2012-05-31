//
//  MoveState.h
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterState.h"
#import "Character.h"

@class Character;

@interface MoveState: NSObject<CharacterState> {
    Character *character;
}

@property(nonatomic, retain) Character *character;

+ (MoveState *) createWithCharacter:(Character *) character;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;
@end
