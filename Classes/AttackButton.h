//
//  AttackButton.h
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectContainer.h"

static CGFloat TIME_EXPIRE_ON_HOLD_IN_SECONDS = 0.5;
static CGFloat TIME_EXPIRE_ON_RELEASE_IN_SECONDS = 0.5;

@interface AttackButton : UIImageView {

}

/**
 * Every touch on the attack button (bottom-right corner),
 * this function will be called.
 */
- (void)touchesBegan:(NSSet *)touches 
		   withEvent:(UIEvent *)event;

/**
 * Everytime a finger is lifted off the attack button,
 * this function will be called.
 */
- (void) touchesEnded:(NSSet*)touches 
            withEvent:(UIEvent*)event;

@end
