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

static NSMutableArray * nodes = nil;
static int nodTag = 200;

@implementation WorldMap

-(id) init {
    if(self = [super init]) {
        NSLog(@"world layer initiation...");
        
        self.isTouchEnabled = YES;
        
        id<Atlas> atlas = [SparseGraph sharedInstance];
        
        nodes = [NSMutableArray arrayWithCapacity:10];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        SpriteSheet *spriteSheet = [[SpriteSheetManager getInstance] loadSpriteSheet:@"lancelotSpSheet.png"];
        NSMutableArray * graph = [SparseGraph sharedInstance].adjacencyList;
        
        int tmpTag = nodTag;
        for (Vertex * vertex in graph) {
            CCSprite * sprite = [CCSprite spriteWithFile:@"attackButton.png"];
            sprite.position = vertex.position;
            sprite.scale = 0.25f;
            [self addChild:sprite z:2 tag:tmpTag++];
        }
        
        NSLog(@"nods ?= %@", nodes);
            
        PlayerBuilder *builder = 
            [PlayerBuilder newBuilder:ccp(50, 245) 
                                 size:CGSizeMake(0.5f, 0.5f)
                          spriteFrame:[spriteSheet getFrameForKey:ANIMATOR_STAND frameNum:0]];
        
        Player *player = [[[[builder buildSpriteSheet:spriteSheet] 
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

    NSLog(@"Touch Point: %@", NSStringFromCGPoint(location));
    [[SparseGraph sharedInstance] computePaths:player.position];
    NSArray * shortestPath = [[SparseGraph sharedInstance] findShortestPath:CGPointZero 
                                                                     target:location];
    
    player.behavior.wayPoints = shortestPath;
    player.behavior.rator = [shortestPath objectEnumerator];
    player.behavior.start = [player.behavior.rator nextObject];
    
    NSLog(@"shortest path: %@", shortestPath);
    int tmp = nodTag;
    for (int i = 0; i < [[SparseGraph sharedInstance].adjacencyList count]; i++) {
        CCNode * nod = [self getChildByTag:tmp++];
        if (CGRectContainsPoint([nod boundingBox], location)) {
            [player setState:[MoveState createWithCharacter:player 
                                                       path:shortestPath]];
            break;
        }
    }
}

- (void) addChild:(CCNode *)node 
                z:(NSInteger)z 
              tag:(NSInteger)tag {
    [[ObjectContainer sharedInstance] addObject:node];
    [super addChild:node z:z tag:tag];
}

- (void)dealloc {
    [super dealloc];
}

-(void) update:(ccTime) delta {
    [[ObjectContainer sharedInstance] update];
}

@end