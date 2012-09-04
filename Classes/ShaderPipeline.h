//
//  ShaderPipeline.h
//  DragonEye
//
//  Created by mac on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shader.h"

@interface ShaderPipeline : NSObject {
    NSMutableArray *shaders;
}

@property(nonatomic, retain) NSMutableArray *shaders;

+ (ShaderPipeline *) pipelineWithShaderFiles:(Shader *) firstShader,...;

@end
