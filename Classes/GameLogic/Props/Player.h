//
//  Player.h
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "SpriteSheet.h"
#import "Character.h"
#import "Gauge.h"

@interface Player : Character<Collidable> {
    Gauge * specialGauge;
}

@property (nonatomic, retain) Gauge * specialGauge;

- (void) resolveCollisions;
// collision reactions
- (void) collidesWithPlayer;
- (void) collidesWithScreen;

/**
 * Based on the number of hits/taps and hold on the attack button
 * this will trigger a combo attempt (draw the nodes on screen 
 * for player to swipe).
 *
 * @param NSUInteger - number of taps on attack button.
 */
- (void) initiateComboAttempt:(NSUInteger) hits;

/**
 * Once the player hits all the combo nodes correctly then
 * this method will get triggered
 *
 * @param comboKey - a key referencing which animation to play
 */
- (void) initiateComboAnimation:(NSString *) comboKey;

/**
 * Is the main player walking around the world map?
 *
 * @return yes or no
 */
- (BOOL) isTravelingTheWorld;

@end
