//
//  FreezeModeManager.m
//  DragonEye
//
//  Created by Mark Mikhail on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "FreezeModeManager.h"
#import "Node.h"
#import "Queue.h"
#import "ObjectContainer.h"
#import "NSPropertyUtil.h"
#import "SpriteSheetManager.h"

@implementation FreezeModeManager

@synthesize nodesDictionary,
            nextValidNodetoTouch, 
            currentComboNodes,
            currentComboKey,
            layer;

+ (FreezeModeManager *) managerWithPlist:(NSString *) plistFilename 
                                   layer:(CCLayer *) layer {
    FreezeModeManager *manager = [[FreezeModeManager alloc] init:plistFilename
                                                           layer:layer];
    return manager;
}

- (id) init:(NSString *) plistFilename 
      layer:(CCLayer *) layerParam {
    if(self = [super init]) {
        self.currentComboKey = @"0";
        self.nodesDictionary = [[NSMutableDictionary dictionaryWithCapacity:2] retain];
        self.nextValidNodetoTouch = 0;
        self.layer = layerParam;
    }
    
    [self loadFromFile:plistFilename];
    
    return self;
}

- (void) loadFromFile:(NSString *) plistFilename {
    NSDictionary *items = [NSPropertyUtil loadProperties:plistFilename];
    NSString *imageFilename = [items objectForKey:@"image"];
    CGSize size = CGSizeFromString([items objectForKey:@"scale"]);
    NSDictionary *nodePositions = [items objectForKey:@"nodePositions"];
    
    for (NSString *comboKey in nodePositions) {
        NSArray *positions = [nodePositions objectForKey:comboKey];
        NSMutableArray *nodesArray = [NSMutableArray arrayWithCapacity:[positions count]];
        for (NSString *pointStr in positions) {
            CGPoint position = CGPointFromString(pointStr);
            
            Node *node = [Node nodeAtPosition:position 
                                         size:size
                                  spriteSheet:[[SpriteSheetManager getInstance] loadSpriteSheet:imageFilename]];
            
            [nodesArray addObject:node];
        }
        
        [self.nodesDictionary setObject:nodesArray forKey:comboKey];
    }
    
}

- (void) displayNodes:(NSString *)comboKey {
    NSMutableArray * comboNodes = [nodesDictionary objectForKey:comboKey];
    [self.layer removeAllChildrenWithCleanup:true];
    
    for (NSInteger index = 0; index < [comboNodes count]; index++) {
        Node *node = [comboNodes objectAtIndex:index];
        
        // Mark all current nodes neutral
        [node markNeutral];
        
        
        [self.layer addChild:node.sprite];
    }
    
    self.nextValidNodetoTouch = 0;
    self.currentComboNodes = comboNodes;
    self.currentComboKey = comboKey;
}

- (void) processNodesTouches:(CGPoint) location {
    for(int i = 0; i < [self.currentComboNodes count]; i++) {
        Node *node = [self.currentComboNodes objectAtIndex:i];
        if ([node isLocationInView:location]) {
            BOOL correctNodeIsTouched = 
                [self.currentComboNodes objectAtIndex:self.nextValidNodetoTouch] == node;
            BOOL nodeHasNotBeenTouched = [node isNeutral];
            
            if (correctNodeIsTouched && nodeHasNotBeenTouched) {
                [node markValid];
                self.nextValidNodetoTouch = (self.nextValidNodetoTouch + 1) % [self.currentComboNodes count];
                
                //all nodes have been touched correctly
                if(self.nextValidNodetoTouch == 0) {
                    [self.layer removeAllChildrenWithCleanup:true];
                    
                    //TODO: play effect in disappearing the nodes.
                    [[ObjectContainer sharedInstance].player initiateComboAnimation:self.currentComboKey];
                }
            } else {
                if(nodeHasNotBeenTouched) {
                    [node markInvalid];
                    NSLog(@"You touched the incorrect node.");
                }
            }
        }
    }
}

- (void) update {
    
    //TODO: count down timer
    //TODO: animation
}

- (void) dealloc {
    [self.nodesDictionary release]; 
    [self.currentComboNodes release];
    [self.currentComboKey release];
    [super dealloc];
}

@end
