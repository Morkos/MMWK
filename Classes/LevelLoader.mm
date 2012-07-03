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
#import "Camera.h"
#import "FreezeModeManager.h"

static LevelLoader * levelLoader = NULL;
static NSDictionary * classToSetup;

//TODO: changg Background class to a singleton
static Background *background = [Background backgroundWithScrollSpeed:1.0f];
static Camera * camera = [Camera getInstance];

@implementation LevelLoader

@synthesize decoder;

+ (LevelLoader *) getInstance {
	
	if(!levelLoader) {
			
		levelLoader = [[LevelLoader alloc] init];
		levelLoader.decoder = [JSONDecoder decoder];
		
		//set up entry point functions for each key in files for each level.
		classToSetup = [NSDictionary dictionaryWithObjectsAndKeys:
							[NSValue valueWithPointer:@selector(setUpBackground:)], @"Backgrounds",
                            [NSValue valueWithPointer:@selector(setUpBgSequence:)], @"BgSequence",
							[NSValue valueWithPointer:@selector(setUpPlayer:)]	  , @"Player",
							[NSValue valueWithPointer:@selector(setUpTitle:)]	  , @"Title",
							[NSValue valueWithPointer:@selector(setUpCombos:)]    , @"Combos",
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
	
    NSLog(@"Key/Values in level%d.json %@", level, items);
    //TODO: get rid of this sort fiasco.
	for(id key in [[items allKeys] sortedArrayUsingSelector:@selector(compare:)]) {
        NSLog(@"iterating.....");
		NSLog(@"Key=%@, value=%@", key, [items objectForKey:key]);
			
		//delegates to a setUp* fxn
		SEL delegate = (SEL)([[classToSetup objectForKey:key] pointerValue]);
		[self performSelector:delegate
				   withObject:[items objectForKey:key]];
			
	}
}

- (void) setUpTitle:(id)levelTitle {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	DLOG("Title is %@", levelTitle);
    [pool release];

}

- (void) setUpBackground:(id)backgrounds {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	for(id bg in backgrounds) {
		DLOG("Creating texture for %@", bg);
		Texture *backgroundTexture = [Texture textureWithFilename:[[NSBundle mainBundle] 
																   pathForResource:bg
																			ofType:@"png"]];
        [background addBackgroundTexture:backgroundTexture];
	}
	
	
	[[ObjectContainer singleton] addObject:background];
    [pool release];

	
	
}

- (void) setUpBgSequence:(id)bgSequence {
    
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    background.bgSequence = bgSequence;
    //end of level is denoted by number of bg frames * frame width
    //TODO: this will be refactored out into the Stage class.
    camera.endOfLevelBoundary = [background.bgSequence count] * camera.frameDimension.width;   
    
    [pool release];
}

- (void) setUpCombos:(id)attributes {
	
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

	NSDictionary * comboToNodes = [attributes objectForKey:@"NodePositions"];
	NSArray * sizeList = [attributes objectForKey:@"Size"];
	NSString * imageName = [attributes objectForKey:@"Image"];
	
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
    
    FreezeModeManager * manager = nil;

    for (id comboId in [comboToNodes allKeys]) {
        
        NSMutableArray * tempNodeList = [NSMutableArray arrayWithCapacity:10];
        
        for(id position in [comboToNodes objectForKey:comboId]) {
            CGPoint pos = CGPointMake([[position objectAtIndex:0] floatValue],
                                      [[position objectAtIndex:1] floatValue]);
                    
            Node * node = [Overlay nodeAtPosition:pos
                                             size:size
                                      spriteSheet:overlaySprite];
            
            [tempNodeList addObject:node];
        }
        
        NSDictionary * nodesDictionary = [NSDictionary dictionaryWithObjectsAndKeys:tempNodeList, comboId,
                                          nil];
       
        manager = [FreezeModeManager getInstance];
        [manager addNodes:nodesDictionary];
    }
    
    [[ObjectContainer singleton] addObject:manager];
	
    [pool release];

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
	ParticleEffectsManager *effectsManager = [ParticleEffectsManager manager:3];
	
	BezierCurve *pathAttack0 = [BezierCurve curveFrom:CGPointMake(0.4, 0.2)
												   c0:CGPointMake(0.5, 0.1)
												   c1:CGPointMake(0.5, 0.05)
												   to:CGPointMake(0.4, 0.0)
										  numOfPoints:50];	
	
	SlashingParticleEffect *attackEffect0 = 
	[SlashingParticleEffect createEffect:pathAttack0
								   speed:5 
							particleSize:CGSizeMake(0.025f, 0.025f)
							  startAngle:0.5f
								endAngle:2.0f
						   opacityFactor:1.15f
						   frameInterval:1
								   image:slashTexture];
	
	BezierCurve *pathAttack1 = [BezierCurve curveFrom:CGPointMake(0.4, 0.2)
                                                   c0:CGPointMake(0.5, 0.1) 
                                                   c1:CGPointMake(0.5, -0.2) 
                                                   to:CGPointMake(0.4, -0.4) 
                                          numOfPoints:50];
	
    SlashingParticleEffect *attackEffect1 = 
	[SlashingParticleEffect createEffect:pathAttack1 
								   speed:5 
							particleSize:CGSizeMake(0.025f, 0.025f)
							  startAngle:0.5f
								endAngle:2.0f
						   opacityFactor:1.15f
						   frameInterval:1
								   image:slashTexture];
	
    BezierCurve *pathAttack2 = [BezierCurve curveFrom:CGPointMake(0.4, 0.1)
                                                   c0:CGPointMake(0.2, 0.05)
                                                   c1:CGPointMake(0.1, 0.02)
                                                   to:CGPointMake(0.0, 0.0)
                                          numOfPoints:50];
	
    SlashingParticleEffect *attackEffect2 =
	[SlashingParticleEffect createEffect:pathAttack2
								   speed:5
							particleSize:CGSizeMake(0.025f, 0.025f)
							  startAngle:0.5f
								endAngle:2.0f
						   opacityFactor:1.15f
						   frameInterval:1
								   image:slashTexture];
	
    [effectsManager addEffect:attackEffect0 key:@"attack0"];
    [effectsManager addEffect:attackEffect1 key:@"attack1"];
    [effectsManager addEffect:attackEffect2 key:@"attack2"];
    
    NSDictionary *stringToRowMap = 
    [NSDictionary dictionaryWithObjectsAndKeys:
                            [NSNumber numberWithInt:0], @"stand", 
                            [NSNumber numberWithInt:1], @"move", 
                            [NSNumber numberWithInt:2], @"attack0", 
                            [NSNumber numberWithInt:3], @"attack1", 
                            [NSNumber numberWithInt:4], @"attack2", 
                            nil];
    
    id<AnimationTimer> animationTimer = [FrameBasedTimer createTimerWithFrameInterval:8];
    
    SpriteSheetAnimator *animator = [SpriteSheetAnimator createWithSpsheet:sprite 
                                                    stringToRowMap:stringToRowMap 
                                                             timer:animationTimer];
	
	Player *player = [Player create:position 
							   size:size
					 effectsManager:effectsManager
                           animator:animator];
	
	[[ObjectContainer singleton] addObject:player];
}
						
- (void) setUpEnemies:(id)enemies {
	for(id enemy in enemies) {
		DLOG("enemy: %@", enemy);
	}
}


@end
