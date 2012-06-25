//
//  TextureManager.h
//  DragonEye
//
//  Created by mac on 6/21/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Texture.h"

@interface TextureManager : NSObject {
    // A map of filepaths -> textures
    NSMutableDictionary *textures;
}

@property (nonatomic, retain) NSMutableDictionary *textures;

+ (TextureManager *) getInstance;
- (Texture *) loadTexture:(NSString *) filepath;
- (void) releaseAllTextures;

@end
