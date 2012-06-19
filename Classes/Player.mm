//
//  Player.m
//  DragonEye
//
//  Created by alkaiser on 3/22/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Player.h"
#import "Loggers.h"
#import <Foundation/NSDictionary.h>
#import "ObjectContainer.h"

//TODO: move these to a better location
static NSMutableDictionary * directionToOpposite;

@implementation Player

- (id) init:(CGPoint)pos 
	   size:(CGSize)sz 
spriteSheet:(SpriteSheet *)spriteSheet
effectsManager:(ParticleEffectsManager *)effectsManagerParam {
	
	if(self = [super init:pos 
					 size:sz 
			  spriteSheet:spriteSheet
		   effectsManager:effectsManagerParam]) {
	   
       directionToOpposite = [NSMutableDictionary new];
	   [directionToOpposite setObject:[NSNumber numberWithInt:RIGHT] 
							   forKey:[NSNumber numberWithInt:LEFT]]; 
	   [directionToOpposite setObject:[NSNumber numberWithInt:LEFT] 
							   forKey:[NSNumber numberWithInt:RIGHT]];
	   
	   [directionToOpposite setObject:[NSNumber numberWithInt:UP] 
							   forKey:[NSNumber numberWithInt:DOWN]]; 
	   [directionToOpposite setObject:[NSNumber numberWithInt:DOWN] 
							   forKey:[NSNumber numberWithInt:UP]]; 
	   
	   [directionToOpposite setObject:[NSNumber numberWithInt:UP_RIGHT] 
							   forKey:[NSNumber numberWithInt:DOWN_LEFT]];
	   [directionToOpposite setObject:[NSNumber numberWithInt:DOWN_LEFT] 
							   forKey:[NSNumber numberWithInt:UP_RIGHT]];
	   
	   [directionToOpposite setObject:[NSNumber numberWithInt:UP_LEFT] 
							   forKey:[NSNumber numberWithInt:DOWN_RIGHT]]; 
	   [directionToOpposite setObject:[NSNumber numberWithInt:DOWN_RIGHT] 
							   forKey:[NSNumber numberWithInt:UP_LEFT]];
	}
	
	return self;
	
}
+ (Player *) create:(CGPoint) position 
			   size:(CGSize) size 
		spriteSheet:(SpriteSheet *) spriteSheet
	 effectsManager:(ParticleEffectsManager *) effectsManager {
	
	Player *player = [[Player alloc] init:position 
									 size:size 
							  spriteSheet:spriteSheet
						   effectsManager:effectsManager];
	
	DLOG("initializing player...");	
	return player;
}

// physics
- (void) resolveCollisions {
	[physicsEngine detectScreenCollision:[ObjectContainer singleton].player];
    
}
							
- (void) collidesWithPlayer {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];

	[super moveTowards:(Direction)([[directionToOpposite 
									objectForKey:[NSNumber 
												  numberWithInt:currentDirection]] intValue])];
    [pool release];

}

- (void) collidesWithScreen {
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
    [super moveTowards:(Direction)([[directionToOpposite 
									 objectForKey:[NSNumber 
												   numberWithInt:currentDirection]] intValue])];
    [pool release];
}

@end
