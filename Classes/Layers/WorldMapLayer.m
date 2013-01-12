//
//  WorldMap.m
//  DragonEye
//
//  Created by Mark Mikhail on 12/15/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "WorldMap.h"
#import "SpriteSheetManager.h"
#import "PlayerBuilder.h"
#import "HealthPotion.h"

@implementation WorldMap

-(id) init {
    if(self = [super init]) {
        NSLog(@"world layer initiation...");
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
                
        PlayerBuilder *builder = 
        [PlayerBuilder newBuilder:ccp(50,220) 
                             size:CGSizeMake(0.5f, 0.5f)
                      spriteFrame:[spriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]];
        
        Player *player = [[[[builder buildSpriteSheet:spriteSheet] 
                                        buildStrength:5] 
                                           buildSpeed:2]
                                                  build];
        player.currentHp = 80;
        player.maxHp = 100;
        
        HealthPotion *healthPotion = [HealthPotion itemWithTexture:@"healthPotion.png"];
        healthPotion.position = ccp(300, 100);
        healthPotion.hpIncrease = 20;
        
        CCSprite * map = [CCSprite spriteWithFile:@"metro_map.png"];
        map.position = ccp(winSize.width / 2, winSize.height / 2);
        [self addChild:map];
        
        [self addChild:player];
        [self addChild:healthPotion];
        
    }
    
    return self;
}
@end
