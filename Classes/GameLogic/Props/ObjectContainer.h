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
#import "Enemy.h"
// TODO: Sometimes adding this fixes errors, and then removing them doesn cause errors anymore
@class Player, Background;
@interface ObjectContainer : NSObject {
    NSMutableDictionary *objDictionary;
	Player *player;
}

+ (ObjectContainer *) sharedInstance;
- (id) init;
- (Player *) player;
- (Enemy *) getEnemy;
- (void) addObject:(CCNode *)object;
- (void) update;
- (NSArray *) findCollidingProps:(Prop *) prop fromContainer:(NSString *)containerKey;


@end
