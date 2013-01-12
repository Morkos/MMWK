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
#import "SpriteSheetManager.h"

@class Character;

@interface MoveState: NSObject<CharacterState> {
    Character *character;
    NSArray * path;
}

@property(nonatomic, retain) Character * character;
@property(nonatomic, assign) NSArray * path;

+ (MoveState *) createWithCharacter:(Character *) character;
+ (MoveState *) createWithCharacter:(Character *) character
                               path:(NSArray *) path;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;
@end
