//
//  ShaderManager.m
//  DragonEye
//
//  Created by mac on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShaderManager.h"

@implementation ShaderManager

@synthesize filenameToShaderMap;

static ShaderManager *shaderManager;

+ (ShaderManager *) getInstance {
    if (!shaderManager) {
        shaderManager = [[ShaderManager alloc] init];
    }
    
    return shaderManager;
}

- (id) init {
	if (self = [super init]) {
		self.filenameToShaderMap = [NSMutableDictionary dictionary];
	}
    
	return self;
}

- (Shader *) getShader: (NSString *)filename {
    Shader *shader = [self.filenameToShaderMap objectForKey:filename];
    NSString *extension = [filename pathExtension];
    GLenum type = 0;
    if ([extension isEqualToString:@"fsh"]) {
        type = GL_FRAGMENT_SHADER;
    } else if ([extension isEqualToString:@"vsh"]) {
        type = GL_VERTEX_SHADER;
    } else {
        @throw([NSException exceptionWithName:@"Shader" reason:@"Unknown extension" userInfo:nil]);
    }
    
    // Compile shader if there wasn't any
    if (!shader) {
        shader = [Shader shaderWithFile:filename type:type];
        [self.filenameToShaderMap setObject:shader forKey:filename];
    }
    
    return shader;
}
@end
