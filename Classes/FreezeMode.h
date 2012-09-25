//
//  FreezeMode.h
//  DragonEye
//
//  Created by alkaiser on 4/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Overlay.h"
#import "Node.h"

@interface FreezeMode : NSObject<Drawable> {
	//Texture *container;
	NSMutableArray *nodes;
}

@property (nonatomic, retain) NSMutableArray *nodes;

+ (FreezeMode *) createWithNodes:(Node *)node1,...;
- (void) draw;
- (void) animate;
- (void) update;

@end
