//
//  AttackButton.h
//  DragonEye
//
//  Created by alkaiser on 4/23/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ObjectContainer.h"
#import "HUDControl.h"

@interface AttackButton : HUDControl {

}

+ (AttackButton *) buttonWithSprite:(CCSprite *) sprite;

/**
 * Every touch on the attack button (bottom-right corner),
 * this function should be called.
 */
- (void) buttonInitiated;

/**
 * Everytime a finger is lifted off the attack button,
 * this function should be called.
 */
- (void) buttonEnded;

@end
