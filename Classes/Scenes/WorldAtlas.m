//
//  WorldAtlas.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorldAtlas.h"
#import "WorldLayer.h"
#import "WorldMap.h"
#import "SpriteSheetManager.h"

@implementation WorldAtlas

+ (CCScene *) scene {
    NSLog(@"Creating world atlas scene");
    
    CCScene * scene = [CCScene node];
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];
    
	// 'scene' is an autorelease object.
    [scene addChild:[WorldMap node] z:2];
    
    NSLog(@"Finishing creating scene...");
    return scene;
}

@end
