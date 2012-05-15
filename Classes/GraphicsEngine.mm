//
//  GraphicsEngine.m
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsEngine.h"
#import "Camera.h"

static CGPoint convertGameCoordinatesToOpenGL(CGPoint gameCoordinates);
static CGSize convertSizeToOpenGL(CGSize size);
static Camera* camera = [Camera getInstance];

@implementation GraphicsEngine

+ (void) initializeProperties {
	glEnable(GL_DEPTH_TEST);
	glDepthFunc(GL_LEQUAL);
	glDepthMask(GL_TRUE);
}


+ (void) drawParticleEffects:(ParticleEffectsManager *) effectsManager {
	// Draw all particle effects
	for (NSString *key in effectsManager.particleEffects) {
		id<ParticleEffect> effect = [effectsManager.particleEffects objectForKey:key];
		if ([effect isActive]) {
			[effect draw];
		}
	}
}

+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoordsParam
			position:(GLPosition) position 
				size:(CGSize) size 
		 orientation:(Orientation) orientation {
	
	[self drawTexture:texture
			texCoords:texCoordsParam 
			 position:position 
				 size:size 
		  orientation:orientation
			  opacity:-1.0f];
}

+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoordsParam
			position:(GLPosition) position 
				size:(CGSize) size 
		 orientation:(Orientation) orientation
			 opacity:(GLfloat) opacity {
	
	[self drawTexture:texture
			texCoords:texCoordsParam 
			 position:position 
				 size:size 
			    angle:0.0f
		  orientation:orientation
			  opacity:-1.0f];
}

+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoordsParam
			position:(GLPosition) position 
				size:(CGSize) size 
			   angle:(GLfloat) angle
		 orientation:(Orientation) orientation
			 opacity:(GLfloat) opacity {
	
	static const GLfloat squareVertices[] = {
		-1.0f,   1.0f,
		 1.0f,   1.0f,
		-1.0f,  -1.0f,
		 1.0f,  -1.0f,
	};
	
	TexCoords *texCoords = [TexCoords copyOfTexCoords:texCoordsParam];
	
	// Swap left and right side 
	if (orientation == ORIENTATION_BACKWARDS) {
		GLfloat left = [texCoords getLeft];
		GLfloat right = [texCoords getRight];
		[texCoords setLeft:right];
		[texCoords setRight:left];
	}
	
	GLfloat textureVertices[8];
	[texCoords convertToCArray:textureVertices];
	
	glBindTexture(GL_TEXTURE_2D, texture.textureId);
	
	glUniform3f(ShaderConstants::uniforms[UNIFORM_TRANSLATE], position.x, position.y, position.z);
	glUniform2f(ShaderConstants::uniforms[UNIFORM_SCALE], size.width, size.height);
	glUniform1f(ShaderConstants::uniforms[UNIFORM_OPACITY], opacity);
	glUniform1f(ShaderConstants::uniforms[UNIFORM_ROTATE], angle);
	glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTURE);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}


+ (void) drawCharacter:(Character *)character {

	SpriteSheet *sprite = character.sprite;
	NSArray *texCoordsArray = [sprite getTextureCoords:character.spsheetRowInd];
	
	TexCoords *texCoords = [texCoordsArray objectAtIndex:character.spsheetColInd];
	
	[self drawTextureInGameCoordinates:sprite.sheet 
			texCoords:texCoords 
			 position:character.position
				 size:character.size
		  orientation:character.currentOrientation];
}

+ (void) drawTextureInGameCoordinates:(Texture *) texture
		   texCoords:(TexCoords *) texCoordsParam
			position:(CGPoint) position
				size:(CGSize) size 
		 orientation:(Orientation) orientation {
	
	CGPoint openGLPoint = convertGameCoordinatesToOpenGL(position);
	CGSize  openGLSize  = convertSizeToOpenGL(size);
	
	// Depth of a character is the same as the y-coordinates
    GLPosition glPosition = {openGLPoint.x, openGLPoint.y, (openGLPoint.y + 1.0) / 2.0}; 
	
	[self drawTexture:texture 
			texCoords:texCoordsParam 
			 position:glPosition
				 size:openGLSize
		  orientation:orientation];
	
}

+ (CGPoint) convertScreenPointToGl:(CGPoint) point
                        screenSize:(CGSize) screenSize {
    CGFloat halfwidth = screenSize.width / 2;
	CGFloat halfheight = screenSize.height / 2;
	CGFloat newX = (point.x - halfwidth) / halfwidth;
	CGFloat newY = (halfheight - point.y) / halfheight;
    
	return CGPointMake(newX, newY); 
}

+ (CGPoint) convertPointToGl:(CGPoint) point {	
	return convertGameCoordinatesToOpenGL(point);
}

static CGPoint convertGameCoordinatesToOpenGL(CGPoint gameCoordinates) {
		
	CGFloat midWay  = (camera.frameBoundary.right + camera.frameBoundary.left) / 2.0f;
	CGFloat midHigh = camera.frameDimension.height / 2.0f;
	
	CGFloat openGLWidth  = (gameCoordinates.x - midWay)  / (camera.frameDimension.width / 2.0f);
	CGFloat openGLHeight = (gameCoordinates.y - midHigh) / midHigh;
	
	CGPoint openGLPoint = { openGLWidth, openGLHeight };
	
	return openGLPoint;	
}

+ (CGSize) convertSizeToGl:(CGSize) size {
	return convertSizeToOpenGL(size);
}

static CGSize convertSizeToOpenGL(CGSize size) {
	
	CGSize openGLSize = { 
						  size.width  / camera.frameDimension.width, 
						  size.height / camera.frameDimension.height 
						};
	
	return openGLSize;
	
}
	

@end
