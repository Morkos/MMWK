//
//  GraphicsEngine.m
//  DragonEye
//
//  Created by alkaiser on 4/3/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GraphicsEngine.h"

@implementation GraphicsEngine

+ (void) drawCharacter:(Character *)character {

	SpriteSheet *sprite = character.sprite;
	NSArray *texCoordsArray = [sprite getTextureCoords:character.spsheetRowInd];
	
	TexCoords *texCoords = [texCoordsArray objectAtIndex:character.spsheetColInd];
	
	// Depth of a character is the same as the y-coordinates
	Position position = {character.position.x, character.position.y, 
											(character.position.y + 1.0) / 2.0};
	DLOG("Z position: %f", position.z);
	
	[self drawTexture:sprite.sheet
			texCoords:texCoords 
			 position:position
				 size:character.size
		  orientation:character.currentOrientation];
}

+ (void) drawTexture:(Texture *) texture 
		   texCoords:(TexCoords *) texCoordsParam
			position:(Position) position 
				size:(CGSize) size 
		 orientation:(Orientation) orientation {
		
	static const GLfloat squareVertices[] = {
		 -1.0f, 1.0f,
		 1.0f, 1.0f,
		 -1.0f, -1.0f,
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
	glVertexAttribPointer(ATTRIB_VERTEX, 2, GL_FLOAT, GL_FALSE, 0, squareVertices);
	glEnableVertexAttribArray(ATTRIB_VERTEX);
	glVertexAttribPointer(ATTRIB_TEXTURE, 2, GL_FLOAT, GL_FALSE, 0, textureVertices);
	glEnableVertexAttribArray(ATTRIB_TEXTURE);
	
	glDrawArrays(GL_TRIANGLE_STRIP, 0, 4);	
}

+ (CGPoint) convertPointToGl:(CGPoint)point 
				  screenSize:(CGSize) screenSize {
	CGFloat halfwidth = screenSize.width/2;
	CGFloat halfheight = screenSize.height/2;
	CGFloat newX = (point.x - halfwidth) / halfwidth;
	CGFloat newY = (halfheight - point.y) / halfheight;
	return CGPointMake(newX, newY); 
}

@end
