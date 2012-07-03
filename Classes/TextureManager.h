//
//  TextureManager.h
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"

/**
 * A utility manager class to manage the creation and 
 * memory management of textures in OpenGL. 
 */
@interface TextureManager : NSObject {
    // A map of filepaths -> textures
    NSMutableDictionary *textures;
}

@property (nonatomic, retain) NSMutableDictionary *textures;

+ (TextureManager *) getInstance;

/**
 * Loads a texture based on whole filepath of the image.
 *
 * @filename: The key provided in the JSON file (without extension)
 */
- (Texture *) loadTexture:(NSString *) filepath;

/**
 * Release all textures from OpenGL
 *
 * @filename: The key provided in the JSON file (without extension)
 */
- (void) releaseAllTextures;

@end
