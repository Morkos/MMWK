//
//  TextureRenderTarget.h
//  DragonEye
//
//  Created by mac on 7/19/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

@interface TextureRenderTarget : NSObject {
    GLuint frameBufferId;
    GLuint textureId;
    GLuint width, height;
}

@property (nonatomic, assign) GLuint frameBufferId;
@property (nonatomic, assign) GLuint textureId;
@property (nonatomic, assign) GLuint width, height;

+ (TextureRenderTarget *) renderTargetWithWidth:(GLuint) width 
                                         height:(GLuint) height;

- (void) setFrameBuffer;
- (void) setTexture;

@end
