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
#import "GraphicsEngine.h"
#import "SpecialBar.h"
#import "TextureRenderTarget.h"

@interface Player : Character<Collidable> {
    SpecialBar * specialBar;
    TextureRenderTarget *renderTarget;
}

@property (nonatomic, retain) SpecialBar * specialBar;
@property (nonatomic, retain) TextureRenderTarget *renderTarget;

- (Player *) init:(CGPoint)pos
             size:(CGSize)sz;
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


@end
