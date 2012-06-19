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

/**
 * LevelLoader is a JSON parser that parses loads the main player,
 * background, and other level related attributes.
 *
 * @return single instance of LevelLoader
 */
+ (LevelLoader *) getInstance;

/**
 * Loads a level that is bounded by LevelEnum.h
 * E.g. If enum is LEVEL1, then the value is 0 so it will 
 * concatenate "level" with '0" and load level0.json.
 */
- (void) loadLevel:(Level)level;

@end
