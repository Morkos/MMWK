//
//  CharacterState.h
//  DragonEye
//
//  Created by mac on 5/29/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * Chang this us a singlton pattrn 
 *
 */
@protocol CharacterState <NSObject>

@required
- (void) start;
- (void) updateState;
- (void) transitionToState:(id<CharacterState>) newState;

@end
