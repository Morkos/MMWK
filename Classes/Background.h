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
#import "GraphicsEngine.h"
#import "Loggers.h"

@interface Background : NSObject <Drawable> {
	
	CADisplayLink *displayLink;
	NSMutableArray *textures;
    NSMutableArray *bgSequence;
	GLfloat rightBoundary; 
	GLfloat scrollSpeed;
	Direction scrollDirection;

}

@property (nonatomic, retain) CADisplayLink *displayLink;
@property (nonatomic, retain) NSMutableArray *textures;
@property (nonatomic, retain) NSMutableArray *bgSequence;
@property (nonatomic, assign) GLfloat rightBoundary, scrollSpeed;
@property (nonatomic, assign) Direction scrollDirection;

+ (Background *) backgroundWithScrollSpeed:(GLfloat)scrollSpeed;
- (void) addBackgroundTexture:(Texture *)texture;

- (void) startAnimation;
- (GLfloat) wrapBoundary:(GLfloat) boundary;

// From Drawable protocol
- (void) draw;
- (void) update;
- (void) animate;

- (void) scroll:(Direction) direction;
- (void) stopScrolling;

@end
