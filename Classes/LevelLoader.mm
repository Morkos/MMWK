//
//  LevelParser.m
//  DragonEye
//
//  Created by Mark Mikhail on 4/25/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelLoader.h"
#import "Loggers.h"
#import "Texture.h"
#import "SpriteSheet.h"
#import "ObjectContainer.h"
#import "Overlay.h"

static const LevelLoader * levelLoader = NULL;
static NSDictionary * classToSetup;

@implementation LevelLoader

@synthesize decoder;

+ (LevelLoader *) getInstance {
	
	if(!levelLoader) {
			
		levelLoader = [[LevelLoader alloc] init];
		levelLoader.decoder = [JSONDecoder decoder];
		
		//set up entry point functions for each key in files for each level.
		classToSetup = [NSDictionary dictionaryWithObjectsAndKeys:
							[NSValue valueWithPointer:@selector(setUpBackground:)], @"Background",
							[NSValue valueWithPointer:@selector(setUpPlayer:)]	  , @"Player",
							[NSValue valueWithPointer:@selector(setUpTitle:)]	  , @"Title",
							[NSValue valueWithPointer:@selector(setUpNodes:)]     , @"Node",
							[NSValue valueWithPointer:@selector(setUpEnemies:)]   , @"Enemies",
							 nil ];
		
	}
	
	return levelLoader;
		
}

- (void) loadLevel:(Level)level {
	
	//concatenates "level" string with numeric value of Level enum being passed in.
	NSString *levelName = [NSString stringWithFormat:@"level%d", level];	
	
	NSString *jsonLevel = [[NSBundle mainBundle] 
								pathForResource:levelName
										 ofType:@"json"];
	
	NSData *jsonData = [NSData dataWithContentsOfURL:
							  [NSURL fileURLWithPath:jsonLevel]];
	
	NSDictionary *items = [decoder objectWithData:jsonData];
	
	for(id key in [[items allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
		
		DLOG("Key=%@, value=%@", key, [items objectForKey:key]);
			
		//delegates to a setUp* fxn
		SEL delegate = (SEL)([[classToSetup objectForKey:key] pointerValue]);
		[self performSelector:delegate
				   withObject:[items objectForKey:key]];
			
	}
	
	DLOG("Total class count: %d", [items count]);
}

- (void) setUpTitle:(id)levelTitle {
	
	DLOG("Title is %@", levelTitle);
		
}

- (void) setUpBackground:(id)backgroundName {
	
		
	Texture *backgroundTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
															   pathForResource:backgroundName 
																		ofType:@"png"]];
	
	Background *background = [Background backgroundWithTexture:backgroundTexture 
												   scrollSpeed:1.0f];
	
	[[ObjectContainer singleton] addObject:background];
	
	
}

- (void) setUpNodes:(id)attributes {
	
	NSArray * positionList = [attributes objectForKey:@"Position"];
	NSArray * sizeList	   = [attributes objectForKey:@"Size"];
	NSString * imageName   = [attributes objectForKey:@"Image"];
	
	CGPoint position = CGPointMake([[positionList objectAtIndex:0] floatValue], 
								   [[positionList objectAtIndex:1] floatValue]);
	
	CGSize size = CGSizeMake([[sizeList objectAtIndex:0] floatValue], 
							 [[sizeList objectAtIndex:1] floatValue]);
	
	DLOG("imageName: %@, position:(%lf, %lf), size:(%lf,%lf)", 
		 imageName, position.x, position.y, size.width, size.height);
 
	Texture *overlayTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
															pathForResource:imageName
															ofType:@"png"]];
	
	SpriteSheet *overlaySprite = [SpriteSheet createWithTexture:overlayTexture  
													  numOfRows:1
														columns:[NSArray arrayWithObjects:
																  [NSNumber numberWithInt:1],
																  nil
																]
								  ];
	
	Node * node = [Overlay nodeAtPosition:position
									 size:size
							  spriteSheet:overlaySprite];
	
	
    [[ObjectContainer singleton] addObject:node];
	
}
						
- (void) setUpPlayer:(id)attributes {
		
	NSArray * positionList = [attributes objectForKey:@"Position"];
	NSArray * sizeList	   = [attributes objectForKey:@"Size"];
	NSString * imageName   = [attributes objectForKey:@"Image"];
	
	
	CGPoint position = CGPointMake([[positionList objectAtIndex:0] floatValue], 
								   [[positionList objectAtIndex:1] floatValue]);
	
	CGSize size = CGSizeMake([[sizeList objectAtIndex:0] floatValue], 
							 [[sizeList objectAtIndex:1] floatValue]);
							
	
	DLOG("imageName: %@, position:(%lf, %lf), size:(%lf,%lf)", 
		 imageName, position.x, position.y, size.width, size.height);
	
	Texture *playerTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
															 pathForResource:imageName 
																	  ofType:@"png"]];
	
	SpriteSheet *sprite = [SpriteSheet createWithTexture:playerTexture 
											   numOfRows:5
												 columns:[NSArray arrayWithObjects:
																 [NSNumber numberWithInt:1],
																 [NSNumber numberWithInt:4],
																 [NSNumber numberWithInt:3],
																 [NSNumber numberWithInt:7],
																 [NSNumber numberWithInt:4],
																 nil
														 ]
						   ];
	
	
	Texture *slashTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
														  pathForResource:@"slash" 
														  ofType:@"png"]];
	
	// Particle effects
	// TODO: Use configuration file
	ParticleEffectsManager *effectsManager = [ParticleEffectsManager manager:1];
	
	BezierCurve *path = [BezierCurve curveFrom:CGPointMake(0.4, 0.2)
											to:CGPointMake(0.4, -0.2) 
											c0:CGPointMake(0.5, 0.1) 
											c1:CGPointMake(0.5, 0.0) 
								   numOfPoints:50];
	
	SlashingParticleEffect *slashingParticleEffect = 
	[SlashingParticleEffect createEffect:path 
								   speed:5 
							particleSize:CGSizeMake(0.05f, 0.1f)
							  startAngle:0.5f
								endAngle:2.0f
						   opacityFactor:1.15f
						   frameInterval:1
								   image:slashTexture];
	
	[effectsManager addEffect:slashingParticleEffect key:@"attack0"];
	
	Player *player = [Player create:position 
							   size:size
						spriteSheet:sprite
					 effectsManager:effectsManager];
	
	[[ObjectContainer singleton] addObject:player];
	
}
						
- (void) setUpEnemies:(id)attributes {
	
	for(id enemy in attributes) {
		DLOG("enemy: %@", enemy);
	}
}


@end
