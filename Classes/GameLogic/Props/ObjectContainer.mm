//
//  ObjectContainer.m
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ObjectContainer.h"
#import "Enemy.h"
#import "Item.h"
#import "NSDictionaryExtensions.h"

@implementation ObjectContainer
@synthesize player, enemyHealthGauge;

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
    if(!IS_SUBCLASS(object, Prop)) {
        return;
    }
    
	// Store player in a singleton player object
	if(IS_SUBCLASS(object, Player)) {
		if (!player) {
			player = (Player *) object;
		} else {
			DLOG("ERROR! More than one player!");
		}
	} else if(IS_SUBCLASS(object, Enemy)) {
        [objDictionary addObjectToArray:object forKey:CONTAINER_ENEMIES];
    } else if(IS_SUBCLASS(object, Item)) {
        [objDictionary addObjectToArray:object forKey:CONTAINER_ITEMS];
    }
}

- (NSArray *) getAllPropsFromContainer:(NSString *) containerKey {
    return [objDictionary objectForKey:containerKey];
}

- (NSArray *) findCollidingProps:(Prop *) target 
                   fromContainer:(NSString *) containerKey {
    NSArray *props = [objDictionary objectForKey:containerKey];
    NSMutableArray *collidingProps = [NSMutableArray arrayWithCapacity:[props count]];
    
    for(Prop *checkedProp in props) {
        bool collided = [[PhysicsEngine getInstance] detectRectangleCollision:target 
                                                                    otherProp:checkedProp];
        
        if (collided) {
            [collidingProps addObject:checkedProp];
        }
    }
    
    return collidingProps;
}

- (void) dealloc {
    [player release];
    [objDictionary release];
    [super dealloc];
}

@end
