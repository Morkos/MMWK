//
//  TextureRenderTarget.m
//  DragonEye
//
//  Created by mac on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "TextureRenderTarget.h"

@implementation TextureRenderTarget

@synthesize frameBufferId, 
            textureId,
            width, height;

+ (TextureRenderTarget *) renderTargetWithWidth:(GLuint) width 
                                         height:(GLuint) height {
    TextureRenderTarget *renderTarget = [[TextureRenderTarget alloc] init];
    
    // The framebuffer, which regroups 0, 1, or more textures, and 0 or 1 depth buffer.
    GLuint framebufferId = 0;
    glGenFramebuffers(1, &framebufferId);
    glBindFramebuffer(GL_FRAMEBUFFER, framebufferId);
    
    // The texture we're going to render to
    GLuint textureId;
    glGenTextures(1, &textureId);
    
    // "Bind" the newly created texture : all future texture functions will modify this texture
    glBindTexture(GL_TEXTURE_2D, textureId);
    
    // Give an empty image to OpenGL ( the last "0" )
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, 0);
    
    // Poor filtering. Needed !
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST);
    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST);
    
    // Set "renderedTexture" as our colour attachement #0
    glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, textureId, 0);
    
    renderTarget.frameBufferId = framebufferId;
    renderTarget.textureId = textureId;
    renderTarget.width = width;
    renderTarget.height = height;
    
    return renderTarget;
}

- (void) setFrameBuffer {
    glBindFramebuffer(GL_FRAMEBUFFER, frameBufferId);
    glViewport(0, 0, width, height);
}

- (void) setTexture {
    glBindTexture(GL_TEXTURE_2D, textureId);
}

@end
