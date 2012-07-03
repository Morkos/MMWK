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

static FreezeModeManager * manager = nil;
static NSMutableArray * nodesOnScreen = nil;

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
    NSMutableArray * nodesArray = [self.nodesDictionary objectForKey:comboKey];
    //shallow copy
    nodesOnScreen = [NSMutableArray arrayWithArray:nodesArray];    
    [nodesOnScreen retain];
}

- (void) processNodesTouches:(CGPoint)touchPoint {
    
    NSMutableArray * nodesShallowCopy = [NSArray arrayWithArray:nodesOnScreen];
    
	for(id node in nodesShallowCopy) {
        if ([node isPressed:touchPoint]) {
            if ([nodesOnScreen peek] == node) {
                [node markValid];
                [nodesOnScreen dequeue];
            } else {
                [node markInvalid];
                NSLog(@"You touched the incorrect node.");
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
