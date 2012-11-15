//
//  StateMachine.h
//  DragonEye
//
//  Created by Mark Mikhail on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CharacterState.h"

@interface StateMachine : NSObject {
    id<CharacterState> currentState;
}

@property(nonatomic, retain) id<CharacterState> currentState;
-(id) init;
-(void) update;

@end
