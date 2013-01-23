//
//  BattleScene.m
//  DragonEye
//
//  Created by Alkaiser on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "BattleScene.h"

#import "BattleLayer.h"
#import "BackgroundLayer.h"
#import "HUDLayer.h"
#import "OverlayLayer.h"
#import "SpriteSheetManager.h"
#import "NSPropertyUtil.h"

@implementation BattleScene

+(CCScene *) scene {
    [[SpriteSheetManager getInstance] loadFromItems:[NSPropertyUtil loadProperties:@"spriteSheets.plist"]];
    
	// 'scene' is an autorelease object.
	CCScene *scene = [BattleScene node];
    
    [scene addChild:[BattleLayer node] z:1 tag:tagBattleLayer];
    
	// return the scene
	return scene;
}

@end
