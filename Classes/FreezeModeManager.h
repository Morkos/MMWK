//
//  FreezeModeManager.h
//  DragonEye
//
//  Created by Mark Mikhail on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"


@interface FreezeModeManager : NSObject<Drawable> {
    NSMutableDictionary * nodesDictionary;
    NSString * currentComboKey;
}

@property (nonatomic, retain) NSMutableDictionary * nodesDictionary;
@property (nonatomic, retain) NSString * currentComboKey;

/**
 * FreezeModeManager is in charge of drawing, storing
 * and processing touch events for nodes
 *
 * @return a single instance of FreezeModeManager
 */
+ (id) getInstance;

/**
 * Given a combo key, display the nodes that are
 * affiliated
 *
 * @param NSString* - unique identifier for the combo
 */
- (void) changeNodes:(NSString *) comboKey;

/**
 * Stores nodes in manager to be displayed and processed
 * in the future
 *
 * @param NSDictionary* - nodes to be stored
 */
- (void) addNodes:(NSDictionary *) nodes;

/**
 * Every time the screen is touch, this method is called
 * and finds which node was touched.
 *
 * @param CGPoint - screen coordinates of the touch event
 */
- (void) processNodesTouches:(CGPoint) touchPoint;

@end
