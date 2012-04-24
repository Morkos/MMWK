//
//  GraphicsEngine.h
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>
#import <OpenGLES/ES2/glext.h>
#import "PropState.h"
#import "SpriteSheet.h"
#import "ShaderConstants.h"
#import "Player.h"
#import "Loggers.h"

@class Player;

@interface GraphicsEngine : NSObject {

}

+ (void) initializeProperties;

// Does not support UP and DOWN
+ (void) drawCharacter:(Character *) character;

// NOTE: texCoords will be modified upon each draw. Create new TexCoords for each call 
+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoords
			position:(Position) position 
				size:(CGSize) size 
		 orientation:(Orientation) orientation;

+ (CGPoint) convertPointToGl:(CGPoint) point 
				  screenSize:(CGSize) screenSize;

@end