//
//  Background.h
//  DragonEye
//
//  Created by alkaiser on 4/6/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Drawable.h"
#import "Texture.h"
#import "PropState.h"
#import "Loggers.h"
#import "FrameBasedTimer.h"

@interface Background : NSObject <Drawable> {
	NSMutableArray *textures;
    NSMutableArray *bgSequence;
	GLfloat rightBoundary; 
	GLfloat scrollSpeed;
	Direction scrollDirection;
    id<AnimationTimer> timer;
}

@property (nonatomic, retain) NSMutableArray *textures;
@property (nonatomic, retain) NSMutableArray *bgSequence;
@property (nonatomic, assign) GLfloat rightBoundary, scrollSpeed;
@property (nonatomic, assign) Direction scrollDirection;
@property (nonatomic, retain) id<AnimationTimer> timer;

/**
 * Factory method to create and initialize attributes
 * for the background.
 *
 * @param scrollSpeed - how fast the background scrolls/moves.
 * @return a pointer to the background.
 */
+ (Background *) backgroundWithScrollSpeed:(GLfloat)scrollSpeed;

/**
 * Add a image/texture to the sequence of backgrounds
 *
 * @param texture - the texture to be added
 */
- (void) addBackgroundTexture:(Texture *)texture;

// From Drawable protocol
- (void) update;

@end
