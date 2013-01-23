//
//  TravelState.h
//  DragonEye
//
//  Created by Mark Mikhail on 1/17/13.
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CharacterState.h"
#import "Character.h"

@class Character;

@interface TravelState : NSObject<CharacterState> {
    Character * character;
    NSArray * path;
}

@property (nonatomic, retain) Character * character;
@property (nonatomic, retain) NSArray * path;

+ (TravelState *) createWithCharacter:(Character *) character
                                 path:(NSArray *)path;
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end
