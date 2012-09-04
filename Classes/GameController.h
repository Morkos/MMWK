//
//  DragonEyeViewController.h
//  DragonEye
//
//  Created by alkaiser on 2/12/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <OpenGLES/EAGL.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import <QuartzCore/QuartzCore.h>
#import "EAGLView.h"
#import "Texture.h"
#import "Program.h"
#import "Player.h"
#import "Overlay.h"
#import "Background.h"
#import "Node.h"
#import "Loggers.h"
#import "Shader.h"
#import "ShaderConstants.h"
#import "ShaderManager.h"
#import "ObjectContainer.h"
#import "SlashingParticleEffect.h"
#import "ParticleEffectsManager.h"
#import "Camera.h"
#import "SpriteSheetManager.h"

@interface GameController : UIViewController
{
    EAGLContext *context;
    BOOL animating;
    NSInteger animationFrameInterval;
    CADisplayLink *displayLink;
}

@property (readonly, nonatomic, getter=isAnimating) BOOL animating;
@property (nonatomic) NSInteger animationFrameInterval;
@property (nonatomic, retain) EAGLContext *context;
@property (nonatomic, assign) CADisplayLink *displayLink;

- (void) startGame;
- (void) stopGame;
- (void) gameLoop;
- (BOOL) loadShaders;

@end
