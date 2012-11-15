//
//  StateMachine.m
//  DragonEye
//
//  Created by Mark Mikhail on 10/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "StateMachine.h"
#import "StandState.h"

@implementation StateMachine
@synthesize currentState;

-(id) init {
    self.currentState = [[StandState alloc] init];
    return self;
}
-(void) update {
    
    [currentState updateState];
}
@end
