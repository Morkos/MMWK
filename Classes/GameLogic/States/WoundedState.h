//
//  WoundedState.h
//  DragonEye
//
//  Created by mac on 9/3/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Character;
#import "CharacterState.h"
#import "Character.h"

@interface WoundedState : NSObject<CharacterState> {
    Character *character;
}

@property(nonatomic, retain) Character *character;

+ (WoundedState *) createWithCharacter:(Character *) character;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end