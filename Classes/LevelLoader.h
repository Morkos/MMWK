//
//  LevelParser.h
//  DragonEye
//
//  Created by Mark Mikhail on 4/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONKit.h"
#import "LevelEnum.h"
#import "BezierCurve.h"
#import "SlashingParticleEffect.h"
#import "ParticleEffectsManager.h"
#import "SpritesheetAnimator.h"
#import "FrameBasedTimer.h"

@interface LevelLoader : NSObject {
	JSONDecoder * decoder;
}

@property (nonatomic, retain) JSONDecoder * decoder;

+ (LevelLoader *) getInstance;

- (void) loadLevel:(Level)level;

@end
