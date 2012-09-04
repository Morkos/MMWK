//
//  Shader.m
//  DragonEye
//
//  Created by mac on 7/23/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Shader.h"

@implementation Shader

@synthesize shaderId;

+ (Shader *) shaderWithFile:(NSString *) filepath type:(GLenum) type {
    GLuint shaderId = 0;
    if (![Shader compileShader:&shaderId type:type file:filepath]) {
        return nil;
    }
          
    Shader *shader = [[Shader alloc] init];
    shader.shaderId = shaderId;
    
    return shader;
}

+ (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file {
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source)
    {
        NSLog(@"Failed to load vertex shader");
        return FALSE;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0)
    {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0)
    {
        glDeleteShader(*shader);
        return FALSE;
    }
    
    return TRUE;
}

- (void) dealloc {
    if (shaderId) {
        glDeleteShader(shaderId);
        shaderId = 0;
    }
    
    [super dealloc];
}

@end
