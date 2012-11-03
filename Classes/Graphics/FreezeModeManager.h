//
//  FreezeModeManager.h
//  DragonEye
//
//  Created by Mark Mikhail on 6/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Drawable.h"


@interface FreezeModeManager : NSObject<Drawable> {
    /**
     * Maps combo keys to a list of Nodes
     */
    @private
    NSMutableDictionary *nodesDictionary;
    NSUInteger nextValidNodetoTouch;
    NSArray *currentComboNodes;
    NSString *currentComboKey;
    CCLayer *layer;
}

@property(nonatomic, retain) NSMutableDictionary *nodesDictionary;
@property(nonatomic, assign) NSUInteger nextValidNodetoTouch;
@property(nonatomic, retain) NSArray *currentComboNodes;
@property(nonatomic, retain) NSString *currentComboKey;
@property(nonatomic, retain) CCLayer *layer; 
          
+ (FreezeModeManager *) managerWithPlist:(NSString *) plistFilename
                                   layer:(CCLayer *) layer;

- (id) init:(NSString *) plistFilename
      layer:(CCLayer *) layer; 

/**
 * Given a combo key, display the nodes that are
 * affiliated
 *
 * @param comboKey - unique identifier for the combo
 * @param layer - The CCLayer to draw the nodes on
 */
- (void) displayNodes:(NSString *)comboKey;

/**
 * Every time the screen is touch, this method is called
 * and finds which node was touched.
 *
 * @param CGPoint - screen coordinates of the touch event
 */
- (void) processNodesTouches:(CGPoint) touchPoint;

@end
