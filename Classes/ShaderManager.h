//
//  ShaderManager.h
//  DragonEye
//
//  Created by mac on 8/13/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shader.h"

@interface ShaderManager : NSObject {
    NSMutableDictionary *filenameToShaderMap;
}

@property(nonatomic, retain) NSMutableDictionary *filenameToShaderMap;

+ (ShaderManager *) getInstance;
- (Shader *) getShader: (NSString *)filename;

@end
