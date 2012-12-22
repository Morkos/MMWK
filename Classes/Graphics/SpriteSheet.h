//
//  SpriteSheet.h
//  DragonEye
//
//  Created by alkaiser on 3/24/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface SpriteSheet : NSObject {
	// The texture containing the sprite sheet
	CCTexture2D *texture;
	
	// Size of a single image in x,y direction
	uint sizeX, sizeY;
    
    // A map that maps strings -> row, column
    // E.g. "stand" -> [[0,0],[0,1],[0,2]]
    // See spriteSheets.plist for example
    NSDictionary *animationFrames;
}

@property (nonatomic, retain) CCTexture2D *texture;
@property (nonatomic, assign) uint sizeX, sizeY;
@property (nonatomic, retain) NSDictionary *animationFrames;

/**
 * Create spritesheet with given parameters:
 *
 * @param texture The texture storing the whole sprite sheet
 * @param animationFrames The map containing strings -> row, column indexes in the sprite sheet for one animation sequence
 *                         e.g. "stand" -> [[0,0], [0,1], [0,2]]
 * @param numOfRows Number of rows in the sprite sheet
 * @param numOfColumns Number of columns in the sprite sheet
 */
+ (SpriteSheet *) createWithTexture:(CCTexture2D *) texture 
                     animationFrames:(NSDictionary *) animationFrames 
                           numOfRows:(NSUInteger) numOfRows
                        numOfColumns:(NSUInteger) numOfColumns;

/**
 * Returns the number of frames for a specific animation sequence
 * @param key A key identifying the animation sequence
 * @return The number of frames for the sequence
 */
- (NSUInteger) getNumOfFramesForKey:(NSString *) key;

/**
 * Returns the animation sequence in a form of CCSpriteFrame array
 * @param key A key identifying the animation sequence
 * @return The number of frames for the sequence
 */
- (NSArray *) getSpriteFramesForKey:(NSString *) key;

/**
 * Returns a single frame from an animation sequence.
 * @param key A key identifying the animation sequence
 * @param frameNum The frame number in the sequence to grab
 * @return The specific frame in the sequence
 */
- (CCSpriteFrame *) getFrameForKey:(NSString *) key frameNum:(NSUInteger) frameNum;

/**
 * Returns a single sprite from a specific frame from an animation sequence.
 * @param key A key identifying the animation sequence
 * @param frameNum The frame number in the sequence to grab
 * @return The specific sprite in the sequence
 */
- (CCSprite *) getSpriteForKey:(NSString *) key frameNum:(NSUInteger) frameNum;

- (void) changeSprite:(CCSprite *) sprite   
                toKey:(NSString *) key 
             frameNum:(NSUInteger) frameNum;

@end

