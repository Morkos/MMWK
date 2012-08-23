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
#import "FreezeModeManager.h"
#import "ComboState.h"

//TODO: move this to a better location
static NSMutableDictionary * directionToOpposite;

@implementation Player

@synthesize specialBar;

- (id)    init:(CGPoint)pos 
          size:(CGSize)sz {
	
	if(self = [super init:pos 
					 size:sz]) {
       
       DLOG("initializing player...");	

       self.specialBar = [SpecialBar getInstance];

       directionToOpposite = [[NSMutableDictionary alloc] init];
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

- (void) initiateComboAttempt:(NSUInteger) hits {
    NSString * hitCount = [[[NSNumberFormatter alloc] init] stringFromNumber:[NSNumber numberWithInt:hits]];
    NSLog(@"hit count: %@", hitCount);
    [[FreezeModeManager getInstance] changeNodes:hitCount];
}

- (void) initiateComboAnimation:(NSString *)comboKey {
    NSLog(@"Initiating combo animation...");
    [self setState:[ComboState createWithCharacter:self
                                          comboKey:ANIMATOR_ATTACK]];
}

@end
