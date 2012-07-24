//
//  Shader.h
//  DragonEye
//
//  Created by mac on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <OpenGLES/ES2/gl.h>

@interface Shader : NSObject {
    GLuint shaderId;
}

@property (nonatomic, assign) GLuint shaderId;

+ (Shader *) shaderWithFile:(NSString *) filepath type:(GLenum) type;
+ (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;

@end
