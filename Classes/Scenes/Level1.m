//
//  Level1.m
//  DragonEye
//
//  Created by Mark Mikhail on 11/4/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Level1.h"

#import "WorldLayer.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "OverlayLayer.h"

@implementation Level1

+ (CCScene *) scene {
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];
    
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
    // 'layer' is an autorelease object.
    
    [scene addChild:[WorldLayer node] z:1 tag:tagWorldLayer];
    [scene addChild:[BackgroundLayer node] z:-2];	
    [scene addChild:[HUDLayer node] z:2 tag:tagHudLayer];
    [scene addChild:[OverlayLayer node] z:3 tag:tagOverlayLayer];
    
	// return the scene
	return scene;
}

@end
