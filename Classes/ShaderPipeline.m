//
//  ShaderPipeline.m
//  DragonEye
//
//  Created by mac on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ShaderPipeline.h"

@implementation ShaderPipeline

@synthesize shaders;

+ (ShaderPipeline *) pipelineWithShaders: (Shader *) firstShader,... {
    ShaderPipeline *pipeline = [[ShaderPipeline alloc] init];
    
    va_list argList;
	[pipeline.shaders addObject:firstShader];
	va_start(argList, firstShader);
	Shader *eachShader;
	while ((eachShader = va_arg(argList, Shader *))) {
		[pipeline.shaders addObject:eachShader];
	}
	va_end(argList);
    
    return pipeline;
}

- (id) init {
	if (self = [super init]) {
		self.shaders = [NSMutableArray arrayWithCapacity:3];
	}
	return self;
}

@end
