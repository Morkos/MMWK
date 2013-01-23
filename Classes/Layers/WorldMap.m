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
#import "ObjectContainer.h"
#import "Atlas.h"
#import "SparseGraph.h"
#import "TravelState.h"
#import "Typedefs.h"

@implementation WorldMap

-(id) init {
    if(self = [super init]) {
        NSLog(@"Initializing the world map.");
        
        self.isTouchEnabled = YES;
                        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        SpriteSheet *playerSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        NSMutableArray * graph = [SparseGraph sharedInstance].adjacencyList;
        
        int tmpTag = tagVertex;
        for (Vertex * vertex in graph) {
            CCSprite * sprite = [CCSprite spriteWithFile:@"attackButton.png"];
            sprite.position = vertex.position;
            sprite.scale = 0.25f;
            [self addChild:sprite z:2 tag:tmpTag++];
        }
                    
        PlayerBuilder *builder = 
            [PlayerBuilder newBuilder:ccp(50, 245) 
                                 size:CGSizeMake(0.5f, 0.5f)
                          spriteFrame:[playerSheet getFrameForKey:ANIMATOR_STAND frameNum:0]];
        
        Player *player = [[[[builder buildSpriteSheet:playerSheet] 
                                        buildStrength:5] 
                                           buildSpeed:2]
                                                  build];
        player.currentHp = 80;
        player.maxHp = 100;
        
        CCSprite * map = [CCSprite spriteWithFile:@"worldmap.gif"];
        [map setScaleX:1.5];
        [map setScaleY:1.5];
        
        map.position = ccp(winSize.width / 2, winSize.height / 2);
                
        [self addChild:map];
        [self addChild:player];
        [self scheduleUpdate];

    }
    return self;
}

-(void) ccTouchesBegan:(NSSet *)touches 
             withEvent:(UIEvent *)event {
    UITouch * touch = [[event allTouches] anyObject];
    CGPoint location = [touch locationInView:[touch view]];
    location = [[CCDirector sharedDirector] convertToGL:location];
    
    Player * player = [ObjectContainer sharedInstance].player;
    CCLOG(@"Touch Point: %@", NSStringFromCGPoint(location));
    
    [[SparseGraph sharedInstance] computePaths:player.position];
    NSArray * shortestPath = [[SparseGraph sharedInstance] findShortestPath:CGPointZero 
                                                                     target:location];
    
    int tmp = tagVertex;
    for (int i = 0; i < [[SparseGraph sharedInstance].adjacencyList count]; i++) {
        CCNode * vertex = [self getChildByTag:tmp++];
        if (CGRectContainsPoint([vertex boundingBox], location)) {
            [player setState:[TravelState createWithCharacter:player 
                                                         path:shortestPath]];
            break;
        }
    }
}

- (void) addChild:(CCNode *)node 
                z:(NSInteger)z 
              tag:(NSInteger)tag {
    [[ObjectContainer sharedInstance] addObject:node];
    [super addChild:node 
                  z:z 
                tag:tag];
}

- (void) dealloc {
    [super dealloc];
}

- (void) update:(ccTime) delta {
    [[ObjectContainer sharedInstance] update];
}

@end
