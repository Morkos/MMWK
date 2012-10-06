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

static FreezeModeManager * manager = nil;
static NSMutableArray * nodesOnScreen = nil;
static int nextValidNodetoTouch = 0;

@implementation FreezeModeManager
@synthesize currentComboKey,
            nodesDictionary;

+ (id) getInstance {
    if(!manager) {
        manager = [[FreezeModeManager alloc] init];
        manager.currentComboKey = @"0";
        manager.nodesDictionary = [[NSMutableDictionary alloc] init];
        
        nodesOnScreen = [[NSMutableArray alloc] init];
        [nodesOnScreen retain];
    }
    
    return manager;
}

- (void) addNodes:(NSMutableDictionary *)nodes {    
    [self.nodesDictionary addEntriesFromDictionary:nodes];
}

- (NSMutableArray *) getNodesOnScreen {
    return nodesOnScreen;
}

- (void) changeNodes:(NSString *)comboKey {
    NSMutableArray * comboNodes = [self.nodesDictionary objectForKey:comboKey];
    /**
     * calls copyWithZone on each element in the array to create a deep copy
     * except that it resets the nodeVisualState to neutral
     */
    nodesOnScreen = [[NSMutableArray alloc] initWithArray:comboNodes
                                                copyItems:YES];
    nextValidNodetoTouch = 0;
}

- (void) processNodesTouches:(CGPoint)touchPoint {    
    for(id node in nodesOnScreen) {
        if ([node isPressed:touchPoint]) {
            BOOL correctNodeIsTouched = 
                [nodesOnScreen objectAtIndex:nextValidNodetoTouch] == node;
            BOOL nodeHasNotBeenTouched = [node isNeutral];
            
            if (correctNodeIsTouched && nodeHasNotBeenTouched) {
                [node markValid];
                nextValidNodetoTouch = (nextValidNodetoTouch + 1) % [nodesOnScreen count];
                
                //all nodes have been touched correctly
                if(nextValidNodetoTouch == 0) {
                    [nodesOnScreen removeAllObjects];
                    //TODO: play effect in disappearing the nodes.
                    [[ObjectContainer sharedInstance].player 
                     initiateComboAnimation:self.currentComboKey];
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

- (void) draw {
    for (id node in nodesOnScreen) {
        [node draw];
    }
}
@end
