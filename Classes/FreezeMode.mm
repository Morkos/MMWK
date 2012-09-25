//
//  FreezeMode.m
//  DragonEye
//
//  Created by alkaiser on 4/14/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FreezeMode.h"


@implementation FreezeMode

@synthesize nodes;

+ (FreezeMode *) createWithNodes:(Node *)node1,... {
	FreezeMode *freezeMode = [[FreezeMode alloc] init];
	freezeMode.nodes = [NSMutableArray arrayWithCapacity:10];
	[freezeMode.nodes addObject:node1];
	
	va_list argList;
	va_start(argList, node1);
	Node *eachNode;
	while ((eachNode = va_arg(argList, Node *))) {
		[freezeMode.nodes addObject:eachNode];
	}
	va_end(argList);
	return freezeMode;
}

- (void) draw {
	// TODO: draw connections between nodes
	for (Node *node in nodes) {
		[node update];
		[node draw];
	}
}

- (void) animate {
}

- (void) update {
}

@end
