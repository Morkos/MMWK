//
//  ObjectContainer.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectContainer.h"
#import "Enemy.h"
#import "NSDictionaryExtensions.h"

@implementation ObjectContainer

static ObjectContainer *singleContainer;

//don't worry -- we will need to change this.

+ (ObjectContainer *) sharedInstance {
	if (!singleContainer) {
		singleContainer = [[ObjectContainer alloc] init];
	}
	
	return singleContainer;
}
						   
- (id) init {
	if (self = [super init]) {
		objDictionary = [[NSMutableDictionary dictionaryWithCapacity:3] retain];
	}
	return self;
}

- (void) addObject:(CCNode *) object {
    if (!IS_SUBCLASS(object, Prop)) {
        return;
    }
    
	// Store player in a singleton player object
	if (IS_SUBCLASS(object, Player)) {
		if (!player) {
			player = (Player *) object;
            [objDictionary addObjectToArray:object forKey:@"player"];
		} else {
			DLOG("ERROR! More than one player!");
		}
	} else if (IS_SUBCLASS(object, Enemy)) {
        [objDictionary addObjectToArray:object forKey:@"enemies"];
    }
}

- (Player *) player {
    return player;
}

- (Enemy *) getEnemy {
    NSMutableArray * enemies = [objDictionary objectForKey:@"enemies"];
    return [enemies objectAtIndex:0];
}

- (NSArray *) findCollidingProps:(Prop *) prop fromContainer:(NSString *) containerKey {
    NSArray *props = [objDictionary objectForKey:containerKey];
    NSMutableArray *collidingProps = [NSMutableArray arrayWithCapacity:[props count]];
    
    for (Prop *checkedProp in props) {
        bool collided = [[PhysicsEngine getInstance] detectRectangleCollision:prop 
                                                                    otherProp:checkedProp];
        
        if (collided) {
            [collidingProps addObject:checkedProp];
        }
    }
    
    return collidingProps;
}

- (void) update {
    [objDictionary enumerateKeysAndObjectsUsingBlock:^(NSString * key, NSMutableArray * objs, BOOL *stop) {
        for(id obj in objs) {
            [obj update];
            
        }
    }];
}

- (void) dealloc {
    [player release];
    [objDictionary release];
    [super dealloc];
}

@end
