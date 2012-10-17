//
//  untitled.h
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "cocos2d.h"
#import "Overlay.h"
#import "Loggers.h"
#import "AnimatorConstants.h"

@interface Node : Overlay<NSCopying> {
@private
    NSString * nodeVisualState;
    CCSprite *sprite;
}

@property (nonatomic, retain) NSString *nodeVisualState;
@property (nonatomic, retain) CCSprite *sprite;

/**
 * Factory method to create a node
 * 
 * @param position - open gl position of node
 * @param size - open gl size of node
 * @param spriteSheet SpriteSheet associated with the node
 * @return a new node
 */
+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
              spriteSheet:(SpriteSheet *)spriteSheet;

- (bool) isLocationInView:(CGPoint) location;

/**
 * Mark node as correctly touched (in order)
 */
- (void) markValid;

/**
 * Mark node as incorrectly touched (out of order)
 */
- (void) markInvalid;

/**
 * Mark the node as not touched
 */
- (void) markNeutral;

/**
 * Creates a deep copy of each node except that it does not
 * copy over the nodeVisualStatue. This gets reset to neutral
 * state.
 *
 * @return deep copy of node
 */
- (id) copyWithZone:(NSZone *)zone;

/**
 * Is the node not touched?
 */
- (BOOL) isNeutral;

@end
