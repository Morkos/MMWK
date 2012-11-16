//
//  ObjectContainer.h
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Node.h"
#import "Queue.h"

// TODO: Sometimes adding this fixes errors, and then removing them doesn cause errors anymore
@class Player, Background;

@interface ObjectContainer : NSObject {
    NSMutableDictionary *objDictionary;
	Player *player;
    Gauge *enemyHealthGauge;
}

@property(nonatomic, retain) Player *player;
@property(nonatomic, retain)     Gauge *enemyHealthGauge;

+ (ObjectContainer *) sharedInstance;
- (void) addObject:(CCNode *)object;

/**
 * Get all the props from a target container 
 *
 * @param containerKey The key for the container
 * @return Array of props.
 */
- (NSArray *) getAllPropsFromContainer:(NSString *) containerKey; 

/**
 * Get all the props from a target container that are colliding with the given target
 *
 * @param target The target to check with
 * @param containerKey The key for the container
 * @return Array of props.
 */
- (NSArray *) findCollidingProps:(Prop *) target 
                   fromContainer:(NSString *)containerKey;


@end
