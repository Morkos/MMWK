//
//  untitled.h
//  DragonEye
//
//  Created by alkaiser on 4/5/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
#import "Overlay.h"
#import "Loggers.h"

@interface Node : Overlay<NSCopying> {
@private
    NSString * nodeVisualState;
}

@property (nonatomic, assign) NSString * nodeVisualState;

/**
 * Factory method to create a node
 * 
 * @param position - open gl position of node
 * @param size - open gl size of node
 * @param spriteSheet animator
 * @return a new node
 */
+ (Node *) nodeAtPosition:(CGPoint)position 
					 size:(CGSize)size 
                 animator:(SpriteSheetAnimator *)spriteSheet;

/**
 * Has the node been touched?
 *
 * @param point - coordinates of where the touch is on the screen
 * @return true if node is touched; false otherwise
 */
- (BOOL) isPressed:(CGPoint)point;

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
