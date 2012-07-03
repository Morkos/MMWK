//
//  ObjectContainer.h
//  DragonEye
//
//  Created by alkaiser on 3/20/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Background.h"
#import "Node.h"
#import "Queue.h"

// TODO: Sometimes adding this fixes errors, and then removing them doesn cause errors anymore
@class Player, Background;

@interface ObjectContainer : NSObject {
	NSMutableArray *objArray;
	Player *player;
	NSMutableArray *nodes;
	Background *background;
}

@property (nonatomic, retain) NSMutableArray *objArray;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) NSMutableArray *nodes;
@property (nonatomic, readonly, retain) Background *background;

+ (ObjectContainer *) singleton;
- (id) init;
- (void) addObject:(id)object;
- (id) getObject:(NSUInteger) index;


@end
